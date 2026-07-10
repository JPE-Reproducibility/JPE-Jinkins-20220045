function run_all_replication(mode)
%RUN_ALL_REPLICATION Main entry point for the EJTX JPE replication package.
%
% Usage:
%   run_all_replication           % fast reproduction from included artifacts
%   run_all_replication('fast')   % same as above
%   run_all_replication('full')   % attempt long estimation workflows
%
% The fast mode is the recommended first check for JPE replicators. It uses
% disclosed data and included intermediate model artifacts to rebuild/copy the
% paper-facing output files into the root output directory. The full mode
% attempts computationally expensive estimation steps where code is available.

if nargin < 1 || isempty(mode)
    mode = 'fast';
end
mode = validatestring(mode, {'fast','full'});

scriptDir = fileparts(mfilename('fullpath'));
rootDir = char(java.io.File(fullfile(scriptDir, '..', '..')).getCanonicalPath());
codeDir = fullfile(rootDir, 'code', 'matlab');
outputDir = fullfile(rootDir, 'output');

addpath(genpath(codeDir));
ensureDir(fullfile(outputDir, 'figures', 'paper'));
ensureDir(fullfile(outputDir, 'tables', 'paper'));
ensureDir(fullfile(outputDir, 'logs'));

logFile = fullfile(outputDir, 'logs', ['run_all_replication_' mode '.log']);
if isfile(logFile)
    delete(logFile);
end
diary(logFile);
cleanupObj = onCleanup(@() diary('off'));

fprintf('EJTX JPE replication package\n');
fprintf('Mode: %s\n', mode);
fprintf('Root: %s\n', rootDir);
fprintf('Started: %s\n\n', datestr(now));

collect_disclosed_data_outputs(rootDir, outputDir);
collect_baseline_outputs(rootDir, outputDir);
collect_counterfactual_outputs(rootDir, outputDir);
collect_mechanical_outputs(rootDir, outputDir, mode);
collect_aar_outputs(rootDir, outputDir, mode);
collect_mp_outputs(rootDir, outputDir);
write_standalone_model_tables(rootDir, outputDir);
run_exact_fit_checks(rootDir, outputDir);
if strcmp(mode, 'full')
    run_full_estimation_workflows(rootDir, outputDir);
end

fprintf('\nFinished: %s\n', datestr(now));
fprintf('Outputs are in %s\n', outputDir);
end

function collect_disclosed_data_outputs(rootDir, outputDir)
fprintf('Collecting disclosed-data figures and tables...\n');
figOut = fullfile(outputDir, 'figures', 'paper');
generate_figure_01(rootDir, outputDir);
generate_figure_04(rootDir, outputDir);

censusFigSrc = fullfile(rootDir, 'data', 'Census_LFTTD--disclosed_statistics_and_graphs', ...
    'CES_disclosed_files', '1109_tybout_release_req5623_20170228');
copyRequired(fullfile(censusFigSrc, 'NoSeller_1996_2011.eps'), ...
    fullfile(figOut, 'figure_02_number_of_suppliers.eps'));
copyRequired(fullfile(censusFigSrc, 'NoSeller_by_country_1996_2011.eps'), ...
    fullfile(figOut, 'figure_03_suppliers_by_country.eps'));
copyRequired(fullfile(censusFigSrc, 'NoBuyer_by_related_1996_2011.eps'), ...
    fullfile(figOut, 'figure_06_buyers_related_arm_length.eps'));

tabOut = fullfile(outputDir, 'tables', 'paper');
stats = fullfile(rootDir, 'data', 'Census_LFTTD--disclosed_statistics_and_graphs', 'CES_disclosed_files');
req5488 = fullfile(stats, '1109_tybout_release_req5488_20170109');
req5952 = fullfile(stats, '1109_tybout_release_req5952_20170808');
copyRequired(fullfile(req5488, 'transition_matrix_num_buyers_per_seller.xls'), ...
    fullfile(tabOut, 'table_01_transition_buyers_per_supplier.xls'));
copyRequired(fullfile(req5488, 'transition_matrix_num_sellers_per_buyer.xls'), ...
    fullfile(tabOut, 'table_02_transition_suppliers_per_buyer.xls'));
copyRequired(fullfile(req5952, '05_avg_number_partners_by_yr_in_market.xls'), ...
    fullfile(tabOut, 'table_03_partner_count_distribution_source.xls'));
write_disclosed_paper_display_tables(tabOut);
end

function collect_baseline_outputs(rootDir, outputDir)
fprintf('Collecting baseline model outputs...\n');
generate_figure_08(rootDir, outputDir);
generate_figure_09(rootDir, outputDir);
generate_figure_10(rootDir, outputDir);
end

function collect_counterfactual_outputs(rootDir, outputDir)
fprintf('Generating baseline counterfactual outputs...\n');
cfRoot = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024');
runMatlabScript(fullfile(cfRoot, 'transition dynamics'), 'transition_dynamics');
copyIfExists(fullfile(cfRoot, 'transition dynamics', 'counterfactual_table_2026.tex'), ...
    fullfile(outputDir, 'tables', 'paper', 'table_06_market_developments_counterfactual.tex'));
runMatlabScript(fullfile(cfRoot, 'trump tariff'), 'setenv(''EJTX_SKIP_TARIFF_TRANSITION'', ''1''); main');
copyIfExists(fullfile(cfRoot, 'trump tariff', 'counterfactual_tariff_table.tex'), ...
    fullfile(outputDir, 'tables', 'paper', 'table_07_trump_section_301_tariff.tex'));
generate_figure_11a(rootDir, outputDir);
generate_figure_11b(rootDir, outputDir);
end

function write_disclosed_paper_display_tables(tabOut)
fprintf('Writing paper-display CSVs for disclosed-data Tables 1-4...\n');

transitionHeader = {'year_t_year_t_plus_1','0','1','2','3','4','5','6','7','8','9','ge_10'};
table1 = {
    '1', 0.65, 0.27, 0.05, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00;
    '2', 0.32, 0.31, 0.21, 0.09, 0.03, 0.02, 0.01, 0.00, 0.00, 0.00, 0.00;
    '3', 0.19, 0.22, 0.23, 0.17, 0.09, 0.05, 0.02, 0.01, 0.01, 0.00, 0.01;
    '4', 0.13, 0.15, 0.18, 0.18, 0.14, 0.09, 0.05, 0.03, 0.02, 0.01, 0.02;
    '5', 0.10, 0.10, 0.13, 0.16, 0.16, 0.12, 0.08, 0.05, 0.03, 0.02, 0.04;
    '6', 0.08, 0.07, 0.10, 0.13, 0.14, 0.13, 0.11, 0.08, 0.05, 0.03, 0.07;
    '7', 0.07, 0.06, 0.08, 0.09, 0.12, 0.13, 0.12, 0.10, 0.07, 0.05, 0.11;
    '8', 0.07, 0.05, 0.05, 0.07, 0.10, 0.11, 0.11, 0.11, 0.09, 0.07, 0.16;
    '9', 0.06, 0.05, 0.05, 0.06, 0.08, 0.09, 0.10, 0.10, 0.10, 0.08, 0.24;
    'ge_10', 0.05, 0.03, 0.03, 0.03, 0.04, 0.04, 0.05, 0.05, 0.06, 0.06, 0.56};
