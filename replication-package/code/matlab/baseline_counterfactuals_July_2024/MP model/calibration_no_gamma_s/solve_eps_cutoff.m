function [cutoffs] = solve_eps_cutoff(rho, delta, deltaB, deltaS, lambda, F, sigma_eps, sbarg, profit_matrix)

    tol = 1e-6;

%% ----------- VECTORIZED CUTOFF COMPUTATION -----------------

cutoffs = zeros(size(profit_matrix));

parfor k = 1:numel(profit_matrix)
    cutoffs(k) = solve_cutoff(profit_matrix(k), ...
        sigma_eps, rho, delta, deltaB, deltaS, lambda, F, sbarg, tol);
end

end   % <---- closes solve_eps_cutoff


%%%%%%%%%%%%%%%%%%%%%  NESTED SCALAR SOLVER  %%%%%%%%%%%%%%%%%%%%%
function cutoff = solve_cutoff(profit_temp, sigma_eps, rho, delta, deltaB, deltaS, lambda, F, sbarg, tol)

    % Bounds
    a = 1e-8;
    b = exp(6*sigma_eps);

    % Evaluate at endpoints
    [CDF_a, E_a] = Epsilon_CDF_values(a, sigma_eps);
    fa = function_epsilon_solve(a, profit_temp, E_a, CDF_a, rho, delta, deltaB, deltaS, lambda, F, sbarg);

    %[CDF_b, E_b] = Epsilon_CDF_values(b, sigma_eps);
    %fb = function_epsilon_solve(b, profit_temp, E_b, CDF_b, rho, delta, deltaB, deltaS, lambda, F, sbarg);

    % If sign does not change -> no root
    if fa > 0
        cutoff = 1e-10;
        return
    end

    % Standard bisection loop
    iter = 0;
    while (b - a) > tol
        c = 0.5 * (a + b);

        [CDF_c, E_c] = Epsilon_CDF_values(c, sigma_eps);
        fc = function_epsilon_solve(c, profit_temp, E_c, CDF_c, rho, delta, deltaB, deltaS, lambda, F, sbarg);

        %fprintf("iter %d: a: %.5f, b: %.5f, c: %.5f, f(a): %.5f, f(c): %.5f, CDF(c): %.5f, E(c): %.5f\n", iter, a, b, c, fa, fc, CDF_c, E_c);
        iter = iter + 1;

        if fa * fc <= 0
            b = c;   % root lies between a and c
            %fb = fc;
        else
            a = c;   % root lies between c and b
            %fa = fc;
        end
    end

    cutoff = 0.5 * (a + b);

end