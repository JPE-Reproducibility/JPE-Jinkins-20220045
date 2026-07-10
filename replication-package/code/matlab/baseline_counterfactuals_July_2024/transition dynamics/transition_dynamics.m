
%% Solve the transition path from 1996-2004, then 2004-2011

%% Define the length of transition periods for iterations
clear;  clc;  

%search cost trasnition  T~400
%ATC phaseout transition T~500

%% I. Sovle the steady states 2011, 2004, 1996

filename = 'se_results_no_M_target.mat';

% Construct full file path
scriptDir = fileparts(mfilename('fullpath'));
matlabRoot = char(java.io.File(fullfile(scriptDir, '..', '..')).getCanonicalPath());
filePath = fullfile(matlabRoot, 'baseline_no_NsNb_target', 'results', filename);

%% Load Data
% Load the specified .mat file
load(filePath);

% Clear unnecessary variables to maintain a clean workspace
clearvars -except x;

xT = x;
gam = xT(end);

%Define fixed parameters
define_parameters;

%Define the static payoff functions at each state
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Solve the terminal steady state equilibrium objects, 2011
[thetasT,thetab1T,thetab2T,ApT,U1T,U2T,VT,mMbT,MbxT,VbxT,sbxT,u1T,u2T,Vs1xT,Vs2xT,Ms1T,Ms2T,QbxT,QS1T,QS2T,...
    net_prof_bT,CsT,Cs1T,Cs2T,net_prof_s1T,net_prof_s2T,tauxs1,tauxs2,profxs,pbs,profx] = ...
    solve_ss(xT,param_indx,param_state,param_fix);

NsT = xT(7);
w2_xT = xT(4);

%Summarize a few statistics to compare with data
disp('mass of active sellers')
nsellerT= xT(7)*(xT(4)*sum(Ms2T(2:end))+(1-xT(4))*sum(Ms1T(2:end)))
disp('total net profit seller')
tsellerT = sum(sum(mMbT.*(repmat(s1,1,Nx).*net_prof_s1T+repmat(s2,1,Nx).*net_prof_s2T)))/Nx
disp('total net profit buyer')
tbuyerT = sum(sum(mMbT.*net_prof_bT))/Nx
disp('double check profit share')
[1/xT(end) tsellerT+tbuyerT]

%% Solve the interim steady state equilibrium objects, 2004
x1 = xT;

thigh = NsT*w2_xT; thigh1=thigh;

