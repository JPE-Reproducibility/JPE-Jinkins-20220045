
%% Trump Tariff

%% Clear
clear;

clc;

filename = 'se_results_no_M_target.mat';

scriptDir = fileparts(mfilename('fullpath'));
matlabRoot = char(java.io.File(fullfile(scriptDir, '..', '..')).getCanonicalPath());
filePath = fullfile(matlabRoot, 'baseline_no_NsNb_target', 'results', filename);
load(filePath)

%true parameters, search cost/network buyer/network seller/
%frac. high type/high type seller/type buyer/mass of sellers/elas. of sub.
clearvars -except x;
x = [x, 0, 0];  
xt = x;  xt(end-1) = 0.15; xt(end) = 0;  
gam = x(end-2);

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;


%% Solve the initial steady state

[thetas1,thetab11,thetab21,Ap1,U11,U21,V1,mMb1,Mbx1,Vbx1,sbx1,u11,u21,Vs1x1,Vs2x1,Ms11,Ms21,Qbx1,QS11,QS21,net_prof_b1,cbs1,Cs1,Cs11,Cs21,net_prof_s11,net_prof_s21,~,~,~,pbs1,~]=...
    solve_model(x,param_indx,param_state,param_fix);


%% Solve the model for new steady state under tariff

[thetasT,thetab1T,thetab2T,ApT,U1T,U2T,VT,mMbT,MbxT,VbxT,sbxT,u1T,u2T,Vs1xT,Vs2xT,Ms1T,Ms2T,QbxT,QS1T,QS2T,net_prof_bT,cbsT,CsT,Cs1T,Cs2T,net_prof_s1T,net_prof_s2T,tauxs1,tauxs2,profxs,pbsT,profx]=...
    solve_model_tariff(xt,param_indx,param_state,param_fix);

%% double check

disp('total gross profit')
net_profT = sum((net_prof_bT + repmat(s1,1,Nx).*net_prof_s1T*(1+xt(end-1)) + repmat(s2,1,Nx).*net_prof_s2T*(1+xt(end))).*mMbT);
[mean(net_profT) 1/x(end-2)]

%consumer welfare
disp('consumer welfare change')
(1/(gam-1))*(log(ApT)-log(Ap1))

disp('tariff revenue')
[mean(sum(repmat(s1,1,Nx).*(net_prof_s1T)*xt(end-1).*mMbT))+mean(sum(repmat(s2,1,Nx).*(net_prof_s2T)*xt(end).*mMbT))]

%% summarize the number of sellers for active buyers
type_mMb1 = mMb1(2:end,:)./repmat(sum(mMb1(2:end,:)),size(mMb1(2:end,:),1),1);
type_mMbT = mMbT(2:end,:)./repmat(sum(mMbT(2:end,:)),size(mMbT(2:end,:),1),1);

type_ns1 = sum(repmat(ns(2:end),1,Nx).*type_mMb1);
share_high1 = sum(repmat(s2(2:end)./ns(2:end),1,Nx).*type_mMb1); 

type_nsT = sum(repmat(ns(2:end),1,Nx).*type_mMbT);
share_highT = sum(repmat(s2(2:end)./ns(2:end),1,Nx).*type_mMbT);

%% summarize the rent sharing 
net_prof1 = net_prof_b1 + repmat(s1,1,Nx).*net_prof_s11 + repmat(s2,1,Nx).*net_prof_s21;
type_rent1 =  sum((net_prof_b1(2:end,:)./net_prof1(2:end,:)).*type_mMb1); 

net_profT = net_prof_bT + repmat(s1,1,Nx).*net_prof_s1T + repmat(s2,1,Nx).*net_prof_s2T;
type_rentT =  sum((net_prof_bT(2:end,:)./net_profT(2:end,:)).*type_mMbT); 

%total profit
disp('total net profit seller low type')
tseller11 = mean(sum(mMb1.*(repmat(s1,1,Nx).*net_prof_s11)));
tseller1T = mean(sum(mMbT.*(repmat(s1,1,Nx).*net_prof_s1T)));
disp('total net profit seller high type')
tseller21 = mean(sum(mMb1.*(repmat(s2,1,Nx).*net_prof_s21)));
tseller2T = mean(sum(mMbT.*(repmat(s2,1,Nx).*net_prof_s2T)));
disp('total net profit buyer')
tbuyer1 = mean(sum(mMb1.*net_prof_b1));
tbuyerT = mean(sum(mMbT.*net_prof_bT));

