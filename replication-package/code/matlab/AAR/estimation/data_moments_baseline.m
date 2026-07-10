function targets = data_moments_baseline(~)
%DATA_MOMENTS_BASELINE Load exporter-discipline moments from the baseline simulation.
%   This wrapper fetches the summary structure saved by
%   `baseline_moments/generate_baseline_moments.m`. The output is consumed by
%   COMPUTE_EMPIRICAL_MOMENTS when constructing the estimation targets for the
%   two-type AAR model.

this_dir = fileparts(mfilename('fullpath'));
root_dir = fileparts(this_dir);

results_path = fullfile(root_dir, 'baseline_moments', 'baseline_moment_results.mat');
if ~isfile(results_path)
    error('Baseline moment file not found: %s', results_path);
end

data = load(results_path, 'results');
if ~isfield(data, 'results')
    error('Variable `results` not found in %s.', results_path);
end
res = data.results;

required_fields = {'exit_deciles', 'entry_summary', 'life_cycle_summary', 'import_share', 'duration_hazard'};
for k = 1:numel(required_fields)
    if ~isfield(res, required_fields{k})
        error('Baseline results missing required field `%s`.', required_fields{k});
    end
end

targets = struct();
targets.exit_deciles       = res.exit_deciles;
targets.exit_stats         = res.exit_stats;
targets.entry_summary      = res.entry_summary;
targets.entry_table        = res.entry;
targets.duration_hazard    = res.duration_hazard;
targets.life_cycle_full    = res.life_cycle;
targets.life_cycle_summary = res.life_cycle_summary;
targets.import_share       = res.import_share;
if isfield(res, 'moment_targets')
    targets.moment_targets = res.moment_targets;
end
if isfield(res, 'calibration')
    targets.calibration = res.calibration;
end

if isfield(res, 'moment_vector'),   targets.moment_vector   = res.moment_vector;   end
if isfield(res, 'moment_cov'),      targets.moment_cov      = res.moment_cov;      end
if isfield(res, 'weight_matrix'),   targets.weight_matrix   = res.weight_matrix;   end
if isfield(res, 'bootstrap_summary'), targets.bootstrap_summary = res.bootstrap_summary; end
if isfield(res, 'sample_size'),     targets.sample_size     = res.sample_size;     end

end
