## Filepaths Analysis Details

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/plot_fit.m**

- Line 16, unix : z = [0:(1/gran):1];
- Line 19, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 22, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 25, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 28, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 107, unix : save results/figures_est_eta

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/counterfactual_tariff_table.tex**

- Line 7, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/generate_table_figure_source_map.m**

- Line 2, unix : %GENERATE_TABLE_FIGURE_SOURCE_MAP Rebuild the table/figure source-map XLSX.
- Line 6, unix : %   generate_table_figure_source_map('/path/to/table_figure_source_map.xlsx')
- Line 53, unix : 'Item', 'Type', 'Paper title', 'Output file(s) after fast run', 'Replication action', 'Generating code', 'Data/source artifact(s)', 'Notes', '', '', '';
- Line 54, unix : 'Figure 1', 'Figure', 'U.S. apparel consumption/imports', 'output/figures/paper/figure_01_apparel_consumption_imports.pdf; output/figures/paper/figure_01_apparel_consumption_imports.eps', 'GENERATED: run_all_replication reads the public BEA/WTO workbook and recreates the paper figure.', 'code/matlab/run_all_replication.m generate_figure_01()', 'data/BEA_and_WTO--trade_and_production_aggregates/data_figure_1_updated.xlsx', 'Generated from included public aggregate apparel consumption/import data.', '', '', '';
- Line 55, unix : 'Figure 2', 'Figure', 'Number of suppliers, 1996-2011', 'output/figures/paper/figure_02_number_of_suppliers.eps', 'COPIED DISCLOSED ARTIFACT: run_all_replication copies the Census disclosure-approved EPS file from the data folder.', 'code/Stata_LFTTD_code/13_lfttd_aggregates.do ; Census disclosure request output', 'data/Census_LFTTD--disclosed_statistics_and_graphs/CES_disclosed_files/1109_tybout_release_req5623_20170228/NoSeller_1996_2011.eps', 'Disclosure-approved supplier-count figure.', '', '', '';
- Line 56, unix : 'Figure 3', 'Figure', 'Number of suppliers by country', 'output/figures/paper/figure_03_suppliers_by_country.eps', 'COPIED DISCLOSED ARTIFACT: run_all_replication copies the Census disclosure-approved EPS file from the data folder.', 'code/Stata_LFTTD_code/12_lfttd_aggregates_by_country.do; Census disclosure request output', 'data/Census_LFTTD--disclosed_statistics_and_graphs/CES_disclosed_files/1109_tybout_release_req5623_20170228/NoSeller_by_country_1996_2011.eps', 'Disclosure-approved country supplier-count figure.', '', '', '';
- Line 57, unix : 'Figure 4', 'Figure', 'Value of imports by country', 'output/figures/paper/figure_04_import_value_by_country.eps', 'GENERATED: run_all_replication reads the Department of Commerce workbook and recreates the paper figure.', 'code/matlab/run_all_replication.m generate_figure_04()', 'data/Dept_of_Commerce--apparel_imports_by_origin/imp_apparel_cty.xls', 'Generated from included public country import-value data.', '', '', '';
- Line 59, unix : 'Figure 6', 'Figure', 'Number of buyers, related party versus arm''s length trade', 'output/figures/paper/figure_06_buyers_related_arm_length.eps', 'COPIED DISCLOSED ARTIFACT: run_all_replication copies the Census disclosure-approved EPS file from the data folder.', 'code/Stata_LFTTD_code/14_lfttd_aggregates_by_related.do; Census disclosure request output', 'data/Census_LFTTD--disclosed_statistics_and_graphs/CES_disclosed_files/1109_tybout_release_req5623_20170228/NoBuyer_by_related_1996_2011.eps', 'Disclosure-approved buyer-count figure by relationship status.', '', '', '';
- Line 61, unix : 'Figure 8', 'Figure', 'Data-based versus model-based moments', 'output/figures/paper/figure_08_baseline_model_fit.pdf', 'GENERATED: run_all_replication runs the baseline plot_fit.m code at the saved baseline parameter vector and writes the Figure 8 PDF during the fast run.', 'code/matlab/run_all_replication.m generate_figure_08(); code/matlab/baseline_no_NsNb_target/plot_fit.m', 'code/matlab/baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat; data/Census_LFTTD--disclosed_statistics_and_graphs/', 'Generated from source code in fast mode; exact baseline fit is also re-evaluated in output/logs/exact_fit_checks.log.', '', '', '';
- Line 62, unix : 'Figure 9', 'Figure', 'Buyer Profit and Search Cost Heterogeneity', 'output/figures/paper/figure_09_buyer_profit_search_cost_heterogeneity.png', 'GENERATED: run_all_replication solves the steady-state model at the saved parameter vector and writes this figure during the fast run.', 'code/matlab/run_all_replication.m generate_figure_09(); code/matlab/baseline_counterfactuals_July_2024/steady state summary/main.m', 'code/matlab/baseline_no_NsNb_target/results/se_results_no_M_target.mat', 'Regenerated by solving the steady-state model at the saved parameter vector and plotting the two paper panels.', '', '', '';
- Line 63, unix : 'Figure 10', 'Figure', 'Buyers and Suppliers Accumulation of Connections', 'output/figures/paper/figure_10_buyers_suppliers_connection_accumulation.png', 'GENERATED: run_all_replication solves/simulates the baseline life-cycle model at the saved parameter vector and writes this figure during the fast run.', 'code/matlab/run_all_replication.m generate_figure_10(); code/matlab/baseline_counterfactuals_July_2024/baseline simulation/main.m', 'code/matlab/baseline_no_NsNb_target/results/se_results_no_M_target.mat; code/matlab/baseline_counterfactuals_July_2024/baseline simulation/05_avg_number_partners_by_yr_in_market.xls', 'Regenerated by solving the baseline model at the saved parameter vector and plotting buyer/supplier life-cycle growth.', '', '', '';
- Line 64, unix : 'Figure 11', 'Figure', 'Trump Tariff Effects on Supplier Dynamics', 'output/figures/paper/figure_11a_trump_tariff_supplier_dynamics.png; output/figures/paper/figure_11b_event_study_china_vs_other_exporters.png', 'GENERATED: panel (a) is generated by run_all_replication from the saved tariff transition sequence using the plotting logic from trump tariff/main.m; the full transition solve can be rerun separately and compared with audit_tariff_transition.m. Panel (b) is generated by the packaged Stata event-study script.', 'Panel (a): code/matlab/run_all_replication.m generate_figure_11a(); code/matlab/baseline_counterfactuals_July_2024/trump tariff/main.m plotting logic; transition audit: code/matlab/audit_tariff_transition.m. Panel (b): code/Stata_figure11b_event_study/event_study.do.', 'Panel (a): code/matlab/baseline_counterfactuals_July_2024/trump tariff/dynamics_tariff.mat; code/matlab/baseline_no_NsNb_target/results/se_results_no_M_target.mat. Panel (b): data/US_ITC_figure11b_event_study/merged_apparel_2017_2025_importVQT.dta; data/US_ITC_figure11b_event_study/model_prediction.dta.', 'Panel (a) is regenerated in fast mode and can be separately audited by rerunning the full tariff transition. Panel (b) requires Stata with ebalance ftools require and reghdfe installed.', '', '', '';
- Line 65, unix : 'Figure 12', 'Figure', 'Mechanical model estimated search intensities', 'output/figures/paper/figure_12_mechanical_search_intensities.png', 'GENERATED: run_all_replication uses load_best_mechanical_estimate.m and the Figure 12 plotting code ported from build_mechanical_appendix_outputs.m to write the PNG during the fast run.', 'code/matlab/run_all_replication.m generate_mechanical_outputs(); code/matlab/mechanical_model/build_mechanical_appendix_outputs.m; code/matlab/mechanical_model/load_best_mechanical_estimate.m', 'code/matlab/mechanical_model/data/mechanical_best_estimate.csv; code/matlab/mechanical_model/results/', 'Generated from the included mechanical estimate in fast mode.', '', '', '';
- Line 66, unix : 'Figure 13', 'Figure', 'Match Shock Model: Data-based versus model-based moments', 'output/figures/paper/figure_13_match_shock_model_fit.png', 'GENERATED: run_all_replication evaluates the MP match-shock model at the saved RA-supplied parameter vector and runs the MP plot_fit.m source code in a temporary working copy.', 'code/matlab/run_all_replication.m generate_figure_13(); code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/plot_fit.m', 'code/matlab/baseline_counterfactuals_July_2024/MP model/Results2026/Baseline_MP/results/se_results_est_eta.mat', 'Generated from source code in fast mode using the RA-supplied full-precision MP parameter artifact; MP objective values are separately re-evaluated in the fit log.', '', '', '';
- Line 71, unix : 'Table 5', 'Table', 'Cost and Distributional Parameters', 'output/tables/paper/table_05_cost_distributional_parameters.csv; output/tables/paper/generated_standard_errors_at_saved_parameters.csv; output/tables/paper/model_fit_checks_for_tables_05_09_10_11_12.csv; output/logs/exact_fit_checks.log; output/logs/standard_error_generation.log', 'GENERATED: run_all_replication writes a standalone Table 5 CSV from the saved baseline parameter vector; it regenerates standard errors by running baseline std_errors.m in a temporary working copy and separately re-evaluates the baseline objective at that vector.', 'code/matlab/run_all_replication.m write_standalone_model_tables(); code/matlab/generate_standard_errors_at_saved_parameters.m; code/matlab/baseline_no_NsNb_target/std_errors.m; code/matlab/baseline_no_NsNb_target/objective.m; code/matlab/audit_report_values.m', 'code/matlab/baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat', 'Standalone CSV contains paper-reported rounded values and generated full-precision values; regenerated standard errors match the revised manuscript at displayed precision.', '', '', '';
- Line 72, unix : 'Table 6', 'Table', 'Counterfactual: Interpreting market developments', 'output/tables/paper/table_06_market_developments_counterfactual.tex', 'GENERATED: run_all_replication runs transition_dynamics.m, which calls summary_ss.m to write counterfactual_table_2026.tex, then copies that newly generated LaTeX fragment into output/tables/paper/.', 'code/matlab/baseline_counterfactuals_July_2024/transition dynamics/transition_dynamics.m; summary_ss.m', 'code/matlab/baseline_counterfactuals_July_2024/transition dynamics/', 'Generated from source code in fast mode at the included saved baseline parameter vector.', '', '', '';
- Line 73, unix : 'Table 7', 'Table', 'Counterfactual: Trump Section 301 Tariff', 'output/tables/paper/table_07_trump_section_301_tariff.tex', 'GENERATED: run_all_replication runs the Trump tariff main.m source code through the table-writing section, then copies the newly generated counterfactual_tariff_table.tex into output/tables/paper/.', 'code/matlab/baseline_counterfactuals_July_2024/trump tariff/main.m', 'code/matlab/baseline_counterfactuals_July_2024/trump tariff/', 'Generated from source code in fast mode. The expensive tariff transition-dynamics loop is skipped after Table 7 is written in fast mode; it can be rerun and compared with code/matlab/audit_tariff_transition.m.', '', '', '';
- Line 74, unix : 'Table 8', 'Table', 'Effect of 2004 policy shock, baseline model and mechanical model', 'output/tables/paper/table_08_mechanical_policy_shock.tex', 'GENERATED: run_all_replication runs mechanical_counterfactual_main.m, which calls summary_mechanical_policy_shock.m to write counterfactual_table_policy_only.tex, then copies that newly generated table into output/tables/paper/.', 'code/matlab/run_all_replication.m generate_mechanical_outputs(); code/matlab/mechanical_model/mechanical_counterfactual_main.m; code/matlab/mechanical_model/summary_mechanical_policy_shock.m', 'code/matlab/mechanical_model/data/mechanical_best_estimate.csv; baseline counterfactual outputs', 'Generated from source code in fast mode using the included mechanical estimate and generated Table 6 baseline counterfactual table as an input.', '', '', '';
- Line 75, unix : 'Table 9', 'Table', 'Parameter Estimates and Fit for Baseline, Match Shock, and No Dispersion', 'output/tables/paper/table_09_mp_model_parameters_and_fit.csv; output/tables/paper/generated_standard_errors_at_saved_parameters.csv; output/tables/paper/model_fit_checks_for_tables_05_09_10_11_12.csv; output/logs/standard_error_generation.log', 'GENERATED: run_all_replication writes the paper-shaped Table 9 CSV from saved full-precision parameter vectors; it regenerates baseline and MP standard errors by running std_errors.m in temporary working copies and re-evaluates MP objective values at the saved vectors.', 'code/matlab/run_all_replication.m write_standalone_model_tables(); code/matlab/generate_standard_errors_at_saved_parameters.m; code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/std_errors.m; code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/objective.m; code/matlab/audit_report_values.m', 'code/matlab/baseline_counterfactuals_July_2024/MP model/Results2026/; code/matlab/baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat', 'Regenerated Results2026 Match Shock objective', ' match-death moment', ' parameter estimates', ' and standard errors match current docs/EJTX_2026_replication.tex at displayed precision.';
- Line 76, unix : 'Table 10', 'Table', 'Comparison of Heterogeneous Death Hazard Model with Baseline', 'output/tables/paper/table_10_heterogeneous_death_hazard_comparison.csv; output/tables/paper/generated_standard_errors_at_saved_parameters.csv; output/tables/paper/model_fit_checks_for_tables_05_09_10_11_12.csv; output/logs/exact_fit_checks.log; output/logs/standard_error_generation.log', 'GENERATED: run_all_replication writes a standalone Table 10 CSV from the baseline and heterogeneous match-death saved parameter vectors; it regenerates standard errors by running std_errors.m in temporary working copies and re-evaluates the heterogeneous objectives.', 'code/matlab/run_all_replication.m write_standalone_model_tables(); code/matlab/generate_standard_errors_at_saved_parameters.m; code/matlab/heterogeneous_death_haz/sellers_only/std_errors.m; code/matlab/heterogeneous_death_haz/sellers_only/objective.m; code/matlab/audit_report_values.m', 'code/matlab/baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat; code/matlab/heterogeneous_death_haz/sellers_only/results/se_results_hetero.mat', 'Standalone CSV contains paper-reported rounded values and generated full-precision values; regenerated objectives and standard errors match the revised manuscript at displayed precision.', '', '', '';
- Line 77, unix : 'Table 11', 'Table', 'Model vs Data-based Moments', 'output/tables/paper/table_11_model_vs_data_based_moments.csv; output/tables/paper/model_fit_checks_for_tables_05_09_10_11_12.csv; output/logs/exact_fit_checks.log', 'GENERATED: run_all_replication writes a standalone Table 11 CSV from the heterogeneous match-death saved/generated moment artifact; exact-fit checks re-evaluate the same model quantities.', 'code/matlab/run_all_replication.m write_standalone_model_tables(); code/matlab/heterogeneous_death_haz/sellers_only/sim_moments_hetero.m; code/matlab/audit_report_values.m', 'code/matlab/heterogeneous_death_haz/sellers_only/results/se_results_hetero.mat; code/matlab/heterogeneous_death_haz/sellers_only/disclosed_moments/', 'Standalone CSV contains the data and model-based match-death moments reported in Table 11.', '', '', '';
- Line 78, unix : 'Table 12', 'Table', 'MSM results (EJTX moments vs. our AAR model)', 'output/tables/paper/table_12_aar_parameter_estimates.csv; table_12_aar_moment_comparison.csv; model_fit_checks_for_tables_05_09_10_11_12.csv', 'GENERATED CHECK SUMMARY + GENERATED CSV ARTIFACTS: run_all_replication runs generate_comparison_outputs.m to write AAR comparison CSVs and re-evaluates the AAR fit in the exact-fit routine.', 'code/matlab/AAR/comparison/scripts/generate_comparison_outputs.m; code/matlab/AAR/estimation/run_estimation.m', 'code/matlab/AAR/estimation/output/estimation_results.mat; code/matlab/AAR/comparison/tables/', 'Generated AAR table artifacts plus exact-fit verification in the log/CSV.', '', '', '';
- Line 79, unix : 'Table 13', 'Table', 'Section 6.1 experiment: EJTX vs. our AAR model (% changes)', 'output/tables/paper/table_13_aar_policy_shock_benchmark_comparison.csv; table_13_aar_policy_shock_comparison.csv', 'GENERATED: run_all_replication runs generate_comparison_outputs.m, which calls the AAR policy-shock source code and writes the Table 13 CSV artifacts before copying them into output/tables/paper/.', 'code/matlab/AAR/comparison/scripts/generate_comparison_outputs.m; code/matlab/AAR/counterfactuals/policy_shock/run_policy_shock_counterfactual.m', 'code/matlab/AAR/counterfactuals/policy_shock/; code/matlab/AAR/comparison/tables/', 'Generated from source code in fast mode using included AAR estimation and baseline-moment artifacts.', '', '', ''
- Line 106, unix : % LibreOffice can make tiny platform-dependent width/height changes.

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/load_best_mechanical_estimate.m**

