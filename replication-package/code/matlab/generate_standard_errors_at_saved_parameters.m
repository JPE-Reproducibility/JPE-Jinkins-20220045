function se = generate_standard_errors_at_saved_parameters(rootDir, outputDir)
%GENERATE_STANDARD_ERRORS_AT_SAVED_PARAMETERS Recompute table SEs from code.
%
% This helper intentionally does not use standard-error fields from the
% packaged result artifacts. It loads saved/reported parameter vectors, runs
% each model's std_errors.m script in an isolated temporary copy of the model
% folder, and returns the standard errors created by that fresh run.

logFile = fullfile(outputDir, 'logs', 'standard_error_generation.log');
ensureLocalDir(fileparts(logFile));
fid = fopen(logFile, 'w');
if fid == -1
    error('Could not open %s for writing.', logFile);
end
cleanupLog = onCleanup(@() fclose(fid)); %#ok<NASGU>

fprintf('Regenerating finite-difference standard errors at saved parameter vectors...\n');
fprintf(fid, 'Standard-error generation at saved parameter vectors\nRoot: %s\n\n', rootDir);

codeRoot = fullfile(rootDir, 'code', 'matlab');

baselineDir = fullfile(codeRoot, 'baseline_no_NsNb_target');
baselineArtifact = fullfile(baselineDir, 'results', 'se_results_baseline_no_M_target.mat');
se.baseline = runBaselineStandardErrors(rootDir, baselineDir, baselineArtifact, fid);

heteroDir = fullfile(codeRoot, 'heterogeneous_death_haz', 'sellers_only');
heteroArtifact = fullfile(heteroDir, 'results', 'se_results_hetero.mat');
se.hetero = runHeteroStandardErrors(rootDir, heteroDir, heteroArtifact, fid);

mpDir = fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
    'MP model', 'calibration_no_gamma_s');
mpMatchArtifact = fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
    'MP model', 'Results2026', 'Baseline_MP', 'results', 'se_results_est_eta.mat');
mpNoDispArtifact = fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
    'MP model', 'Results2026', 'No_dispersion_MP', 'results', 'se_results_est_eta.mat');
se.mpMatch = runMpStandardErrors(rootDir, mpDir, mpMatchArtifact, fid, 'MP match shock');
se.mpNoDisp = runMpStandardErrors(rootDir, mpDir, mpNoDispArtifact, fid, 'MP no dispersion');

writeStandardErrorSummary(se, fullfile(outputDir, 'tables', 'paper', ...
    'generated_standard_errors_at_saved_parameters.csv'));
fprintf('Standard-error generation log written to %s\n', logFile);
end

function result = runBaselineStandardErrors(rootDir, srcDir, artifact, fid)
fprintf('  Baseline standard errors...\n');
fprintf(fid, '===== Baseline standard errors =====\n');
S = load(artifact, 'x', 'D0');
x = S.x; %#ok<NASGU>
[tmpParent, tmpDir] = copyWorkingModel(srcDir);
cleanupTmp = onCleanup(@() cleanupDir(tmpParent)); %#ok<NASGU>
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(tmpDir);
cd(tmpDir);
txt = evalc('define_parameters; define_states; define_lindex; std_errors;');
fprintf(fid, '%s\n', txt);
objectiveText = evalc('data_moments_baseline; D0_generated = objective(x, param_indx, param_state, param_fix, data_moments, cov_v);');
fprintf(fid, '%s\n', objectiveText);
R = load(fullfile(tmpDir, 'results', 'se_results_no_M_target.mat'), ...
    'param_vec', 'stderr', 'V_coef');
result.param_vec = R.param_vec(:);
result.stderr = R.stderr(:);
result.V_coef = R.V_coef;
result.D0 = D0_generated;
result.saved_D0 = S.D0;
result.source_artifact = artifact;
end

function result = runHeteroStandardErrors(rootDir, srcDir, artifact, fid)
fprintf('  Heterogeneous match-death standard errors...\n');
fprintf(fid, '===== Heterogeneous match-death standard errors =====\n');
S = load(artifact, 'x', 'out', 'out_old', 'avg_match_death_haz', ...
    'match_death_reg_coef', 'delta2', 'data_match_death_haz', ...
    'data_match_death_reg_coef');
x = S.x; %#ok<NASGU>
[tmpParent, tmpDir] = copyWorkingModel(srcDir);
cleanupTmp = onCleanup(@() cleanupDir(tmpParent)); %#ok<NASGU>
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(tmpDir);
cd(tmpDir);
txt = evalc('define_parameters; define_states; define_lindex; std_errors;');
fprintf(fid, '%s\n', txt);
objectiveText = evalc(['[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,net_prof_b,Cs,Cs1,Cs2,net_prof_s1,net_prof_s2,avg_match_death_haz,match_death_reg_coef,delta2] = ' ...
    'solve_model(x, param_indx, param_state, param_fix); sim_moments_hetero; W = inv(cov_v); hetero_model_moments = eval(''model_moments''); ' ...
    'out_generated = (data_moments - hetero_model_moments)'' * W * (data_moments - hetero_model_moments); ' ...
    'n_old = numel(data_moments) - 2; old_idx = 1:n_old; ' ...
    'out_old_generated = (data_moments(old_idx) - hetero_model_moments(old_idx))'' * W(old_idx,old_idx) * (data_moments(old_idx) - hetero_model_moments(old_idx));']);