writecell([transitionHeader; table1], fullfile(tabOut, ...
    'table_01_transition_buyers_per_supplier_paper_display.csv'));

table2 = {
    '1', 0.58, 0.26, 0.09, 0.04, 0.02, 0.01, 0.01, 0.00, 0.00, 0.00, 0.01;
    '2', 0.34, 0.24, 0.19, 0.10, 0.05, 0.03, 0.02, 0.01, 0.01, 0.00, 0.02;
    '3', 0.25, 0.16, 0.18, 0.14, 0.09, 0.06, 0.03, 0.02, 0.02, 0.01, 0.03;
    '4', 0.21, 0.11, 0.14, 0.14, 0.13, 0.08, 0.06, 0.04, 0.03, 0.02, 0.06;
    '5', 0.19, 0.07, 0.10, 0.12, 0.12, 0.11, 0.07, 0.06, 0.04, 0.03, 0.09;
    '6', 0.17, 0.06, 0.08, 0.09, 0.11, 0.11, 0.09, 0.07, 0.05, 0.04, 0.13;
    '7', 0.16, 0.05, 0.05, 0.07, 0.09, 0.10, 0.09, 0.09, 0.06, 0.06, 0.19;
    '8', 0.15, 0.04, 0.05, 0.06, 0.07, 0.08, 0.08, 0.08, 0.07, 0.06, 0.25;
    '9', 0.15, 0.03, 0.03, 0.04, 0.06, 0.07, 0.08, 0.08, 0.07, 0.07, 0.32;
    'ge_10', 0.12, 0.01, 0.01, 0.01, 0.02, 0.02, 0.02, 0.02, 0.03, 0.03, 0.71};
writecell([transitionHeader; table2], fullfile(tabOut, ...
    'table_02_transition_suppliers_per_buyer_paper_display.csv'));

table3Header = {'x','share_buyers_at_most_x_suppliers','share_suppliers_at_most_x_buyers'};
table3 = {
    1, 0.407, 0.798;
    2, 0.554, 0.911;
    3, 0.645, 0.951;
    4, 0.709, 0.970;
    5, 0.743, 0.980;
    6, 0.780, 0.987;
    7, 0.808, 0.991;
    8, 0.823, 0.993;
    9, 0.837, 0.995;
    10, 0.855, 0.996};
writecell([table3Header; table3], fullfile(tabOut, ...
    'table_03_firm_distributions_by_partner_counts_2011.csv'));

table4Header = {'num_suppliers','mean_log_imports','share_1st','share_2nd', ...
    'share_3rd','share_4th','share_5th','share_6th','share_7th', ...
    'share_8th','share_9th','share_10th'};
table4 = {
    1, 0.000, 1.000, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    2, 1.134, 0.771, 0.229, 0, 0, 0, 0, 0, 0, 0, 0;
    3, 1.604, 0.668, 0.240, 0.092, 0, 0, 0, 0, 0, 0, 0;
    4, 1.764, 0.608, 0.232, 0.111, 0.049, 0, 0, 0, 0, 0, 0;
    5, 1.904, 0.544, 0.231, 0.126, 0.067, 0.032, 0, 0, 0, 0, 0;
    6, 2.054, 0.540, 0.218, 0.115, 0.070, 0.039, 0.019, 0, 0, 0, 0;
    7, 2.214, 0.502, 0.214, 0.123, 0.074, 0.045, 0.027, 0.019, 0, 0, 0;
    8, 2.094, 0.460, 0.212, 0.125, 0.080, 0.054, 0.035, 0.023, 0.011, 0, 0;
    9, 2.364, 0.451, 0.201, 0.121, 0.083, 0.055, 0.038, 0.026, 0.017, 0.017, 0;
    10, 2.324, 0.420, 0.197, 0.125, 0.084, 0.060, 0.042, 0.029, 0.021, 0.013, 0.007};
writecell([table4Header; table4], fullfile(tabOut, ...
    'table_04_buyers_imports_per_supplier_and_supplier_shares.csv'));
end

function collect_mechanical_outputs(rootDir, outputDir, mode)
fprintf('Generating mechanical-model appendix outputs...\n');
mechDir = fullfile(rootDir, 'code', 'matlab', 'mechanical_model');
if isfile(fullfile(mechDir, 'build_mechanical_appendix_outputs.m'))
    generate_mechanical_outputs(rootDir);
end
copyIfExists(fullfile(mechDir, 'results', 'combined_search_intensities.png'), ...
    fullfile(outputDir, 'figures', 'paper', 'figure_12_mechanical_search_intensities.png'));
copyIfExists(fullfile(mechDir, 'output', 'tables', 'counterfactual_table_policy_only.tex'), ...
    fullfile(outputDir, 'tables', 'paper', 'table_08_mechanical_policy_shock.tex'));
end

function collect_aar_outputs(rootDir, outputDir, mode)
fprintf('Generating AAR appendix/comparison outputs...\n');
aarDir = fullfile(rootDir, 'code', 'matlab', 'AAR');
if isfile(fullfile(aarDir, 'comparison', 'scripts', 'generate_comparison_outputs.m'))
    here = pwd;
    try
        cd(fullfile(aarDir, 'comparison', 'scripts'));
        generate_comparison_outputs;
    catch err
        fprintf('AAR comparison rebuild failed: %s\n', err.message);
    end
    cd(here);
end
tabOut = fullfile(outputDir, 'tables', 'paper');
copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'parameter_estimates.csv'), ...
    fullfile(tabOut, 'table_12_aar_parameter_estimates.csv'));
copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'moment_comparison.csv'), ...
    fullfile(tabOut, 'table_12_aar_moment_comparison.csv'));
copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'policy_shock_benchmark_comparison.csv'), ...
    fullfile(tabOut, 'table_13_aar_policy_shock_benchmark_comparison.csv'));
copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'policy_shock_comparison.csv'), ...
    fullfile(tabOut, 'table_13_aar_policy_shock_comparison.csv'));
end

function collect_mp_outputs(rootDir, outputDir)
fprintf('Generating MP appendix model outputs...\n');
generate_figure_13(rootDir, outputDir);
copyIfExists(fullfile(rootDir, 'data', 'intermediate', 'mp_model_appendix_table_parameters.csv'), ...
    fullfile(outputDir, 'tables', 'paper', 'table_09_mp_model_source_parameters.csv'));
end

function write_standalone_model_tables(rootDir, outputDir)
fprintf('Writing standalone model parameter/moment tables...\n');
tabOut = fullfile(outputDir, 'tables', 'paper');

generatedSe = generate_standard_errors_at_saved_parameters(rootDir, outputDir);
base = generatedSe.baseline;
hetero = generatedSe.hetero;

matchDeathVarianceForTable = 0.0004^2;
baselineFullObjective = base.D0 + (hetero.data_match_death_reg_coef^2 / matchDeathVarianceForTable);

