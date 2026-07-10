function results = run_policy_shock_counterfactual()
%RUN_POLICY_SHOCK_COUNTERFACTUAL Replicates the EJTX-style 2004 policy shock.
%   The policy shock in EJTX Section 7.1 raises potential suppliers of both
%   types while lowering the high-type share among potential exporters:
%       M^S: 2.4 -> 4.2,   omega_H: 0.043 -> 0.030.
%   We map this calibration into the two-type AAR block by solving:
%     (i) a pre-policy equilibrium with (M^S, omega_H) = (2.4, 0.043),
%    (ii) a post-policy equilibrium with (M^S, omega_H) = (4.2, 0.030).
%   All other AAR parameters are fixed at the estimated baseline values.
%
%   Revenue and welfare objects follow Eq. (eq:revenue) and Eq. (eq:price_index)
%   in Appendix AAR of docs/reply_r3_R2.tex.

this_dir = fileparts(mfilename('fullpath'));
project_root = fileparts(fileparts(this_dir));
addpath(fullfile(project_root, 'estimation'));

est_path = fullfile(project_root, 'estimation', 'output', 'estimation_results.mat');
if ~isfile(est_path)
    error('Estimation results not found: %s', est_path);
end

S = load(est_path, 'results', 'config');
results_est = S.results;
cfg_post = S.config;
theta = results_est.theta;

% Section 7.1 calibration in legacy/ejtx_2025.tex (policy shock only).
Ms_pre = 2.4;
Ms_post = 4.2;
omega_pre = 0.043;
omega_post = 0.030;

cfg_post.calib_type_share = omega_post;
cfg_pre = cfg_post;
cfg_pre.mass_M = cfg_post.mass_M * (Ms_pre / Ms_post);
cfg_pre.calib_type_share = omega_pre;

sol_pre = solve_model(theta, cfg_pre);
sol_post = solve_model(theta, cfg_post);

metrics_pre = collect_policy_metrics(sol_pre);
metrics_post = collect_policy_metrics(sol_post);
pct_change = 100 * ((metrics_post.values - metrics_pre.values) ./ metrics_pre.values);

metric_names = metrics_pre.names(:);
pre_vec = metrics_pre.values(:);
post_vec = metrics_post.values(:);

% EJTX policy-only benchmarks reported in Table "mech_vs_base", baseline column.
ejtx_policy_pct = nan(size(pre_vec));
ejtx_policy_pct(strcmp(metric_names, 'measure active low-productivity suppliers')) = 29.3;
ejtx_policy_pct(strcmp(metric_names, 'measure active high-productivity suppliers')) = 19.3;

result_tbl = table(metric_names, pre_vec, post_vec, pct_change, ejtx_policy_pct, ...
    'VariableNames', {'metric', 'pre_policy', 'post_policy', 'pct_change', 'ejtx_policy_pct_change'});
% Full EJTX policy-only benchmark table from counterfactual_table_2026.tex.
benchmark_tbl = build_policy_benchmark_table(pre_vec, post_vec, metric_names);

low_factor = (cfg_post.mass_M * (1 - omega_post)) / (cfg_pre.mass_M * (1 - omega_pre));
high_factor = (cfg_post.mass_M * omega_post) / (cfg_pre.mass_M * omega_pre);
calib_tbl = table(...
    Ms_pre, Ms_post, omega_pre, omega_post, low_factor, high_factor, ...
    'VariableNames', { ...
        'Ms_pre', 'Ms_post', 'omega_pre', 'omega_post', ...
        'low_type_mass_factor_post_over_pre', 'high_type_mass_factor_post_over_pre'});

fprintf('Policy-shock counterfactual (AAR, Section 7.1 calibration)\n');
fprintf('  M^S pre  = %6.3f, omega_H pre  = %6.3f\n', Ms_pre, omega_pre);
fprintf('  M^S post = %6.3f, omega_H post = %6.3f\n', Ms_post, omega_post);
fprintf('  Low-type potential mass multiplier  = %6.3f\n', low_factor);
fprintf('  High-type potential mass multiplier = %6.3f\n', high_factor);
for k = 1:numel(metric_names)
    fprintf('  %-42s pre = %9.4f  post = %9.4f  pct = %+7.2f%%%%\n', ...
        metric_names{k}, pre_vec(k), post_vec(k), pct_change(k));
end

results = struct();
results.metric_names = metric_names;
results.pre_policy = pre_vec;
results.post_policy = post_vec;
results.pct_change = pct_change;
results.ejtx_policy_pct_change = ejtx_policy_pct;
results.output_table = result_tbl;
results.calibration_table = calib_tbl;
results.benchmark_table = benchmark_tbl;
end