%% summarize the quantity
c11 =1; c1T = (1+xt(9)); c2 = x(5);  
sharex1 = (cbs1.^(1-gam).*mean(repmat(profx,size(mMb1,1),1).*mMb1,2))/sum(cbs1.^(1-gam).*mean(repmat(profx,size(mMb1,1),1).*mMb1,2));
sharexT = (cbsT.^(1-gam).*mean(repmat(profx,size(mMbT,1),1).*mMbT,2))/sum(cbsT.^(1-gam).*mean(repmat(profx,size(mMbT,1),1).*mMbT,2));

%double check
% pbs1(1)=0;
% q_s11 = (gam/(gam-1)*c11)^(-alp)*mean(sum((repmat(s1,1,Nx).*repmat(profx,size(mMb1,1),1).*repmat(pbs1.^(alp-gam),1,Nx).*mMb1)))/Ap1;
% pbsT(1)=0;
% q_s1T = (gam/(gam-1)*c1T)^(-alp)*mean(sum((repmat(s1,1,Nx).*repmat(profx,size(mMb1,1),1).*repmat(pbsT.^(alp-gam),1,Nx).*mMbT)))/ApT;

disp('total quantity seller low type')
x_s11 = sum(s1(2:end).*(c11./cbs1(2:end)).^(1-alp).*sharex1(2:end));
q_s11 = (gam/(gam-1)*c11)^(-1)* x_s11;
x_s1T = sum(s1(2:end).*(c1T./cbsT(2:end)).^(1-alp).*sharexT(2:end));
q_s1T = (gam/(gam-1)*c1T)^(-1)*x_s1T;
disp('total quantity seller high type')
x_s21 = sum(s2(2:end).*(c2./cbs1(2:end)).^(1-alp).*sharex1(2:end));
q_s21 = (gam/(gam-1)*c2)^(-1)*x_s21;
x_s2T = sum(s2(2:end).*(c2./cbsT(2:end)).^(1-alp).*sharexT(2:end));
q_s2T = (gam/(gam-1)*c2)^(-1)*x_s2T;

%% unit value (before tariff) implied
v_s11 = tseller11/q_s11+c11;
v_s1T = tseller1T/q_s1T+c11;

v_s21 = tseller21/q_s21+c2;
v_s2T = tseller2T/q_s2T+c2;

disp('unit value changes')
[log(v_s1T/v_s11)-log(v_s2T/v_s21)]

%% total volume
%disp('trade volume response in long run SS')
%[log((tseller1T+c11*q_s1T)/(tseller11+c11*q_s11))]
disp('trade volume upon impact')
x_s1_impact = sum(s1(2:end).*(c1T./cbsT(2:end)).^(1-alp).*sharex1(2:end));
q_s1_impact = (gam/(gam-1)*c1T)^(-1)* x_s1_impact;
tseller1_impact = mean(sum(mMb1.*(repmat(s1,1,Nx).*net_prof_s1T)));
x_s2_impact = sum(s2(2:end).*(c2./cbsT(2:end)).^(1-alp).*sharex1(2:end));
q_s2_impact = (gam/(gam-1)*c2)^(-1)* x_s2_impact;
tseller2_impact = mean(sum(mMb1.*(repmat(s2,1,Nx).*net_prof_s2T)));
[log((tseller1_impact+c1T*q_s1_impact)/(tseller11+c11*q_s11))-log((tseller2_impact+c2*q_s2_impact)/(tseller21+c2*q_s21))]

%% suppliers per buyer
disp('suppliers per buyer')
spb1 = mean(sum(mMb1(ns>0,:).*repmat(ns(ns>0),1,Nx))./sum(mMb1(ns>0,:)));
spbT = mean(sum(mMbT(ns>0,:).*repmat(ns(ns>0),1,Nx))./sum(mMbT(ns>0,:)));

disp('high type suppliers per buyer')
s2pb1 = mean(sum(mMb1(ns>0,:).*repmat(s2(ns>0),1,Nx))./sum(mMb1(ns>0,:)));
s2pbT = mean(sum(mMbT(ns>0,:).*repmat(s2(ns>0),1,Nx))./sum(mMbT(ns>0,:)));

%% mass of suppliers and buyers
disp('mass of active suppliers low type')
nseller11= x(7)*((1-x(4))*sum(Ms11(2:end)));
nseller1T= x(7)*((1-x(4))*sum(Ms1T(2:end)));
disp('mass of active suppliers high type')
nseller21= x(7)*(x(4)*sum(Ms21(2:end)));
nseller2T= x(7)*(x(4)*sum(Ms2T(2:end)));
disp('mass of active buyers')
nbuyer1=sum(mean(mMb1(2:end,:),2));
nbuyerT=sum(mean(mMbT(2:end,:),2));

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
    'number of suppliers per buyer', ...
    'high-$\xi$ suppliers per buyer', ...
    'consumer welfare'};