fprintf(fid, '%s\n', objectiveText);
R = load(fullfile(tmpDir, 'results', 'se_results_hetero.mat'), ...
    'param_vec', 'stderr', 'V_coef');
result.param_vec = R.param_vec(:);
result.stderr = R.stderr(:);
result.V_coef = R.V_coef;
result.out = out_generated;
result.out_old = out_old_generated;
result.saved_out = S.out;
result.saved_out_old = S.out_old;
result.avg_match_death_haz = avg_match_death_haz;
result.match_death_reg_coef = match_death_reg_coef;
result.delta2 = delta2;
result.data_match_death_haz = S.data_match_death_haz;
result.data_match_death_reg_coef = S.data_match_death_reg_coef;
result.source_artifact = artifact;
end

function result = runMpStandardErrors(rootDir, srcDir, artifact, fid, label)
fprintf('  %s standard errors...\n', label);
fprintf(fid, '===== %s standard errors =====\n', label);
S = load(artifact, 'x');
x = S.x; %#ok<NASGU>
[tmpParent, tmpDir] = copyWorkingModel(srcDir);
cleanupTmp = onCleanup(@() cleanupDir(tmpParent)); %#ok<NASGU>
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(tmpDir);
cd(tmpDir);
txt = evalc('std_errors; objectiveText = evalc(''out_generated = objective(x, param_indx, param_state, param_fix);'');');
fprintf(fid, '%s\n', txt);
fprintf(fid, '%s\n', objectiveText);
R = load(fullfile(tmpDir, 'results', 'se_results_est_eta.mat'), ...
    'param_vec', 'stderr', 'V_coef');
result.param_vec = R.param_vec(:);
result.stderr = R.stderr(:);
result.V_coef = R.V_coef;
result.out = out_generated;
result.out_old = parseObjectiveLine(objectiveText, 'OLD OBJECTIVE FUNCTION');
result.match_death_reg_coef = parseObjectiveLine(objectiveText, 'match death reg coef');
result.source_artifact = artifact;
end

function [tmpParent, tmpDir] = copyWorkingModel(srcDir)
tmpParent = tempname;
mkdir(tmpParent);
[~, modelName] = fileparts(srcDir);
tmpDir = fullfile(tmpParent, modelName);
copyfile(srcDir, tmpDir);
if ~isfolder(fullfile(tmpDir, 'results'))
    mkdir(fullfile(tmpDir, 'results'));
end
if ~isfolder(fullfile(tmpDir, 'Output'))
    mkdir(fullfile(tmpDir, 'Output'));
end
end

function value = parseObjectiveLine(txt, label)
pattern = [regexptranslate('escape', label) '\s*=\s*([-+0-9.eE]+)'];
tokens = regexp(txt, pattern, 'tokens', 'once');
if isempty(tokens)
    value = NaN;
else
    value = str2double(tokens{1});
end
end

function writeStandardErrorSummary(se, dst)
ensureLocalDir(fileparts(dst));
rows = {};
rows = appendSeRows(rows, 'baseline', se.baseline);
rows = appendSeRows(rows, 'heterogeneous_match_death', se.hetero);
rows = appendSeRows(rows, 'mp_match_shock', se.mpMatch);
rows = appendSeRows(rows, 'mp_no_dispersion', se.mpNoDisp);
T = cell2table(rows, 'VariableNames', {'model', 'parameter_index', ...
    'generated_parameter', 'generated_std_error'});
writetable(T, dst);
end

function rows = appendSeRows(rows, label, result)
for i = 1:numel(result.param_vec)
    rows(end+1, :) = {label, i, result.param_vec(i), result.stderr(i)}; %#ok<AGROW>
end
end

function ensureLocalDir(pathName)
if ~isfolder(pathName)
    mkdir(pathName);
end
end

function cleanupDir(pathName)
if isfolder(pathName)
    removePathTree(pathName);
    rmdir(pathName, 's');
end
end

function removePathTree(pathName)
try
    canonicalRoot = char(java.io.File(pathName).getCanonicalPath());
    parts = strsplit(path, pathsep);
    remove = {};
    for i = 1:numel(parts)
        if isempty(parts{i})
            continue
        end
        try
            canonicalPart = char(java.io.File(parts{i}).getCanonicalPath());
        catch
            canonicalPart = parts{i};
        end
        if strcmp(canonicalPart, canonicalRoot) || startsWith(canonicalPart, [canonicalRoot filesep])
            remove{end+1} = parts{i}; %#ok<AGROW>
        end
    end
    if ~isempty(remove)
        rmpath(strjoin(remove, pathsep));
    end
catch
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
