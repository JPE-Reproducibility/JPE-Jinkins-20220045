function generate_comparison_outputs()
%GENERATE_COMPARISON_OUTPUTS Create tables comparing AAR model and EJTX targets.

project_root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(project_root, 'estimation'));
addpath(fullfile(project_root, 'baseline_moments'));
addpath(fullfile(project_root, 'counterfactuals', 'policy_shock'));

baseline_path = fullfile(project_root, 'baseline_moments', 'baseline_moment_results.mat');
if ~isfile(baseline_path)
    error('Missing baseline moments file: %s', baseline_path);
end
baseline = load(baseline_path, 'results');
baseline = baseline.results;

estimation_path = fullfile(project_root, 'estimation', 'output', 'estimation_results.mat');
if ~isfile(estimation_path)
    error('Missing estimation results file: %s', estimation_path);
end
est = load(estimation_path, 'results', 'empirical_summary', 'config');
results = est.results;
summary = est.empirical_summary;

labels = summary.moment_labels(:);
data_vec = summary.data_moments(:);
model_vec = results.model_moments(:);
diff_vec = model_vec - data_vec;

comparison_tbl = table(labels, data_vec, model_vec, diff_vec, ...
    'VariableNames', {'moment', 'ejtx_data', 'aar_model', 'model_minus_data'});
output_table_path = fullfile(project_root, 'comparison', 'tables', 'moment_comparison.csv');
writetable(comparison_tbl, output_table_path);

param_names = {'f_bar', 'delta_f', 'xi_H', 'rho_xi'}';
param_values = [results.theta.f_bar; results.theta.delta_f; ...
    results.theta.xi_H; results.theta.rho_xi];
param_tbl = table(param_names, param_values, 'VariableNames', {'parameter', 'estimate'});
output_param_path = fullfile(project_root, 'comparison', 'tables', 'parameter_estimates.csv');
writetable(param_tbl, output_param_path);

% Policy-shock comparison (EJTX Section 7.1 calibration mapped into AAR).
policy_results = run_policy_shock_counterfactual();
policy_tbl = policy_results.output_table;
output_policy_path = fullfile(project_root, 'comparison', 'tables', 'policy_shock_comparison.csv');
writetable(policy_tbl, output_policy_path);
output_policy_benchmark_path = fullfile(project_root, 'comparison', 'tables', 'policy_shock_benchmark_comparison.csv');
writetable(policy_results.benchmark_table, output_policy_benchmark_path);

fprintf('Comparison outputs written to %s\n', fullfile(project_root, 'comparison'));
end