write_table_09_mp(outputDir, base, generatedSe.mpMatch, generatedSe.mpNoDisp, baselineFullObjective);

baseOrder = [1 2 3 4 5 7 8 6];
table5Rows = {'k0'; 'gamma_B'; 'gamma_S'; 'omega'; 'Delta'; 'M_S'; 'eta'; ...
    'sigma2_ln_mu'; 'Objective function'};
table5PaperEstimate = [0.009; 0.320; 0.230; 0.030; 0.454; 4.203; 2.432; 7.428; 10461.73];
table5PaperStdError = [0.003; 0.041; 0.046; 0.002; 0.006; 0.728; 0.141; 2.508; NaN];
table5GeneratedEstimate = [base.param_vec(baseOrder(:)); base.D0];
table5GeneratedStdError = [base.stderr(baseOrder(:)); NaN];
table5Notes = repmat({''}, numel(table5Rows), 1);
table5Notes{7} = 'Standard error regenerated by running baseline std_errors.m at the saved parameter vector.';
T5 = table(table5Rows, table5PaperEstimate, table5PaperStdError, ...
    table5GeneratedEstimate, table5GeneratedStdError, table5Notes, ...
    'VariableNames', {'row', 'paper_reported_estimate', 'paper_reported_std_error', ...
    'generated_estimate', 'generated_std_error', 'notes'});
writeTableCsv(T5, fullfile(tabOut, 'table_05_cost_distributional_parameters.csv'));

heteroOrder = [1 2 3 4 5 7 8 6 9];
table10Rows = {'k0'; 'gamma_B'; 'gamma_S'; 'omega'; 'Delta'; 'M_S'; 'eta'; ...
    'sigma2_ln_mu'; 'delta_1'; 'delta_2'; 'Objective function'; ...
    'Baseline moments only'};
baselinePaperEstimate = [0.009; 0.320; 0.230; 0.030; 0.454; 4.203; 2.432; 7.428; ...
    NaN; NaN; 11346.79; 10461.73];
baselineGenerated = [base.param_vec(baseOrder(:)); NaN; NaN; baselineFullObjective; base.D0];
baselinePaperStdError = [0.003; 0.041; 0.046; 0.002; 0.006; 0.728; 0.141; 2.508; ...
    NaN; NaN; NaN; NaN];
baselineGeneratedStdError = [base.stderr(baseOrder(:)); NaN; NaN; NaN; NaN];
heteroPaperEstimate = [0.008; 0.311; 0.177; 0.031; 0.457; 4.496; 2.435; 7.121; ...
    0.563; 0.529; 10867.17; 10804.13];
heteroGenerated = [hetero.param_vec(heteroOrder(:)); hetero.delta2; hetero.out; hetero.out_old];
heteroPaperStdError = [0.003; 0.051; 0.068; 0.001; 0.006; 1.012; 0.177; 3.178; ...
    0.010; NaN; NaN; NaN];
heteroGeneratedStdError = [hetero.stderr(heteroOrder(:)); NaN; NaN; NaN];
notes = repmat({''}, numel(table10Rows), 1);
notes{7} = 'Baseline eta standard error regenerated by running baseline std_errors.m at the saved parameter vector.';
notes{10} = 'Generated from heterogeneous-death model solution at the saved parameter vector.';
notes{11} = 'Baseline objective generated as baseline-moments objective plus the disclosed match-death moment contribution.';
notes{end} = 'Generated by evaluating the heterogeneous-death model on the baseline-moment subset.';
T10 = table(table10Rows, baselinePaperEstimate, baselineGenerated, ...
    baselinePaperStdError, baselineGeneratedStdError, heteroPaperEstimate, ...
    heteroGenerated, heteroPaperStdError, heteroGeneratedStdError, notes, ...
    'VariableNames', {'row', 'baseline_paper_reported', 'baseline_generated', ...
    'baseline_paper_reported_std_error', 'baseline_generated_std_error', ...
    'hetero_paper_reported', 'hetero_generated', 'hetero_paper_reported_std_error', ...
    'hetero_generated_std_error', 'notes'});
writeTableCsv(T10, fullfile(tabOut, 'table_10_heterogeneous_death_hazard_comparison.csv'));

table11Rows = {'Average match death probability'; 'Buyer count coefficient (beta_NB)'};
dataValues = [hetero.data_match_death_haz; hetero.data_match_death_reg_coef];
modelValues = [hetero.avg_match_death_haz; hetero.match_death_reg_coef];
T11 = table(table11Rows, dataValues, modelValues, ...
    'VariableNames', {'row', 'data', 'model_based_estimate'});
writeTableCsv(T11, fullfile(tabOut, 'table_11_model_vs_data_based_moments.csv'));
end

function write_table_09_mp(outputDir, base, match, nodisp, baselineFullObjective)
tabOut = fullfile(outputDir, 'tables', 'paper');

rows = {
    'Buyer search cost scalar', base.param_vec(1), base.stderr(1), match.param_vec(1), match.stderr(1), nodisp.param_vec(1), nodisp.stderr(1), '';
    'Supplier search cost scalar', NaN, NaN, match.param_vec(2), match.stderr(2), nodisp.param_vec(2), nodisp.stderr(2), 'Baseline supplier scalar is constrained to equal buyer scalar.';
    'Buyer visibility parameter', base.param_vec(2), base.stderr(2), NaN, NaN, NaN, NaN, 'MP specifications shut down visibility effects.';
    'Supplier visibility parameter', base.param_vec(3), base.stderr(3), NaN, NaN, NaN, NaN, 'MP specifications shut down visibility effects.';
    'Share of high-type suppliers', base.param_vec(4), base.stderr(4), match.param_vec(3), match.stderr(3), nodisp.param_vec(3), nodisp.stderr(3), '';
    'High-type supplier cost advantage', base.param_vec(5), base.stderr(5), match.param_vec(4), match.stderr(4), nodisp.param_vec(4), nodisp.stderr(4), '';
    'Buyer type dispersion', base.param_vec(6), base.stderr(6), match.param_vec(5), match.stderr(5), nodisp.param_vec(5), nodisp.stderr(5), '';
    'Supplier to buyer ratio', base.param_vec(7), base.stderr(7), match.param_vec(6), match.stderr(6), nodisp.param_vec(6), nodisp.stderr(6), '';
    'Within-store elasticity', NaN, NaN, match.param_vec(7), match.stderr(7), nodisp.param_vec(7), nodisp.stderr(7), 'Baseline within-store elasticity is calibrated.';
    'Cross-store elasticity', base.param_vec(8), base.stderr(8), NaN, NaN, NaN, NaN, 'MP cross-store elasticity is constrained to equal within-store elasticity.';
    'Match shock scale', NaN, NaN, match.param_vec(8), match.stderr(8), nodisp.param_vec(8), nodisp.stderr(8), 'No-dispersion estimate fixes this at the 1e-6 approximation; its SE is generated but the paper omits it.';
    'Fixed cost (share of median match surplus)', NaN, NaN, match.param_vec(9), match.stderr(9), nodisp.param_vec(9), nodisp.stderr(9), '';
    'Match death moment (data: -0.0119)', NaN, NaN, match.match_death_reg_coef, NaN, nodisp.match_death_reg_coef, NaN, '';
    'Objective function', baselineFullObjective, NaN, match.out, NaN, nodisp.out, NaN, '';
    'Objective function (baseline moments)', base.D0, NaN, match.out_old, NaN, nodisp.out_old, NaN, ''
    };
