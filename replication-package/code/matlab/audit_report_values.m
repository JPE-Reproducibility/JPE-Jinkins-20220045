function audit_report_values()
%AUDIT_REPORT_VALUES Print core numeric checks used in AUDIT_REPORT.md.
%
% This script does not reestimate models. It evaluates selected saved
% parameter vectors and reads saved result artifacts.

rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath());
incomingPath = path;
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

fprintf('Replication audit values\n');
fprintf('Root: %s\n\n', rootDir);

baselineDir = fullfile(rootDir, 'code', 'matlab', 'baseline_no_NsNb_target');
path(basePath);
addpath(baselineDir);
cd(baselineDir);
S = load(fullfile('results', 'se_results_baseline_no_M_target.mat'), 'x', 'D0');
x = S.x; %#ok<NASGU>
define_parameters; define_states; define_lindex; data_moments_baseline;
D = objective(x, param_indx, param_state, param_fix, data_moments, cov_v);
fprintf('BASELINE_REPORTED_SAVED_FIT %.15g\n', S.D0);
fprintf('BASELINE_REPORTED_REEVALUATED_FIT %.15g\n', D);
fprintf('BASELINE_REPORTED_DIFF %.15g\n\n', D - S.D0);
cd(here);

mechDir = fullfile(rootDir, 'code', 'matlab', 'mechanical_model');
path(basePath);
addpath(mechDir);
cd(mechDir);
[si_in, best_fval, meta] = load_best_mechanical_estimate();
define_parameters; define_states; define_lindex;
S = load(fullfile('..', 'baseline_no_NsNb_target', 'results', 'se_results_baseline_no_M_target.mat'), 'x');
D = objective_mechanical(si_in, S.x, param_indx, param_state, param_fix);
fprintf('MECHANICAL_SOURCE %s\n', meta.source_file);
fprintf('MECHANICAL_SAVED_FVAL %.15g\n', best_fval);
fprintf('MECHANICAL_REEVALUATED_FIT %.15g\n', D);
fprintf('MECHANICAL_DIFF %.15g\n\n', D - best_fval);
cd(here);

heteroDir = fullfile(rootDir, 'code', 'matlab', 'heterogeneous_death_haz', 'sellers_only');
path(basePath);
addpath(heteroDir);
cd(heteroDir);
S = load(fullfile('results', 'se_results_hetero.mat'), 'out', 'out_old', 'x');
x = S.x; %#ok<NASGU>
define_parameters; define_states; define_lindex; data_moments_hetero;
[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,net_prof_b,Cs,Cs1,Cs2,net_prof_s1,net_prof_s2,avg_match_death_haz,match_death_reg_coef,delta2] = ...
    solve_model(x, param_indx, param_state, param_fix); %#ok<ASGLU>
sim_moments_hetero;
W = inv(cov_v);
hetero_model_moments = eval('model_moments');
out = (data_moments - hetero_model_moments)' * W * (data_moments - hetero_model_moments);
n_old = numel(data_moments) - 2;
old_idx = 1:n_old;
out_old = (data_moments(old_idx) - hetero_model_moments(old_idx))' * W(old_idx,old_idx) * ...
    (data_moments(old_idx) - hetero_model_moments(old_idx));
fprintf('HETERO_SAVED_FULL_OBJECTIVE %.15g\n', S.out);
fprintf('HETERO_REEVALUATED_FULL_OBJECTIVE %.15g\n', out);
fprintf('HETERO_FULL_DIFF %.15g\n', out - S.out);
fprintf('HETERO_SAVED_OLD_OBJECTIVE %.15g\n', S.out_old);
fprintf('HETERO_REEVALUATED_OLD_OBJECTIVE %.15g\n', out_old);
fprintf('HETERO_OLD_DIFF %.15g\n', out_old - S.out_old);
fprintf('HETERO_AVG_MATCH_DEATH %.15g\n', avg_match_death_haz);
fprintf('HETERO_REG_COEF %.15g\n', match_death_reg_coef);
fprintf('HETERO_DELTA2 %.15g\n\n', delta2);
cd(here);