- Line 5, unix : % 2) Fallback snapshot in `data/mechanical_best_estimate.mat`.
- Line 30, windows : c = regexp(opt_files(i).name,'(Optimization_[0-9_]+)_Run\d+of\d+\.mat$','tokens','once');
- Line 80, unix : 'or fallback file data/mechanical_best_estimate.mat']);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_dynamics.m**

- Line 67, unix : Ms1 = mass1/sum(mass1);
- Line 155, unix : %now aggregate up to V/U
- Line 161, unix : thetab=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table.tex**

- Line 7, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/A7_lfttd_imp_apparel_statistics.do**

- Line 28, unix : gen SellerShr = value_imp/TotImports

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/13_lfttd_aggregates.do**

- Line 67, unix : gen import_value = value_imp/10^9
- Line 79, unix : gen import_value = value_imp/10^9
- Line 130, unix : replace NoBuyer_r = NoBuyer_r/1000
- Line 182, unix : replace NoSeller_r = NoSeller_r/1000

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/plot_fit.m**

- Line 20, unix : z = [0:(1/gran):1];
- Line 23, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 26, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 29, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 32, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 111, unix : save results/figures_no_M_target

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/objective_mechanical.m**

- Line 46, windows : %    fprintf(' buyer search cost exponent   = %.5f\n',coefvec(2));
- Line 47, windows : %    fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 48, windows : %    fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 49, windows : %    fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 50, windows : %    fprintf(' seller network parameter     = %.5f\n',coefvec(6));
- Line 51, windows : %    fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 52, windows : %    fprintf(' intercept parameter, compat. = %.5f\n',coefvec(8));
- Line 53, windows : %    fprintf(' slope parameter, compat.     = %.5f\n',coefvec(9));
- Line 54, windows : %    fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 55, windows : %    fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 61, windows : fprintf(' Buyer search params        = %.5f\n',si.buyer);
- Line 63, windows : fprintf(' Seller search params        = %.5f\n',si.seller);
- Line 65, windows : fprintf(' Share of high type sellers        = %.5f\n',x(4));
- Line 67, windows : fprintf(' Relative number of sellers        = %.5f\n',x(7));
- Line 69, windows : fprintf(' OBJECTIVE FUNCTION = %.5f\n',out);
- Line 71, windows : fprintf(' Welfare (no prices) = %.5f\n',welfare);
- Line 74, unix : fileID1 = fopen('results/fitlog_mechanical.txt','a');
- Line 81, windows : fprintf('objective_mechanical error: %s\n', ME.message);
- Line 85, unix : %save('results/se_results_mechanical')

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/14_lfttd_aggregates_by_related.do**

