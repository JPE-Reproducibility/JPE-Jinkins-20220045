
%% SUMMARY of Steady State

%% 1996
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
nbuyer0=sum(mean(mMb0(2:end,:),2));
[nbuyer0]

%total profit
disp('total net profit seller low type')
tseller10 = sum(sum(mMb0.*(repmat(s1,1,Nx).*net_prof_s10)))/Nx;
[tseller10] 
disp('total net profit seller high type')
tseller20 = sum(sum(mMb0.*(repmat(s2,1,Nx).*net_prof_s20)))/Nx;
[tseller20] 
disp('total net profit buyer')
tbuyer0 = sum(sum(mMb0.*net_prof_b0))/Nx;
[tbuyer0]
disp('double check profit share')
[1/x0(end) tseller10+tseller20+tbuyer0]

%total search cost
disp('search cost for sellers')
type_css0 = [sum(Cs10.*Ms10)*(1-x0(4))*x0(7) sum(Cs20.*Ms20)*x0(4)*x0(7)];
[type_css0]
disp('search cost for buyers')
mCs0 = zeros((N1+1)*(N2+1),Nx);
for b=1:Nx
    mCs0(:,b) = Cs0{b};
end
type_cbs0 = mean(sum(mCs0.*mMb0));
[type_cbs0]

%suppliers per buyer
disp('suppliers per buyer')
spb0 = mean(sum(mMb0(ns>0,:).*repmat(ns(ns>0),1,Nx))./sum(mMb0(ns>0,:)))
disp('high type suppliers per buyer')
s2pb0 = mean(sum(mMb0(ns>0,:).*repmat(s2(ns>0),1,Nx))./sum(mMb0(ns>0,:)))

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
nbuyerT=sum(mean(mMbT(2:end,:),2));
[nbuyerT/nbuyer0-1]

%total profit
disp('total net profit seller low type')
tseller1T = sum(sum(mMbT.*(repmat(s1,1,Nx).*net_prof_s1T)))/Nx;
[tseller1T/tseller10-1]
disp('total net profit seller high type')
tseller2T = sum(sum(mMbT.*(repmat(s2,1,Nx).*net_prof_s2T)))/Nx;
[tseller2T/tseller20-1]
disp('total net profit buyer')
tbuyerT = sum(sum(mMbT.*net_prof_bT))/Nx;
[tbuyerT/tbuyer0-1]
disp('double check profit share')
[1/xT(end) tsellerT+tbuyerT]

%total search cost
disp('search cost for sellers')
type_cssT = [sum(Cs1T.*Ms1T)*(1-xT(4))*xT(7) sum(Cs2T.*Ms2T)*xT(4)*xT(7)];
[type_cssT./type_css0-1]
disp('search cost for buyers')
mCsT = zeros((N1+1)*(N2+1),Nx);
for b=1:Nx
    mCsT(:,b) = CsT{b};
end
type_cbsT = mean(sum(mCsT.*mMbT));
[type_cbsT./type_cbs0-1]

%suppliers per buyer
disp('suppliers per buyer')
spbT = mean(sum(mMbT(ns>0,:).*repmat(ns(ns>0),1,Nx))./sum(mMbT(ns>0,:)));
[spbT/spb0-1]
disp('high type suppliers per buyer')
s2pbT = mean(sum(mMbT(ns>0,:).*repmat(s2(ns>0),1,Nx))./sum(mMbT(ns>0,:)));
[s2pbT/s2pb0-1]

%consumer welfare
disp('consumer welfare change')
(gam-1)*(log(ApT)-log(Ap0))

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
nbuyer1=sum(mean(mMb1(2:end,:),2));
[nbuyer1/nbuyer0-1]

%total profit
disp('total net profit seller low type')
tseller11 = sum(sum(mMb1.*(repmat(s1,1,Nx).*net_prof_s11)))/Nx;
[tseller11/tseller10-1] 
disp('total net profit seller high type')
tseller21 = sum(sum(mMb1.*(repmat(s2,1,Nx).*net_prof_s21)))/Nx;
[tseller21/tseller20-1] 
disp('total net profit buyer')
tbuyer1 = sum(sum(mMb1.*net_prof_b1))/Nx;
[tbuyer1/tbuyer0-1]
disp('double check profit share')
[1/x1(end) tseller11+tseller21+tbuyer1]

%total search cost
disp('search cost for sellers')
type_css1 = [sum(Cs11.*Ms11)*(1-x1(4))*x1(7) sum(Cs21.*Ms21)*x1(4)*x1(7)];
[type_css1./type_css0-1]
disp('search cost for buyers')
mCs1 = zeros((N1+1)*(N2+1),Nx);
for b=1:Nx
    mCs1(:,b) = Cs1{b};
end
type_cbs1 = mean(sum(mCs1.*mMb1));
[type_cbs1./type_cbs0-1]

