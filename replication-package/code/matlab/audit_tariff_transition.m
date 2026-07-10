function audit_tariff_transition(generatedPath)
%AUDIT_TARIFF_TRANSITION Compare a generated Trump-tariff transition path
%with the packaged transition sequence used for Figure 11a.

if nargin < 1 || isempty(generatedPath)
    rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath());
    generatedPath = fullfile(rootDir, 'output', 'tariff_transition_audit', ...
        'dynamics_tariff_generated.mat');
else
    rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath());
end

outputDir = fullfile(rootDir, 'output');
logDir = fullfile(outputDir, 'logs');
if ~isfolder(logDir)
    mkdir(logDir);
end

tariffDir = fullfile(rootDir, 'code', 'matlab', ...
    'baseline_counterfactuals_July_2024', 'trump tariff');
packagedPath = fullfile(tariffDir, 'dynamics_tariff.mat');

if ~isfile(generatedPath)
    error('Generated tariff transition file not found: %s', generatedPath);
end
if ~isfile(packagedPath)
    error('Packaged tariff transition file not found: %s', packagedPath);
end

packaged = load(packagedPath, 'Ms1_seq', 'Ms2_seq');
generated = load(generatedPath, 'Ms1_seq', 'Ms2_seq', 'Ms1_count', 'Ms2_count', ...
    'Mb_count', 'DID');

metrics = {};
values = [];
notes = {};

[maxMs1, idxMs1] = maxCellSeqDiff(packaged.Ms1_seq, generated.Ms1_seq);
[maxMs2, idxMs2] = maxCellSeqDiff(packaged.Ms2_seq, generated.Ms2_seq);
metrics(end+1,1) = {'num_periods_packaged'}; values(end+1,1) = numel(packaged.Ms1_seq); notes(end+1,1) = {''};
metrics(end+1,1) = {'num_periods_generated'}; values(end+1,1) = numel(generated.Ms1_seq); notes(end+1,1) = {''};
metrics(end+1,1) = {'max_abs_diff_Ms1_seq'}; values(end+1,1) = maxMs1; notes(end+1,1) = {sprintf('period %d', idxMs1)};
metrics(end+1,1) = {'max_abs_diff_Ms2_seq'}; values(end+1,1) = maxMs2; notes(end+1,1) = {sprintf('period %d', idxMs2)};

if isfield(generated, 'Ms1_count') && isfield(generated, 'Ms2_count')
    packagedMs1Count = countActive(packaged.Ms1_seq);
    packagedMs2Count = countActive(packaged.Ms2_seq);
    metrics(end+1,1) = {'max_abs_diff_Ms1_count'}; %#ok<AGROW>
    values(end+1,1) = max(abs(packagedMs1Count(:) - generated.Ms1_count(:))); %#ok<AGROW>
    notes(end+1,1) = {''}; %#ok<AGROW>
    metrics(end+1,1) = {'max_abs_diff_Ms2_count'}; %#ok<AGROW>
    values(end+1,1) = max(abs(packagedMs2Count(:) - generated.Ms2_count(:))); %#ok<AGROW>
    notes(end+1,1) = {''}; %#ok<AGROW>
end

T = table(metrics, values, notes, 'VariableNames', {'metric','value','notes'});
writetable(T, fullfile(logDir, 'tariff_transition_audit.csv'));

fprintf('Tariff transition audit written to %s\n', ...
    fullfile(logDir, 'tariff_transition_audit.csv'));
disp(T);
end

function [maxDiff, maxIdx] = maxCellSeqDiff(a, b)
T = min(numel(a), numel(b));
maxDiff = 0;
maxIdx = 0;
for t = 1:T
    d = max(abs(a{t}(:) - b{t}(:)));
    if d > maxDiff
        maxDiff = d;
        maxIdx = t;
    end
end
if numel(a) ~= numel(b)
    maxDiff = Inf;
    maxIdx = T + 1;
end
end

function counts = countActive(seq)
counts = zeros(numel(seq), 1);
for t = 1:numel(seq)
    counts(t) = sum(seq{t}(2:end));
end
end
