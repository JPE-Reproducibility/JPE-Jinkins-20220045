%% SUMMARY_MECHANICAL_GPT
% Workspace-based reporting script called by `mechanical_counterfactual_main.m`.
% Expects steady-state objects (1996/2004/2011) to already exist in memory.
% Writes a standalone LaTeX table with policy-shock-only percent changes.

%% SUMMARY of Steady State

%% 1996
active_idx = (ns > 0);
wt_active = repmat(wt_x, nnz(active_idx), 1);

%mass of suppliers and buyers
disp('mass of active suppliers')
nseller0= x0(7)*(x0(4)*sum(Ms20(2:end))+(1-x0(4))*sum(Ms10(2:end)))
disp('mass of active suppliers low type')
nseller10= x0(7)*((1-x0(4))*sum(Ms10(2:end))); 
[nseller10]
disp('mass of active suppliers high type')
nseller20= x0(7)*(x0(4)*sum(Ms20(2:end)));
[nseller20]
disp('mass of active buyers')
nbuyer0 = sum(mMb0(2:end,:) * wt_x');
[nbuyer0]

%suppliers per buyer
disp('suppliers per buyer')
spb0 = sum(sum(mMb0(active_idx,:).*repmat(ns(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMb0(active_idx,:).*wt_active))
disp('high type suppliers per buyer')
s2pb0 = sum(sum(mMb0(active_idx,:).*repmat(s2(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMb0(active_idx,:).*wt_active))

%% 2011
%mass of suppliers and buyers
disp('mass of active suppliers')
nsellerT= xT(7)*(xT(4)*sum(Ms2T(2:end))+(1-xT(4))*sum(Ms1T(2:end)))
disp('mass of active suppliers low type')
nseller1T= xT(7)*((1-xT(4))*sum(Ms1T(2:end)));
[nseller1T/nseller10-1]
disp('mass of active suppliers high type')
nseller2T= xT(7)*(xT(4)*sum(Ms2T(2:end)));
[nseller2T/nseller20-1]
disp('mass of active buyers')
nbuyerT = sum(mMbT(2:end,:) * wt_x');
[nbuyerT/nbuyer0-1]

%suppliers per buyer
disp('suppliers per buyer')
spbT = sum(sum(mMbT(active_idx,:).*repmat(ns(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMbT(active_idx,:).*wt_active));
[spbT/spb0-1]
disp('high type suppliers per buyer')
s2pbT = sum(sum(mMbT(active_idx,:).*repmat(s2(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMbT(active_idx,:).*wt_active));
[s2pbT/s2pb0-1]

%% 2004
%mass of suppliers and buyers
disp('mass of active suppliers')
nseller1= x1(7)*(x1(4)*sum(Ms21(2:end))+(1-x1(4))*sum(Ms11(2:end)))
disp('mass of active suppliers low type')
nseller11= x1(7)*((1-x1(4))*sum(Ms11(2:end))); 
[nseller11/nseller10-1]
disp('mass of active suppliers high type')
nseller21= x1(7)*(x1(4)*sum(Ms21(2:end)));
[nseller21/nseller20-1]
disp('mass of active buyers')
nbuyer1 = sum(mMb1(2:end,:) * wt_x');
[nbuyer1/nbuyer0-1]

%suppliers per buyer
disp('suppliers per buyer')
spb1 = sum(sum(mMb1(active_idx,:).*repmat(ns(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMb1(active_idx,:).*wt_active));
[spb1/spb0-1]
disp('high type suppliers per buyer')
s2pb1 = sum(sum(mMb1(active_idx,:).*repmat(s2(active_idx),1,Nx).*wt_active)) ...
    / sum(sum(mMb1(active_idx,:).*wt_active));
[s2pb1/s2pb0-1]

% %consumer welfare
% disp('consumer welfare change')
% (gam-1)*(log(Ap1)-log(Ap0))

welfareT = welfare_calc(mMbT,N1,N2,ns,alp,gam);
welfare1 = welfare_calc(mMb1,N1,N2,ns,alp,gam);
disp('consumer welfare log change')
log(welfareT)-log(welfare1)
disp('consumer welfare percent change')
(welfareT-welfare1)/welfare1


%% === Read and Parse the Source LaTeX File ===
% File path to source baseline counterfactual table used in ejtx_2025.tex
baselineFile = '../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex';
if ~isfile(baselineFile)
    baselineFile = '../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table.tex';
end
fid = fopen(baselineFile, 'r');
if fid == -1
    error('Could not open baseline file: %s', baselineFile);
end

% Create containers to store: the baseline (col 1), the 2004 % (col 2), and 2011 % (col 3).
rowMap_baseline = containers.Map();
rowMap_2004     = containers.Map();
rowMap_2011     = containers.Map();

while ~feof(fid)
    line = fgetl(fid);
    if ~ischar(line)
        break;
    end

    % Only process lines that start with a row number (e.g., "1.")
    if isempty(regexp(line, '^\s*\d+\.', 'once'))
        continue;
    end

    % Split the line by '&'
    parts = strsplit(line, '&');
    % Remove any trailing '\\' from each part
    parts = regexprep(parts, '\\\\', '');

    % We expect at least 8 parts:
    %  row number, label, blank, (col1 = 1996), blank, (col2 = 2004%), blank, (col3 = 2011%)
    if length(parts) < 8
        continue;
    end

    % Extract the row label from parts{2}
    rawLabel = strtrim(parts{2});
    labelExpr = '\\multicolumn\{2\}\{l\}\{(.+?)\}';
    tokens = regexp(rawLabel, labelExpr, 'tokens');
    if ~isempty(tokens)
        rowLabel = tokens{1}{1};
    else
        rowLabel = rawLabel;
    end

    %--- Column 1 (baseline) ---
    baseStr = strtrim(parts{4});
    baseStr = strrep(baseStr, '%',''); % just in case
    baseStr = strrep(baseStr, '\', '');
    baseVal = str2double(baseStr);

    %--- Column 2 (2004) as % from baseline ---
    val2004Str = strtrim(parts{6});
    val2004Str = strrep(val2004Str, '%', '');
    val2004Str = strrep(val2004Str, '\', '');
    val2004 = str2double(val2004Str);

    %--- Column 3 (2011) as % from baseline ---
    val2011Str = strtrim(parts{8});
    val2011Str = strrep(val2011Str, '%', '');
    val2011Str = strrep(val2011Str, '\', '');
    val2011 = str2double(val2011Str);

    % Store
    rowMap_baseline(rowLabel) = baseVal;
    rowMap_2004(rowLabel)     = val2004;
    rowMap_2011(rowLabel)     = val2011;
end
fclose(fid);

%% === Define the Labels for the Policy Shock Comparison ===
tableLabels = { ...
    'measure, active low-$\xi$ suppliers', ...
    'measure, active high-$\xi$ suppliers', ...
    'measure, active buyers', ...
    'number of suppliers per buyer', ...
    'high-$\xi$ suppliers per buyer'};

%% === Compute the "Actual" Percentage Change (Second Experiment Only) ===
nLabels = numel(tableLabels);
actualChange = zeros(1, nLabels);

for i = 1:nLabels
    lbl = tableLabels{i};

    if rowMap_baseline.isKey(lbl) && rowMap_2004.isKey(lbl) && rowMap_2011.isKey(lbl)
        % Baseline (col 1):
        baseVal = rowMap_baseline(lbl);      % e.g. 0.446
        % 2004 shock in percent:
        shock2004 = rowMap_2004(lbl);        % e.g. 26.4
        % 2011 shock in percent:
        shock2011 = rowMap_2011(lbl);        % e.g. 69.3

        % New baseline after first experiment:
        newBaseline = baseVal * (1 + shock2004/100);

        % Final value after second experiment:
        finalValue  = baseVal * (1 + shock2011/100);

        % Percentage effect of second experiment, relative to the new baseline:
        %   = ((finalValue / newBaseline) - 1) * 100
        actualChange(i) = (finalValue / newBaseline - 1) * 100;

    else
        actualChange(i) = NaN;
    end
end

%% === Compute the Mechanical Model’s Policy Shock (2011 vs. 2004) ===
% You presumably already have these variables somewhere:
%  nseller1T/nseller11, etc.
modelChange = [ ...
    (nseller1T / nseller11 - 1), ...
    (nseller2T / nseller21 - 1), ...
    (nbuyerT   / nbuyer1  - 1), ...
    (spbT      / spb1     - 1), ...
    (s2pbT     / s2pb1    - 1)] * 100;

%% === Generate LaTeX Table Comparing Actual vs. Mechanical Policy Shocks ===
if ~exist(fullfile('output','tables'),'dir')
    mkdir(fullfile('output','tables'));
end
outputFile = fullfile('output','tables','counterfactual_table_policy_only.tex');
fileID = fopen(outputFile, 'w');
if fileID == -1
    error('Could not open output file for writing.');
end

fprintf(fileID, '\\begin{table}[h!]\\centering\n');
fprintf(fileID, '\\caption{Effect of 2004 policy shock, baseline model and mechanical model}\n');
fprintf(fileID, '\\begin{tabular}{lcc}\n\\hline\\hline\n');
fprintf(fileID, ' & Baseline \\%% Change & Mechanical \\%% Change \\\\\n\\hline\n');

for i = 1:nLabels
    fprintf(fileID, '%s & %.2f & %.2f \\\\\n', tableLabels{i}, actualChange(i), modelChange(i));
end

fprintf(fileID, '\\hline\n\\end{tabular}\n\\end{table}\n');
fclose(fileID);

disp(['LaTeX table written to ', outputFile]);

