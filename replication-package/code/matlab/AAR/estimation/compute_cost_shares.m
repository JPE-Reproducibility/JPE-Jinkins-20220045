function stats = compute_cost_shares(sol, theta, cfg)
%COMPUTE_COST_SHARES Conditional fixed-cost averages and aggregate burdens.
%   Uses the fixed-cost structure in Eq. (eq:cost) and export decision
%   rule in Eq. (eq:pe_general). The truncated-normal conditional mean
%   leverages the same shock specification used in Eq. (eq:Delta).

arguments
    sol struct
    theta struct
    cfg struct
end

beta = cfg.beta;
mu = cfg.shock_mu;
sigma_eps = cfg.shock_sigma;

Phi = sol.Phi;
Xi = sol.Xi;
V = sol.V(:);
V0 = V(1:2);
V1 = [V(3:4)'; V(5:6)'];

revenue_matrix = sol.revenue_matrix;
profit_matrix = revenue_matrix ./ sol.sigma; % Eq. (eq:r_pi)

EV0 = zeros(2, 1);
EV1 = zeros(2, 2);
for z = 1:2
    sum0 = 0;
    for z_next = 1:2
        phi = Phi(z, z_next);
        for xi_next = 1:2
            sum0 = sum0 + phi * Xi(2, xi_next) * (V1(z_next, xi_next) - V0(z_next));
        end
    end
    EV0(z) = beta * sum0;

    for xi_cur = 1:2
        sum1 = 0;
        for z_next = 1:2
            phi = Phi(z, z_next);
            for xi_next = 1:2
                sum1 = sum1 + phi * Xi(xi_cur, xi_next) * (V1(z_next, xi_next) - V0(z_next));
            end
        end
        EV1(z, xi_cur) = beta * sum1;
    end
end

Delta0 = [profit_matrix(1, 2); profit_matrix(2, 2)] - theta.f_bar - theta.delta_f + EV0;
Delta1 = zeros(2, 2);
Delta1(1, 1) = profit_matrix(1, 1) - theta.f_bar + EV1(1, 1);
Delta1(1, 2) = profit_matrix(1, 2) - theta.f_bar + EV1(1, 2);
Delta1(2, 1) = profit_matrix(2, 1) - theta.f_bar + EV1(2, 1);
Delta1(2, 2) = profit_matrix(2, 2) - theta.f_bar + EV1(2, 2);

phi = @(x) exp(-0.5 * x .* x) ./ sqrt(2 * pi);
PhiC = @(x) 0.5 * erfc(-x ./ sqrt(2));
z0 = (Delta0 + mu) ./ sigma_eps;
z1 = (Delta1 + mu) ./ sigma_eps;
eps_mean0 = mu - sigma_eps * phi(z0) ./ max(PhiC(z0), 1e-12);
eps_mean1 = mu - sigma_eps * phi(z1) ./ max(PhiC(z1), 1e-12);

mu_state = sol.mu_state(:);
pe = sol.pe(:);
entry_masses = [mu_state(1) * pe(1); mu_state(2) * pe(2)];
entry_weights = entry_masses ./ max(sum(entry_masses), 1e-12);

continue_masses = [mu_state(3) * pe(3); mu_state(4) * pe(4); ...
    mu_state(5) * pe(5); mu_state(6) * pe(6)];
continue_weights = continue_masses ./ max(sum(continue_masses), 1e-12);
eps_mean1_vec = [eps_mean1(1, 1); eps_mean1(1, 2); eps_mean1(2, 1); eps_mean1(2, 2)];

entry_cost = theta.f_bar + theta.delta_f + sum(entry_weights .* eps_mean0);
continue_cost = theta.f_bar + sum(continue_weights .* eps_mean1_vec);

revenue_state = sol.revenue_state(:);
active_masses = sol.active_masses(:);
entry_revenue = sum(revenue_state(1:2) .* active_masses(1:2)) / max(sum(active_masses(1:2)), 1e-12);
continue_revenue = sum(revenue_state(3:6) .* active_masses(3:6)) / max(sum(active_masses(3:6)), 1e-12);
avg_revenue = sum(revenue_state .* active_masses) / max(sum(active_masses), 1e-12);

entry_mass = sol.entry_flow;
active_mass_total = sum(active_masses);
continue_mass = max(active_mass_total - entry_mass, 0);

% Aggregate fixed-cost burden and gross operating profits.
total_fixed_cost = entry_mass * entry_cost + continue_mass * continue_cost;
total_revenue = sum(revenue_state .* active_masses);
gross_operating_profit = total_revenue / max(sol.sigma, 1e-12); % Eq. (eq:r_pi)
net_operating_profit = gross_operating_profit - total_fixed_cost;

stats = struct();
stats.f1_over_f0 = theta.f_bar / max(theta.f_bar + theta.delta_f, 1e-12);
stats.entry_cost_conditional = entry_cost;
stats.continue_cost_conditional = continue_cost;
stats.entry_revenue = entry_revenue;
stats.continue_revenue = continue_revenue;
stats.avg_revenue = avg_revenue;
stats.entry_cost_share_entry_revenue = entry_cost / max(entry_revenue, 1e-12);
stats.continue_cost_share_continue_revenue = continue_cost / max(continue_revenue, 1e-12);
stats.entry_cost_share_avg_revenue = entry_cost / max(avg_revenue, 1e-12);
stats.continue_cost_share_avg_revenue = continue_cost / max(avg_revenue, 1e-12);
stats.entry_mass = entry_mass;
stats.continue_mass = continue_mass;
stats.active_mass_total = active_mass_total;
stats.total_fixed_cost = total_fixed_cost;
stats.total_revenue = total_revenue;
stats.gross_operating_profit = gross_operating_profit;
stats.net_operating_profit = net_operating_profit;
stats.total_fixed_cost_share_expenditure = total_fixed_cost / max(total_revenue, 1e-12);
stats.total_fixed_cost_share_gross_profit = total_fixed_cost / max(gross_operating_profit, 1e-12);
stats.total_fixed_cost_share_net_profit = total_fixed_cost / max(net_operating_profit, 1e-12);
end
