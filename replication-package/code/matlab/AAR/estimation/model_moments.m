function vec = model_moments(sol, theta, cfg)
%MODEL_MOMENTS Model counterparts to {entry, hazard1, growth2, growth3}.

hazard_curve = export_duration_hazard(sol, max(cfg.hazard_horizon, 5));
if numel(hazard_curve) < 2
    hazard_curve(2) = hazard_curve(end);
end
hazard_age1 = hazard_curve(1);

% Entry probability uses p_e(z,h=0) from Eq. (eq:pe_general) in AAR.tex and
% the steady-state trade-cost dynamics in Eq. (eq:xi_transition).
entry_rate = sol.entry_conditional;

growth2 = within_firm_growth_ratio_model(sol, 2);
growth3 = within_firm_growth_ratio_model(sol, 3);

vec = [entry_rate; hazard_age1; growth2; growth3];
end


%% -------------------------------------------------------------------------
function hazard = export_duration_hazard(sol, horizon)
%EXPORT_DURATION_HAZARD Exit probability conditional on exporter tenure.
%   Uses export choice probabilities p_e from Eq. (eq:pe_general) in AAR.tex
%   and trade-cost transitions from Eq. (eq:xi_transition).

if horizon <= 0
    hazard = zeros(0, 1);
    return;
end

Phi = sol.Phi;
Xi = sol.Xi;
pe = sol.pe(:);
mu_state = sol.mu_state(:);

% Entrant mass by productivity type (h = 0 states)
entrant_low = mu_state(1) * pe(1);
entrant_high = mu_state(2) * pe(2);

% Age-one entrants start in the high-cost state per Eq. (eq:xi_transition).
S = zeros(2, 2); % rows: z ∈ {L,H}, cols: ξ ∈ {L,H}
S(1, 2) = entrant_low;
S(2, 2) = entrant_high;

cont_prob = zeros(2, 2);
cont_prob(1, 1) = pe(3);
cont_prob(1, 2) = pe(4);
cont_prob(2, 1) = pe(5);
cont_prob(2, 2) = pe(6);

hazard = zeros(horizon, 1);
for t = 1:horizon
    denom = sum(S, 'all');
    if denom <= 0
        hazard(t) = 0;
        S(:) = 0;
    else
        survivors = cont_prob .* S;
        survival_mass = sum(survivors, 'all');
        hazard(t) = 1 - survival_mass / denom;

        S_next = zeros(2, 2);
        for z = 1:2
            for xi = 1:2
                surv = survivors(z, xi);
                if surv <= 0
                    continue;
                end
                for z_next = 1:2
                    phi = Phi(z, z_next);
                    for xi_next = 1:2
                        S_next(z_next, xi_next) = S_next(z_next, xi_next) + surv * phi * Xi(xi, xi_next);
                    end
                end
            end
        end
        S = S_next;
    end
end
end

%% -------------------------------------------------------------------------
function [growth, avg_sales] = export_life_cycle_sales_growth(sol, horizon)
%EXPORT_LIFE_CYCLE_SALES_GROWTH Export sales growth across exporter tenure.

if horizon <= 0
    growth = zeros(0, 1);
    avg_sales = zeros(0, 1);
    return;
end

Phi = sol.Phi;
Xi = sol.Xi;
pe = sol.pe(:);
mu_state = sol.mu_state(:);
revenue_matrix = sol.revenue_matrix;

entrant_low = mu_state(1) * pe(1);
entrant_high = mu_state(2) * pe(2);
S = zeros(2, 2);
S(1, 2) = entrant_low;
S(2, 2) = entrant_high;
total_entrants = sum(S, 'all');
if total_entrants <= 0
    growth = zeros(horizon, 1);
    avg_sales = zeros(horizon, 1);
    return;
end

cont_prob = zeros(2, 2);
cont_prob(1, 1) = pe(3);
cont_prob(1, 2) = pe(4);
cont_prob(2, 1) = pe(5);
cont_prob(2, 2) = pe(6);