T9 = cell2table(rows, 'VariableNames', {'row', 'baseline_estimate', ...
    'baseline_std_error_generated', 'match_shock_estimate', ...
    'match_shock_std_error_generated', 'no_dispersion_estimate', ...
    'no_dispersion_std_error_generated', 'notes'});
writeTableCsv(T9, fullfile(tabOut, 'table_09_mp_model_parameters_and_fit.csv'));

latexRows = {
    'Buyer search cost scalar', 0.009, 0.003, 0.0090, 0.0014, 0.0071, 0.0014;
    'Supplier search cost scalar', NaN, NaN, 0.0020, 0.2254, 0.0019, 0.1830;
    'Buyer visibility parameter', 0.320, 0.041, NaN, NaN, NaN, NaN;
    'Supplier visibility parameter', 0.230, 0.046, NaN, NaN, NaN, NaN;
    'Share of high-type suppliers', 0.030, 0.002, 0.0341, 0.0003, 0.0341, 0.0003;
    'High-type supplier cost advantage', 0.454, 0.006, 0.0559, 0.0008, 0.0551, 0.0008;
    'Buyer type dispersion', 7.428, 2.508, 6.5224, 0.2542, 5.9207, 0.2375;
    'Supplier to buyer ratio', 4.203, 0.728, 6.7579, 0.2114, 8.0639, 0.4000;
    'Within-store elasticity', NaN, NaN, 1.8771, 0.0034, 1.8687, 0.0035;
    'Cross-store elasticity', 2.432, 0.141, NaN, NaN, NaN, NaN;
    'Match shock scale', NaN, NaN, 0.0414, 0.5724, 0.0000, NaN;
    'Fixed cost (share of median match surplus)', NaN, NaN, 0.0015, 0.0006, 0.0018, 0.0005;
    'Match death moment (data: -0.0119)', NaN, NaN, -0.003, NaN, 0.000, NaN;
    'Objective function', 11346.79, NaN, 11522.25, NaN, 11892.5, NaN;
    'Objective function (baseline moments)', 10461.73, NaN, 10983.1, NaN, 11007.4, NaN
    };
L9 = cell2table(latexRows, 'VariableNames', {'row', 'baseline_latex', ...
    'baseline_latex_std_error', 'match_shock_latex', ...
    'match_shock_latex_std_error', 'no_dispersion_latex', ...
    'no_dispersion_latex_std_error'});
writeTableCsv(L9, fullfile(tabOut, 'table_09_mp_model_latex_comparison.csv'));
end

function writeTableCsv(T, dst)
ensureDir(fileparts(dst));
writetable(T, dst);
end

function run_exact_fit_checks(rootDir, outputDir)
fprintf('Running exact-fit checks at reported/saved parameter vectors...\n');
logFile = fullfile(outputDir, 'logs', 'exact_fit_checks.log');
try
    txt = evalc('audit_report_values');
    fid = fopen(logFile, 'w');
    if fid == -1
        error('Could not open %s for writing.', logFile);
    end
    cleanupObj = onCleanup(@() fclose(fid)); %#ok<NASGU>
    fwrite(fid, txt);
    fprintf('%s', txt);
    writeFitCheckSummary(txt, fullfile(outputDir, 'tables', 'paper', 'model_fit_checks_for_tables_05_09_10_11_12.csv'));
    fprintf('Exact-fit check log written to %s\n', logFile);
catch err
    fprintf('Exact-fit checks failed: %s\n', err.message);
end
end

function run_full_estimation_workflows(rootDir, outputDir)
if strcmp(getenv('EJTX_TEST_RUN'), '1')
    run_full_estimation_test_checks(rootDir, outputDir);
    return
end

fprintf('Running full estimation workflows. These optimizations are computationally expensive.\n');
codeRoot = fullfile(rootDir, 'code', 'matlab');
runMatlabScript(fullfile(codeRoot, 'baseline_no_NsNb_target'), 'start_estimation_ga');
runMatlabScript(fullfile(codeRoot, 'heterogeneous_death_haz', 'sellers_only'), 'start_estimation_ga');
runMatlabScript(fullfile(codeRoot, 'mechanical_model'), 'start_mechanical');
runMatlabScript(fullfile(codeRoot, 'AAR', 'estimation'), 'run_estimation');
runMatlabScript(fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
    'MP model', 'calibration_no_gamma_s'), 'main_no_gamma');
end

function run_full_estimation_test_checks(rootDir, outputDir)
fprintf('Running bounded test checks for full-estimation entry points...\n');
logFile = fullfile(outputDir, 'logs', 'full_estimation_test_run.log');
fid = fopen(logFile, 'w');
if fid == -1
    error('Could not open %s for writing.', logFile);
end
cleanupObj = onCleanup(@() fclose(fid)); %#ok<NASGU>

codeRoot = fullfile(rootDir, 'code', 'matlab');
steps = {
    'baseline GA', fullfile(codeRoot, 'baseline_no_NsNb_target'), baselineTestCommand();
    'heterogeneous match-death GA', fullfile(codeRoot, 'heterogeneous_death_haz', 'sellers_only'), heteroTestCommand();
    'mechanical-model GA', fullfile(codeRoot, 'mechanical_model'), mechanicalTestCommand();
    'AAR MSM estimator', fullfile(codeRoot, 'AAR', 'estimation'), aarTestCommand();
    'MP match-shock GA/patternsearch', fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
        'MP model', 'calibration_no_gamma_s'), mpTestCommand()
    };

failed = {};
for i = 1:size(steps, 1)
    stepName = steps{i, 1};
    stepDir = steps{i, 2};
    stepCommand = steps{i, 3};
    fprintf('  Test checking %s...\n', stepName);
    fprintf(fid, '===== %s =====\n', stepName);
    try
        txt = evalc('run_single_estimation_test_step(rootDir, stepDir, stepCommand);');
        fprintf(fid, '%s\nPASS: %s\n\n', txt, stepName);
        fprintf('  PASS: %s\n', stepName);
    catch err
        fprintf(fid, 'FAIL: %s\n%s\n\n', stepName, getReport(err, 'extended', 'hyperlinks', 'off'));
        fprintf('  FAIL: %s -- %s\n', stepName, err.message);
        failed{end+1} = stepName; %#ok<AGROW>
    end
end

fprintf('Full-estimation test-run log written to %s\n', logFile);
if ~isempty(failed)
    error('Full-estimation test checks failed: %s', strjoin(failed, ', '));
end
end

function run_single_estimation_test_step(rootDir, stepDir, stepCommand)
incomingPath = path;
here = pwd;
try
    basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
    path(basePath);
    addpath(stepDir);
    cd(stepDir);
    eval(stepCommand);
catch err
    path(incomingPath);
    cd(here);
    rethrow(err);
end
path(incomingPath);
cd(here);
end