changes = [ ...
    nseller1T/nseller11-1, nseller2T/nseller21-1, nbuyerT/nbuyer1-1, ...
    tseller1T/tseller11-1, tseller2T/tseller21-1, tbuyerT/tbuyer1-1, ...
    spbT/spb1-1, s2pbT/s2pb1-1, (ApT/Ap1)^(1/(gam-1))-1]*100;

% Open file for writing
fileID = fopen('counterfactual_tariff_table.tex', 'w');

% Write LaTeX table header
fprintf(fileID, '\\begin{table}[tbp]\n');
fprintf(fileID, '\\caption{Counterfactual: Trump Section 301 Tariff}\n');
fprintf(fileID, '\\label{tab:tariff_experiments}\\centering\n');
fprintf(fileID, '\\resizebox{\\textwidth}{!} {\n\n');
fprintf(fileID, '\\begin{tabular}{ccccc}\n');
fprintf(fileID, '\\hline\\hline\n');
fprintf(fileID, '&  &  &  & Changes after tariff \\\\\n');
fprintf(fileID, '\\hline\n');

% Write table rows
for i = 1:length(row_labels)
    fprintf(fileID, '%d. & \\multicolumn{2}{l}{%s} &  & %.1f\\%% \\\\\n', ...
        i, row_labels{i}, changes(i));
end

% Write table footer
fprintf(fileID, '\\hline\n');
fprintf(fileID, '\\end{tabular}\n');
fprintf(fileID, '}\n');
% fprintf(fileID, '\\begin{tablenotes}\\footnotesize\n');
% fprintf(fileID, '\\medskip\n');
% fprintf(fileID, '\\item [a] *Baseline figures reflect several normalizations. First, measures of active buyers and suppliers are expressed as shares of the population of potential buyers. Second, surpluses, profits, and search costs are expressed as shares of total consumer expenditures. Finally, baseline consumer welfare is normalized to unity.\n');
% fprintf(fileID, '\\end{tablenotes}\n');
fprintf(fileID, '\\end{table}\n');

% Close file
fclose(fileID);

disp('LaTeX table written to counterfactual_tariff_table.tex');

if strcmp(getenv('EJTX_SKIP_TARIFF_TRANSITION'), '1')
    disp('Skipping tariff transition dynamics after Table 7 generation.');
    return
end

%% solve transition dynamics
T = 400;
thetab1_old=linspace(thetab11,thetab1T,T)'; thetab2_old=linspace(thetab21,thetab2T,T)'; thetas_old=linspace(thetas1,thetasT,T)';
Ap_old=linspace(Ap1,ApT,T)';
% 
[Vbx_seq,sbx_seq,Cs_seq,Qbx_seq,Vs1x_seq,Vs2x_seq,Mbx_seq,EVs1_seq,EVs2_seq,u1_seq,u2_seq,QS1_seq,QS2_seq,Ms1_seq,Ms2_seq,Ap_new,thetab1_new,thetab2_new]...
     = solve_tariff_dynamics(x,T,param_indx,param_state,param_fix,thetab1_old,thetab2_old,thetas_old,Ap_old,VbxT,sbxT,CsT,QbxT,Vs1xT,Vs2xT,Mbx1,u11,u21,QS11,QS21,Ms11,Ms21,tauxs1,tauxs2,profxs,pbsT,profx);

%% summarize the active sellers and buyers
Ms1_count = zeros(T,1); Ms2_count = zeros(T,1);
Mb_count = zeros(T,1);
u1t = zeros(T,1); u2t = zeros(T,1); sbt = zeros(T,1); 
x_s1t = zeros(T,1); q_s1t = zeros(T,1); tseller1t = zeros(T,1); x_s2t = zeros(T,1); q_s2t = zeros(T,1); tseller2t = zeros(T,1);

for t=1:T
    Ms1_count(t) = sum(Ms1_seq{t}(2:end));
    Ms2_count(t) = sum(Ms2_seq{t}(2:end));
    u1t(t) = u1_seq{t}'*Ms1_seq{t};
    u2t(t) = u2_seq{t}'*Ms2_seq{t};
    msbx=zeros((N1+1)*(N2+1),Nx); 
    mMbt=zeros((N1+1)*(N2+1),Nx); 
    for b=1:Nx
        mMbt(:,b)=Mbx_seq{t}{b};
        msbx(:,b) = sbx_seq{t}{b};
    end
    Mb_count(t)=sum(mean(mMbt(2:end,:),2)); 
    sbt(t) = sum(mean(mMbt.*msbx,2));  
    
    sharext = (cbsT.^(1-gam).*mean(repmat(profx,size(mMbt,1),1).*mMbt,2))/sum(cbsT.^(1-gam).*mean(repmat(profx,size(mMbt,1),1).*mMbt,2));
    x_s1t(t) = sum(s1(2:end).*(c1T./cbsT(2:end)).^(1-alp).*sharext(2:end));
    q_s1t(t) = (gam/(gam-1)*c1T)^(-1)* x_s1t(t);
    tseller1t(t) = mean(sum(mMbt.*(repmat(s1,1,Nx).*net_prof_s1T*ApT/Ap_new(t))));  %adjust ApT vs Apt
    
    x_s2t(t) = sum(s2(2:end).*(c2./cbsT(2:end)).^(1-alp).*sharext(2:end));
    q_s2t(t) = (gam/(gam-1)*c2)^(-1)* x_s2t(t);
    tseller2t(t) = mean(sum(mMbt.*(repmat(s2,1,Nx).*net_prof_s2T*ApT/Ap_new(t))));
