%% RUN_ESTIMATION calibrates the export-only dynamic model in AAR.pdf.
%  The script (i) loads the empirical targets from DATA_MOMENTS_BASELINE,
%  (ii) computes the reduced-form objects that map the data into the
%  moment vector, and (iii) uses Method of Simulated Moments to estimate
%  theta = (f_bar, delta_f, xi_H, rho_xi). Type shares and the productivity
%  ratio remain fixed from the EJTX baseline moments while productivity types
%  stay permanent per instruction.
%
%  The economic structure follows AAR.pdf:
%    - Preferences: Eq. (1)
%    - Pricing and revenues: Eqs. (4)–(7)
%    - Firm problem with additive normal shocks: Eqs. (8)–(12)
%    - Stationary equilibrium: Eq. (14) with two productivity types
%
%  See README.txt for a verbal overview.

clear; clc;
this_dir = fileparts(mfilename('fullpath'));
addpath(this_dir);

%% 1. Load empirical targets
param_fix = cell(15, 1);
empirical_targets = data_moments_baseline(param_fix);

%% 2. Map data into model-consistent summary statistics
config = default_config();
empirical_summary = compute_empirical_moments(empirical_targets, config);

if isfield(config, 'override_calibration') && isfield(config.override_calibration, 'z_ratio') ...
        && ~isempty(config.override_calibration.z_ratio)
    config.calib_z_ratio = config.override_calibration.z_ratio;
else
    config.calib_z_ratio = empirical_summary.calibration.z_ratio;
end
if isfield(config, 'override_calibration') && isfield(config.override_calibration, 'omega_H') ...
        && ~isempty(config.override_calibration.omega_H)
    config.calib_type_share = config.override_calibration.omega_H;
else
    config.calib_type_share = empirical_summary.calibration.omega_H;
end

%% 3. Launch the MSM estimator
results = estimate_parameters(empirical_summary, config);

%% 4. Report estimates
fprintf('Estimated parameters (physical scale)\n');
fprintf('  f_bar         = %8.4f\n', results.theta.f_bar);
fprintf('  delta_f       = %8.4f\n', results.theta.delta_f);
fprintf('  xi_H          = %8.4f\n', results.theta.xi_H);
fprintf('  rho_xi        = %8.4f\n', results.theta.rho_xi);

fprintf('\nCalibrated primitives\n');
fprintf('  sigma     = %8.4f\n', results.cfg.sigma);
fprintf('  shock_mu  = %8.4f\n', results.cfg.shock_mu);
fprintf('  shock_sigma (fixed) = %8.4f\n', results.cfg.shock_sigma);
fprintf('  omega_H (cal.)     = %8.4f\n', results.theta.omega_H);
fprintf('  z_H/z_L (cal.)     = %8.4f\n', results.theta.z_ratio);

fprintf('\nModel moments vs. data\n');
labels = empirical_summary.moment_labels;
for k = 1:numel(labels)
    fprintf('  %-18s data = %8.4f   model = %8.4f\n', labels{k}, ...
        empirical_summary.data_moments(k), results.model_moments(k));
end

if isfield(results, 'cost_shares')
    cs = results.cost_shares;
    fprintf('\nEntry/continuation cost diagnostics\n');
    fprintf('  f1/f0 = %8.4f\n', cs.f1_over_f0);
    fprintf('  Avg entry cost | entry = %8.4f\n', cs.entry_cost_conditional);
    fprintf('  Avg cont. cost | continue = %8.4f\n', cs.continue_cost_conditional);
    fprintf('  Entry cost / entry revenue = %8.4f\n', cs.entry_cost_share_entry_revenue);
    fprintf('  Continue cost / continuer revenue = %8.4f\n', cs.continue_cost_share_continue_revenue);

    fprintf('\nAggregate supplier cost-burden diagnostics\n');
    fprintf('  Total fixed cost / import expenditure = %8.4f\n', ...
        cs.total_fixed_cost_share_expenditure);
    fprintf('  Total fixed cost / supplier gross profits = %8.4f\n', ...
        cs.total_fixed_cost_share_gross_profit);

    % EJTX benchmark objects used in the referee comparison paragraph.
    ejtx_cost_share_expenditure = 0.064;
    ejtx_cost_share_supplier_profit = 0.45;
    fprintf('\nComparison against EJTX benchmark\n');
    fprintf('  EJTX: search cost / expenditure = %8.4f\n', ejtx_cost_share_expenditure);
    fprintf('  AAR : fixed cost / expenditure  = %8.4f\n', cs.total_fixed_cost_share_expenditure);
    fprintf('  EJTX: search cost / supplier profit = %8.4f\n', ejtx_cost_share_supplier_profit);
    fprintf('  AAR : fixed cost / supplier gross profit = %8.4f\n', ...
        cs.total_fixed_cost_share_gross_profit);