function cmd = baselineTestCommand()
cmd = [
    "define_parameters; define_states; define_lindex; data_moments_baseline; " + ...
    "x0 = [0.00945610159077022 0.328405888208306 0.229729202367540 0.0303627427733110 " + ...
    "0.454124065271806 7.32064657468461 4.19004349697171 2.43268886413272]; " + ...
    "D0 = objective(x0,param_indx,param_state,param_fix,data_moments,cov_v); " + ...
    "fprintf('Baseline start-vector objective %.15g\n', D0);"
    ];
cmd = char(cmd);
end

function cmd = heteroTestCommand()
cmd = [
    "if ~exist('results','dir'), mkdir('results'); end; " + ...
    "define_parameters; define_states; define_lindex; data_moments_hetero; " + ...
    "x0 = [0.00800149670142449 0.311412680597366 0.176627736944740 0.0306233133085443 " + ...
    "0.457037217583970 7.12118405670129 4.49554048853843 2.43536849736572 0.563213343051187]; " + ...
    "D0 = objective(x0,param_indx,param_state,param_fix,data_moments,cov_v,data_life); " + ...
    "fprintf('Heterogeneous match-death start-vector objective %.15g\n', D0);"
    ];
cmd = char(cmd);
end

function cmd = mechanicalTestCommand()
cmd = [
    "S = load(fullfile('..','baseline_no_NsNb_target','results','se_results_baseline_no_M_target.mat'),'param_vec'); " + ...
    "x = S.param_vec; define_parameters; define_payoffs; define_lindex; " + ...
    "si_in = [5.30475970194135 2.54322006301519 0.348565315964827 0.369505098908116 " + ...
    "9.35562288711672 0.441813632503381 7.87504269207164 0.340689355526077 " + ...
    "22.9491963021357 28.2005129010624 2.66627677681297 1.98610727953777 " + ...
    "0.517564937662059 0.367303303415852 0.321406045111434 0.300434151091727 " + ...
    "0.385153971571320 0.332210230982581 2.00214162149974 0.319917507402888 " + ...
    "2.16833653770023 0.354051646421266 0.892034393568599 0.377314705140029 " + ...
    "2.19396527483993 0.335786031814243 0.336829230525515 0.305377065853247 " + ...
    "0.358834912727211 0.405293209243906 1.30757293276676 14.2853658011404 " + ...
    "0.0373113278254231 8.71516134851435]'; " + ...
    "x(4) = si_in(33); x(7) = si_in(34); " + ...
    "D0 = objective_mechanical(si_in,x,param_indx,param_state,param_fix); " + ...
    "fprintf('Mechanical-model start-vector objective %.15g\n', D0);"
    ];
cmd = char(cmd);
end

function cmd = aarTestCommand()
cmd = [
    "param_fix = cell(15,1); empirical_targets = data_moments_baseline(param_fix); " + ...
    "cfg = default_config(); empirical_summary = compute_empirical_moments(empirical_targets, cfg); " + ...
    "if isfield(cfg,'override_calibration') && isfield(cfg.override_calibration,'z_ratio') && ~isempty(cfg.override_calibration.z_ratio), " + ...
    "cfg.calib_z_ratio = cfg.override_calibration.z_ratio; else, cfg.calib_z_ratio = empirical_summary.calibration.z_ratio; end; " + ...
    "if isfield(cfg,'override_calibration') && isfield(cfg.override_calibration,'omega_H') && ~isempty(cfg.override_calibration.omega_H), " + ...
    "cfg.calib_type_share = cfg.override_calibration.omega_H; else, cfg.calib_type_share = empirical_summary.calibration.omega_H; end; " + ...
    "theta = cfg.init_theta; theta.z_ratio = cfg.calib_z_ratio; theta.omega_H = cfg.calib_type_share; theta.shock_sigma = cfg.shock_sigma; " + ...
    "sol = solve_model(theta, cfg); model_vec = model_moments(sol, theta, cfg); " + ...
    "D0 = sum((model_vec(:) - empirical_summary.data_moments(:)).^2); " + ...
    "fprintf('AAR start-vector MSM objective %.15g\n', D0);"
    ];
cmd = char(cmd);
end

function cmd = mpTestCommand()
cmd = [
    "x0 = [0.00669 0 0.00183 0.03431 0.05356 5.48040 8.56411 1.86338 0.04029 0.00198]'; " + ...
    "define_parameters; define_states; define_lindex; " + ...
    "D0 = objective(x0,param_indx,param_state,param_fix); " + ...
    "fprintf('MP match-shock start-vector objective %.15g\n', D0);"
    ];
cmd = char(cmd);
end

function generate_figure_08(rootDir, outputDir)
fprintf('Generating Figure 8 from baseline model fit code...\n');
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

baseDir = fullfile(rootDir, 'code', 'matlab', 'baseline_no_NsNb_target');
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(baseDir);
cd(baseDir);
generate_figure_08_from_current_dir(outputDir);
end

function generate_figure_08_from_current_dir(outputDir)
S = load(fullfile('results', 'se_results_baseline_no_M_target.mat'), 'x');
x = S.x; %#ok<NASGU>
define_parameters; define_states; define_lindex;
oldVisibility = get(0, 'DefaultFigureVisible');
set(0, 'DefaultFigureVisible', 'off');
plot_fit;
set(0, 'DefaultFigureVisible', oldVisibility);
fig = figure(1);
forceLightFigure(fig);
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_08_baseline_model_fit.pdf'));
close(1);
if ishghandle(2)
    close(2);
end
end

function generate_figure_09(rootDir, outputDir)
fprintf('Generating Figure 9 from steady-state model artifacts...\n');
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

srcDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', 'steady state summary');
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(srcDir);
cd(srcDir);

S = load(fullfile(rootDir, 'code', 'matlab', 'baseline_no_NsNb_target', 'results', 'se_results_no_M_target.mat'), 'x');
x = S.x;
define_parameters; define_states; define_lindex;
[~, ~, Ap, ~, ~, ~, mMb, ~, ~, ~, Ms1, Ms2, ~, ~, ~, ...
    net_prof_b, Cs, Cs1, Cs2, net_prof_s1, net_prof_s2, pbs, profx] = ...
    solve_model(x, param_indx, param_state, param_fix); %#ok<ASGLU>

type_mMb = mMb(2:end,:) ./ repmat(sum(mMb(2:end,:)), size(mMb(2:end,:), 1), 1);
type_ns = sum(repmat(ns(2:end), 1, Nx) .* type_mMb);
net_prof = net_prof_b + repmat(s1, 1, Nx) .* net_prof_s1 + repmat(s2, 1, Nx) .* net_prof_s2;
type_rent = sum((net_prof_b(2:end,:) ./ net_prof(2:end,:)) .* type_mMb);

fig = figure('Visible', 'off', 'Color', 'w');
subplot(1, 2, 1);
yyaxis right;
plot(type_ns, 'r--', 'LineWidth', 2.5);
grid on;
yyaxis left;
plot(type_rent, 'b-', 'LineWidth', 2.5);
grid on;
xlabel('Type of Buyers');
legend('profit share', 'avg. number of suppliers', 'Location', 'northwest');
title('(a) Buyer Share of Gross Profit');
formatWhiteAxes(gca, true);