% we now pick Ns1 and w2_x1 jointly to target [#of sellers, sales/seller]

E1 = 1.83;
Ns1 = NsT - E1;  %NsT = 4.2
w2_x1 = (NsT*w2_xT - E1*0.015)/Ns1;  %w2_xT = 0.0304   

%Ns1 = thigh1 + NsT*(1-w2_xT)*0.6;
%w2_x1 = thigh1/Ns1;

x1(7) = Ns1;
x1(4) = w2_x1;

[thetas1,thetab11,thetab21,Ap1,U11,U21,V1,mMb1,Mbx1,Vbx1,sbx1,u11,u21,Vs1x1,Vs2x1,Ms11,Ms21,Qbx1,QS11,QS21,...
    net_prof_b1,Cs1,Cs11,Cs21,net_prof_s11,net_prof_s21,~,~,~,~,~] = ...
    solve_ss(x1,param_indx,param_state,param_fix);

disp('mass of active sellers')
nseller1= Ns1*(w2_x1*sum(Ms21(2:end))+(1-w2_x1)*sum(Ms11(2:end)))
disp('total net profit seller')
tseller1 = sum(sum(mMb1.*(repmat(s1,1,Nx).*net_prof_s11+repmat(s2,1,Nx).*net_prof_s21)))/Nx
disp('total net profit buyer')
tbuyer1 = sum(sum(mMb1.*net_prof_b1))/Nx
disp('double check profit share')
[1/gam tseller1+tbuyer1]

disp('changes in number of sellers, changes in sales per seller')
[nsellerT/nseller1-1 ((1-1/xT(end)+tsellerT)/nsellerT)/((1-1/x1(end)+tseller1)/nseller1)-1]
disp('changes in number of sellers, changes in sales per seller: data')
[123/95-1,(82/123)/(80/95)-1]

%% Solve the initial steady state equilibrium objects, 1996
x0 = x1;
x0(1) = x1(1)*1.65;

[thetas0,thetab10,thetab20,Ap0,U10,U20,V0,mMb0,Mbx0,Vbx0,sbx0,u10,u20,Vs1x0,Vs2x0,Ms10,Ms20,Qbx0,QS10,QS20,...
    net_prof_b0,Cs0,Cs10,Cs20,net_prof_s10,net_prof_s20,~,~,~,~,~] = ...
    solve_ss(x0,param_indx,param_state,param_fix);

disp('mass of active sellers')
nseller0= Ns1*(w2_x1*sum(Ms20(2:end))+(1-w2_x1)*sum(Ms10(2:end)))
disp('total net profit seller')
tseller0 = sum(sum(mMb0.*(repmat(s1,1,Nx).*net_prof_s10+repmat(s2,1,Nx).*net_prof_s20)))/Nx
disp('total net profit buyer')
tbuyer0 = sum(sum(mMb0.*net_prof_b0))/Nx
disp('double check profit share')
[1/gam tseller0+tbuyer0]

disp('changes in number of sellers')
[nseller1/nseller0-1]
disp('changes in number of sellers: data')
[95/80-1]

%% Summarize steady state comparisons
summary_ss;

% %% Solve the transition path from 2004 - 2011
% T = 500;
% thetab1_old=linspace(thetab11,thetab1T,T)'; thetab2_old=linspace(thetab21,thetab2T,T)'; thetas_old=linspace(thetas1,thetasT,T)';
% Ap_old=linspace(Ap1,ApT,T)';
% 
% [Vbx_seq,sbx_seq,Cs_seq,Qbx_seq,Vs1x_seq,Vs2x_seq,Mbx_seq,EVs1_seq,EVs2_seq,u1_seq,u2_seq,QS1_seq,QS2_seq,Ms1_seq,Ms2_seq,Ap_new]...
%     = solve_dynamics(xT,x1,T,param_indx,param_state,param_fix,thetab1_old,thetab2_old,thetas_old,Ap_old,VbxT,sbxT,CsT,QbxT,Vs1xT,Vs2xT,Mbx1,u11,u21,QS11,QS21,Ms11,Ms21,tauxs1,tauxs2,profxs,pbs,profx);
% 
% save dynamics_2004_2011.mat Vbx_seq sbx_seq Cs_seq Qbx_seq Vs1x_seq Vs2x_seq Mbx_seq EVs1_seq EVs2_seq u1_seq u2_seq QS1_seq QS2_seq Ms1_seq Ms2_seq Ap_new
% 
% % summarize the active sellers and buyers
% Ms1_count = zeros(T,1); Ms2_count = zeros(T,1);
% Mb_count = zeros(T,1);
% for t=1:T
%     Ms1_count(t) = sum(Ms1_seq{t}(2:end));
%     Ms2_count(t) = sum(Ms2_seq{t}(2:end));
%     mMb_count=zeros((N1+1)*(N2+1),Nx); 
%     for b=1:Nx
%         mMb_count(:,b)=Mbx_seq{t}{b};
%     end
%     Mb_count(t)=sum(mean(mMb_count(2:end,:),2));   
% end
% % total mass of firms at end
% disp('type 1 seller, end of transition vs steady state')
% [Ms1_count(end)*NsT*(1-w2_xT) sum(Ms1T(2:end))*NsT*(1-w2_xT)]
% disp('type 2 seller, end of transition vs steady state')
% [Ms2_count(end)*NsT*w2_xT sum(Ms2T(2:end))*NsT*w2_xT]
% disp('buyer, end of transition vs steady state')
% [Mb_count(end) sum(mean(mMbT(2:end,:),2))]
% 
% 
% %% Plot and Save all the Figures
% % sequence of potential sellers
% Ns_t = NsT*ones(T,1);
% 
% % Figure 1
% 
% figure 
% subplot(2,1,1), plot(Ms1_count.*Ns_t*(1-w2_xT),'LineWidth',1.5)
% title('Number of Type 1 sellers')
% xlabel('periods')
% ylabel('mass of firms')
% 
% subplot(2,1,2), plot(Ms2_count.*Ns_t*w2_xT,'LineWidth',1.5)
% title('Number of Type 2 sellers')
% xlabel('periods')
% ylabel('mass of firms')
% 
% saveas(gcf,'figure_1_2004_2011.png')
% close
% 
% % Figure 2
% figure
% plot(Mb_count,'LineWidth',1.5)
% title('Number of Buyers')
% xlabel('periods')
% ylabel('mass of firms')
% 
% saveas(gcf,'figure_2_2004_2011.png')
% close
% 
% % Figure 3
% figure 
% plot(Ap_new,'LineWidth',1.5)
% title('Aggregate Welfare')
% xlabel('periods')
% ylabel('welfare')
% 
% saveas(gcf,'figure_3_2004_2011.png')
% close

%% Solve the transition path from 1996 - 2004
%T = 400;

% thetab1_old=linspace(thetab10,thetab11,T)'; thetab2_old=linspace(thetab20,thetab21,T)'; thetas_old=linspace(thetas0,thetas1,T)';
% Ap_old=linspace(Ap0,Ap1,T)';

% [Vbx_seq,sbx_seq,Cs_seq,Qbx_seq,Vs1x_seq,Vs2x_seq,Mbx_seq,EVs1_seq,EVs2_seq,u1_seq,u2_seq,QS1_seq,QS2_seq,Ms1_seq,Ms2_seq,Ap_new]...
%     = solve_dynamics(x1,x0,T,param_indx,param_state,param_fix,thetab1_old,thetab2_old,thetas_old,Ap_old,Vbx1,sbx1,Cs1,Qbx1,Vs1x1,Vs2x1,Mbx0,u10,u20,QS10,QS20,Ms10,Ms20,tauxs1,tauxs2,profxs,pbs,profx);

% % summarize the active sellers and buyers
% Ms1_count = zeros(T,1); Ms2_count = zeros(T,1);
% Mb_count = zeros(T,1);
% for t=1:T
%     Ms1_count(t) = sum(Ms1_seq{t}(2:end));
%     Ms2_count(t) = sum(Ms2_seq{t}(2:end));
%     mMb_count=zeros((N1+1)*(N2+1),Nx); 
%     for b=1:Nx
%         mMb_count(:,b)=Mbx_seq{t}{b};
%     end
%     Mb_count(t)=sum(mean(mMb_count(2:end,:),2));   
% end
% % total mass of firms at end
% disp('type 1 seller, end of transition vs steady state')
% [Ms1_count(end)*Ns1*(1-w2_x1) sum(Ms11(2:end))*Ns1*(1-w2_x1)]
% disp('type 2 seller, end of transition vs steady state')
% [Ms2_count(end)*Ns1*w2_x1 sum(Ms21(2:end))*Ns1*w2_x1]
% disp('buyer, end of transition vs steady state')
% [Mb_count(end) sum(mean(mMb1(2:end,:),2))]


% %% Plot and Save all the Figures
% sequence of potential sellers
% Ns_t = Ns1*ones(T,1);
% 
% % % Figure 1
% 
% figure 
% subplot(2,1,1), plot(Ms1_count.*Ns_t*(1-w2_x1),'LineWidth',1.5)
% title('Number of Low Quality sellers')
% xlabel('periods')
% ylabel('mass of firms')
% 
% subplot(2,1,2), plot(Ms2_count.*Ns_t*w2_x1,'LineWidth',1.5)
% title('Number of High Quality sellers')
% xlabel('periods')
% ylabel('mass of firms')
% 
% saveas(gcf,'figure_1_1996_2004.png')
% close

% % Figure 2
% figure
% plot(Mb_count,'LineWidth',1.5)
% title('Number of Buyers')
% xlabel('periods')
% ylabel('mass of firms')

% saveas(gcf,'figure_2_1996_2004.png')
% close

% % Figure 3
% figure 
% plot((Ap_new/Ap0).^(gam-1),'LineWidth',1.5)
% title('Aggregate Welfare')
% xlabel('periods')
% ylabel('welfare')

% saveas(gcf,'figure_3_1996_2004.png')
% close