function metrics = collect_policy_metrics(sol)
%COLLECT_POLICY_METRICS Export-side objects available in the two-type AAR block.
active_low = sum(sol.N_components.L);
active_high = sum(sol.N_components.H);
active_total = active_low + active_high;

if active_total > 0
    high_share_active = active_high / active_total;
else
    high_share_active = 0;
end

total_revenue = sum(sol.revenue_state .* sol.active_masses);
avg_revenue = total_revenue / max(active_total, 1e-12);
welfare_level = 1 / sol.P_star;

metrics.names = {
    'measure active low-productivity suppliers'
    'measure active high-productivity suppliers'
    'measure active exporters'
    'share high-productivity among active exporters'
    'average exporter revenue'
    'consumer welfare level (1/P)'
};
metrics.values = [
    active_low
    active_high
    active_total
    high_share_active
    avg_revenue
    welfare_level
];
end

function benchmark_tbl = build_policy_benchmark_table(pre_vec, post_vec, metric_names)
%BUILD_POLICY_BENCHMARK_TABLE EJTX policy-only changes and mapped AAR counterparts.
%   EJTX values come from:
%   ../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex
%   Policy-only changes are computed as:
%   100 * [ (1 + delta_2011_1996/100) / (1 + delta_2004_1996/100) - 1 ].

ejtx_metric = {
    'measure active low-productivity suppliers'
    'measure active high-productivity suppliers'
    'measure active buyers'
    'total profit, low-productivity suppliers'
    'total profit, high-productivity suppliers'
    'total profit, buyers'
    'total search costs, low-productivity suppliers'
    'total search costs, high-productivity suppliers'
    'total search costs, buyers'
    'number of suppliers per buyer'
    'high-productivity suppliers per buyer'
    'consumer welfare'
    'derived: measure active suppliers (low+high)'
    'derived: high-type share among active suppliers'
};

% 2004-vs-1996 and 2011-vs-1996 percentage changes from the EJTX table.
delta_2004_1996 = [
    21.6
    4.2
    16.7
    -0.3
    -1.4
    0.6
    0.1
    4.0
    -14.8
    11.3
    11.7
    8.0
];

delta_2011_1996 = [
    57.2
    24.3
    15.6
    24.5
    -7.8
    1.2
    24.2
    -4.9
    -4.8
    17.9
    -6.8
    7.1
];

ejtx_policy = 100 * (((1 + delta_2011_1996 / 100) ./ (1 + delta_2004_1996 / 100)) - 1);

% Derived EJTX totals and composition from baseline masses in the same table.
low_1996 = 0.480;
high_1996 = 0.087;
low_2004 = low_1996 * (1 + delta_2004_1996(1) / 100);
high_2004 = high_1996 * (1 + delta_2004_1996(2) / 100);
low_2011 = low_1996 * (1 + delta_2011_1996(1) / 100);
high_2011 = high_1996 * (1 + delta_2011_1996(2) / 100);

ejtx_total_active = 100 * (((low_2011 + high_2011) / (low_2004 + high_2004)) - 1);
ejtx_high_share = 100 * (((high_2011 / (low_2011 + high_2011)) / (high_2004 / (low_2004 + high_2004))) - 1);

ejtx_policy_all = [ejtx_policy; ejtx_total_active; ejtx_high_share];

aar_policy = nan(size(ejtx_policy_all));

idx_low = strcmp(metric_names, 'measure active low-productivity suppliers');
idx_high = strcmp(metric_names, 'measure active high-productivity suppliers');
idx_total = strcmp(metric_names, 'measure active exporters');
idx_share = strcmp(metric_names, 'share high-productivity among active exporters');
idx_welfare = strcmp(metric_names, 'consumer welfare level (1/P)');

aar_policy(strcmp(ejtx_metric, 'measure active low-productivity suppliers')) = ...
    100 * (post_vec(idx_low) / pre_vec(idx_low) - 1);
aar_policy(strcmp(ejtx_metric, 'measure active high-productivity suppliers')) = ...
    100 * (post_vec(idx_high) / pre_vec(idx_high) - 1);
aar_policy(strcmp(ejtx_metric, 'consumer welfare')) = ...
    100 * (post_vec(idx_welfare) / pre_vec(idx_welfare) - 1);
aar_policy(strcmp(ejtx_metric, 'derived: measure active suppliers (low+high)')) = ...
    100 * (post_vec(idx_total) / pre_vec(idx_total) - 1);
aar_policy(strcmp(ejtx_metric, 'derived: high-type share among active suppliers')) = ...
    100 * (post_vec(idx_share) / pre_vec(idx_share) - 1);

benchmark_tbl = table(ejtx_metric, ejtx_policy_all, aar_policy, ...
    'VariableNames', {'metric', 'ejtx_policy_pct_change', 'aar_policy_pct_change'});
end