mCs = zeros((N1 + 1) * (N2 + 1), Nx);
for b = 1:Nx
    mCs(:, b) = Cs{b};
end
type_cbs = sum(mCs .* mMb);
type_profb = sum(net_prof_b .* mMb);
type_cshare = type_cbs ./ type_profb;
type_idx = [1; 5; 10; 15; (20:30)'];

subplot(1, 2, 2);
plot(type_idx, type_cshare(type_idx), 'b-', 'LineWidth', 2.5);
grid on;
xlabel('Type of Buyers');
legend('search cost as share of buyer profit', 'Location', 'southwest');
title('(b) Buyer Search Cost as Share of Flow Profit');
formatWhiteAxes(gca, false);

set(fig, 'Position', [100 100 1000 420]);
set(fig, 'InvertHardcopy', 'off');
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_09_buyer_profit_search_cost_heterogeneity.png'));
close(fig);
end

function generate_mechanical_outputs(rootDir)
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

mechDir = fullfile(rootDir, 'code', 'matlab', 'mechanical_model');
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(mechDir);
cd(mechDir);

if ~isfolder('results')
    mkdir('results');
end

[best_si, best_fval, meta] = load_best_mechanical_estimate();
fprintf('Using mechanical estimate from %s (%s), fval=%.6f\n', ...
    meta.source_type, meta.source_file, best_fval);

si = best_si;
fig = figure('Visible', 'off', 'Color', 'w');
set(fig, 'Position', [100, 100, 1200, 500]);

buyer_levels = sort(si(1:30));
subplot(1, 2, 1);
hb = bar(1:numel(buyer_levels), buyer_levels);
xlabel('Type', 'FontSize', 12);
ylabel('Search Intensity (levels, ln y-axis)', 'FontSize', 12);
title('Estimated Buyer Search Intensities', 'FontSize', 14);
ax1 = gca;
set(ax1, 'YScale', 'log', 'Color', 'w', 'XColor', 'k', 'YColor', 'k');
ax1.YLim = [0.14 55];
hb.BaseValue = 0.14;
yt1 = [0.14 0.37 1 2.7 7.4 20 55];
ax1.YTick = yt1;
ax1.YTickLabel = compose('%.2g', yt1);
xlim([0.5, numel(buyer_levels) + 0.5]);

seller_levels = sort(si(31:32));
subplot(1, 2, 2);
hs = bar(1:numel(seller_levels), seller_levels);
xlabel('Type', 'FontSize', 12);
ylabel('Search Intensity (levels, ln y-axis)', 'FontSize', 12);
title('Estimated Seller Search Intensities', 'FontSize', 14);
ax2 = gca;
set(ax2, 'YScale', 'log', 'Color', 'w', 'XColor', 'k', 'YColor', 'k');
ax2.YLim = [1 33];
hs.BaseValue = 1;
yt2 = [1 1.6 2.7 4.5 7.4 12 20 33];
ax2.YTick = yt2;
ax2.YTickLabel = compose('%.2g', yt2);
xlim([0.5, numel(seller_levels) + 0.5]);

sg = sgtitle('Mechanical Model: Estimated Search Intensities', 'FontSize', 16);
set(sg, 'Color', 'k');
forceLightFigure(fig);
saveas(fig, fullfile('results', 'combined_search_intensities.png'));
close(fig);

runMatlabScript(mechDir, 'mechanical_counterfactual_main');
end

function generate_figure_11a(rootDir, outputDir)
fprintf('Generating Figure 11a from saved tariff transition sequence...\n');
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

tariffDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', 'trump tariff');
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(tariffDir);
cd(tariffDir);

Sx = load(fullfile(rootDir, 'code', 'matlab', 'baseline_no_NsNb_target', 'results', 'se_results_no_M_target.mat'), 'x');
x = Sx.x; %#ok<NASGU>
define_parameters;
dyn = load(fullfile(tariffDir, 'dynamics_tariff.mat'), 'Ms1_seq', 'Ms2_seq');
T = numel(dyn.Ms1_seq);
Ms1_count = zeros(T, 1);
Ms2_count = zeros(T, 1);
for t = 1:T
    Ms1_count(t) = sum(dyn.Ms1_seq{t}(2:end));
    Ms2_count(t) = sum(dyn.Ms2_seq{t}(2:end));
end
Ns = x(7);
w2_x = x(4);
Year = dt * (1:T);

fig = figure('Visible', 'off', 'Color', 'w');
subplot(2, 1, 1);
plot(Year, Ms1_count .* Ns .* (1 - w2_x), 'LineWidth', 1.5);
title('Number of Low Quality sellers');
xlabel('periods');
ylabel('mass of firms');
subplot(2, 1, 2);
plot(Year, Ms2_count .* Ns .* w2_x, 'LineWidth', 1.5);
title('Number of High Quality sellers');
xlabel('periods');
ylabel('mass of firms');
set(fig, 'Position', [100 100 875 656]);
forceLightFigure(fig);
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_11a_trump_tariff_supplier_dynamics.png'));
close(fig);
end

function generate_figure_13(rootDir, outputDir)
incomingPath = path;
here = pwd;
oldVisibility = get(0, 'DefaultFigureVisible');
tmpParent = '';

mpCodeDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', ...
    'MP model', 'calibration_no_gamma_s');
artifact = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', ...
    'MP model', 'Results2026', 'Baseline_MP', 'results', 'se_results_est_eta.mat');

try
    tmpParent = tempname;
    mkdir(tmpParent);
    mpTmp = fullfile(tmpParent, 'calibration_no_gamma_s');
    copyfile(mpCodeDir, mpTmp);

    basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
    path(basePath);
    addpath(mpTmp);
    cd(mpTmp);
    if ~isfolder('results')
        mkdir('results');
    end
    if ~isfolder('Output')
        mkdir('Output');
    end

    S = load(artifact, 'x');
    x = S.x; %#ok<NASGU>
    define_parameters; define_states; define_lindex;
    param = x2param(x);
    param_fix{7} = param{12};
    [thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Qbx, epsilon_cutoffs_matrix, ...
        phi, uncond_surplus_match, profit_matrix, Ms1, Ms2, QS1, QS2, ...
        match_death_reg_coef, avg_flow_profit, median_flow_profit] = ...
        solve_model_no_gamma(x, param_indx, param_state, param_fix); %#ok<ASGLU>
    data_moments_baseline;
    sim_moments_baseline;
    set(0, 'DefaultFigureVisible', 'off');
    plot_fit;
    fig = figure(1);
    forceLightFigure(fig);
    formatFigure13Axes(fig);
    saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_13_match_shock_model_fit.png'));
    close all;
catch err
    set(0, 'DefaultFigureVisible', oldVisibility);
    path(incomingPath);
    cd(here);
    if ~isempty(tmpParent)
        cleanupDir(tmpParent);
    end
    close all;
    rethrow(err);
end