end
DID = [(tseller1t+c11*q_s1t)./(tseller11+c11*q_s11)-(tseller2t+c2*q_s2t)./(tseller21+c2*q_s21)];

% total mass of firms at end
Ns = x(7); w2_x = x(4);
disp('type 1 seller, end of transition vs steady state')
[Ms1_count(end)*Ns*(1-w2_x) sum(Ms1T(2:end))*Ns*(1-w2_x)]
disp('type 2 seller, end of transition vs steady state')
[Ms2_count(end)*Ns*w2_x sum(Ms2T(2:end))*Ns*w2_x]
disp('buyer, end of transition vs steady state')
[Mb_count(end) sum(mean(mMbT(2:end,:),2))]

%% save
% save dynamics_tariff_2025.mat Vbx_seq sbx_seq Cs_seq Qbx_seq Vs1x_seq Vs2x_seq Mbx_seq EVs1_seq EVs2_seq u1_seq u2_seq QS1_seq QS2_seq Ms1_seq Ms2_seq Ap_new
transitionOut = getenv('EJTX_TARIFF_TRANSITION_OUT');
if ~isempty(transitionOut)
    save(transitionOut, 'Vbx_seq', 'sbx_seq', 'Cs_seq', 'Qbx_seq', ...
        'Vs1x_seq', 'Vs2x_seq', 'Mbx_seq', 'EVs1_seq', 'EVs2_seq', ...
        'u1_seq', 'u2_seq', 'QS1_seq', 'QS2_seq', 'Ms1_seq', 'Ms2_seq', ...
        'Ap_new', 'thetab1_new', 'thetab2_new', 'Ms1_count', 'Ms2_count', ...
        'Mb_count', 'DID');
    fprintf('Tariff transition sequence saved to %s\n', transitionOut);
end

%% Summarize welfare and profit along transitional path

%Consumer welfare, accounting for transition path
UT_tr = sum(exp(-rho*dt*(1:T))'.*(Ap_new(1:T).^(1/(gam-1)))*dt) + 1/rho*exp(-rho*(dt*T))*(Ap_new(end).^(1/(gam-1)));
%steady state
UT_ss = 1/rho*(Ap_new(end).^(1/(gam-1)));
U0 = 1/rho*(Ap1.^(1/(gam-1)));

%Figure 1
Year = dt*(1:T);
%Report point estimates each year
%DID_est = [DID(1) DID(round(1/dt)) DID(round(2/dt)) DID(round(3/dt)) DID(round(4/dt))];

figure 
subplot(2,1,1), plot(Year,Ms1_count.*Ns*(1-w2_x),'LineWidth',1.5)
title('Number of Low Quality sellers')
xlabel('periods')
ylabel('mass of firms')

subplot(2,1,2), plot(Year,Ms2_count.*Ns*w2_x,'LineWidth',1.5)
title('Number of High Quality sellers')
xlabel('periods')
ylabel('mass of firms')

saveas(gcf,'figure_1_trump_tariff.png')
close

%Figure 2
figure 
plot(Year,(Ap_new/Ap1).^(1/(gam-1)),'LineWidth',1.5)
title('Aggregate Welfare')
xlabel('periods')
ylabel('welfare')

%set(gca, 'YTick', [0.975 0.98 0.985 0.99 0.995], ...
%         'YTickLabel', {'0.975', '0.98', '0.985', '0.99', '0.995'})

saveas(gcf,'figure_2_trump_tariff.png')
close

%Figure 3
% figure 
% plot(Year,DID,'LineWidth',1.5)
% title('Difference-in-Difference')
% xlabel('periods')
% ylabel('relative change: treatment vs control')
% 
% set(gca, 'YTick', [0.975 0.98 0.985 0.99 0.995], ...
%          'YTickLabel', {'0.975', '0.98', '0.985', '0.99', '0.995'})
% 
% saveas(gcf,'figure_3_trump_tariff.png')
% close
