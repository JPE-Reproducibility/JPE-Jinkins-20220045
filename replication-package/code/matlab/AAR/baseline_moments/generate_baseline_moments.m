function results = generate_baseline_moments()
%GENERATE_BASELINE_MOMENTS Moments from the EJTX baseline simulation.
%   Computes exporter exit by size, entry rates, and life-cycle growth
%   profiles using the legacy baseline simulation code bundled with the
%   project. Outputs are saved in the same folder as this function.

this_dir = fileparts(mfilename('fullpath'));
root_dir = fileparts(this_dir);
legacy_dir = fullfile(root_dir, 'legacy');

life_cycle_horizon = 10;      % number of ages reported in the summary outputs
hazard_horizon = 5;           % number of export-duration hazard points retained
num_bootstrap_draws = 500;    % bootstrap replicates for moment covariance
bootstrap_ridge = 1.0e-8;     % numerical ridge for covariance inversion
import_share_data = 0.7308;   % retained for calibration of α via EJTX mark-up Eq. (\ref{mark-up})
growth_target_ages = [2, 3];  % tenures used for within-firm growth moments

baseline_sim_dir = fullfile(root_dir, 'other_code', 'baseline simulation');
if ~isfolder(baseline_sim_dir)
    baseline_sim_dir = fullfile(legacy_dir, 'other_code', 'baseline simulation');
end
paths_to_use = {baseline_sim_dir, this_dir};
added_flags = false(size(paths_to_use));
for idx = 1:numel(paths_to_use)
    candidate = paths_to_use{idx};
    if isempty(candidate) || ~isfolder(candidate)
        continue;
    end
    if ~is_path_member(candidate)
        addpath(candidate);
        added_flags(idx) = true;
    end
end
path_cleaner = onCleanup(@() remove_added_paths(paths_to_use, added_flags));

baseline_results = fullfile(root_dir, 'baseline_no_NsNb_target', 'results', ...
    'se_results_no_M_target.mat');
if ~isfile(baseline_results)
    baseline_results = fullfile(legacy_dir, 'baseline_no_NsNb_target', 'results', ...
        'se_results_no_M_target.mat');
end
if ~isfile(baseline_results)
    error('Baseline results file not found: %s', baseline_results);
end

data = load(baseline_results, 'x');
if ~isfield(data, 'x')
    error('Parameter vector x not found in %s.', baseline_results);
end
x = data.x;

% Replicate the baseline pipeline (parameter scripts run in function scope)
define_parameters;
define_states;
define_lindex;

param = x2param(x);

[thetas, thetab, ~, U1, U2, ~, mMb, msb, u1, u2, Ms1, Ms2, ~, QS1, QS2, ...
    ~, ~, ~, ~, net_prof_s1, net_prof_s2] = ...
    solve_model(x, param_indx, param_state, param_fix);

% Expected match revenue by seller type (used as sales scalar)
[rev_type1, rev_type2] = expected_match_revenue(net_prof_s1, net_prof_s2, msb, mMb, param_fix);

w2_x = param{7};

exit_stats = compute_size_exit_rates(QS1, QS2, Ms1, Ms2, w2_x, rev_type1, rev_type2);

% Entry rates (annual horizon)
P1 = expm(QS1);
P2 = expm(QS2);

entry_prob_type1 = 1 - P1(1, 1);
entry_prob_type2 = 1 - P2(1, 1);

share_zero_type1 = (1 - w2_x) * Ms1(1);
share_zero_type2 = w2_x * Ms2(1);
share_zero_total = share_zero_type1 + share_zero_type2;

entry_flow = share_zero_type1 * entry_prob_type1 + share_zero_type2 * entry_prob_type2;
if share_zero_total > 0
    entry_rate_conditional = entry_flow / share_zero_total;
else
    entry_rate_conditional = NaN;
end

entry_table = table(entry_prob_type1, entry_prob_type2, share_zero_type1, ...
    share_zero_type2, share_zero_total, entry_flow, entry_rate_conditional);