S = load(fullfile(rootDir, 'code', 'matlab', 'AAR', 'estimation', 'output', 'estimation_results.mat'));
r = S.results;
path(basePath);
addpath(fullfile(rootDir, 'code', 'matlab', 'AAR', 'estimation'));
clear model_moments data_moments cov_v W sol
sol = solve_model(r.theta, S.config);
model_vec = feval('model_moments', sol, r.theta, S.config);
fval_aar = sum((model_vec(:) - S.empirical_summary.data_moments(:)).^2);
fprintf('AAR_SAVED_FVAL %.15g\n', r.fval);
fprintf('AAR_REEVALUATED_FVAL %.15g\n', fval_aar);
fprintf('AAR_DIFF %.15g\n', fval_aar - r.fval);
fprintf('AAR_THETA %.15g %.15g %.15g %.15g\n', ...
    r.theta.f_bar, r.theta.delta_f, r.theta.xi_H, r.theta.rho_xi);
fprintf('AAR_MAX_ABS_MOMENT_DIFF %.15g\n\n', max(abs(model_vec(:) - S.empirical_summary.data_moments(:))));

mpCodeDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', ...
    'MP model', 'calibration_no_gamma_s');
mpArtifacts = {
    'MP_MATCH_SHOCK', fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', ...
        'MP model', 'Results2026', 'Baseline_MP', 'results', 'se_results_est_eta.mat');
    'MP_NO_DISPERSION', fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', ...
        'MP model', 'Results2026', 'No_dispersion_MP', 'results', 'se_results_est_eta.mat')
    };

for i = 1:size(mpArtifacts, 1)
    label = mpArtifacts{i, 1};
    artifact = mpArtifacts{i, 2};
    if isfile(artifact)
        path(basePath);
        tmpParent = tempname;
        mkdir(tmpParent);
        cleanupTmp = onCleanup(@() cleanupDir(tmpParent)); %#ok<NASGU>
        mpTmp = fullfile(tmpParent, 'calibration_no_gamma_s');
        copyfile(mpCodeDir, mpTmp);
        addpath(mpTmp);
        cd(mpTmp);
        S = load(artifact, 'x', 'out', 'out_old');
        x = S.x; %#ok<NASGU>
        define_parameters; define_states; define_lindex;
        objectiveText = evalc('out_mp = objective(x, param_indx, param_state, param_fix);');
        fprintf('%s', objectiveText);
        oldTokens = regexp(objectiveText, 'OLD OBJECTIVE FUNCTION =\s*([0-9.]+)', 'tokens', 'once');
        if isempty(oldTokens)
            out_old_mp = NaN;
        else
            out_old_mp = str2double(oldTokens{1});
        end
        fprintf('%s_SOURCE %s\n', label, artifact);
        fprintf('%s_X ', label);
        fprintf('%.15g ', S.x(:));
        fprintf('\n');
        fprintf('%s_SAVED_OUT %.15g\n', label, S.out);
        fprintf('%s_REEVALUATED_OUT %.15g\n', label, out_mp);
        fprintf('%s_DIFF %.15g\n', label, out_mp - S.out);
        fprintf('%s_SAVED_OUT_OLD %.15g\n', label, S.out_old);
        fprintf('%s_REEVALUATED_OUT_OLD %.15g\n', label, out_old_mp);
        fprintf('%s_OLD_DIFF %.15g\n\n', label, out_old_mp - S.out_old);
        cd(here);
        rmpath(mpTmp);
        clear cleanupTmp
    else
        fprintf('%s_ARTIFACT missing: %s\n', label, artifact);
    end
end
path(basePath);
cd(here);
end

function cleanupDir(pathName)
if isfolder(pathName)
    rmdir(pathName, 's');
end
end

function cleanPath = stripCodeTreeFromPath(pathString, codeRoot)
canonicalRoot = char(java.io.File(codeRoot).getCanonicalPath());
parts = strsplit(pathString, pathsep);
keep = true(size(parts));
for i = 1:numel(parts)
    if isempty(parts{i})
        continue
    end
    try
        canonicalPart = char(java.io.File(parts{i}).getCanonicalPath());
    catch
        canonicalPart = parts{i};
    end
    keep(i) = ~(strcmp(canonicalPart, canonicalRoot) || startsWith(canonicalPart, [canonicalRoot filesep]));
end
cleanPath = strjoin(parts(keep), pathsep);
end
