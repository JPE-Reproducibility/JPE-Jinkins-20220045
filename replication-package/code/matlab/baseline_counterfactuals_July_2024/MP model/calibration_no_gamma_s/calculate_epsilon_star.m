function epsilon_star_matrix = calculate_epsilon_star(sigma, beta, F, lambda, pi_matrix, rho, delta, deltaB, deltaS, expected_value_epsilon_greater)
    % sigma: Standard deviation of the log-normal distribution
    % beta: Buyer bargaining power
    % F: Fixed cost
    % lambda: Arrival of demand shock
    % pi_matrix: Matrix of profits (pi_ij)
    % rho: Discount rate
    % delta, deltaB, deltaS: death hazards

    % Preallocate matrix for epsilon* values
    [rows, cols] = size(pi_matrix);
    epsilon_star_matrix = zeros(rows, cols);
    
    % Define the equation to solve for epsilon*
    epsilon_star_equation = @(epsilon, pi_ij) (1 - beta) * (pi_ij * epsilon - F) + ...
        lambda * (1 - beta) * pi_ij * ...
                (expected_value_epsilon_greater(epsilon, sigma) - epsilon) * ...
                (1 - logncdf(epsilon, 0, sigma)) / ...
        (rho + delta + deltaB + deltaS + lambda);

    % Solve for epsilon* for each pi_ij in the matrix
    for i = 1:rows
        for j = 1:cols
            pi_ij = pi_matrix(i, j);
            % Initial guess and solver for the equation
            epsilon_initial = sigma; % A reasonable starting point
            if epsilon_star_equation(1e-6, pi_ij) > 0
                epsilon_star_matrix(i, j) = 1e-6;
            else
                options = optimset('MaxIter', 500, 'MaxFunEvals', 1000);
                epsilon_star_matrix(i, j) = fminbnd(@(epsilon) abs(epsilon_star_equation(epsilon, pi_ij)), 1e-6, exp(4*sigma),options);
            end
        end
    end
end