%suppliers per buyer
disp('suppliers per buyer')
spb1 = mean(sum(mMb1(ns>0,:).*repmat(ns(ns>0),1,Nx))./sum(mMb1(ns>0,:)));
[spb1/spb0-1]
disp('high type suppliers per buyer')
s2pb1 = mean(sum(mMb1(ns>0,:).*repmat(s2(ns>0),1,Nx))./sum(mMb1(ns>0,:)));
[s2pb1/s2pb0-1]

%consumer welfare
disp('consumer welfare change')
(gam-1)*(log(Ap1)-log(Ap0))

%% Generate Latex table

% MATLAB Code: Generate LaTeX Table for Counterfactual Results

% Data definitions
row_labels = { ...
    'measure, active low-$\xi$ suppliers', ...
    'measure, active high-$\xi$ suppliers', ...
    'measure, active buyers', ...
    'total profit, low-$\xi$ suppliers', ...
    'total profit, high-$\xi$ suppliers', ...
    'total profit, buyers', ...
    'total search costs, low-$\xi$ suppliers', ...
    'total search costs, high-$\xi$ suppliers', ...
    'total search costs, buyers', ...
    'number of suppliers per buyer', ...
    'high-$\xi$ suppliers per buyer', ...
    'consumer welfare'};

baseline_values = [ ...
    nseller10, nseller20, nbuyer0, ...
    tseller10, tseller20, tbuyer0, ...
    type_css0(1), type_css0(2), type_cbs0, ...
    spb0, s2pb0, 1.000];

changes_2004 = [ ...
    nseller11/nseller10-1, nseller21/nseller20-1, nbuyer1/nbuyer0-1, ...
    tseller11/tseller10-1, tseller21/tseller20-1, tbuyer1/tbuyer0-1, ...
    type_css1(1)/type_css0(1)-1, type_css1(2)/type_css0(2)-1, type_cbs1/type_cbs0-1, ...
    spb1/spb0-1, s2pb1/s2pb0-1, (Ap1/Ap0)^(gam-1)-1]*100;

changes_2011 = [ ...
    nseller1T/nseller10-1, nseller2T/nseller20-1, nbuyerT/nbuyer0-1, ...
    tseller1T/tseller10-1, tseller2T/tseller20-1, tbuyerT/tbuyer0-1, ...
    type_cssT(1)/type_css0(1)-1, type_cssT(2)/type_css0(2)-1, type_cbsT/type_cbs0-1, ...
    spbT/spb0-1, s2pbT/s2pb0-1, (ApT/Ap0)^(gam-1)-1]*100;

% Open file for writing
fileID = fopen('counterfactual_table_2026.tex', 'w');

% Write LaTeX table header
fprintf(fileID, '\\begin{table}[tbp]\n');
fprintf(fileID, '\\caption{Counterfactual: Interpreting market developments}\n');
fprintf(fileID, '\\label{tab:experiments}\\centering\n');
fprintf(fileID, '\\resizebox{\\textwidth}{!} {\n\n');
fprintf(fileID, '\\begin{tabular}{ccccccccc}\n');
fprintf(fileID, '\\hline\\hline\n');
fprintf(fileID, '&  &  &  & Before ATC phaseout &  & Before ATC phaseout &  & After ATC phaseout \\\\\n');
fprintf(fileID, '&  &  &  & $1996$ (high $\\kappa_0$) &  & $2004$ (low $\\kappa_0$) &  & $2011$ (low $\\kappa_0$) \\\\\n');
fprintf(fileID, '\\hline\n');
fprintf(fileID, '&  &  &  & (1) &  & (2) &  & (3) \\\\\n');
fprintf(fileID, '\\hline\n');

% Write table rows
for i = 1:length(row_labels)
    fprintf(fileID, '%d. & \\multicolumn{2}{l}{%s} &  & %.3f &  & %.1f\\%% &  & %.1f\\%% \\\\\n', ...
        i, row_labels{i}, baseline_values(i), changes_2004(i), changes_2011(i));
end

% Write table footer
fprintf(fileID, '\\hline\n');
fprintf(fileID, '\\end{tabular}\n');
fprintf(fileID, '}\n');
fprintf(fileID, '\\begin{tablenotes}\\footnotesize\n');
fprintf(fileID, '\\medskip\n');
fprintf(fileID, '\\item [a] *Baseline figures reflect several normalizations. First, measures of active buyers and suppliers are expressed as shares of the population of potential buyers. Second, surpluses, profits, and search costs are expressed as shares of total consumer expenditures. Finally, baseline consumer welfare is normalized to unity.\n');
fprintf(fileID, '\\end{tablenotes}\n');
fprintf(fileID, '\\end{table}\n');

% Close file
fclose(fileID);

disp('LaTeX table written to counterfactual_table.tex');



