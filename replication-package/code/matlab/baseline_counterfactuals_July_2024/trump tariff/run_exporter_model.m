function run_exporter_model
    % Parameters
    sigma = 4.0; tau = 1.05; w = 1.0; beta = 0.95; alpha = 0.7; 
    E_star = 1.0; M = 1.0;
    z_grid = [1.0; 1.5];                % [z_L; z_H]
    Phi = [0.8 0.2; 0.5 0.5];           % transition matrix
    mu = [0.25 0.25 0.25 0.25];         % initial dist over (L,0),(H,0),(L,1),(H,1)
    f_bar = 1.0; delta_f = 0.5;         % fixed costs
    f_costs = [f_bar + delta_f, f_bar]; % [h=0, h=1]

    damp = 0.3; tolP = 1e-6; maxOuter = 100;
    P_star = 1.0;                       % initial guess

    for k = 1:maxOuter
        P_old = P_star;
        profits = get_profits(z_grid, sigma, tau, w, E_star, P_old);

        % Inner loop: value function iteration (2x2 for z x h)
        V = zeros(2,2);
        for t = 1:1000
            V_old = V;
            EV_next0 = Phi * V_old(:,1);              % E[V(z',h=0)|z]
            A_z = beta * EV_next0;                    % 2x1
            E_diff = Phi * (V_old(:,2) - V_old(:,1)); % 2x1
            Delta = profits - f_costs + beta * E_diff; % broadcasts h
            Mg = option_value_Mg(Delta);              % 2x2
            V = A_z + Mg;                             % add column-wise
            if max(abs(V - V_old), [], 'all') < 1e-6
                break;
            end
        end

        % Export probabilities and stationary distribution
        p_e = normcdf(Delta);
        mu = get_stationary_dist(p_e, mu, Phi);

        % Update price index with damping
        [P_new, N_L, N_H] = get_price_index(mu, p_e, z_grid, sigma, tau, w, M);
        P_star = damp * P_new + (1 - damp) * P_old;

        if abs(P_star - P_old) < tolP
            fprintf('Converged after %d iterations.\n', k);
            fprintf('Equilibrium P*: %.6f\n', P_star);
            disp('Value function V(z,h):'); disp(V);
            disp('Export probabilities p_e(z,h):'); disp(p_e);
            disp('Stationary dist [L0 H0 L1 H1]:'); disp(mu);
            fprintf('N_L: %.4f, N_H: %.4f\n', N_L, N_H);
            return;
        end
    end
    warning('Did not converge within max iterations. P* = %.6f', P_star);
end

function profits = get_profits(z_grid, sigma, tau, w, E_star, P_star)
    markup = sigma / (sigma - 1);
    prices = markup * tau * w ./ z_grid;
    revenues = E_star * (prices / P_star) .^ (1 - sigma);
    profits = revenues / sigma; % 2x1
end

function Mg = option_value_Mg(Delta)
    Mg = Delta .* normcdf(Delta) + normpdf(Delta);
end

function mu = get_stationary_dist(p_e, mu0, Phi)
    prob_enter = reshape(p_e, [], 1);            % 4x1, column-major by h
    prob_stay_out = 1 - prob_enter;
    T_stay_out = prob_stay_out .* repmat(Phi, 2, 1);
    T_enter = prob_enter .* repmat(Phi, 2, 1);
    T = [T_stay_out, T_enter];                   % 4x4
    mu = mu0;
    for t = 1:1000
        mu_old = mu;
        mu = mu_old * T;
        if max(abs(mu - mu_old)) < 1e-6, break; end
    end
end

function [P_star, N_L, N_H] = get_price_index(mu, p_e, z_grid, sigma, tau, w, M)
    markup = sigma / (sigma - 1);
    cost = markup * tau * w;
    N_L = M * (mu(1) * p_e(1) + mu(3) * p_e(3)); % (L,0) and (L,1)
    N_H = M * (mu(2) * p_e(2) + mu(4) * p_e(4)); % (H,0) and (H,1)
    P_star = cost * ( [N_L N_H] * (z_grid .^ (sigma - 1)) ) ^ (1 / (1 - sigma));
end