entry_summary = struct( ...
    'unconditional', entry_flow, ...
    'conditional', entry_rate_conditional, ...
    'type1_probability', entry_prob_type1, ...
    'type2_probability', entry_prob_type2, ...
    'share_zero_type1', share_zero_type1, ...
    'share_zero_type2', share_zero_type2, ...
    'share_zero_total', share_zero_total ...
);

base_seed = 48611;
rev_per_type = [rev_type1; rev_type2];
profile = compute_lifecycle_profile(thetas, thetab, U1, U2, msb, u1, u2, param_fix, param, 30, base_seed, rev_per_type);

if numel(profile.agg_growth) < life_cycle_horizon
    error('Life-cycle profile shorter (%d) than requested horizon (%d).', ...
        numel(profile.agg_growth), life_cycle_horizon);
end

ages = profile.ages;
agg_avg_matches = profile.agg_mean_seller;
agg_growth = profile.agg_growth;
type1_avg = profile.type1_avg;
type2_avg = profile.type2_avg;
type1_growth = profile.type1_growth;
type2_growth = profile.type2_growth;
nh_over_nl = profile.type_ratio;

seller_counts = profile.seller_count;
agg_counts = profile.agg_count_seller;

% Export sales (transfer plus cost rebate) map matches into revenues per EJTX Eq. (\ref{bargaining})
type1_sales_avg = type1_avg * rev_type1;
type2_sales_avg = type2_avg * rev_type2;

agg_avg_sales = (type1_sales_avg .* seller_counts(:, 1) + type2_sales_avg .* seller_counts(:, 2)) ./ ...
    max(agg_counts, eps);

type1_sales_growth = type1_sales_avg - type1_sales_avg(1);
type2_sales_growth = type2_sales_avg - type2_sales_avg(1);
agg_sales_growth = agg_avg_sales - agg_avg_sales(1);

sales_std = profile.seller_std .* [rev_type1, rev_type2];
count_weights = seller_counts ./ max(sum(seller_counts, 2), 1);
var_sales_components = (count_weights .^ 2) .* (sales_std .^ 2 ./ max(seller_counts, 1));
agg_sales_se = sqrt(sum(var_sales_components, 2));
agg_sales_se(~isfinite(agg_sales_se)) = 0;

profile.agg_avg_sales = agg_avg_sales;
profile.agg_sales_growth = agg_sales_growth;
profile.agg_sales_se = agg_sales_se;
profile.type1_sales_avg = type1_sales_avg;
profile.type1_sales_growth = type1_sales_growth;
profile.type2_sales_avg = type2_sales_avg;
profile.type2_sales_growth = type2_sales_growth;

% Store both match and sales metrics so diagnostics align with EJTX outputs
life_cycle_table = table(ages, agg_avg_matches, agg_growth, agg_avg_sales, agg_sales_growth, ...
    type1_avg, type1_growth, type1_sales_avg, type1_sales_growth, ...
    type2_avg, type2_growth, type2_sales_avg, type2_sales_growth, nh_over_nl);

% Tenure-dependent exit hazards computed from exporter spell histories
if numel(profile.hazard_agg) < hazard_horizon
    error('Hazard curve shorter (%d) than requested horizon (%d).', ...
        numel(profile.hazard_agg), hazard_horizon);
end

hazard_age = (1:hazard_horizon)';
hazard_series = profile.hazard_agg(1:hazard_horizon);
hazard_exposure = profile.hazard_risk(1:hazard_horizon);
hazard_exits = profile.hazard_exit(1:hazard_horizon);

if any(hazard_series < -1e-10) || any(hazard_series > 1 + 1e-10)
    warning('Duration hazards outside [0,1] detected (min %.5f, max %.5f).', ...
        min(hazard_series), max(hazard_series));
end

duration_table = table(hazard_age, hazard_series, hazard_exposure, hazard_exits, ...
    'VariableNames', {'age', 'hazard', 'exposure', 'exit_count'});

% Entry probability maps to exporter entry choice p_e(z,h=0) in Eq. (eq:pe_general) of AAR.tex.
entry_rate_conditional = entry_summary.conditional;
if ~isfinite(entry_rate_conditional)
    entry_rate_conditional = 0;
end

