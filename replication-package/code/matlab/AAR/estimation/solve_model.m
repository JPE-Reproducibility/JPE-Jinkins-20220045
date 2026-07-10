function sol = solve_model(theta, cfg)
%SOLVE_MODEL Two-type export model with trade-cost shocks (AAR_extension).
%   θ = (f_bar, Δ_f, ξ_H, ρ_ξ, Z_H/Z_L) determines the fixed
%   costs, productivity dynamics, and exporter-specific iceberg wedges.
%   Revenues follow Eq. (AAR_r_pi_xi) and the fixed-cost problem follows
%   Eqs. (AAR_Delta_xi)–(AAR_V_general). The outer fixed point iterates on
%   the denominator of Eq. (AAR_Pstar_xi) until the implied price index is
%   consistent with the mass of active exporters.

arguments
    theta struct
    cfg struct
end

%% Fixed primitives
beta        = cfg.beta;
sigma       = cfg.sigma;
w           = cfg.wage;
tau         = cfg.tau;
shock_mu    = cfg.shock_mu;
shock_sigma = cfg.shock_sigma;
import_expenditure = cfg.import_expenditure; % E* in Eq. (AAR_r_pi_xi)
Delta_f     = theta.delta_f;
mu_markup   = sigma / (sigma - 1);           % Eq. (AAR_price)

% Productivity types are permanent: Φ = I per Eq. (phi_identity).
Phi = eye(2);
if isfield(cfg, 'phi') && ~isempty(cfg.phi)
    if any(abs(cfg.phi(:) - Phi(:)) > 1e-12)
        error('solve_model:phi', ...
            'Phi is hard-coded to identity (per Eq. (phi_identity)); modify solve_model.m to use alternative dynamics.');
    end
end

rho_xi = min(max(theta.rho_xi, 1e-6), 1 - 1e-6);
Xi = [rho_xi, 1 - rho_xi; 1 - rho_xi, rho_xi]; % Eq. (AAR_Xi)

tariff_multiplier = ones(2, 1);
if isfield(cfg, 'policy') && isfield(cfg.policy, 'tariff_low_z') && ~isempty(cfg.policy.tariff_low_z)
    tariff_multiplier(1) = (1 + cfg.policy.tariff_low_z)^(1 - sigma);
end

%% State bookkeeping: rows = (z_idx, h ∈ {0,1}, xi_idx)
state_info = [
    1 0 2;  % (L,0) entrants always use ξ_H for current profits
    2 0 2;  % (H,0)
    1 1 1;  % (L, ξ_L,1)
    1 1 2;  % (L, ξ_H,1)
    2 1 1;  % (H, ξ_L,1)
    2 1 2   % (H, ξ_H,1)
];
num_states = size(state_info, 1);

if ~isfield(cfg, 'calib_type_share') || isempty(cfg.calib_type_share)
    error('solve_model:calibration', 'cfg.calib_type_share must be provided by the EJTX baseline.');
end

if ~isfield(theta, 'z_ratio') || isempty(theta.z_ratio)
    error('solve_model:parameters', 'theta.z_ratio must be provided when estimating the productivity ratio.');
end

%% Mass of each productivity type (fixed from EJTX moments)
M_total = cfg.mass_M;
omega_H = min(max(real(cfg.calib_type_share), 1e-6), 1 - 1e-6);
M_H = M_total * omega_H;
M_L = M_total - M_H;

%% Productivity and trade-cost values
z_ratio = max(real(theta.z_ratio), 1 + 1e-8);
z_values  = [1.0; z_ratio];
xi_values = [1.0; max(theta.xi_H, 1 + 1e-8)];
q_values  = z_values.^(sigma - 1);
xi_terms  = xi_values.^(1 - sigma);