set(0, 'DefaultFigureVisible', oldVisibility);
path(incomingPath);
cd(here);
cleanupDir(tmpParent);
end

function runMatlabScript(scriptDir, scriptName)
cmd = sprintf('matlab -batch "cd(''%s''); %s"', escapeQuotes(scriptDir), scriptName);
status = system(cmd);
if status ~= 0
    error('MATLAB generator failed with status %d: %s', status, scriptName);
end
end

function runStataScript(rootDir, doFile)
stataCmd = findStataExecutable();
relDoFile = relativePath(rootDir, doFile);
[~, logBase] = fileparts(relDoFile);
logFile = fullfile(rootDir, [logBase '.log']);
if isfile(logFile)
    delete(logFile);
end
cmd = sprintf('cd "%s" && "%s" -b do "%s"', rootDir, stataCmd, relDoFile);
status = system(cmd);
if status ~= 0
    error('Stata generator failed with status %d: %s', status, doFile);
end
if ~isfile(logFile)
    error('Stata generator did not write the expected batch log: %s', logFile);
end
logText = fileread(logFile);
if ~isempty(regexp(logText, 'r\([0-9]+\);', 'once'))
    error('Stata generator reported an error. See %s', logFile);
end
ensureDir(fullfile(rootDir, 'output', 'logs'));
movefile(logFile, fullfile(rootDir, 'output', 'logs', 'figure_11b_event_study.log'));
end

function stataCmd = findStataExecutable()
candidates = {'stata', 'stata-se', 'stata-mp'};
for i = 1:numel(candidates)
    [status, out] = system(sprintf('command -v %s', candidates{i}));
    if status == 0 && ~isempty(strtrim(out))
        stataCmd = strtrim(out);
        return
    end
end
error('Could not find a Stata executable on PATH. Figure 11b requires Stata with ebalance, ftools, require, and reghdfe installed.');
end

function rel = relativePath(rootDir, fileName)
rootDir = char(java.io.File(rootDir).getCanonicalPath());
fileName = char(java.io.File(fileName).getCanonicalPath());
prefix = [rootDir filesep];
if startsWith(fileName, prefix)
    rel = fileName(numel(prefix)+1:end);
else
    rel = fileName;
end
end

function generate_figure_11b(rootDir, outputDir)
fprintf('Generating Figure 11b from Stata event-study code...\n');
doFile = fullfile(rootDir, 'code', 'Stata_figure11b_event_study', 'event_study.do');
outFile = fullfile(outputDir, 'figures', 'paper', 'figure_11b_event_study_china_vs_other_exporters.png');
if isfile(outFile)
    delete(outFile);
end
runStataScript(rootDir, doFile);
requireFile(outFile);
end

function generate_figure_01(rootDir, outputDir)
fprintf('Generating Figure 1 from public BEA/WTO data...\n');
src = fullfile(rootDir, 'data', 'BEA_and_WTO--trade_and_production_aggregates', ...
    'data_figure_1_updated.xlsx');
requireFile(src);
T = readtable(src, 'Sheet', 'Previous Version', 'ReadVariableNames', false);
year = T{2:end, 1};
consumption = T{2:end, 2};
imports = T{2:end, 3};

fig = figure('Visible', 'off', 'Color', 'w');
plot(year, consumption, 'k-', 'LineWidth', 1.8);
hold on;
plot(year, imports, 'b--', 'LineWidth', 1.8);
grid on;
xlabel('Year');
ylabel('Billions of USD');
legend('Domestic consumption', 'Imports', 'Location', 'northwest');
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.85 0.85 0.85]);
set(fig, 'Position', [100 100 700 430], 'InvertHardcopy', 'off');
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_01_apparel_consumption_imports.pdf'));
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_01_apparel_consumption_imports.eps'), 'epsc');
close(fig);
end

function generate_figure_04(rootDir, outputDir)
fprintf('Generating Figure 4 from public Department of Commerce data...\n');
src = fullfile(rootDir, 'data', 'Dept_of_Commerce--apparel_imports_by_origin', ...
    'imp_apparel_cty.xls');
requireFile(src);
C = readcell(src);
years = cell2mat(C(7, 2:17));
countries = string(C(8:17, 1));
values = cell2mat(C(8:17, 2:17));

fig = figure('Visible', 'off', 'Color', 'w');
plot(years, values', 'LineWidth', 1.3);
grid on;
xlabel('Year');
ylabel('Billions of USD');
legend(countries, 'Location', 'eastoutside', 'Interpreter', 'none');
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.85 0.85 0.85]);
set(fig, 'Position', [100 100 900 520], 'InvertHardcopy', 'off');
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_04_import_value_by_country.eps'), 'epsc');
close(fig);
end

function generate_figure_10(rootDir, outputDir)
fprintf('Generating Figure 10 from baseline life-cycle simulation artifacts...\n');
incomingPath = path;
here = pwd;
cleanupPath = onCleanup(@() path(incomingPath)); %#ok<NASGU>
cleanupCd = onCleanup(@() cd(here)); %#ok<NASGU>

srcDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', 'baseline simulation');
basePath = stripCodeTreeFromPath(incomingPath, fullfile(rootDir, 'code', 'matlab'));
path(basePath);
addpath(srcDir);
cd(srcDir);

S = load(fullfile(rootDir, 'code', 'matlab', 'baseline_no_NsNb_target', 'results', 'se_results_no_M_target.mat'), 'x');
x = S.x;
define_parameters; define_states; define_lindex;
[thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Ms1, Ms2, Qbx, QS1, QS2, ...
    net_prof_b, Cs, Cs1, Cs2, net_prof_s1, net_prof_s2] = ...
    solve_model(x, param_indx, param_state, param_fix); %#ok<ASGLU>
[thetas_old, thetab_old, Ap_old, U1_old, U2_old, V_old, mMb_old, msb_old, ...
    u1_old, u2_old, Ms1_old, Ms2_old, Qbx_old, QS1_old, QS2_old, ...
    net_prof_b_old, Cs_old, Cs1_old, Cs2_old, net_prof_s1_old, net_prof_s2_old] = ...
    solve_model_old(x, param_indx, param_state, param_fix); %#ok<ASGLU>
sim_moments_baseline;
data_moments_baseline;
sim_growth_moments;

data_life = readmatrix('05_avg_number_partners_by_yr_in_market', 'NumHeaderLines', 1);
age = data_life(1:10, 1);
buyer_growth = data_life(age, 2) - data_life(1, 2);
seller_growth = data_life(age, 5) - data_life(1, 5);
model_buyer_growth = agg_mean_gph_b(age) - agg_mean_gph_b(1);
model_seller_growth1 = mean_traj_s(age, 1) - mean_traj_s(1, 1);
model_seller_growth2 = mean_traj_s(age, 2) - mean_traj_s(1, 2);