% Tenure hazards (Eq. (eqn: eom_seller1)) feed the tenure-1 exit target; other
% horizons are retained for diagnostics and survival summaries.
hazard_idx1 = 1;
hazard_idx2 = min(2, hazard_horizon);
hazard_idx5 = min(5, hazard_horizon);
hazard_age1 = hazard_series(hazard_idx1);
hazard_age2 = hazard_series(hazard_idx2);
hazard_age5 = hazard_series(hazard_idx5);
survival_two_years = (1 - hazard_age1) * (1 - hazard_age2);
if hazard_idx5 == hazard_idx1
    hazard_ratio = 1;
else
    hazard_ratio = hazard_age5 / max(hazard_age1, 1e-8);
end

growth_stats = compute_within_firm_growth_stats(profile.seller_sales_by_age, growth_target_ages);
if any(~isfinite(growth_stats.mean))
    error('Within-firm growth ratios unavailable at requested horizons.');
end

type_ratio_overall = profile.type_ratio_overall;
omega_H = type_ratio_overall / max(1 + type_ratio_overall, eps);
omega_H = min(max(real(omega_H), 1e-6), 1 - 1e-6);
z_ratio_calib = type2_sales_avg(1) / max(type1_sales_avg(1), eps);

if profile.reentry_exits > 0
    reentry_probability = profile.reentry_success / profile.reentry_exits;
else
    reentry_probability = 0;
end

moment_vector = assemble_moment_vector(entry_rate_conditional, hazard_age1, ...
    growth_stats.mean(1), growth_stats.mean(2));

Ns = param{11};
N_sim = param_fix{18};
sample_total = max(round(Ns * N_sim), 1);

life_cycle_mean = profile.agg_avg_sales(1:life_cycle_horizon);
life_cycle_se = profile.agg_sales_se(1:life_cycle_horizon);
life_cycle_se(~isfinite(life_cycle_se)) = 0;

moment_draws = zeros(numel(moment_vector), num_bootstrap_draws);
for b = 1:num_bootstrap_draws
    rng(base_seed + 1000 + b);
    entry_draw = bootstrap_entry_conditional(entry_summary, sample_total);
    hazard_boot = bootstrap_duration_hazard(hazard_exits, hazard_exposure);
    h1 = hazard_boot(1);
    growth_draws = zeros(numel(growth_target_ages), 1);
    for g = 1:numel(growth_target_ages)
        samples = growth_stats.samples{g};
        if isempty(samples)
            growth_draws(g) = growth_stats.mean(g);
        else
            idx = randi(numel(samples), numel(samples), 1);
            growth_draws(g) = mean(samples(idx));
        end
    end
    moment_draws(:, b) = [entry_draw; h1; growth_draws(:)];
end