- Line 20, unix : gen import_value = value_imp/10^9
- Line 70, unix : replace NoBuyer_r = NoBuyer_r/1000
- Line 127, unix : replace NoSeller_r = NoSeller_r/1000

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/report_match_shock_stats.m**

- Line 37, unix : %top_half_count = floor(Nx/2);
- Line 42, windows : fprintf('\n--- Match-shock segmentation (Appendix E, eq. A-34) ---\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/output/tables/paper/table_08_mechanical_policy_shock.tex**

- Line 4, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/define_parameters.m**

- Line 17, unix : % profit split under equal bargaining weights/constant share approximation

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/objective.m**

- Line 26, windows : fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 27, windows : fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 28, windows : fprintf(' seller network parameter     = %.5f\n',coefvec(6));
- Line 29, windows : fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 30, windows : fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
- Line 31, windows : fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
- Line 32, windows : fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 33, windows : fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
- Line 37, windows : fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 38, windows : fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 39, windows : fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
- Line 44, unix : fileID1 = fopen('Output/ga_running_output.txt','a');
- Line 47, unix : %      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
- Line 50, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
- Line 51, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/summary_mechanical_policy_shock.m**

- Line 3, unix : % Expects steady-state objects (1996/2004/2011) to already exist in memory.
- Line 39, unix : [nseller1T/nseller10-1]
- Line 42, unix : [nseller2T/nseller20-1]
- Line 45, unix : [nbuyerT/nbuyer0-1]
- Line 51, unix : [spbT/spb0-1]
- Line 55, unix : [s2pbT/s2pb0-1]
- Line 63, unix : [nseller11/nseller10-1]
- Line 66, unix : [nseller21/nseller20-1]
- Line 69, unix : [nbuyer1/nbuyer0-1]
- Line 75, unix : [spb1/spb0-1]
- Line 79, unix : [s2pb1/s2pb0-1]
- Line 95, unix : baselineFile = '../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex';
- Line 97, unix : baselineFile = '../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table.tex';
- Line 206, unix : %  nseller1T/nseller11, etc.
- Line 227, windows : fprintf(fileID, ' & Baseline \\%% Change & Mechanical \\%% Change \\\\\n\\hline\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/summary_ss.m**

- Line 29, unix : [1/x0(end) tseller10+tseller20+tbuyer0]
- Line 55, unix : [nseller1T/nseller10-1]
- Line 58, unix : [nseller2T/nseller20-1]
- Line 61, unix : [nbuyerT/nbuyer0-1]
- Line 66, unix : [tseller1T/tseller10-1]
- Line 69, unix : [tseller2T/tseller20-1]
- Line 72, unix : [tbuyerT/tbuyer0-1]
- Line 74, unix : [1/xT(end) tsellerT+tbuyerT]
- Line 91, unix : [spbT/spb0-1]
- Line 94, unix : [s2pbT/s2pb0-1]
- Line 106, unix : [nseller11/nseller10-1]
- Line 109, unix : [nseller21/nseller20-1]
- Line 112, unix : [nbuyer1/nbuyer0-1]
- Line 117, unix : [tseller11/tseller10-1]
- Line 120, unix : [tseller21/tseller20-1]
- Line 123, unix : [tbuyer1/tbuyer0-1]
- Line 125, unix : [1/x1(end) tseller11+tseller21+tbuyer1]
- Line 142, unix : [spb1/spb0-1]
- Line 145, unix : [s2pb1/s2pb0-1]
- Line 177, unix : nseller11/nseller10-1, nseller21/nseller20-1, nbuyer1/nbuyer0-1, ...
- Line 178, unix : tseller11/tseller10-1, tseller21/tseller20-1, tbuyer1/tbuyer0-1, ...
- Line 179, unix : type_css1(1)/type_css0(1)-1, type_css1(2)/type_css0(2)-1, type_cbs1/type_cbs0-1, ...
- Line 183, unix : nseller1T/nseller10-1, nseller2T/nseller20-1, nbuyerT/nbuyer0-1, ...
- Line 184, unix : tseller1T/tseller10-1, tseller2T/tseller20-1, tbuyerT/tbuyer0-1, ...
- Line 185, unix : type_cssT(1)/type_css0(1)-1, type_cssT(2)/type_css0(2)-1, type_cbsT/type_cbs0-1, ...
- Line 197, windows : fprintf(fileID, '\\hline\\hline\n');
- Line 200, windows : fprintf(fileID, '\\hline\n');
- Line 202, windows : fprintf(fileID, '\\hline\n');
- Line 211, windows : fprintf(fileID, '\\hline\n');
- Line 215, windows : fprintf(fileID, '\\medskip\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/objective.m**

- Line 29, windows : fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 30, windows : fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 31, windows : fprintf(' seller network parameter     = %.5f\n',coefvec(6));
- Line 32, windows : fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 33, windows : fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
- Line 34, windows : fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
- Line 35, windows : fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 36, windows : fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
- Line 37, windows : fprintf(' death hazard low type seller = %.5f\n',coefvec(13));
- Line 38, windows : fprintf(' death hazard high type seller    = %.5f\n',delta2);
- Line 40, windows : fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 43, windows : fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 44, windows : fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
- Line 47, windows : fprintf(' model avg match death hazard (0.774)  = %.5f\n',avg_match_death_haz);
- Line 48, windows : fprintf(' model reg: hazard on buyers (-0.0119)= %.5f\n',match_death_reg_coef);
- Line 56, unix : fileID1 = fopen('Output/fitlog_heterogeneous_death.txt','a');
- Line 58, unix : %     dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
- Line 61, unix : fileID2 = fopen('Output/ga_running_output.txt','a');
- Line 64, windows : fprintf(fileID2, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
- Line 65, windows : fprintf(fileID2, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/estimation/run_estimation.m**

- Line 47, windows : fprintf('  f_bar         = %8.4f\n', results.theta.f_bar);
- Line 48, windows : fprintf('  delta_f       = %8.4f\n', results.theta.delta_f);
- Line 49, windows : fprintf('  xi_H          = %8.4f\n', results.theta.xi_H);
- Line 50, windows : fprintf('  rho_xi        = %8.4f\n', results.theta.rho_xi);
- Line 53, windows : fprintf('  sigma     = %8.4f\n', results.cfg.sigma);
- Line 54, windows : fprintf('  shock_mu  = %8.4f\n', results.cfg.shock_mu);
- Line 55, windows : fprintf('  shock_sigma (fixed) = %8.4f\n', results.cfg.shock_sigma);
- Line 56, windows : fprintf('  omega_H (cal.)     = %8.4f\n', results.theta.omega_H);
- Line 57, mixed : fprintf('  z_H/z_L (cal.)     = %8.4f\n', results.theta.z_ratio);
- Line 62, windows : fprintf('  %-18s data = %8.4f   model = %8.4f\n', labels{k}, ...
- Line 68, mixed : fprintf('\nEntry/continuation cost diagnostics\n');
- Line 69, mixed : fprintf('  f1/f0 = %8.4f\n', cs.f1_over_f0);
- Line 72, windows : fprintf('  Entry cost / entry revenue = %8.4f\n', cs.entry_cost_share_entry_revenue);
- Line 73, windows : fprintf('  Continue cost / continuer revenue = %8.4f\n', cs.continue_cost_share_continue_revenue);
- Line 76, windows : fprintf('  Total fixed cost / import expenditure = %8.4f\n', ...
- Line 78, windows : fprintf('  Total fixed cost / supplier gross profits = %8.4f\n', ...
- Line 85, windows : fprintf('  EJTX: search cost / expenditure = %8.4f\n', ejtx_cost_share_expenditure);
- Line 86, windows : fprintf('  AAR : fixed cost / expenditure  = %8.4f\n', cs.total_fixed_cost_share_expenditure);
- Line 87, windows : fprintf('  EJTX: search cost / supplier profit = %8.4f\n', ejtx_cost_share_supplier_profit);
- Line 88, windows : fprintf('  AAR : fixed cost / supplier gross profit = %8.4f\n', ...
- Line 101, mixed : fprintf('  age %2d: N_H/N_L = %8.4f\n', age_val, ratio_val);
- Line 103, unix : fprintf('  age %2d: N_H/N_L = +Inf (no low types)\n', age_val);
- Line 105, mixed : fprintf('  age %2d: N_H/N_L undefined\n', age_val);
- Line 113, mixed : fprintf('  Overall (data): N_H/N_L = %8.4f\n', overall_data);
- Line 115, unix : fprintf('  Overall (data): N_H/N_L = +Inf (no low types)\n');
- Line 117, mixed : fprintf('  Overall (data): N_H/N_L undefined\n');
- Line 138, mixed : fprintf('  age %2d: N_H/N_L = %8.4f\n', age_val, ratio_val);
- Line 140, unix : fprintf('  age %2d: N_H/N_L = +Inf (no low types)\n', age_val);
- Line 142, mixed : fprintf('  age %2d: N_H/N_L undefined\n', age_val);
- Line 146, mixed : fprintf('  Overall (model): N_H/N_L = %8.4f\n', results.solution.N_ratio);
- Line 154, mixed : fprintf('  Active exporter states (H/L) = %8.4f\n', ratio_active);
- Line 156, unix : fprintf('  Active exporter states (H/L) = +Inf (no low types)\n');
- Line 158, mixed : fprintf('  Active exporter states (H/L) undefined\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/plot_fit.m**

- Line 16, unix : z = [0:(1/gran):1];
- Line 19, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 22, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 25, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 28, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 107, unix : %save results/figures_est_eta

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_ss.m**

- Line 228, unix : %now aggregate up to V/U
- Line 235, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/output/tables/paper/table_06_market_developments_counterfactual.tex**

- Line 7, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_tariff_dynamics.m**

- Line 161, unix : %now aggregate up to V/U
- Line 167, unix : thetab=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/comparison/scripts/generate_comparison_outputs.m**

- Line 49, windows : fprintf('Comparison outputs written to %s\n', fullfile(project_root, 'comparison'));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/define_parameters.m**

- Line 50, unix : c1 = 1/seller_type(1); %the worse type  JT: 25th percentile, xi distr.
- Line 51, unix : c2 = 1/seller_type(2); %the better type JT: 25th percentile, xi distr.

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/counterfactuals/policy_shock/run_policy_shock_counterfactual.m**

- Line 12, unix : %   in Appendix AAR of docs/reply_r3_R2.tex.
- Line 28, unix : % Section 7.1 calibration in legacy/ejtx_2025.tex (policy shock only).
- Line 69, windows : fprintf('  M^S pre  = %6.3f, omega_H pre  = %6.3f\n', Ms_pre, omega_pre);
- Line 70, windows : fprintf('  M^S post = %6.3f, omega_H post = %6.3f\n', Ms_post, omega_post);
- Line 71, windows : fprintf('  Low-type potential mass multiplier  = %6.3f\n', low_factor);
- Line 72, windows : fprintf('  High-type potential mass multiplier = %6.3f\n', high_factor);
- Line 111, unix : 'consumer welfare level (1/P)'
- Line 126, unix : %   ../baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex
- Line 199, unix : idx_welfare = strcmp(metric_names, 'consumer welfare level (1/P)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/estimation/solve_model.m**

- Line 3, unix : %   θ = (f_bar, Δ_f, ξ_H, ρ_ξ, Z_H/Z_L) determines the fixed
- Line 113, unix : % Conditional distribution of productivity types across history/ξ states

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/objective.m**

- Line 26, windows : fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 27, windows : fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 28, windows : fprintf(' seller network parameter     = %.5f\n',coefvec(6));
- Line 29, windows : fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 30, windows : fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
- Line 31, windows : fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
- Line 32, windows : fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 33, windows : fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
- Line 37, windows : fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 38, windows : fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 39, windows : fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
- Line 44, unix : fileID1 = fopen('Output/ga_running_output.txt','a');
- Line 47, unix : %      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
- Line 50, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
- Line 51, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/objective.m**

- Line 31, windows : fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 32, windows : fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 33, windows : fprintf(' seller network parameter     = %.5f\n',coefvec(6));
- Line 34, windows : fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 35, windows : fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
- Line 36, windows : fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
- Line 37, windows : fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 38, windows : fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
- Line 42, windows : fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 43, windows : fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 44, windows : fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
- Line 52, unix : fileID1 = fopen('Output/ga_running_output.txt','a');
- Line 55, unix : %      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
- Line 58, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
- Line 59, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/tables_mechanical.m**

- Line 28, windows : fprintf('\r\n')
- Line 31, windows : fprintf(' buyer search cost exponent   = %.4f\n',coefvec(2));
- Line 32, windows : fprintf(' seller search cost scalar    = %.4f\n',coefvec(3));
- Line 33, windows : fprintf(' seller search cost exponent  = %.4f\n',coefvec(4));
- Line 34, windows : fprintf(' buyer network parameter      = %.4f\n',coefvec(5));
- Line 35, windows : fprintf(' seller network parameter     = %.4f\n',coefvec(6));
- Line 36, windows : fprintf(' share of high-type sellers   = %.4f\n',coefvec(7));
- Line 37, windows : fprintf(' intercept parameter, compat. = %.4f\n',coefvec(8));
- Line 38, windows : fprintf(' slope parameter, compat.     = %.4f\n',coefvec(9));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/01_lfttd_imp_apparel_1996_2011.do**

- Line 19, unix : forvalues y = 1996/2000{
- Line 45, unix : gen hs2 = int(hs10/100000000)
- Line 51, unix : forvalues y = 2001/2005{
- Line 76, unix : gen hs2 = int(hs10/100000000)
- Line 83, unix : forvalues y = 2006/2011{
- Line 109, unix : gen hs2 = int(hs10/100000000)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/build_mechanical_appendix_outputs.m**

- Line 10, unix : %% 1) Pick best estimate from latest/most complete optimization campaign
- Line 23, windows : fprintf(fid,'source_type=%s\n',meta.source_type);
- Line 24, windows : fprintf(fid,'source_file=%s\n',meta.source_file);
- Line 26, windows : fprintf(fid,'fval_ga=NaN\n');
- Line 28, windows : fprintf(fid,'fval_ga=%.10f\n',best_fval);
- Line 30, windows : fprintf(fid,'omega=%.10f\n',best_si(33));
- Line 31, windows : fprintf(fid,'Ns=%.10f\n',best_si(34));
- Line 78, windows : fprintf('Counterfactual table written to %s\n', ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/objective.m**

- Line 39, windows : fprintf(' Buyer search cost scalar     = %.5f\n', coefvec(1));
- Line 40, windows : fprintf(' Seller search cost scalar    = %.5f\n', coefvec(3));
- Line 41, windows : fprintf(' Buyer network parameter      = %.5f\n', coefvec(5));
- Line 42, windows : fprintf(' Seller network parameter     = %.5f\n', coefvec(6));
- Line 43, windows : fprintf(' Share of high-type sellers   = %.5f\n', coefvec(7));
- Line 44, windows : fprintf(' High-type seller cost adv.   = %.5f\n', coefvec(8));
- Line 45, windows : fprintf(' Buyer type dispersion        = %.5f\n', coefvec(9));
- Line 46, windows : fprintf(' Seller-to-buyer ratio        = %.5f\n', coefvec(11));
- Line 47, windows : fprintf(' Cross-store elasticity       = %.5f\n', coefvec(12));
- Line 50, windows : fprintf(' Buyer search cost exponent   = %.5f\n', coefvec(2));
- Line 51, windows : fprintf(' Seller search cost exponent  = %.5f\n', coefvec(4));
- Line 52, windows : fprintf(' Seller bargaining parameter  = %.5f\n', coefvec(10));
- Line 53, windows : fprintf(' Cross-product elasticity     = %.5f\n', param_fix{7});
- Line 60, unix : fileID1 = fopen('Output/ga_running_output.txt', 'a');
- Line 69, windows : fprintf(fileID1, '\r\n\n');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/main_no_gamma.m**

- Line 2, unix : %This code solves the model once and experiment w/the calculation of model moments
- Line 19, unix : % subdirectory = '../../../baseline_no_NsNb_target/results/';
- Line 25, unix : % %true parameters, search cost/network buyer/network seller/
- Line 26, unix : % %frac. high type/high type seller/type buyer/mass of sellers/elas. of sub.
- Line 31, unix : % %x0(end-2:end) = 0; %shut down match shocks/fixed costs
- Line 124, unix : num2str(time_elapsed1/60) ...
- Line 151, windows : fprintf('Patternsearch completed. Objective = %.5f\n',fval_local);
- Line 158, windows : fprintf('Warning with parameters: %s\n', mat2str(best_ga_x'));
- Line 161, unix : % Generate final figures/standard errors once for paper outputs

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/run_all_replication.m**

- Line 10, unix : % disclosed data and included intermediate model artifacts to rebuild/copy the
- Line 36, windows : fprintf('EJTX JPE replication package\n');
- Line 37, windows : fprintf('Mode: %s\n', mode);
- Line 38, windows : fprintf('Root: %s\n', rootDir);
- Line 39, windows : fprintf('Started: %s\n\n', datestr(now));
- Line 53, windows : fprintf('\nFinished: %s\n', datestr(now));
- Line 54, windows : fprintf('Outputs are in %s\n', outputDir);
- Line 183, unix : fprintf('Generating AAR appendix/comparison outputs...\n');
- Line 191, windows : fprintf('AAR comparison rebuild failed: %s\n', err.message);
- Line 214, unix : fprintf('Writing standalone model parameter/moment tables...\n');
- Line 335, unix : fprintf('Running exact-fit checks at reported/saved parameter vectors...\n');
- Line 347, windows : fprintf('Exact-fit check log written to %s\n', logFile);
- Line 349, windows : fprintf('Exact-fit checks failed: %s\n', err.message);
- Line 384, unix : 'MP match-shock GA/patternsearch', fullfile(codeRoot, 'baseline_counterfactuals_July_2024', ...
- Line 397, windows : fprintf(fid, '%s\nPASS: %s\n\n', txt, stepName);
- Line 398, windows : fprintf('  PASS: %s\n', stepName);
- Line 400, windows : fprintf(fid, 'FAIL: %s\n%s\n\n', stepName, getReport(err, 'extended', 'hyperlinks', 'off'));
- Line 401, windows : fprintf('  FAIL: %s -- %s\n', stepName, err.message);
- Line 406, windows : fprintf('Full-estimation test-run log written to %s\n', logFile);
- Line 436, windows : "fprintf('Baseline start-vector objective %.15g\n', D0);"
- Line 448, windows : "fprintf('Heterogeneous match-death start-vector objective %.15g\n', D0);"
- Line 468, windows : "fprintf('Mechanical-model start-vector objective %.15g\n', D0);"
- Line 484, windows : "fprintf('AAR start-vector MSM objective %.15g\n', D0);"
- Line 494, windows : "fprintf('MP match-shock start-vector objective %.15g\n', D0);"
- Line 609, windows : fprintf('Using mechanical estimate from %s (%s), fval=%.6f\n', ...
- Line 830, unix : fprintf('Generating Figure 1 from public BEA/WTO data...\n');
- Line 1027, windows : fprintf(fid, 'paper_item,check_label,saved_value,reevaluated_value,difference\n');
- Line 1036, windows : fprintf(fid, '"%s","%s",%.15g,%.15g,%.15g\n', paperItem, diffLabel, saved, reeval, diffVal);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/start_estimation_ga.m**

- Line 97, unix : num2str(time_elapsed1/60) ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/start_mechanical.m**

- Line 14, unix : fileID1 = fopen('results/fitlog_mechanical.txt','a');
- Line 19, unix : filepath = fullfile('../baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat');
- Line 135, unix : num2str(time_elapsed1/60) ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/main.m**

- Line 11, unix : % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';
- Line 13, unix : subdirectory = '/baseline_no_NsNb_target/results';
- Line 60, unix : %% plot the number of sellers/rent share
- Line 62, windows : folder = 'D:\Dropbox\Apps\Overleaf\EJTX\figures\'; % Change to your desired folder
- Line 92, unix : type_share = type_P/Ap;
- Line 106, unix : % plot the number of sellers/rent share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/transition_dynamics.m**

- Line 54, unix : [1/xT(end) tsellerT+tbuyerT]
- Line 61, unix : % we now pick Ns1 and w2_x1 jointly to target [#of sellers, sales/seller]
- Line 68, unix : %w2_x1 = thigh1/Ns1;
- Line 84, unix : [1/gam tseller1+tbuyer1]
- Line 87, unix : [nsellerT/nseller1-1 ((1-1/xT(end)+tsellerT)/nsellerT)/((1-1/x1(end)+tseller1)/nseller1)-1]
- Line 89, unix : [123/95-1,(82/123)/(80/95)-1]
- Line 106, unix : [1/gam tseller0+tbuyer0]
- Line 109, unix : [nseller1/nseller0-1]
- Line 111, unix : [95/80-1]
- Line 249, unix : % plot((Ap_new/Ap0).^(gam-1),'LineWidth',1.5)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/solve_model_old.m**

- Line 241, unix : %now aggregate up to V/U
- Line 248, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_model.m**

- Line 229, unix : %now aggregate up to V/U
- Line 242, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/output/tables/paper/table_07_trump_section_301_tariff.tex**

- Line 7, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/solve_model_mechanical.m**

- Line 74, unix : %now aggregate up to V/U
- Line 82, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/estimation/data_moments_baseline.m**

- Line 4, unix : %   `baseline_moments/generate_baseline_moments.m`. The output is consumed by

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/run_exporter_model.m**

- Line 47, windows : fprintf('N_L: %.4f, N_H: %.4f\n', N_L, N_H);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/main.m**

- Line 11, unix : % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';
- Line 13, unix : subdirectory = '/baseline_no_NsNb_target/results';
- Line 108, windows : folder = 'D:\Dropbox\Apps\Overleaf\EJTX\figures\'; % Change to your desired folder

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/plot_fit.m**

- Line 16, unix : z = [0:(1/gran):1];
- Line 19, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 22, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 25, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 28, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 107, unix : save results/figures_est_eta

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/generate_standard_errors_at_saved_parameters.m**

- Line 5, unix : % packaged result artifacts. It loads saved/reported parameter vectors, runs
- Line 18, windows : fprintf(fid, 'Standard-error generation at saved parameter vectors\nRoot: %s\n\n', rootDir);
- Line 41, windows : fprintf('Standard-error generation log written to %s\n', logFile);
- Line 60, windows : fprintf(fid, '%s\n', txt);
- Line 62, windows : fprintf(fid, '%s\n', objectiveText);
- Line 91, windows : fprintf(fid, '%s\n', txt);
- Line 97, windows : fprintf(fid, '%s\n', objectiveText);
- Line 131, windows : fprintf(fid, '%s\n', txt);
- Line 132, windows : fprintf(fid, '%s\n', objectiveText);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/02_lfttd_imp_apparel_alpha_id_exp.do**

- Line 15, unix : forvalues y = 1996/2011{
- Line 34, unix : forvalues y = 1997/2011{

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/objective.m**

- Line 56, windows : fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
- Line 57, windows : fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
- Line 58, windows : fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
- Line 59, windows : fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
- Line 60, windows : fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
- Line 61, windows : fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
- Line 62, windows : fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
- Line 63, windows : fprintf(' arrival rate of match shocks = %.5f\n',4);
- Line 64, windows : fprintf(' Match shock scale            = %.5f\n',coefvec(14));
- Line 65, windows : fprintf(' Fixed cost (frac of tot surp)= %.5f\n',coefvec(15)/median_flow_profit);
- Line 69, windows : fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
- Line 70, windows : fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
- Line 71, windows : fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
- Line 75, windows : fprintf(' Market tightness (Theta B)   = %.5f\n',thetab);
- Line 76, windows : fprintf(' active sellers per buyer     = %.5f\n',model_NS_NB);
- Line 77, windows : fprintf(' seller search high           = %.5f\n',u2(1));
- Line 78, windows : fprintf(' seller search low            = %.5f\n',u1(1));
- Line 79, windows : fprintf(' buyer average search         = %.5f\n',mean(msb(1,:)));
- Line 80, windows : fprintf(' match death reg coef         = %.5f\n',match_death_reg_coef);
- Line 88, unix : fileID1 = fopen('Output/ga_running_output.txt','a');
- Line 91, unix : %      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
- Line 94, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
- Line 95, windows : fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex**

- Line 7, windows : \hline\hline

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/plot_fit.m**

- Line 18, unix : z = [0:(1/gran):1];
- Line 21, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 24, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 27, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 30, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 128, unix : save results/plotfit_SellerHetHaz

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/regressDeathOnNumPartnersWithTypes.m**

- Line 73, unix : R2 = 1 - SSR/SST;
- Line 88, unix : R2 = 1 - SSR/SST;
- Line 105, windows : fprintf('\n--- %s on p_loss_match_combined(s) vs s ---\n', wstr);
- Line 108, windows : fprintf('R^2 = %.4f\n\n', R2);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_growth_moments.m**

- Line 1, unix : %% Simulate firm life cycle in export/import

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 228, unix : NS_NB = N_S/N_B;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/solve_model_no_gamma.m**

- Line 179, windows : %fprintf('Iter: %d, thetas: %f, thetab: %f\n', iter, thetas, thetab);
- Line 274, unix : %now aggregate up to V/U
- Line 358, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/solve_model.m**

- Line 240, unix : %now aggregate up to V/U
- Line 247, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 237, unix : NS_NB = act_NS/act_NB;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/sim_moments_hetero.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 228, unix : NS_NB = N_S/N_B;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/docs/EJTX_2026_replication.tex**

- Line 31, windows : \let\counterwithout\relax
- Line 32, windows : \let\counterwithin\relax
- Line 161, unix : \includegraphics[width=\textwidth]{figures/figure_1.eps}
- Line 162, unix : \captionof{figure}{U.S. apparel consumption/imports$^a$}
- Line 166, unix : \includegraphics[width = \textwidth]{figures/figure_2.eps}
- Line 174, unix : \includegraphics[width = \textwidth]{figures/figure_3.eps}
- Line 179, unix : \includegraphics[width = \textwidth]{figures/figure_4.eps}
- Line 209, unix : \includegraphics[scale=0.4]{figures/apparel_flows_v2.pdf}
- Line 242, unix : \includegraphics[scale=0.65]{figures/figure_6.eps}
- Line 269, unix : importers, 69 percent identified as importer/wholesalers, and 27 percent
- Line 270, unix : identified as manufacturer/suppliers. (Percentages do not sum to 100 because
- Line 515, unix : We model the interactions between three types of agents in continuous time: suppliers (exporting manufacturers), buyers (importers/retailers), and consumers.\footnote{In the previous section, we documented that there are several types of importers in the apparel sector.  We abstract from importer type in order to simplify our model, but allow for heterogeneity in retailer amenities.\medskip} Figure \ref{fig:model_diagram} provides a schematic overview. In the retail market, a representative final consumer sources her flow purchases from an evolving set of heterogeneous buyers, each of which offers its own evolving collection of goods. The consumer values each buyer for the menu of products it currently sells and for the amenities it offers---e.g., a convenient location, pleasant ambience, or attentive service. In the wholesale market, heterogeneous suppliers export their products to discrete subsets of heterogeneous buyers, providing each with a variety that is custom-tailored to the buyer's specifications.
- Line 519, unix : \includegraphics[scale=0.36]{figures/industry_structure_v2.pdf}
- Line 554, windows : \right] ^{1/(1-\alpha)},$
- Line 772, unix : Note that at any point in time, some agents on each side of the wholesale market will not have any active matches. So \textit{active} suppliers per \textit{active} buyer, $ \sum_{j}\left( M_{j}^{S}-M_{j}^{S}(\mathbf{0})\right)  / \sum_{i} \left( M^B_i -M_{i}^{B}(\mathbf{0}) \right) $, is an endogenous object, and it typically differs from the exogenous ratio of $potential$ suppliers to $potential$ buyers $M^S/M^B$.
- Line 911, mixed : \includegraphics[width=1.0\linewidth]{figures/figure1_1-8-25.pdf}
- Line 918, unix : \paragraph{Alternative specifications.} In Appendix \ref{sec:alternative_specifications}, we develop three alternative specifications to our baseline model and discuss their properties.  First, we consider a mechanical model in which each buyer and each supplier has its own parametrically fixed search intensity. Although this version of the model has far more free parameters than our baseline specification, it fits the data only slightly better, and it fails to capture endogenous compositional effects on buyer and supplier portfolios in counterfactual experiments.  Next we develop a version of the model in which match-specific fixed costs and match-level earning shocks induce endogenous separations, as in \citet{MortensenPissarides1994}. Here we find that separations occur mainly among low-productivity firms which contribute little to market-wide aggregates.  Finally, we add heterogeneous match death hazards to the model and show that this has little effect on our estimates, mainly because there is only a weak relationship between buyer size and match death in the data.\footnote{\label{footnote:AAR} To highlight the effect of two-sided search on welfare, we also calibrate a standard sunk/fixed cost exporting model in the spirit of \citet{AlessandriaArkolakisRuhl2020}. This comparison isolates the role of endogenous buyer–supplier matching and search congestion in shaping policy outcomes, demonstrating that in their absence, policy experiments can generate welfare responses that differ, even in sign, from our baseline search framework (see Appendix \ref{app:AAR} for details)\medskip.}
- Line 929, unix : We can similarly calculate the gross profits obtained by the two types of suppliers.  Our parameter estimates imply that only 3 percent of \textit{potential} suppliers are of high type. However, in the steady state equilibrium, the high type suppliers are disproportionately more likely to form at least one match with U.S. buyers. Consequently, approximately 12 percent of \textit{active} suppliers are high type. Together, these high-quality suppliers obtain 0.11 of the total expenditure as profit, while low-quality suppliers receive only 0.03.\footnote{In other words, high type suppliers earn close to 80 percent (0.11/0.14) of the aggregate supplier profit.}
- Line 934, unix : \includegraphics[width=\textwidth]{figures/buyer_profit_share.png}
- Line 941, unix : \includegraphics[width=\textwidth]{figures/buyer_search_cost_share.png}
- Line 951, unix : On the supplier side, total search costs constitute 0.064 of total expenditure, representing $45$ percent (0.064/0.14) of total supplier profit. Compared with the buyers, suppliers incur relatively higher search costs in proportion to their profit partly because our estimates indicate that the number of potential suppliers significantly exceeds the number of potential buyers.
- Line 960, unix : \includegraphics[scale = 0.8]{figures/life_cycle.png}
- Line 989, unix : \input{tables/counterfactual_table_2026.tex}
- Line 1008, unix : \input{tables/counterfactual_tariff_table.tex}
- Line 1040, unix : \includegraphics[width=\textwidth]{figures/trump_tariff.png}
- Line 1047, unix : \includegraphics[width=\textwidth]{figures/event_study/val_entropy_top5_no2025_full.png}
- Line 1065, unix : % \includegraphics[scale = 0.9]{figures/trump_tariff_2.png}
- Line 1089, windows : \appendix\pagebreak
- Line 1112, windows : -1} \left( p_{xy}\right) ^{-\alpha
- Line 2096, unix : While we will estimate a large number of search intensity parameters, for comparability we use the number and distribution of types from the baseline model.  We assume that buyer types are of uniform measure and sum to one: $\sum_{\boldsymbol{s}\in\mathbb{S}}M_{i}^{B}(\mathbf{s})=1/30$
- Line 2155, unix : \includegraphics[scale=0.5]{figures/combined_search_intensities.png}
- Line 2305, unix : This subsection describes how to compute the transition/intensity matrices. For the buyers we can still characterize an intensity matrix. For the suppliers we compute the ``expected'' intensity matrix given that supplier transitions now depend on the type(s) of buyers they are matched with. Therefore, the relevant intensity matrix for suppliers is one in which the entries compute the average hazard when suppliers have a certain number of partners.
- Line 2396, mixed : \includegraphics[width=0.9\linewidth]{figures/MP_fit_panel_Jan2026_Baseline}
- Line 2574, unix : \section{Fixed/sunk cost exporting model}
- Line 2580, windows : Time is discrete. Each potential exporter has a permanent productivity type $z\in\{z_L,z_H\}$.  Type shares are denoted by $\omega_L$ and $\omega_H=1-\omega_L$. Let $h\in\{0,1\}$ denote whether the firm exported in the previous period. Firms that consider exporting draw an additive normal shock when paying the fixed cost,
- Line 2587, windows : $\xi\in\{\xi_L,\xi_H\}$ that evolves according to
- Line 2606, windows : N(z,\xi)\,p(z,\xi)^{1-\sigma},
- Line 2613, unix : \paragraph{Parameters taken from EJTX} Some of the parameters in AAR have analogs in EJTX. We set these equal to their values in our best-fit EJTX calibration. Specifically, we set the high-type share to $\omega_H = 0.03$ and the productivity gap $z_H/z_L = e^{0.454} \approx 1.575$. We set the elasticity of substitution across firms to $\sigma = 3.25$, the geometric mean of the EJTX within-store and cross-store elasticities, to provide a single-nest proxy for the nested CES structure.  We set the discount factor to $\beta = 0.951$ to correspond to the annual discount rate used in EJTX.  We normalize cost of production $w=1$ and the total incumbent mass \(M_L + M_H = 1\). Finally, we set total spending on imported goods $E^\ast$ to unity.
- Line 2633, unix : Parameter/moment & Estimate & EJTX target & our AAR model \\ \midrule
- Line 2656, unix : It is instructive to compare the fixed costs we estimate with those reported by \citet{AlessandriaArkolakisRuhl2020}. We find the continuation-to-entry cost ratio to be $f_1/f_0 = \bar f/(\bar f+\Delta_f)=0.875$, while \citet{AlessandriaArkolakisRuhl2020} report $f_1/f_0=0.263$. One plausible interpretation is that apparel exporters, which are subject to frequently changing fashion trends, exhibit more churning than the typical American exporter studied in \citet{AlessandriaArkolakisRuhl2020}.\footnote{Selection implies that both the average entry cost paid by firms that actually enter and the average fixed costs paid by firms that continue exporting are both lower than the unconditional average of those costs.  The conditional entry cost $\mathbb{E}[f_0+\varepsilon \mid \text{entry}] = 0.747$, which is 22\% of average entrant revenue. Among firms that continue exporting, the average fixed cost is $\mathbb{E}[f_1+\varepsilon \mid \text{continue}] = 1.571$, or 18\% of average continuing revenue.}
- Line 2672, unix : Consumer welfare ($1/P$) & $-0.8$ & $+5.5$ \\

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/solve_model.m**

- Line 221, unix : %now aggregate up to V/U
- Line 228, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/sim_growth_moments.m**

- Line 1, unix : %% Simulate firm life cycle in export/import

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/comparison_plots.m**

- Line 29, unix : saveas(gcf, 'results/spb_dist.png');
- Line 40, unix : saveas(gcf, 'results/bps_dist.png');
- Line 49, unix : saveas(gcf, 'results/spb_trans.png');
- Line 58, unix : saveas(gcf, 'results/bps_trans.png');
- Line 67, unix : saveas(gcf, 'results/within_buyer_concentration.png');
- Line 76, unix : saveas(gcf, 'results/sellers_to_buyers.png');
- Line 109, unix : saveas(gcf, 'results/growth_not_targeted.png');

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/data_moments_mechanical.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 228, unix : NS_NB = N_S/N_B;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/val_b.m**

- Line 26, unix : Vbn=prof/rho;
- Line 51, windows : %            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 237, unix : NS_NB = act_NS/act_NB;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/std_errors.m**

- Line 3, unix : % % 1. Find dM/dP, the dependence of moments on parameters
- Line 65, unix : param_names = {'cb0 and cs0','gamB','gamS','w2_x','Delta','var ln(mu)','Ms/Mb','eta'}';
- Line 72, unix : save results/se_results_no_M_target
- Line 79, unix : save results/AGS_sens_no_M_target

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 228, unix : NS_NB = N_S/N_B;
- Line 258, unix : % current calibration targets: NS/NB excluded, match-death regression included

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/plot_fit.m**

- Line 17, unix : z = [0:(1/gran):1];
- Line 20, unix : z2 = [0:(zmax2/gran):zmax2];
- Line 23, unix : z3 = [0:(zmax3/gran):zmax3];
- Line 26, unix : z4 = [0:(zmax4/gran):zmax4];
- Line 29, unix : z5 = [0:(zmax5/gran):zmax5];
- Line 96, unix : saveas(gcf,'results/MP_fit_panel.png')
- Line 119, unix : save results/figures_est_eta

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/solve_eps_cutoff.m**

- Line 45, windows : %fprintf("iter %d: a: %.5f, b: %.5f, c: %.5f, f(a): %.5f, f(c): %.5f, CDF(c): %.5f, E(c): %.5f\n", iter, a, b, c, fa, fc, CDF_c, E_c);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/std_errors.m**

- Line 3, unix : % % 1. Find dM/dP, the dependence of moments on parameters
- Line 76, unix : param_names = {'cb0','cs0','w2_x','c2','var ln(mu)','Ms/Mb','subs elas','match_scale','F'}';
- Line 82, unix : save results/se_results_est_eta
- Line 89, unix : save results/AGS_sens_est_eta

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/AAR/baseline_moments/expected_match_revenue.m**

- Line 34, unix : % Probability a new match involves a specific buyer state/type

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/data_moments_hetero.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 228, unix : NS_NB = N_S/N_B;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/12_lfttd_aggregates_by_country.do**

- Line 124, unix : gen import_value = value_imp/10^9
- Line 202, unix : replace NoBuyer_r = NoBuyer_r/1000
- Line 284, unix : replace NoSeller_r = NoSeller_r/1000

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share
- Line 220, unix : % baseline moments (match-death excluded, NS/NB excluded)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/audit_report_values.m**

- Line 14, windows : fprintf('Replication audit values\n');
- Line 15, windows : fprintf('Root: %s\n\n', rootDir);
- Line 25, windows : fprintf('BASELINE_REPORTED_SAVED_FIT %.15g\n', S.D0);
- Line 26, windows : fprintf('BASELINE_REPORTED_REEVALUATED_FIT %.15g\n', D);
- Line 27, windows : fprintf('BASELINE_REPORTED_DIFF %.15g\n\n', D - S.D0);
- Line 38, windows : fprintf('MECHANICAL_SOURCE %s\n', meta.source_file);
- Line 39, windows : fprintf('MECHANICAL_SAVED_FVAL %.15g\n', best_fval);
- Line 40, windows : fprintf('MECHANICAL_REEVALUATED_FIT %.15g\n', D);
- Line 41, windows : fprintf('MECHANICAL_DIFF %.15g\n\n', D - best_fval);
- Line 61, windows : fprintf('HETERO_SAVED_FULL_OBJECTIVE %.15g\n', S.out);
- Line 62, windows : fprintf('HETERO_REEVALUATED_FULL_OBJECTIVE %.15g\n', out);
- Line 63, windows : fprintf('HETERO_FULL_DIFF %.15g\n', out - S.out);
- Line 64, windows : fprintf('HETERO_SAVED_OLD_OBJECTIVE %.15g\n', S.out_old);
- Line 65, windows : fprintf('HETERO_REEVALUATED_OLD_OBJECTIVE %.15g\n', out_old);
- Line 66, windows : fprintf('HETERO_OLD_DIFF %.15g\n', out_old - S.out_old);
- Line 67, windows : fprintf('HETERO_AVG_MATCH_DEATH %.15g\n', avg_match_death_haz);
- Line 68, windows : fprintf('HETERO_REG_COEF %.15g\n', match_death_reg_coef);
- Line 69, windows : fprintf('HETERO_DELTA2 %.15g\n\n', delta2);
- Line 80, windows : fprintf('AAR_SAVED_FVAL %.15g\n', r.fval);
- Line 81, windows : fprintf('AAR_REEVALUATED_FVAL %.15g\n', fval_aar);
- Line 82, windows : fprintf('AAR_DIFF %.15g\n', fval_aar - r.fval);
- Line 83, windows : fprintf('AAR_THETA %.15g %.15g %.15g %.15g\n', ...
- Line 85, windows : fprintf('AAR_MAX_ABS_MOMENT_DIFF %.15g\n\n', max(abs(model_vec(:) - S.empirical_summary.data_moments(:))));
- Line 119, windows : fprintf('%s_SOURCE %s\n', label, artifact);
- Line 123, windows : fprintf('%s_SAVED_OUT %.15g\n', label, S.out);
- Line 124, windows : fprintf('%s_REEVALUATED_OUT %.15g\n', label, out_mp);
- Line 125, windows : fprintf('%s_DIFF %.15g\n', label, out_mp - S.out);
- Line 126, windows : fprintf('%s_SAVED_OUT_OLD %.15g\n', label, S.out_old);
- Line 127, windows : fprintf('%s_REEVALUATED_OUT_OLD %.15g\n', label, out_old_mp);
- Line 128, windows : fprintf('%s_OLD_DIFF %.15g\n\n', label, out_old_mp - S.out_old);
- Line 133, windows : fprintf('%s_ARTIFACT missing: %s\n', label, artifact);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/std_errors.m**

- Line 3, unix : % % 1. Find dM/dP, the dependence of moments on parameters
- Line 73, unix : save results/se_results_hetero
- Line 80, unix : save results/AGS_sens_hetero

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/sim_moments_mechanical.m**

- Line 125, unix : %   %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/solve_model.m**

- Line 221, unix : %now aggregate up to V/U
- Line 228, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/data_moments_baseline.m**

- Line 4, unix : %%1. Buyer/Seller Degree Dist.
- Line 237, unix : NS_NB = act_NS/act_NB;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_model.m**

- Line 227, unix : %now aggregate up to V/U
- Line 234, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/val_b.m**

- Line 26, unix : Vbn=prof/rho;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/Stata_LFTTD_code/A10_lfttd_tenure_of_BuyerSeller.do**

- Line 9, unix : This code calculates the tenure of buyers/sellers. Two defintions of

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/solve_model.m**

- Line 249, unix : %now aggregate up to V/U
- Line 256, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/solve_model_mechanical_cf.m**

- Line 89, unix : %now aggregate up to V/U
- Line 97, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/mechanical_counterfactual_main.m**

- Line 3, unix : % Solves 1996/2004/2011 steady states for the mechanical model and
- Line 30, unix : error('Could not find baseline calibration file in ../baseline_no_NsNb_target/results/');
- Line 48, windows : fprintf('Using mechanical estimate from %s (%s), fval=%.4f\n', ...
- Line 85, unix : [1/xT(end) tsellerT+tbuyerT]
- Line 90, unix : % 1) Use the baseline transition calibration to infer how potential low/high
- Line 93, unix : %    estimated 2011 potential low/high supplier masses.
- Line 130, unix : [1/gam tseller1+tbuyer1]
- Line 133, unix : [nsellerT/nseller1-1 ((1-1/xT(end)+tsellerT)/nsellerT)/((1-1/x1(end)+tseller1)/nseller1)-1]
- Line 150, unix : [1/gam tseller0+tbuyer0]
- Line 153, unix : [nseller1/nseller0-1]

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/match_death_reg_MP.m**

- Line 71, windows : fprintf('\n--- OLS: p_loss(s) on s ---\n');
- Line 74, windows : fprintf('R^2 = %.4f\n\n', R2);

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/start_estimation_ga.m**

- Line 14, unix : fileID1 = fopen('results/fitlog_heterogeneous_death.txt','a');
- Line 106, unix : num2str(time_elapsed1/60) ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_no_NsNb_target/define_parameters.m**

- Line 17, unix : % profit split under equal bargaining weights/constant share approximation

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/mechanical_model/welfare_calc.m**

- Line 13, unix : welfare = 1/price;

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_model_tariff.m**

- Line 235, unix : %now aggregate up to V/U
- Line 251, unix : thetab_new=X/V;       % JT: match rate per effective match seeking buyer

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/audit_tariff_transition.m**

- Line 59, windows : fprintf('Tariff transition audit written to %s\n', ...

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/main.m**

- Line 16, unix : %true parameters, search cost/network buyer/network seller/
- Line 17, unix : %frac. high type/high type seller/type buyer/mass of sellers/elas. of sub.
- Line 49, unix : [mean(net_profT) 1/x(end-2)]
- Line 109, unix : v_s11 = tseller11/q_s11+c11;
- Line 110, unix : v_s1T = tseller1T/q_s1T+c11;
- Line 112, unix : v_s21 = tseller21/q_s21+c2;
- Line 113, unix : v_s2T = tseller2T/q_s2T+c2;
- Line 116, unix : [log(v_s1T/v_s11)-log(v_s2T/v_s21)]
- Line 167, unix : nseller1T/nseller11-1, nseller2T/nseller21-1, nbuyerT/nbuyer1-1, ...
- Line 168, unix : tseller1T/tseller11-1, tseller2T/tseller21-1, tbuyerT/tbuyer1-1, ...
- Line 180, windows : fprintf(fileID, '\\hline\\hline\n');
- Line 182, windows : fprintf(fileID, '\\hline\n');
- Line 191, windows : fprintf(fileID, '\\hline\n');
- Line 195, windows : % fprintf(fileID, '\\medskip\n');
- Line 267, windows : fprintf('Tariff transition sequence saved to %s\n', transitionOut);
- Line 281, unix : %DID_est = [DID(1) DID(round(1/dt)) DID(round(2/dt)) DID(round(3/dt)) DID(round(4/dt))];
- Line 299, unix : plot(Year,(Ap_new/Ap1).^(1/(gam-1)),'LineWidth',1.5)

**/var/folders/5q/yhcyv3z55wvg6lhgc3h22kk00000gq/T/20220045-2/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/sim_moments_baseline.m**

- Line 125, unix : %when #of high type larger/equal to k, use high type share