end

% Diagnostic: show how the composition of exporters evolves in the data moments
if isfield(empirical_summary, 'nh_over_nl')
    fprintf('\nExporter composition (data moments)\n');
    ratios = empirical_summary.nh_over_nl(:);
    ages = empirical_summary.life_cycle_ages(:);
    for k = 1:numel(ratios)
        age_val = ages(k);
        ratio_val = ratios(k);
        if isfinite(ratio_val)
            fprintf('  age %2d: N_H/N_L = %8.4f\n', age_val, ratio_val);
        elseif ratio_val > 0
            fprintf('  age %2d: N_H/N_L = +Inf (no low types)\n', age_val);
        else
            fprintf('  age %2d: N_H/N_L undefined\n', age_val);
        end
    end
end

if isfield(empirical_summary, 'nh_over_nl_overall')
    overall_data = empirical_summary.nh_over_nl_overall;
    if isfinite(overall_data)
        fprintf('  Overall (data): N_H/N_L = %8.4f\n', overall_data);
    elseif overall_data > 0
        fprintf('  Overall (data): N_H/N_L = +Inf (no low types)\n');
    else
        fprintf('  Overall (data): N_H/N_L undefined\n');
    end
end

% Model-side diagnostic extracted from the stationary distribution
if isfield(results, 'solution') && isfield(results.solution, 'N_ratio')
    fprintf('\nExporter composition (model moments)\n');

    horizon = config.life_cycle_horizon;
    if isfield(empirical_summary, 'life_cycle_ages')
        ages_model = empirical_summary.life_cycle_ages(:);
    else
        ages_model = (1:horizon)';
    end

    model_ratio = exporter_type_ratio_model(results.solution, horizon);
    num_print = min(numel(model_ratio), numel(ages_model));
    for k = 1:num_print
        age_val = ages_model(k);
        ratio_val = model_ratio(k);
        if isfinite(ratio_val)
            fprintf('  age %2d: N_H/N_L = %8.4f\n', age_val, ratio_val);
        elseif ratio_val > 0
            fprintf('  age %2d: N_H/N_L = +Inf (no low types)\n', age_val);
        else
            fprintf('  age %2d: N_H/N_L undefined\n', age_val);
        end
    end

    fprintf('  Overall (model): N_H/N_L = %8.4f\n', results.solution.N_ratio);

    if isfield(results.solution, 'mu_state') && numel(results.solution.mu_state) >= 4
        mu = results.solution.mu_state(:);
        low_active = mu(3);
        high_active = mu(4);
        if low_active > 0
            ratio_active = high_active / low_active;
            fprintf('  Active exporter states (H/L) = %8.4f\n', ratio_active);
        elseif high_active > 0
            fprintf('  Active exporter states (H/L) = +Inf (no low types)\n');
        else
            fprintf('  Active exporter states (H/L) undefined\n');
        end
    end
end

%% Optional: store results for downstream scripts
save(fullfile(config.output_dir, 'estimation_results.mat'), 'results', ...
    'empirical_summary', 'config');

function ratio = exporter_type_ratio_model(sol, horizon)
%EXPORTER_TYPE_RATIO_MODEL High-to-low exporter ratio across tenure for the model solution.
if nargin < 2 || horizon <= 0
    ratio = zeros(0, 1);
    return;
end

Phi = sol.Phi;
Xi = sol.Xi;
pe = sol.pe(:);
mu = sol.mu_state(:);

entrants = zeros(2, 2);
entrants(1, :) = mu(1) * pe(1) * Xi(2, :);
entrants(2, :) = mu(2) * pe(2) * Xi(2, :);

cont_prob = [pe(3), pe(4); pe(5), pe(6)];
S = entrants;
ratio = zeros(horizon, 1);

for t = 1:horizon
    low_mass = sum(S(1, :));
    high_mass = sum(S(2, :));
    if low_mass > 0
        ratio(t) = high_mass / low_mass;
    elseif high_mass > 0
        ratio(t) = Inf;
    else
        ratio(t) = NaN;
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
end
