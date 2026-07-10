function summary = compute_empirical_moments(targets, cfg)
%COMPUTE_EMPIRICAL_MOMENTS Map baseline simulation statistics into AAR targets.
%   Consumes the `moment_targets` struct saved by baseline_moments and
%   builds the MSM data vector for the just-identified system.

arguments
    targets struct
    cfg struct
end

if ~isfield(targets, 'moment_targets')
    error('Baseline moments missing the aggregated `moment_targets` struct.');
end
mt = targets.moment_targets;

required = {'entry_rate_conditional', 'hazard_age1', ...
    'within_firm_growth_ratio_age2', 'within_firm_growth_ratio_age3'};
for k = 1:numel(required)
    if ~isfield(mt, required{k})
        error('moment_targets missing field `%s`.', required{k});
    end
end

% Entry rate corresponds to p_e(z,h=0) in Eq. (eq:pe_general) of AAR.tex.
entry_rate = mt.entry_rate_conditional;
hazard_age1 = mt.hazard_age1;
growth2 = mt.within_firm_growth_ratio_age2;
growth3 = mt.within_firm_growth_ratio_age3;
if isfield(mt, 'type_ratio_overall')
    type_ratio_overall = mt.type_ratio_overall;
else
    type_ratio_overall = NaN;
end

data_vec = [entry_rate; hazard_age1; growth2; growth3];

if numel(data_vec) ~= numel(cfg.moment_labels)
    error('Moment vector length (%d) does not match label count (%d).', ...
        numel(data_vec), numel(cfg.moment_labels));
end

summary = struct();
summary.data_moments      = data_vec(:);
summary.moment_labels     = cfg.moment_labels(:);
summary.import_share      = targets.import_share;
summary.weight_matrix     = cfg.weight_matrix;
summary.entry_rate_conditional = entry_rate;
summary.hazard_targets    = hazard_age1;
summary.within_firm_growth_ratio_age2 = growth2;
summary.within_firm_growth_ratio_age3 = growth3;
summary.type_ratio_overall = type_ratio_overall;
if isfield(mt, 'survival_through_2')
    summary.survival_through_2 = mt.survival_through_2;
end
if isfield(targets, 'price_stats'), summary.price_stats = targets.price_stats; end
if isfield(targets, 'duration_hazard'), summary.duration_hazard = targets.duration_hazard; end
if isfield(targets, 'life_cycle_summary')
    summary.life_cycle_summary = targets.life_cycle_summary;
    if isfield(targets.life_cycle_summary, 'ages')
        summary.life_cycle_ages = targets.life_cycle_summary.ages;
    end
    if isfield(targets.life_cycle_summary, 'nh_over_nl')
        summary.nh_over_nl = targets.life_cycle_summary.nh_over_nl;
    end
    if isfield(targets.life_cycle_summary, 'nh_over_nl_overall')
        summary.nh_over_nl_overall = targets.life_cycle_summary.nh_over_nl_overall;
    end
end
if isfield(targets, 'moment_cov'), summary.moment_cov = targets.moment_cov; end
if isfield(targets, 'bootstrap_summary'), summary.bootstrap_summary = targets.bootstrap_summary; end
if isfield(targets, 'moment_vector'), summary.moment_vector = targets.moment_vector; end
if isfield(targets, 'calibration'), summary.calibration = targets.calibration; end
end