fig = figure('Visible', 'off', 'Color', 'w');
plot(age, buyer_growth, 'b--', 'LineWidth', 2);
hold on;
plot(age, model_buyer_growth, 'r-', 'LineWidth', 2);
plot(age, seller_growth, 'g--', 'LineWidth', 2);
plot(age, model_seller_growth1, 'm-', 'LineWidth', 2);
plot(age, model_seller_growth2, 'y-', 'LineWidth', 2);
xlabel('number of years in the international market');
ylabel('cumulative increase of business connections');
legend('data: buyer', 'model: buyer', 'data: seller', ...
    'model: seller type1', 'model: seller type2', 'Location', 'northwest');
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.85 0.85 0.85]);
grid on;
set(fig, 'Position', [100 100 700 520]);
forceLightFigure(fig);
saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_10_buyers_suppliers_connection_accumulation.png'));
close(fig);
end

function forceLightFigure(fig)
set(fig, 'Color', 'w', 'InvertHardcopy', 'off');

axHandles = findall(fig, 'Type', 'Axes');
for i = 1:numel(axHandles)
    ax = axHandles(i);
    if strcmp(get(ax, 'Tag'), 'legend')
        continue
    end
    set(ax, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'ZColor', 'k', ...
        'GridColor', [0.85 0.85 0.85], 'MinorGridColor', [0.90 0.90 0.90]);
    if isprop(ax, 'Toolbar') && ~isempty(ax.Toolbar)
        ax.Toolbar.Visible = 'off';
    end
    set(get(ax, 'Title'), 'Color', 'k');
    set(get(ax, 'XLabel'), 'Color', 'k');
    set(get(ax, 'YLabel'), 'Color', 'k');
    set(get(ax, 'ZLabel'), 'Color', 'k');
end

legendHandles = findall(fig, 'Type', 'Legend');
for i = 1:numel(legendHandles)
    set(legendHandles(i), 'Color', 'w', 'TextColor', 'k', 'EdgeColor', 'k');
end

textHandles = findall(fig, 'Type', 'Text');
for i = 1:numel(textHandles)
    set(textHandles(i), 'Color', 'k');
end
end

function formatFigure13Axes(fig)
axHandles = findall(fig, 'Type', 'Axes');
for i = 1:numel(axHandles)
    ax = axHandles(i);
    if strcmp(get(ax, 'Tag'), 'legend')
        continue
    end

    titleText = get(get(ax, 'Title'), 'String');
    if iscell(titleText)
        titleText = strjoin(titleText, ' ');
    end
    titleText = lower(char(titleText));

    if contains(titleText, 'payment per supplier')
        xlim(ax, [0 4]);
        xticks(ax, 0:1:4);
        ylim(ax, [0 3]);
        yticks(ax, 0:1:3);
    else
        xlim(ax, [0 1]);
        ylim(ax, [0 1]);
        xticks(ax, [0 0.5 1]);
        yticks(ax, [0 0.5 1]);
    end
end
end

function formatWhiteAxes(ax, hasRightAxis)
set(ax, 'Color', 'w', 'XColor', 'k', 'GridColor', [0.85 0.85 0.85]);
if hasRightAxis
    yyaxis(ax, 'left');
    ax.YColor = [0 0.4470 0.7410];
    yyaxis(ax, 'right');
    ax.YColor = [0.8500 0.3250 0.0980];
    yyaxis(ax, 'left');
else
    ax.YColor = [0 0.4470 0.7410];
end
titleHandle = get(ax, 'Title');
xlabelHandle = get(ax, 'XLabel');
set(titleHandle, 'Color', 'k');
set(xlabelHandle, 'Color', 'k');
legendHandle = legend(ax);
if ~isempty(legendHandle)
    set(legendHandle, 'Color', 'w', 'TextColor', 'k');
end
end

function writeFitCheckSummary(txt, dst)
labels = {
    'Table 5 baseline fit', 'BASELINE_REPORTED_SAVED_FIT', 'BASELINE_REPORTED_REEVALUATED_FIT', 'BASELINE_REPORTED_DIFF';
    'Table 8 mechanical fit', 'MECHANICAL_SAVED_FVAL', 'MECHANICAL_REEVALUATED_FIT', 'MECHANICAL_DIFF';
    'Table 10 heterogeneous death full objective', 'HETERO_SAVED_FULL_OBJECTIVE', 'HETERO_REEVALUATED_FULL_OBJECTIVE', 'HETERO_FULL_DIFF';
    'Table 10 heterogeneous death baseline-moment objective', 'HETERO_SAVED_OLD_OBJECTIVE', 'HETERO_REEVALUATED_OLD_OBJECTIVE', 'HETERO_OLD_DIFF';
    'Table 12 AAR fit', 'AAR_SAVED_FVAL', 'AAR_REEVALUATED_FVAL', 'AAR_DIFF';
    'Table 9 match-shock fit', 'MP_MATCH_SHOCK_SAVED_OUT', 'MP_MATCH_SHOCK_REEVALUATED_OUT', 'MP_MATCH_SHOCK_DIFF';
    'Table 9 no-dispersion fit', 'MP_NO_DISPERSION_SAVED_OUT', 'MP_NO_DISPERSION_REEVALUATED_OUT', 'MP_NO_DISPERSION_DIFF'
    };

ensureDir(fileparts(dst));
fid = fopen(dst, 'w');
if fid == -1
    error('Could not open %s for writing.', dst);
end
cleanupObj = onCleanup(@() fclose(fid)); %#ok<NASGU>
fprintf(fid, 'paper_item,check_label,saved_value,reevaluated_value,difference\n');
for i = 1:size(labels, 1)
    paperItem = labels{i, 1};
    savedLabel = labels{i, 2};
    reevalLabel = labels{i, 3};
    diffLabel = labels{i, 4};
    saved = firstNumber(txt, [savedLabel '\s+([-+0-9.eE]+)']);
    reeval = firstNumber(txt, [reevalLabel '\s+([-+0-9.eE]+)']);
    diffVal = firstNumber(txt, [diffLabel '\s+([-+0-9.eE]+)']);
    fprintf(fid, '"%s","%s",%.15g,%.15g,%.15g\n', paperItem, diffLabel, saved, reeval, diffVal);
end
end

function value = firstNumber(txt, pattern)
tokens = regexp(txt, pattern, 'tokens', 'once');
if isempty(tokens)
    value = NaN;
else
    value = str2double(tokens{1});
end
end

function cleanupDir(pathName)
if isfolder(pathName)
    rmdir(pathName, 's');
end
end

function copyPattern(srcDir, pattern, dstDir)
if ~isfolder(srcDir)
    return
end
files = dir(fullfile(srcDir, pattern));
if isempty(files)
    return
end
ensureDir(dstDir);
for i = 1:numel(files)
    if ~files(i).isdir
        copyfile(fullfile(files(i).folder, files(i).name), fullfile(dstDir, files(i).name));
    end
end
end

function copyIfExists(src, dst)
if isfile(src)
    ensureDir(fileparts(dst));
    copyfile(src, dst);
end
end

function copyRequired(src, dst)
requireFile(src);
ensureDir(fileparts(dst));
copyfile(src, dst);
end

function requireFile(fileName)
if ~isfile(fileName)
    error('Required replication source file is missing: %s', fileName);
end
end

function ensureDir(pathName)
if ~isfolder(pathName)
    mkdir(pathName);
end
end

function out = escapeQuotes(in)
out = strrep(in, '''', '''''');
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