moment_cov = cov(moment_draws');
moment_cov = moment_cov + bootstrap_ridge * eye(size(moment_cov));
weight_matrix = inv(moment_cov);

% Persist outputs
results = struct();
results.exit_stats = exit_stats;
results.entry = entry_table;
results.life_cycle = life_cycle_table;
results.import_share = import_share_data;

% Aggregate composition statistic helps monitor selection in steady state
results.nh_over_nl_overall = profile.type_ratio_overall;

results.exit_deciles = struct( ...
    'decile', exit_stats.by_quantile.bin_index, ...
    'cdf_lower', exit_stats.by_quantile.cdf_lower, ...
    'cdf_upper', exit_stats.by_quantile.cdf_upper, ...
    'avg_sales', exit_stats.by_quantile.bin_sales, ...
    'exit_rate', exit_stats.by_quantile.bin_exit, ...
    'mass_share', exit_stats.by_quantile.bin_mass ...
);

results.entry_summary = entry_summary;
results.duration_hazard = duration_table;

max_age_idx = min(life_cycle_horizon, numel(agg_avg_matches));
results.life_cycle_summary = struct( ...
    'ages', ages(1:max_age_idx), ...
    'agg_avg_matches', agg_avg_matches(1:max_age_idx), ...
    'agg_growth', agg_growth(1:max_age_idx), ...
    'agg_avg_sales', agg_avg_sales(1:max_age_idx), ...
    'agg_sales_growth', agg_sales_growth(1:max_age_idx), ...
    'type1_avg_matches', type1_avg(1:max_age_idx), ...
    'type1_growth', type1_growth(1:max_age_idx), ...
    'type1_avg_sales', type1_sales_avg(1:max_age_idx), ...
    'type1_sales_growth', type1_sales_growth(1:max_age_idx), ...
    'type2_avg_matches', type2_avg(1:max_age_idx), ...
    'type2_growth', type2_growth(1:max_age_idx), ...
    'type2_avg_sales', type2_sales_avg(1:max_age_idx), ...
    'type2_sales_growth', type2_sales_growth(1:max_age_idx), ...
    'nh_over_nl', nh_over_nl(1:max_age_idx), ...
    'nh_over_nl_overall', profile.type_ratio_overall ...
);

results.moment_vector   = moment_vector;
results.moment_cov      = moment_cov;
results.weight_matrix   = weight_matrix;
results.sample_size     = sample_total;
results.moment_targets = struct( ...
    'entry_rate_conditional', entry_rate_conditional, ...
    'survival_through_2', survival_two_years, ...
    'hazard_age1', hazard_age1, ...
    'within_firm_growth_ratio_age2', growth_stats.mean(1), ...
    'within_firm_growth_ratio_age3', growth_stats.mean(2), ...
    'growth_target_ages', growth_target_ages, ...
    'type_ratio_overall', profile.type_ratio_overall ...
);
results.calibration = struct( ...
    'z_ratio', z_ratio_calib, ...
    'omega_H', omega_H ...
);
results.bootstrap_summary = struct( ...
    'draws', moment_draws, ...
    'mean', mean(moment_draws, 2), ...
    'std', std(moment_draws, 0, 2), ...
    'num_draws', num_bootstrap_draws, ...
    'ridge', bootstrap_ridge, ...
    'seed', base_seed, ...
    'life_cycle_horizon', life_cycle_horizon, ...
    'growth_target_ages', growth_target_ages ...
);

results.within_firm_growth_samples = growth_stats.samples;

save(fullfile(this_dir, 'baseline_moment_results.mat'), 'results');
writetable(exit_stats.by_state, fullfile(this_dir, 'size_exit_rates_by_state.csv'));
writetable(exit_stats.by_quantile, fullfile(this_dir, 'size_exit_rates_by_quantile.csv'));
writetable(entry_table, fullfile(this_dir, 'export_entry_rates.csv'));
writetable(life_cycle_table, fullfile(this_dir, 'life_cycle_growth.csv'));

end

%% -------------------------------------------------------------------------
function vec = assemble_moment_vector(entry_rate, hazard1, growth_age2, growth_age3)
vec = [entry_rate; hazard1; growth_age2; growth_age3];
end

%% -------------------------------------------------------------------------

function entry_draw = bootstrap_entry_conditional(entry_summary, sample_total)
%BOOTSTRAP_ENTRY_CONDITIONAL Binomial draw for the share of zero-match sellers that enter.
n_zero = max(round(entry_summary.share_zero_total * sample_total), 1);
p_cond = max(min(entry_summary.conditional, 1 - eps), eps);
entry_draw = binornd(n_zero, p_cond) / max(n_zero, 1);
end

%% -------------------------------------------------------------------------
function hazard_draw = bootstrap_duration_hazard(exit_counts, exposures)
num_points = numel(exit_counts);
hazard_draw = zeros(num_points, 1);

for k = 1:num_points
    n = round(exposures(k));
    if n <= 0
        hazard_draw(k) = 0;
        continue;
    end
    p = exit_counts(k) / max(exposures(k), 1);
    p = min(max(p, 0), 1);
    hazard_draw(k) = binornd(n, p) / max(n, 1);
end
end

%% -------------------------------------------------------------------------
function tf = is_path_member(dir_path)
%IS_PATH_MEMBER True if the directory is already on the MATLAB search path.
paths = strsplit(path, pathsep);
tf = any(strcmp(paths, dir_path));
end

%% -------------------------------------------------------------------------
function remove_added_paths(paths, flags)
%REMOVE_ADDED_PATHS Remove only the directories inserted by this function.
for idx = 1:numel(paths)
    if flags(idx)
        rmpath(paths{idx});
    end
end
end