%% Outer fixed point initialisation (Eq. (AAR_Pstar_xi))
Den = max(sum([M_L, M_H] .* (q_values.' * xi_terms(2))), 1e-6);
outer_converged = false;
lambda = min(max(cfg.damping, cfg.damping_min), cfg.damping_max);
prev_gap = Inf;
last_gap = Inf;

for iter_outer = 1:cfg.max_outer
    revenue_matrix = zeros(2, 2);
    for s = 1:2
        for m = 1:2
            revenue_matrix(s, m) = import_expenditure * xi_terms(m) * q_values(s) * tariff_multiplier(s) / Den;
        end
    end
    profit_matrix = revenue_matrix / sigma;

    [pe, V, inner_converged] = solve_firm_problem_trade_cost(...
        profit_matrix, beta, Phi, Xi, shock_mu, shock_sigma, theta.f_bar, Delta_f, cfg.max_inner, cfg.inner_tol);
    if ~inner_converged
        error('solve_model:valueIteration', ...
            'Value function iteration failed to converge within %d iterations (tol = %.1e).', ...
            cfg.max_inner, cfg.inner_tol);
    end

    T = transition_matrix_trade_cost(pe, Phi, Xi);

    % With permanent types Φ = I each type evolves independently. Construct
    % the within-type stationary distributions explicitly to avoid the
    % degeneracy that arises when applying a global eigenvector to the block
    % diagonal transition matrix.
    mu_type_L = type_stationary_distribution(pe(1), pe(3), pe(4), Xi);
    mu_type_H = type_stationary_distribution(pe(2), pe(5), pe(6), Xi);

    % Scale by the calibrated type masses so that mu_state sums to one.
    mu_state = zeros(num_states, 1);
    mu_state([1, 3, 4]) = (M_L / (M_L + M_H)) * mu_type_L;
    mu_state([2, 5, 6]) = (M_H / (M_L + M_H)) * mu_type_H;

    % Conditional distribution of productivity types across history/ξ states
    mu_L_states = mu_state([1, 3, 4]);
    mu_H_states = mu_state([2, 5, 6]);
    mu_L = sum(mu_L_states);
    mu_H = sum(mu_H_states);
    if mu_L > 0
        cond_L = mu_L_states / mu_L;
    else
        cond_L = [1, 0, 0];
    end
    if mu_H > 0
        cond_H = mu_H_states / mu_H;
    else
        cond_H = [1, 0, 0];
    end

    % Active exporter masses by (z, ξ)
    N_L_xiL = M_L * cond_L(2) * pe(3);
    N_L_xiH = M_L * (cond_L(1) * pe(1) + cond_L(3) * pe(4));
    N_H_xiL = M_H * cond_H(2) * pe(5);
    N_H_xiH = M_H * (cond_H(1) * pe(2) + cond_H(3) * pe(6));

    Den_new = N_L_xiL * xi_terms(1) * q_values(1) + ...
              N_L_xiH * xi_terms(2) * q_values(1) + ...
              N_H_xiL * xi_terms(1) * q_values(2) + ...
              N_H_xiH * xi_terms(2) * q_values(2);

    gap = abs(Den_new - Den);
    last_gap = gap;
    if gap < cfg.outer_tol * max(1.0, Den)
        Den = max(Den_new, 1e-8);
        outer_converged = true;
        break;
    end

    if gap > prev_gap
        lambda = max(lambda * cfg.damping_shrink, cfg.damping_min);
    else
        lambda = min(lambda * cfg.damping_growth, cfg.damping_max);
    end
    Den = (1 - lambda) * Den + lambda * Den_new;
    Den = max(Den, 1e-8);
    prev_gap = gap;
end

if ~outer_converged
    error('Outer loop failed to converge after %d iterations (gap = %.3g).', ...
        cfg.max_outer, last_gap);
end

%% Equilibrium objects
P_star = mu_markup * tau * w * Den.^(1 / (1 - sigma)); % Eq. (AAR_price)

% Entry and exit rates
entry_flow = M_L * cond_L(1) * pe(1) + M_H * cond_H(1) * pe(2);
non_export_mass = mu_state(1) + mu_state(2);
entry_conditional = entry_flow / max(non_export_mass, 1e-8);
exit_masses = [M_L * cond_L(2); M_L * cond_L(3); M_H * cond_H(2); M_H * cond_H(3)];
exit_probs = [1 - pe(3); 1 - pe(4); 1 - pe(5); 1 - pe(6)];
total_exit_mass = sum(exit_masses);
if total_exit_mass > 0
    exit_rate = sum(exit_masses .* exit_probs) / total_exit_mass;
else
    exit_rate = 0;
end

% Exporter masses (used by diagnostics and life-cycle calculations)
active_masses = zeros(num_states, 1);
active_masses(1) = M_L * cond_L(1) * pe(1);
active_masses(2) = M_H * cond_H(1) * pe(2);
active_masses(3) = N_L_xiL;
active_masses(4) = M_L * cond_L(3) * pe(4);
active_masses(5) = N_H_xiL;
active_masses(6) = M_H * cond_H(3) * pe(6);

% Revenue and price vectors by state
revenue_state = zeros(num_states, 1);
log_price_state = zeros(num_states, 1);
for idx = 1:num_states
    z_idx = state_info(idx, 1);
    xi_idx = state_info(idx, 3);
    revenue_state(idx) = revenue_matrix(z_idx, xi_idx);
    price_val = mu_markup * tau * xi_values(xi_idx) * w / z_values(z_idx);
    log_price_state(idx) = log(price_val);
end

%% Package outputs for downstream routines
sol = struct();
sol.pe               = pe;
sol.V                = V;
sol.T                = T;
sol.mu_state         = mu_state;
sol.outer_converged  = outer_converged;
sol.iter_outer       = iter_outer;
sol.outer_lambda     = lambda;
sol.outer_gap        = last_gap;
sol.revenue_matrix   = revenue_matrix;
sol.revenue_state    = revenue_state;
sol.log_price_state  = log_price_state;
sol.P_star           = P_star;
sol.entry_flow       = entry_flow;
sol.exit_rate        = exit_rate;
sol.entry_conditional = entry_conditional;
sol.non_export_mass  = non_export_mass;
sol.exit_masses     = exit_masses;
sol.exit_probs      = exit_probs;
% Export revenue levels used for moment mapping

sol.N_components     = struct('L', [N_L_xiL, N_L_xiH], 'H', [N_H_xiL, N_H_xiH]);
sol.active_masses    = active_masses;
sol.N_ratio          = (N_H_xiL + N_H_xiH) / max(N_L_xiL + N_L_xiH, 1e-12);
sol.beta             = beta;
sol.import_expenditure = import_expenditure;
sol.theta            = theta;
sol.Phi              = Phi;
sol.Xi               = Xi;
sol.z_values         = z_values;
sol.xi_values        = xi_values;
sol.state_info       = state_info;
sol.sigma            = sigma;
sol.mu_markup        = mu_markup;
end

%% -------------------------------------------------------------------------
function [pe_vec, V_vec, converged] = solve_firm_problem_trade_cost(profit_matrix, beta, Phi, Xi, shock_mu, shock_sigma, f_bar, Delta_f, max_iter, tol)
%SOLVE_FIRM_PROBLEM_TRADE_COST Value functions with trade-cost shocks (Eq. AAR_Delta_xi).

V0 = zeros(2, 1);      % V(z, h=0)
V1 = zeros(2, 2);      % V(z, ξ, h=1)
converged = false;

profit_L = profit_matrix(1, :);
profit_H = profit_matrix(2, :);

for iter = 1:max_iter
    A = beta * (Phi * V0);

    % Continuation premia β E[V(z',ξ',1) - V(z',ξ_H,0)]
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

    Delta0 = zeros(2,1);
    Delta1 = zeros(2,2);
    Delta0(1) = profit_L(2) - f_bar - Delta_f + EV0(1);
    Delta0(2) = profit_H(2) - f_bar - Delta_f + EV0(2);
    Delta1(1,1) = profit_L(1) - f_bar + EV1(1,1);
    Delta1(1,2) = profit_L(2) - f_bar + EV1(1,2);
    Delta1(2,1) = profit_H(1) - f_bar + EV1(2,1);
    Delta1(2,2) = profit_H(2) - f_bar + EV1(2,2);

    [prob0, MG0] = normal_choice_terms(Delta0, shock_mu, shock_sigma);
    [probL, MGL] = normal_choice_terms(Delta1(1, :).', shock_mu, shock_sigma);
    [probH, MGH] = normal_choice_terms(Delta1(2, :).', shock_mu, shock_sigma);

    V0_new = A + MG0;
    V1_new = [MGL.'; MGH.'];
    for z = 1:2
        V1_new(z, :) = V1_new(z, :) + A(z);
    end

    diff = max([max(abs(V0_new - V0)), max(abs(V1_new - V1), [], 'all')]);
    V0 = V0_new;
    V1 = V1_new;
    if diff < tol
        converged = true;
        break;
    end
end

if ~converged
    warning('solve_model:innerLoop', 'Value iteration reached max_iter = %d (tol %.2e).', max_iter, tol);
end

pe_vec = [prob0(1); prob0(2); probL(1); probL(2); probH(1); probH(2)];
V_vec = [V0(1); V0(2); V1(1,1); V1(1,2); V1(2,1); V1(2,2)];
end

%% -------------------------------------------------------------------------
function [prob, MG] = normal_choice_terms(Delta, mu, sigma)
%NORMAL_CHOICE_TERMS Export probabilities and option values under normal shocks.
if sigma <= 0
    error('shock_sigma must be strictly positive.');
end
z = (Delta + mu) ./ sigma;
prob = 0.5 * erfc(-z ./ sqrt(2));
MG   = (Delta + mu) .* prob + sigma .* exp(-0.5 * z .* z) / sqrt(2 * pi);
end

%% -------------------------------------------------------------------------
function T = transition_matrix_trade_cost(pe, Phi, Xi)
%TRANSITION_MATRIX_TRADE_COST Transition over {(L,0),(H,0),(L,ξ_L,1),(L,ξ_H,1),(H,ξ_L,1),(H,ξ_H,1)}.
state_info = [
    1 0 2;
    2 0 2;
    1 1 1;
    1 1 2;
    2 1 1;
    2 1 2
];
num_states = size(state_info, 1);
T = zeros(num_states);

for i = 1:num_states
    z_idx = state_info(i,1);
    h = state_info(i,2);
    xi_idx = state_info(i,3);
    prob_export = pe(i);

    for z_next = 1:2
        phi_entry = Phi(z_idx, z_next);
        idx_noexport = state_index_trade_cost(z_next, 0);
        idx_export_L = state_index_trade_cost(z_next, 1, 1);
        idx_export_H = state_index_trade_cost(z_next, 1, 2);

        T(i, idx_noexport) = T(i, idx_noexport) + (1 - prob_export) * phi_entry;
        row_idx = (h == 0) * 2 + (h == 1) * xi_idx; % entrants use ξ_H row
        T(i, idx_export_L) = T(i, idx_export_L) + prob_export * phi_entry * Xi(row_idx, 1);
        T(i, idx_export_H) = T(i, idx_export_H) + prob_export * phi_entry * Xi(row_idx, 2);
    end
end
end

function idx = state_index_trade_cost(z_idx, h, xi_idx)
%STATE_INDEX_TRADE_COST Map (z,h,ξ) to the 1..6 index.
if nargin < 3
    xi_idx = 2;
end
if h == 0
    if z_idx == 1
        idx = 1;
    else
        idx = 2;
    end
else
    if z_idx == 1
        idx = 2 + xi_idx; % 3 or 4
    else
        idx = 4 + xi_idx; % 5 or 6
    end
end
end

%% -------------------------------------------------------------------------
function mu_type = type_stationary_distribution(p_entry, p_xiL, p_xiH, Xi)
%TYPE_STATIONARY_DISTRIBUTION Stationary distribution over {h=0, ξ_L, ξ_H}.
%   Permanent productivity types imply that each block evolves independently;
%   this helper builds the 3x3 transition matrix for a given type and returns
%   the unique stationary distribution (left eigenvector associated with 1).

T_type = zeros(3);

% State order: {h=0, ξ_L, ξ_H}
% h=0 → remain h=0 or start exporting and draw ξ from the ξ_H row
T_type(1, 1) = 1 - p_entry;
T_type(1, 2) = p_entry * Xi(2, 1);
T_type(1, 3) = p_entry * Xi(2, 2);

% Exporters with ξ=ξ_L either exit or continue and transition using row 1
T_type(2, 1) = 1 - p_xiL;
T_type(2, 2) = p_xiL * Xi(1, 1);
T_type(2, 3) = p_xiL * Xi(1, 2);

% Exporters with ξ=ξ_H behave analogously with row 2
T_type(3, 1) = 1 - p_xiH;
T_type(3, 2) = p_xiH * Xi(2, 1);
T_type(3, 3) = p_xiH * Xi(2, 2);

mu_type = stationary_distribution(T_type);
mu_type = mu_type(:);
end
