function [si_in,best_fval,meta] = load_best_mechanical_estimate()
%LOAD_BEST_MECHANICAL_ESTIMATE Load the preferred mechanical estimate.
% Priority order:
% 1) Best checkpoint from the most complete campaign in `results/`.
% 2) Fallback snapshot in `data/mechanical_best_estimate.mat`.
%
% Outputs
%   si_in     34x1 parameter vector (30 buyer sigmas, 2 seller sigmas,
%             omega, Ns).
%   best_fval Objective value (NaN if unavailable in fallback file).
%   meta      Struct with fields:
%             - source_file
%             - source_type ('results' or 'data')

best_fval = inf;
si_in = [];
meta = struct('source_file','','source_type','');

opt_files = dir(fullfile('results','Optimization_*_Run*of*.mat'));
if ~isempty(opt_files)
    run_num = nan(numel(opt_files),1);
    total_num = nan(numel(opt_files),1);
    campaign = strings(numel(opt_files),1);
    for i = 1:numel(opt_files)
        tok = regexp(opt_files(i).name,'Run(\d+)of(\d+)\.mat$','tokens','once');
        if ~isempty(tok)
            run_num(i) = str2double(tok{1});
            total_num(i) = str2double(tok{2});
        end
        c = regexp(opt_files(i).name,'(Optimization_[0-9_]+)_Run\d+of\d+\.mat$','tokens','once');
        if ~isempty(c)
            campaign(i) = string(c{1});
        end
    end

    valid_total = total_num(~isnan(total_num));
    if ~isempty(valid_total)
        max_total = max(valid_total);
        cand_idx = find(total_num == max_total);
        [~,ix_latest] = max([opt_files(cand_idx).datenum]);
        campaign_use = campaign(cand_idx(ix_latest));
        use_idx = find(campaign == campaign_use);

        best_file = '';
        for i = 1:numel(use_idx)
            S = load(fullfile(opt_files(use_idx(i)).folder,opt_files(use_idx(i)).name));
            if isfield(S,'fval_ga') && isfield(S,'si_in') && (S.fval_ga < best_fval)
                best_fval = S.fval_ga;
                si_in = S.si_in(:);
                best_file = opt_files(use_idx(i)).name;
            end
        end

        if ~isempty(si_in)
            meta.source_file = best_file;
            meta.source_type = 'results';
            return;
        end
    end
end

fallback = fullfile('data','mechanical_best_estimate.mat');
if isfile(fallback)
    S = load(fallback);
    if ~isfield(S,'si_in')
        error('Fallback estimate file %s exists but has no variable si_in.', fallback);
    end
    si_in = S.si_in(:);
    if isfield(S,'fval_ga')
        best_fval = S.fval_ga;
    else
        best_fval = NaN;
    end
    meta.source_file = fallback;
    meta.source_type = 'data';
    return;
end

error(['No mechanical estimate found. Expected optimization checkpoints in results/ ' ...
       'or fallback file data/mechanical_best_estimate.mat']);
end
