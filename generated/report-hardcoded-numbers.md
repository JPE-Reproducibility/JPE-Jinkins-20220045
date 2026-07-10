## Potentially Hardcoded Numeric Constants


We found the following set of hard coded numbers. This may be completely legitimate (parameter input, thresholds for computations, etc), and is hence only for information.

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/AAR/baseline_moments/generate_baseline_moments.m**

- Line 15, : import_share_data = 0.7308;   % retained for calibration of α via EJTX mark-up Eq. (\ref{mark-up})

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/define_parameters.m**

- Line 38, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/run_all_replication.m**

- Line 139, : 1, 0.407, 0.798;
- Line 140, : 2, 0.554, 0.911;
- Line 141, : 3, 0.645, 0.951;
- Line 142, : 4, 0.709, 0.970;
- Line 143, : 5, 0.743, 0.980;
- Line 144, : 6, 0.780, 0.987;
- Line 145, : 7, 0.808, 0.991;
- Line 146, : 8, 0.823, 0.993;
- Line 147, : 9, 0.837, 0.995;
- Line 148, : 10, 0.855, 0.996};
- Line 156, : 1, 0.000, 1.000, 0, 0, 0, 0, 0, 0, 0, 0, 0;
- Line 157, : 2, 1.134, 0.771, 0.229, 0, 0, 0, 0, 0, 0, 0, 0;
- Line 158, : 3, 1.604, 0.668, 0.240, 0.092, 0, 0, 0, 0, 0, 0, 0;
- Line 159, : 4, 1.764, 0.608, 0.232, 0.111, 0.049, 0, 0, 0, 0, 0, 0;
- Line 160, : 5, 1.904, 0.544, 0.231, 0.126, 0.067, 0.032, 0, 0, 0, 0, 0;
- Line 161, : 6, 2.054, 0.540, 0.218, 0.115, 0.070, 0.039, 0.019, 0, 0, 0, 0;
- Line 162, : 7, 2.214, 0.502, 0.214, 0.123, 0.074, 0.045, 0.027, 0.019, 0, 0, 0;
- Line 163, : 8, 2.094, 0.460, 0.212, 0.125, 0.080, 0.054, 0.035, 0.023, 0.011, 0, 0;
- Line 164, : 9, 2.364, 0.451, 0.201, 0.121, 0.083, 0.055, 0.038, 0.026, 0.017, 0.017, 0;
- Line 165, : 10, 2.324, 0.420, 0.197, 0.125, 0.084, 0.060, 0.042, 0.029, 0.021, 0.013, 0.007};
- Line 221, : matchDeathVarianceForTable = 0.0004^2;
- Line 229, : table5PaperEstimate = [0.009; 0.320; 0.230; 0.030; 0.454; 4.203; 2.432; 7.428; 10461.73];
- Line 230, : table5PaperStdError = [0.003; 0.041; 0.046; 0.002; 0.006; 0.728; 0.141; 2.508; NaN];
- Line 245, : baselinePaperEstimate = [0.009; 0.320; 0.230; 0.030; 0.454; 4.203; 2.432; 7.428; ...
- Line 248, : baselinePaperStdError = [0.003; 0.041; 0.046; 0.002; 0.006; 0.728; 0.141; 2.508; ...
- Line 251, : heteroPaperEstimate = [0.008; 0.311; 0.177; 0.031; 0.457; 4.496; 2.435; 7.121; ...
- Line 252, : 0.563; 0.529; 10867.17; 10804.13];
- Line 254, : heteroPaperStdError = [0.003; 0.051; 0.068; 0.001; 0.006; 1.012; 0.177; 3.178; ...
- Line 255, : 0.010; NaN; NaN; NaN];
- Line 295, : 'Match death moment (data: -0.0119)', NaN, NaN, match.match_death_reg_coef, NaN, nodisp.match_death_reg_coef, NaN, '';
- Line 306, : 'Buyer search cost scalar', 0.009, 0.003, 0.0090, 0.0014, 0.0071, 0.0014;
- Line 307, : 'Supplier search cost scalar', NaN, NaN, 0.0020, 0.2254, 0.0019, 0.1830;
- Line 308, : 'Buyer visibility parameter', 0.320, 0.041, NaN, NaN, NaN, NaN;
- Line 309, : 'Supplier visibility parameter', 0.230, 0.046, NaN, NaN, NaN, NaN;
- Line 310, : 'Share of high-type suppliers', 0.030, 0.002, 0.0341, 0.0003, 0.0341, 0.0003;
- Line 311, : 'High-type supplier cost advantage', 0.454, 0.006, 0.0559, 0.0008, 0.0551, 0.0008;
- Line 312, : 'Buyer type dispersion', 7.428, 2.508, 6.5224, 0.2542, 5.9207, 0.2375;
- Line 313, : 'Supplier to buyer ratio', 4.203, 0.728, 6.7579, 0.2114, 8.0639, 0.4000;
- Line 314, : 'Within-store elasticity', NaN, NaN, 1.8771, 0.0034, 1.8687, 0.0035;
- Line 315, : 'Cross-store elasticity', 2.432, 0.141, NaN, NaN, NaN, NaN;
- Line 316, : 'Match shock scale', NaN, NaN, 0.0414, 0.5724, 0.0000, NaN;
- Line 317, : 'Fixed cost (share of median match surplus)', NaN, NaN, 0.0015, 0.0006, 0.0018, 0.0005;
- Line 318, : 'Match death moment (data: -0.0119)', NaN, NaN, -0.003, NaN, 0.000, NaN;
- Line 433, : "x0 = [0.00945610159077022 0.328405888208306 0.229729202367540 0.0303627427733110 " + ...
- Line 434, : "0.454124065271806 7.32064657468461 4.19004349697171 2.43268886413272]; " + ...
- Line 445, : "x0 = [0.00800149670142449 0.311412680597366 0.176627736944740 0.0306233133085443 " + ...
- Line 446, : "0.457037217583970 7.12118405670129 4.49554048853843 2.43536849736572 0.563213343051187]; " + ...
- Line 457, : "si_in = [5.30475970194135 2.54322006301519 0.348565315964827 0.369505098908116 " + ...
- Line 458, : "9.35562288711672 0.441813632503381 7.87504269207164 0.340689355526077 " + ...
- Line 459, : "22.9491963021357 28.2005129010624 2.66627677681297 1.98610727953777 " + ...
- Line 460, : "0.517564937662059 0.367303303415852 0.321406045111434 0.300434151091727 " + ...
- Line 461, : "0.385153971571320 0.332210230982581 2.00214162149974 0.319917507402888 " + ...
- Line 462, : "2.16833653770023 0.354051646421266 0.892034393568599 0.377314705140029 " + ...
- Line 463, : "2.19396527483993 0.335786031814243 0.336829230525515 0.305377065853247 " + ...
- Line 464, : "0.358834912727211 0.405293209243906 1.30757293276676 14.2853658011404 " + ...
- Line 465, : "0.0373113278254231 8.71516134851435]'; " + ...
- Line 491, : "x0 = [0.00669 0 0.00183 0.03431 0.05356 5.48040 8.56411 1.86338 0.04029 0.00198]'; " + ...
- Line 993, : ax.YColor = [0 0.4470 0.7410];
- Line 995, : ax.YColor = [0.8500 0.3250 0.0980];
- Line 998, : ax.YColor = [0 0.4470 0.7410];

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/data_moments_baseline.m**

- Line 85, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 86, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 87, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 88, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 89, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 90, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 91, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 92, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 93, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 94, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 102, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 103, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 104, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 105, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 106, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 107, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 108, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 109, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 110, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 111, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 123, : data_interm_sh = 0.7308;
- Line 124, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/mechanical_model/summary_mechanical_policy_shock.m**

- Line 183, : baseVal = rowMap_baseline(lbl);      % e.g. 0.446

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/mechanical_model/data_moments_mechanical.m**

- Line 85, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 86, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 87, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 88, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 89, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 90, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 91, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 92, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 93, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 94, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 102, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 103, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 104, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 105, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 106, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 107, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 108, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 109, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 110, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 111, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 123, : data_interm_sh = 0.7308;
- Line 124, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/docs/EJTX_2026_replication.tex**

- Line 401, : 1 & 0.407 & 0.798 \\
- Line 402, : 2 & 0.554 & 0.911 \\
- Line 403, : 3 & 0.645 & 0.951 \\
- Line 404, : 4 & 0.709 & 0.970 \\
- Line 405, : 5 & 0.743 & 0.980 \\
- Line 406, : 6 & 0.780 & 0.987 \\
- Line 407, : 7 & 0.808 & 0.991 \\
- Line 408, : 8 & 0.823 & 0.993 \\
- Line 409, : 9 & 0.837 & 0.995 \\
- Line 410, : 10 & 0.855 & 0.996 \\
- Line 434, : {\small 1} & {\small 0.000} & {\small 1.000} & {\small 0} & {\small 0} &
- Line 437, : {\small 2} & {\small 1.134} & {\small 0.771} & {\small 0.229} & {\small 0} &
- Line 440, : {\small 3} & {\small 1.604} & {\small 0.668 } & {\small 0.240} & {\small %
- Line 441, : 0.092} & {\small 0} & {\small 0} & {\small 0} & {\small 0} & {\small 0} &
- Line 443, : {\small 4} & {\small 1.764} & {\small 0.608 } & {\small 0.232} & {\small %
- Line 444, : 0.111} & {\small 0.049} & {\small 0} & {\small 0} & {\small 0} & {\small 0}
- Line 446, : {\small 5} & {\small 1.904} & {\small 0.544 } & {\small 0.231 } & {\small %
- Line 447, : 0.126} & {\small 0.067} & {\small 0.032} & {\small 0} & {\small 0} & {\small 0%
- Line 449, : {\small 6} & {\small 2.054} & {\small 0.540} & {\small 0.218} & {\small 0.115%
- Line 450, : } & {\small 0.070} & {\small 0.039} & {\small 0.019} & {\small 0} & {\small 0%
- Line 452, : {\small 7} & {\small 2.214} & {\small 0.502 } & {\small 0.214} & {\small %
- Line 453, : 0.123} & {\small 0.074 } & {\small 0.045 } & {\small 0.027} & {\small 0.019}
- Line 455, : {\small 8} & {\small 2.094} & {\small 0.460 } & {\small 0.212} & {\small %
- Line 456, : 0.125 } & {\small 0.080 } & {\small 0.054} & {\small 0.035} & {\small 0.023}
- Line 457, : & {\small 0.011} & {\small 0} & {\small 0} \\
- Line 458, : {\small 9} & {\small 2.364} & {\small 0.451} & {\small 0.201} & {\small %
- Line 459, : 0.121 } & {\small 0.083} & {\small 0.055} & {\small 0.038} & {\small 0.026 }
- Line 460, : & {\small 0.017 } & {\small 0.017} & {\small 0} \\
- Line 461, : {\small 10} & {\small 2.324} & {\small 0.420 } & {\small 0.197 } & {\small 0.125 } & {\small 0.084 } & {\small 0.060} & {\small 0.042 } & {\small 0.029 } & {\small 0.021} & {\small 0.013 } & {\small 0.007} \\
- Line 845, : To estimate the remaining parameters we proceed in two stages. First, since it is possible to identify the match separation hazard $\delta$ without solving our dynamic model, we do so in a preliminary step. Specifically, we estimate $\delta$ as the Poisson parameter that best fits the distribution of match death rates observed in the customs records, adjusted for the buyer death hazard and the supplier death hazard discussed above. This calculation yields $\delta = 0.774 - 0.07 - 0.15 = 0.554$.
- Line 886, : $k_{0}$ & 0.009 & 0.003 \\
- Line 887, : $\gamma ^{B}$ & 0.320 & 0.041 \\
- Line 888, : $\gamma ^{S}$ & 0.230 & 0.046 \\
- Line 889, : $\omega $ & 0.030 & 0.002 \\
- Line 890, : $\Delta $ & 0.454 & 0.006 \\
- Line 891, : $M^{S}$ & 4.203 & 0.728 \\
- Line 892, : $\eta $ & 2.432 & 0.141 \\
- Line 893, : $\sigma _{\ln \mu }^{2}$ & 7.428 & 2.508 \\
- Line 917, : There is one targeted data moment that does not appear in Figure \ref{fig:baseline_fit}: the ratio of variable costs to total revenues among apparel buyers. For completeness, we note here that the data-based value of this is 0.731, while the model-based simulated value is 0.730.
- Line 925, : Our model implies that suppliers and buyers together take a constant share $\frac{1}{\eta} = 0.411$ of final expenditures $E$ as gross profits, using the rest to cover variable production and distribution costs (Section \ref{sec:payoff_functions}).\footnote{To get a crude sense for the dollar value of these aggregates, refer back to Figure \ref{fig:cons_imports}, which shows that the F.O.B. value of apparel imports was roughly \$100 billion in 2015.} But the division of these profits among individual buyers and suppliers is endogenously determined by their types and matching patterns. These patterns matter because an additional supplier not only contributes to a buyer's retail profit, it also helps the buyer negotiate down transfers to her other suppliers. As a result, high-$\mu$ buyers---which match with more suppliers---are able to capture relatively large profit shares. And similarly, high-quality suppliers---which have a relatively large impact on sales---capture larger profit shares per dollar exported.
- Line 951, : On the supplier side, total search costs constitute 0.064 of total expenditure, representing $45$ percent (0.064/0.14) of total supplier profit. Compared with the buyers, suppliers incur relatively higher search costs in proportion to their profit partly because our estimates indicate that the number of potential suppliers significantly exceeds the number of potential buyers.
- Line 982, : To construct the 2004 equilibrium, we choose the values of ($M^{S,2004},\omega^{2004}$) that imply the observed growth in the number of active exporters and their average sales between 2004 and the baseline years (2006-2011), holding other parameters fixed. We find that the share of high-quality firms in potential exporters fell from $\omega^{2004}=0.043$ to $\omega^{2006-2011}=0.030$ as Chinese access to the U.S. market improved, while the measure of potential suppliers rose from $M^{S,2004}= 2.4$ to its post-shock estimated value of $M^{S,2006-2011}=4.2$. To construct the 1996 equilibrium, we fix all parameters except $\kappa_0$ at their 2004 values. Then we increase $\kappa_0$ sufficiently to reduce the number of active exporters by the observed fraction, going backward from 2004 to 1996. We find that to explain the smaller number of active exporters in 1996 with search costs alone, we require $\kappa_0^{1996} = 1.65 \times \kappa^{2004}_0$.
- Line 2359, : Buyer search cost scalar & 0.009 & 0.0090 & 0.0071 \\
- Line 2360, : & (0.003) & (0.0014) & (0.0014) \\
- Line 2361, : Supplier search cost scalar & same as buyer & 0.0020 & 0.0019 \\
- Line 2362, : &  & (0.2254) & (0.1830) \\
- Line 2363, : Buyer visibility parameter & 0.320 & --- & --- \\
- Line 2364, : & (0.041) & --- & --- \\
- Line 2365, : Supplier visibility parameter & 0.230 & --- & --- \\
- Line 2366, : & (0.046) & --- & --- \\
- Line 2367, : Share of high-type suppliers & 0.030 & 0.0341 & 0.0341 \\
- Line 2368, : & (0.002) & (0.0003) & (0.0003) \\
- Line 2369, : High-type supplier cost advantage & 0.454 & 0.0559 & 0.0551 \\
- Line 2370, : & (0.006) & (0.0008) & (0.0008) \\
- Line 2371, : Buyer type dispersion & 7.428 & 6.5224 & 5.9207 \\
- Line 2372, : & (2.508) & (0.2542) & (0.2375) \\
- Line 2373, : Supplier to buyer ratio & 4.203 & 6.7579 & 8.0639 \\
- Line 2374, : & (0.728) & (0.2114) & (0.4000) \\
- Line 2375, : Within-store elasticity & calibrated & 1.8771 & 1.8687 \\
- Line 2376, : &  & (0.0034) & (0.0035) \\
- Line 2377, : Cross-store elasticity & 2.432 & same as within & same as within \\
- Line 2378, : & (0.141) & --- & --- \\
- Line 2379, : Match shock scale & --- & 0.0414 & 0.0000 \\
- Line 2380, : &  & (0.5724) & --- \\
- Line 2381, : Fixed cost (shr.\ of median match surp.) & --- & 0.0015 & 0.0018 \\
- Line 2382, : &  & (0.0006) & (0.0005) \\
- Line 2384, : Match death moment (data: $-0.0119$) & --- & $-0.003$ & 0.000 \\
- Line 2410, : Because of the weak (but negative) relationship between match death hazard and number of supplier matches in the data, the estimated best fit match death hazard of high-type suppliers is only slightly lower than that of low-type suppliers (0.529 vs 0.563). The rest of the fitted parameters are similar to those of the baseline model. Moreover, the fit of the heterogeneous death hazard model on only the baseline moments is slightly worse than our baseline fit.  For these reasons and for parsimony, we maintain the benchmark assumption of a uniform death hazard across supplier types.
- Line 2522, : $k_{0}$ & 0.009 & 0.008 \\
- Line 2523, : & (0.003) & (0.003) \\[0.5ex]
- Line 2524, : $\gamma^{B}$ & 0.320 & 0.311 \\
- Line 2525, : & (0.041) & (0.051) \\[0.5ex]
- Line 2526, : $\gamma^{S}$ & 0.230 & 0.177 \\
- Line 2527, : & (0.046) & (0.068) \\[0.5ex]
- Line 2528, : $\omega$ & 0.030 & 0.031 \\
- Line 2529, : & (0.002) & (0.001) \\[0.5ex]
- Line 2530, : $\Delta$ & 0.454 & 0.457 \\
- Line 2531, : & (0.006) & (0.006) \\[0.5ex]
- Line 2532, : $M^{S}$ & 4.203 & 4.496 \\
- Line 2533, : & (0.728) & (1.012) \\[0.5ex]
- Line 2534, : $\eta$ & 2.432 & 2.435 \\
- Line 2535, : & (0.141) & (0.177) \\[0.5ex]
- Line 2536, : $\sigma_{\ln \mu }^{2}$ & 7.428 & 7.121 \\
- Line 2537, : & (2.508) & (3.178) \\[0.5ex]
- Line 2538, : $\delta_1$ & --- & 0.563 \\
- Line 2539, : & & (0.010) \\[0.5ex]
- Line 2540, : $\delta_2$ & --- & 0.529 \\
- Line 2560, : Average match death probability & 0.774 & 0.774 \\
- Line 2561, : Buyer count coefficient $(\hat{\beta}_{N_B})$ & $-0.0119$ & $-0.0087$ \\
- Line 2572, : %Note: to get the adjusted fit from the baseline, I add the contribution of the match death regression moment.  The baseline model will always generate a zero coefficient.  The data value is −0.0119, and the variance is (0.0004)^2 = 1.6x10^7.  The relevant calculation is thus (0.0119)^2 / 1.6x10^7 = 885.0625.  The baseline fit is 10461.73, so the adjusted fit is 11346.7925.
- Line 2613, : \paragraph{Parameters taken from EJTX} Some of the parameters in AAR have analogs in EJTX. We set these equal to their values in our best-fit EJTX calibration. Specifically, we set the high-type share to $\omega_H = 0.03$ and the productivity gap $z_H/z_L = e^{0.454} \approx 1.575$. We set the elasticity of substitution across firms to $\sigma = 3.25$, the geometric mean of the EJTX within-store and cross-store elasticities, to provide a single-nest proxy for the nested CES structure.  We set the discount factor to $\beta = 0.951$ to correspond to the annual discount rate used in EJTX.  We normalize cost of production $w=1$ and the total incumbent mass \(M_L + M_H = 1\). Finally, we set total spending on imported goods $E^\ast$ to unity.
- Line 2634, : $\bar f$ & 2.1507 & \multicolumn{2}{c}{---} \\
- Line 2635, : $\Delta_f$ & 0.3071 & \multicolumn{2}{c}{---} \\
- Line 2636, : $\xi_H$ & 1.3529 & \multicolumn{2}{c}{---} \\
- Line 2637, : $\rho_\xi$ & 0.5552 & \multicolumn{2}{c}{---} \\
- Line 2639, : Entry rate  & --- & 0.1093 & 0.1093 \\
- Line 2640, : Conditional survival & --- & 0.8209 & 0.8209 \\
- Line 2641, : Within-firm sales ratio $\bar r_{2}/\bar r_{1}$ & --- & 1.4332 & 1.4332 \\
- Line 2642, : Within-firm sales ratio $\bar r_{3}/\bar r_{1}$ & --- & 1.5090 & 1.5090 \\
- Line 2656, : It is instructive to compare the fixed costs we estimate with those reported by \citet{AlessandriaArkolakisRuhl2020}. We find the continuation-to-entry cost ratio to be $f_1/f_0 = \bar f/(\bar f+\Delta_f)=0.875$, while \citet{AlessandriaArkolakisRuhl2020} report $f_1/f_0=0.263$. One plausible interpretation is that apparel exporters, which are subject to frequently changing fashion trends, exhibit more churning than the typical American exporter studied in \citet{AlessandriaArkolakisRuhl2020}.\footnote{Selection implies that both the average entry cost paid by firms that actually enter and the average fixed costs paid by firms that continue exporting are both lower than the unconditional average of those costs.  The conditional entry cost $\mathbb{E}[f_0+\varepsilon \mid \text{entry}] = 0.747$, which is 22\% of average entrant revenue. Among firms that continue exporting, the average fixed cost is $\mathbb{E}[f_1+\varepsilon \mid \text{continue}] = 1.571$, or 18\% of average continuing revenue.}
- Line 2659, : Using the policy experiment described in Section 6.1, we now juxtapose the predictions of our AAR model with those of our EJTX (baseline) model. The experiment, recall, is to increase the mass of potential exporters from $M^{S,\text{pre}} = 2.4$ to $M^{S,\text{post}} = 4.2$ while simultaneously reducing the fraction of potential suppliers that are high quality from $\omega_H^{\text{pre}} = 0.043$ to $\omega_H^{\text{post}} = 0.030$. All other parameters are fixed at their estimated baseline values from our AAR model calibration.

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/mechanical_model/define_parameters.m**

- Line 15, : gam=2.389;   % JT: corresponds to eta in the paper (draft v20)
- Line 26, : delta = 0.774 - delta_B - delta_S;
- Line 39, : logn_param_2 = sqrt(0.7302); %sqrt(underlying normal variance) JT: var(mu) in text (v20)?
- Line 47, : logn_param_2 = sqrt(5.360); %sqrt(underlying normal variance) JT: var(xi) in text (v20)?

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/solve_model_no_gamma.m**

- Line 316, : % adjust delta to hit the observed total match death hazard (0.774)
- Line 317, : target_match_death_haz = 0.774;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/data_moments_baseline.m**

- Line 8, : degSPB = [0.407
- Line 9, : 0.554
- Line 10, : 0.645
- Line 11, : 0.709
- Line 12, : 0.743
- Line 13, : 0.780
- Line 14, : 0.808
- Line 15, : 0.823
- Line 16, : 0.837
- Line 17, : 0.855
- Line 18, : 0.865
- Line 19, : 0.876
- Line 20, : 0.882
- Line 21, : 0.892
- Line 22, : 0.900
- Line 23, : 0.907
- Line 24, : 0.912
- Line 25, : 0.917
- Line 26, : 0.921
- Line 27, : 0.925]';
- Line 29, : degBPS = [0.798
- Line 30, : 0.911
- Line 31, : 0.951
- Line 32, : 0.970
- Line 33, : 0.980
- Line 34, : 0.987
- Line 35, : 0.991
- Line 36, : 0.993
- Line 37, : 0.995
- Line 38, : 0.996
- Line 39, : 0.997
- Line 40, : 0.998
- Line 41, : 0.998
- Line 42, : 0.999
- Line 43, : 0.999
- Line 44, : 0.999
- Line 45, : 0.999
- Line 46, : 0.999
- Line 47, : 0.999
- Line 48, : 1.000]';
- Line 69, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 70, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 71, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 72, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 73, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 74, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 75, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 76, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 77, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 78, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 87, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 88, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 89, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 90, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 91, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 92, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 93, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 94, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 95, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 96, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 133, : data_interm_sh = 0.7308;
- Line 134, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_no_NsNb_target/std_errors.m**

- Line 7, : % x = [0.0208235156070959,0.533836940132876,2.58302378926168e-05,0.0306054114966558,...
- Line 8, : %      20.8543850811222,0.389585504781911,3.01447950461815];

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/mechanical_model/mechanical_counterfactual_main.m**

- Line 97, : entrant_high_share = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_no_NsNb_target/start_estimation_ga.m**

- Line 29, : % x0 = [0.000703601651058875, 0.205444929183100, 0.379201523279817,0.034691950475348...
- Line 30, : %      0.450429447009274, 9.80129366907417, 10.0571675688598, 2.50598242772316];
- Line 31, : % OBJECTIVE FUNCTION =  9924.17623758453
- Line 33, : % x0 = [0.000936625410970870	0.179975275303972	0.528352266072876	0.0313994062192726...
- Line 34, : %       0.458124403279351	10.2854318378267	11.2670644485353	2.49234044616565];
- Line 36, : % x0 = [0.01732   0.38107   0.20826   0.02971   0.44274   4.99617  3.72127   2.39926 ];
- Line 37, : x0= [ 0.00945610159077022	0.328405888208306	0.229729202367540	0.0303627427733110...
- Line 38, : 0.454124065271806	7.32064657468461	4.19004349697171	2.43268886413272];

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/AAR/estimation/default_config.m**

- Line 39, : cfg.bounds.rho_xi     = [0.05, 0.999];
- Line 43, : cfg.override_calibration = struct('z_ratio', 1.574598, 'omega_H', 0.03);

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/data_moments_baseline.m**

- Line 8, : degSPB = [0.407
- Line 9, : 0.554
- Line 10, : 0.645
- Line 11, : 0.709
- Line 12, : 0.743
- Line 13, : 0.780
- Line 14, : 0.808
- Line 15, : 0.823
- Line 16, : 0.837
- Line 17, : 0.855
- Line 18, : 0.865
- Line 19, : 0.876
- Line 20, : 0.882
- Line 21, : 0.892
- Line 22, : 0.900
- Line 23, : 0.907
- Line 24, : 0.912
- Line 25, : 0.917
- Line 26, : 0.921
- Line 27, : 0.925]';
- Line 29, : degBPS = [0.798
- Line 30, : 0.911
- Line 31, : 0.951
- Line 32, : 0.970
- Line 33, : 0.980
- Line 34, : 0.987
- Line 35, : 0.991
- Line 36, : 0.993
- Line 37, : 0.995
- Line 38, : 0.996
- Line 39, : 0.997
- Line 40, : 0.998
- Line 41, : 0.998
- Line 42, : 0.999
- Line 43, : 0.999
- Line 44, : 0.999
- Line 45, : 0.999
- Line 46, : 0.999
- Line 47, : 0.999
- Line 48, : 1.000]';
- Line 69, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 70, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 71, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 72, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 73, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 74, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 75, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 76, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 77, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 78, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 87, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 88, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 89, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 90, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 91, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 92, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 93, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 94, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 95, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 96, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 133, : data_interm_sh = 0.7308;
- Line 134, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/Stata_LFTTD_code/03_lfttd_dist_NumSeller_per_buyer.do**

- Line 150, : // round to 0.0001
- Line 151, : replace Percent = round(Percent,0.0001)
- Line 193, : // round to 0.0001
- Line 194, : replace Percent = round(Percent,0.0001)
- Line 236, : // round to 0.0001
- Line 237, : replace Percent = round(Percent,0.0001)

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/objective.m**

- Line 47, : fprintf(' model avg match death hazard (0.774)  = %.5f\n',avg_match_death_haz);
- Line 48, : fprintf(' model reg: hazard on buyers (-0.0119)= %.5f\n',match_death_reg_coef);

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/AAR/counterfactuals/policy_shock/run_policy_shock_counterfactual.m**

- Line 5, : %       M^S: 2.4 -> 4.2,   omega_H: 0.043 -> 0.030.
- Line 7, : %     (i) a pre-policy equilibrium with (M^S, omega_H) = (2.4, 0.043),
- Line 8, : %    (ii) a post-policy equilibrium with (M^S, omega_H) = (4.2, 0.030).
- Line 31, : omega_pre = 0.043;
- Line 32, : omega_post = 0.030;
- Line 181, : low_1996 = 0.480;
- Line 182, : high_1996 = 0.087;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/define_parameters.m**

- Line 38, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/data_moments_hetero.m**

- Line 85, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 86, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 87, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 88, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 89, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 90, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 91, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 92, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 93, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 94, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 102, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 103, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 104, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 105, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 106, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 107, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 108, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 109, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 110, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 111, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 123, : data_interm_sh = 0.7308;
- Line 124, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;
- Line 234, : data_match_death_frac = 0.774; %This is the number in the paper
- Line 242, : data_match_death_reg_coef = -0.0119; %from Regression_pair_exit_tenure_rounded.csv in disclosed_data_moments folder.  Ignore lnNoSeller coefficient, as that is identically zero in our model.
- Line 243, : var_match_death_reg_coef = (0.0004)^2; %from Regression_pair_exit_tenure_rounded.csv in disclosed_data_moments folder.  0.0004 is the standard error of the coefficient.

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/data_moments_baseline.m**

- Line 85, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 86, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 87, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 88, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 89, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 90, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 91, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 92, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 93, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 94, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 102, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 103, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 104, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 105, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 106, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 107, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 108, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 109, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 110, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 111, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 123, : data_interm_sh = 0.7308;
- Line 124, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;
- Line 234, : data_match_death_frac = 0.774; %This is the number in the paper
- Line 242, : data_match_death_reg_coef = -0.0119; %from Regression_pair_exit_tenure_rounded.csv in disclosed_data_moments folder.  Ignore lnNoSeller coefficient, as that is identically zero in our model.
- Line 243, : var_match_death_reg_coef = (0.0004)^2; %from Regression_pair_exit_tenure_rounded.csv in disclosed_data_moments folder.  0.0004 is the standard error of the coefficient.

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/Stata_LFTTD_code/05_lfttd_NumSellerBuyer_transition_matrix.do**

- Line 62, : replace NoSeller_gr_shr_f`i' = round(NoSeller_gr_shr_f`i',0.0001)
- Line 115, : replace NoBuyer_gr_shr_f`i' = round(NoBuyer_gr_shr_f`i',0.0001)

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/main.m**

- Line 304, : %set(gca, 'YTick', [0.975 0.98 0.985 0.99 0.995], ...
- Line 305, : %         'YTickLabel', {'0.975', '0.98', '0.985', '0.99', '0.995'})
- Line 317, : % set(gca, 'YTick', [0.975 0.98 0.985 0.99 0.995], ...
- Line 318, : %          'YTickLabel', {'0.975', '0.98', '0.985', '0.99', '0.995'})

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table.tex**

- Line 13, : 1. & \multicolumn{2}{l}{measure, active low-$\xi$ suppliers} &  & 0.446 &  & 26.4\% &  & 69.3\% \\
- Line 14, : 2. & \multicolumn{2}{l}{measure, active high-$\xi$ suppliers} &  & 0.106 &  & 6.5\% &  & 2.3\% \\
- Line 15, : 3. & \multicolumn{2}{l}{measure, active buyers} &  & 0.188 &  & 19.9\% &  & 17.0\% \\
- Line 16, : 4. & \multicolumn{2}{l}{total profit, low-$\xi$ suppliers} &  & 0.022 &  & 0.1\% &  & 35.4\% \\
- Line 17, : 5. & \multicolumn{2}{l}{total profit, high-$\xi$ suppliers} &  & 0.120 &  & -1.7\% &  & -9.8\% \\
- Line 18, : 6. & \multicolumn{2}{l}{total profit, buyers} &  & 0.269 &  & 0.7\% &  & 1.4\% \\
- Line 19, : 7. & \multicolumn{2}{l}{total search costs, low-$\xi$ suppliers} &  & 0.009 &  & 0.5\% &  & 35.4\% \\
- Line 20, : 8. & \multicolumn{2}{l}{total search costs, high-$\xi$ suppliers} &  & 0.057 &  & 4.6\% &  & -6.0\% \\
- Line 21, : 9. & \multicolumn{2}{l}{total search costs, buyers} &  & 0.045 &  & -17.3\% &  & -2.8\% \\
- Line 22, : 10. & \multicolumn{2}{l}{number of suppliers per buyer} &  & 1.653 &  & 12.9\% &  & 20.9\% \\
- Line 23, : 11. & \multicolumn{2}{l}{high-$\xi$ suppliers per buyer} &  & 0.614 &  & 13.2\% &  & -11.7\% \\
- Line 24, : 12. & \multicolumn{2}{l}{consumer welfare} &  & 1.000 &  & 9.0\% &  & 7.3\% \\

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex**

- Line 13, : 1. & \multicolumn{2}{l}{measure, active low-$\xi$ suppliers} &  & 0.480 &  & 21.6\% &  & 57.2\% \\
- Line 14, : 2. & \multicolumn{2}{l}{measure, active high-$\xi$ suppliers} &  & 0.087 &  & 4.2\% &  & 24.3\% \\
- Line 15, : 3. & \multicolumn{2}{l}{measure, active buyers} &  & 0.190 &  & 16.7\% &  & 15.6\% \\
- Line 16, : 4. & \multicolumn{2}{l}{total profit, low-$\xi$ suppliers} &  & 0.024 &  & -0.3\% &  & 24.5\% \\
- Line 17, : 5. & \multicolumn{2}{l}{total profit, high-$\xi$ suppliers} &  & 0.117 &  & -1.4\% &  & -7.8\% \\
- Line 18, : 6. & \multicolumn{2}{l}{total profit, buyers} &  & 0.270 &  & 0.6\% &  & 1.2\% \\
- Line 19, : 7. & \multicolumn{2}{l}{total search costs, low-$\xi$ suppliers} &  & 0.010 &  & 0.1\% &  & 24.2\% \\
- Line 20, : 8. & \multicolumn{2}{l}{total search costs, high-$\xi$ suppliers} &  & 0.056 &  & 4.0\% &  & -4.9\% \\
- Line 21, : 9. & \multicolumn{2}{l}{total search costs, buyers} &  & 0.046 &  & -14.8\% &  & -4.8\% \\
- Line 22, : 10. & \multicolumn{2}{l}{number of suppliers per buyer} &  & 1.695 &  & 11.3\% &  & 17.9\% \\
- Line 23, : 11. & \multicolumn{2}{l}{high-$\xi$ suppliers per buyer} &  & 0.581 &  & 11.7\% &  & -6.8\% \\
- Line 24, : 12. & \multicolumn{2}{l}{consumer welfare} &  & 1.000 &  & 8.0\% &  & 7.1\% \\

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/output/tables/paper/table_06_market_developments_counterfactual.tex**

- Line 13, : 1. & \multicolumn{2}{l}{measure, active low-$\xi$ suppliers} &  & 0.480 &  & 21.6\% &  & 57.2\% \\
- Line 14, : 2. & \multicolumn{2}{l}{measure, active high-$\xi$ suppliers} &  & 0.087 &  & 4.2\% &  & 24.3\% \\
- Line 15, : 3. & \multicolumn{2}{l}{measure, active buyers} &  & 0.190 &  & 16.7\% &  & 15.6\% \\
- Line 16, : 4. & \multicolumn{2}{l}{total profit, low-$\xi$ suppliers} &  & 0.024 &  & -0.3\% &  & 24.5\% \\
- Line 17, : 5. & \multicolumn{2}{l}{total profit, high-$\xi$ suppliers} &  & 0.117 &  & -1.4\% &  & -7.8\% \\
- Line 18, : 6. & \multicolumn{2}{l}{total profit, buyers} &  & 0.270 &  & 0.6\% &  & 1.2\% \\
- Line 19, : 7. & \multicolumn{2}{l}{total search costs, low-$\xi$ suppliers} &  & 0.010 &  & 0.1\% &  & 24.2\% \\
- Line 20, : 8. & \multicolumn{2}{l}{total search costs, high-$\xi$ suppliers} &  & 0.056 &  & 4.0\% &  & -4.9\% \\
- Line 21, : 9. & \multicolumn{2}{l}{total search costs, buyers} &  & 0.046 &  & -14.8\% &  & -4.8\% \\
- Line 22, : 10. & \multicolumn{2}{l}{number of suppliers per buyer} &  & 1.695 &  & 11.3\% &  & 17.9\% \\
- Line 23, : 11. & \multicolumn{2}{l}{high-$\xi$ suppliers per buyer} &  & 0.581 &  & 11.7\% &  & -6.8\% \\
- Line 24, : 12. & \multicolumn{2}{l}{consumer welfare} &  & 1.000 &  & 8.0\% &  & 7.1\% \\

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/define_parameters.m**

- Line 13, : % gam = 2.346;
- Line 26, : %delta = 0.774 - delta_B - delta_S;
- Line 60, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/AAR/estimation/run_estimation.m**

- Line 82, : ejtx_cost_share_expenditure = 0.064;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/start_estimation_ga.m**

- Line 36, : %x0 = [0.00956146005090706	0.330189801449791	0.219604830598328	0.0303997761931385	0.453161553841973	7.32780844275308	4.14599033418063	2.43134077299700	0.553993967511284]';
- Line 37, : % fval 10462.1507632021
- Line 40, : %x0 = [0.00899253936128899	0.331315431963304	0.258451583001122	0.0303800065325126	0.457368466866821	7.06968637695934	4.44036030268518	2.44296872665957	0.554466532366635 ];
- Line 41, : %% fval 10482.5098202313 (with extra moments)
- Line 44, : x0 = [0.00800149670142449	0.311412680597366	0.176627736944740	0.0306233133085443	0.457037217583970	7.12118405670129	4.49554048853843	2.43536849736572	0.563213343051187];
- Line 45, : % fval 10672.6246332165 (with extra moments) 10657.57747 (without)

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/Stata_LFTTD_code/04_lfttd_dist_NumBuyer_per_seller.do**

- Line 146, : // round to 0.0001
- Line 147, : replace Percent = round(Percent,0.0001)
- Line 188, : // round to 0.0001
- Line 189, : replace Percent = round(Percent,0.0001)
- Line 229, : // round to 0.0001
- Line 230, : replace Percent = round(Percent,0.0001)
- Line 268, : // round to 0.0001
- Line 269, : replace Percent = round(Percent,0.0001)

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_no_NsNb_target/define_parameters.m**

- Line 13, : % gam = 2.346;
- Line 26, : delta = 0.774 - delta_B - delta_S;
- Line 60, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/data_moments_baseline.m**

- Line 8, : degSPB = [0.407
- Line 9, : 0.554
- Line 10, : 0.645
- Line 11, : 0.709
- Line 12, : 0.743
- Line 13, : 0.780
- Line 14, : 0.808
- Line 15, : 0.823
- Line 16, : 0.837
- Line 17, : 0.855
- Line 18, : 0.865
- Line 19, : 0.876
- Line 20, : 0.882
- Line 21, : 0.892
- Line 22, : 0.900
- Line 23, : 0.907
- Line 24, : 0.912
- Line 25, : 0.917
- Line 26, : 0.921
- Line 27, : 0.925]';
- Line 29, : degBPS = [0.798
- Line 30, : 0.911
- Line 31, : 0.951
- Line 32, : 0.970
- Line 33, : 0.980
- Line 34, : 0.987
- Line 35, : 0.991
- Line 36, : 0.993
- Line 37, : 0.995
- Line 38, : 0.996
- Line 39, : 0.997
- Line 40, : 0.998
- Line 41, : 0.998
- Line 42, : 0.999
- Line 43, : 0.999
- Line 44, : 0.999
- Line 45, : 0.999
- Line 46, : 0.999
- Line 47, : 0.999
- Line 48, : 1.000]';
- Line 69, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 70, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 71, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 72, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 73, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 74, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 75, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 76, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 77, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 78, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 87, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 88, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 89, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 90, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 91, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 92, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 93, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 94, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 95, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 96, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 133, : data_interm_sh = 0.7308;
- Line 134, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/main_no_gamma.m**

- Line 39, : %x0 = [0.0305728220723054 0 0.00489830177817786 0.0142304035075620 0.0506115073452684 4.06143374246236 42.5037888978692 1.92208400334610	0.153856847595365 0.213761866989002]';
- Line 40, : % (new) fval = 18702.2682003173 (old) fval = 18630.46223
- Line 43, : x0 = [0.00669 0 0.00183 0.03431 0.05356 5.48040 8.56411 1.86338 0.04029 0.00198]';
- Line 44, : %% (new) fval = 19841.27419 (old) fval = 18956.21169

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/define_parameters.m**

- Line 17, : delta = 0.774 - delta_B - delta_S;
- Line 38, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/define_parameters.m**

- Line 38, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_no_NsNb_target/data_moments_baseline.m**

- Line 85, : [0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
- Line 86, : 0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
- Line 87, : 0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
- Line 88, : 0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
- Line 89, : 0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
- Line 90, : 0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
- Line 91, : 0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
- Line 92, : 0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
- Line 93, : 0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
- Line 94, : 0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];
- Line 102, : [0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
- Line 103, : 0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
- Line 104, : 0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
- Line 105, : 0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
- Line 106, : 0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
- Line 107, : 0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
- Line 108, : 0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
- Line 109, : 0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
- Line 110, : 0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
- Line 111, : 0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];
- Line 123, : data_interm_sh = 0.7308;
- Line 124, : var_interm_sh  = 0.00203^2; % previously 0.0029^2;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/summary_ss.m**

- Line 174, : spb0, s2pb0, 1.000];

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/std_errors.m**

- Line 7, : % x = [0.0208235156070959,0.533836940132876,2.58302378926168e-05,0.0306054114966558,...
- Line 8, : %      20.8543850811222,0.389585504781911,3.01447950461815];

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/mechanical_model/start_mechanical.m**

- Line 34, : si_in = [5.30475970194135	2.54322006301519	0.348565315964827 ...
- Line 35, : 0.369505098908116	9.35562288711672	0.441813632503381 ...
- Line 36, : 7.87504269207164	0.340689355526077	22.9491963021357 ...
- Line 37, : 28.2005129010624	2.66627677681297	1.98610727953777 ...
- Line 38, : 0.517564937662059	0.367303303415852	0.321406045111434 ...
- Line 39, : 0.300434151091727	0.385153971571320	0.332210230982581 ...
- Line 40, : 2.00214162149974	0.319917507402888	2.16833653770023 ...
- Line 41, : 0.354051646421266	0.892034393568599	0.377314705140029 ...
- Line 42, : 2.19396527483993	0.335786031814243	0.336829230525515 ...
- Line 43, : 0.305377065853247	0.358834912727211	0.405293209243906 ...
- Line 44, : 1.30757293276676	14.2853658011404	0.0373113278254231 ...
- Line 45, : 8.71516134851435];
- Line 46, : %fval_ga = 6643.75311595123
- Line 90, : lb=ones(1,D)*0.0001;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/define_parameters.m**

- Line 38, : dt = 0.015;

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/solve_model.m**

- Line 279, : target = 0.774 - (delta_S + delta_B);

**/Users/florianoswald/actions-runner/_work/JPE-Jinkins-20220045/JPE-Jinkins-20220045/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/transition_dynamics.m**

- Line 65, : w2_x1 = (NsT*w2_xT - E1*0.015)/Ns1;  %w2_xT = 0.0304