avg_sales = zeros(horizon, 1);
for t = 1:horizon
    mass_active = sum(S, 'all');
    if mass_active <= 0
        if t == 1
            avg_sales(t) = 0;
        else
            avg_sales(t) = avg_sales(t - 1);
        end
    else
        revenue_total = sum(S .* revenue_matrix, 'all');
        avg_sales(t) = revenue_total / mass_active;
    end

    survivors = cont_prob .* S;
    S_next = zeros(2, 2);
    for z = 1:2
        for xi = 1:2
            surv = survivors(z, xi);
            if surv <= 0
                continue;
            end
            for z_next = 1:2
                phi = Phi(z, z_next);
                for xi_next = 1:2
                    S_next(z_next, xi_next) = S_next(z_next, xi_next) + surv * phi * Xi(xi, xi_next);
                end
            end
        end
    end
    S = S_next;
end

growth = avg_sales - avg_sales(1);
end

%% -------------------------------------------------------------------------
function ratio = within_firm_growth_ratio_model(sol, target_age)
%WITHIN_FIRM_GROWTH_RATIO_MODEL Expected revenue ratio for survivors at tenure target_age.
if target_age <= 1
    ratio = 1;
    return;
end

pe = sol.pe(:);
mu_state = sol.mu_state(:);
Xi = sol.Xi;
revenue_states = sol.revenue_state(:);
revenue_matrix = sol.revenue_matrix;

state_indices = [3, 4, 5, 6]; % exporter states
state_types = [1; 1; 2; 2];    % productivity type per state
state_xi = [1; 2; 1; 2];       % xi = {L,H}

entrant_low = mu_state(1) * pe(1);
entrant_high = mu_state(2) * pe(2);
total_entry = entrant_low + entrant_high;
if total_entry <= 0
    ratio = 0;
    return;
end

dist = zeros(4, 1);
% entrants start in ξ_H
dist(2) = entrant_low / total_entry;   % low type with ξ_H (state index 4 globally)
dist(4) = entrant_high / total_entry;  % high type with ξ_H

entry_revenue = zeros(2, 1);
entry_revenue(1) = revenue_matrix(1, 2);
entry_revenue(2) = revenue_matrix(2, 2);

revenue_vec = revenue_states(state_indices);
entry_rev_per_state = [entry_revenue(1); entry_revenue(1); entry_revenue(2); entry_revenue(2)];
continue_prob = [pe(3); pe(4); pe(5); pe(6)];

ratio = 1;
for age = 1:target_age
    ratio_current = sum(dist .* (revenue_vec ./ max(entry_rev_per_state, 1e-12)));
    if age == target_age
        ratio = ratio_current;
        break;
    end

    masses = dist .* continue_prob;
    survival_mass = sum(masses);
    if survival_mass <= 0
        ratio = ratio_current;
        break;
    end

    dist_next = zeros(size(dist));
    for s = 1:numel(dist)
        mass_s = masses(s);
        if mass_s <= 0
            continue;
        end
        type_s = state_types(s);
        xi_idx = state_xi(s);
        for xi_next = 1:2
            idx_next = local_state_index(type_s, xi_next);
            dist_next(idx_next) = dist_next(idx_next) + mass_s * Xi(xi_idx, xi_next);
        end
    end
    dist = dist_next / survival_mass;
end
end

function idx = local_state_index(type_id, xi_idx)
%LOCAL_STATE_INDEX Map (type, ξ) to the 4-element exporter state ordering.
if type_id == 1
    if xi_idx == 1
        idx = 1;
    else
        idx = 2;
    end
else
    if xi_idx == 1
        idx = 3;
    else
        idx = 4;
    end
end
end

%% -------------------------------------------------------------------------
% Note: price-dispersion diagnostics are still produced in baseline moments but
% no longer enter the MSM objective for the streamlined configuration.
