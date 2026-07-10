
% MECHANICAL_COUNTERFACTUAL_MAIN
% Solves 1996/2004/2011 steady states for the mechanical model and
% computes the policy-shock-only comparison table used in the appendix.

%% Solve the transition path from 1996-2004, then 2004-2011

%% Define the length of transition periods for iterations
clear;  clc;  T1 = 400; T2 = 500;

%search cost trasnition  T~400
%ATC phaseout transition T~500

%% I. Sovle the steady states 2011, 2004, 1996

%% Load baseline calibration data
baseline_candidates = {
    fullfile('..','baseline_no_NsNb_target','results','se_results_baseline_no_M_target.mat')
    fullfile('..','baseline_no_NsNb_target','results','se_results_no_M_target.mat')
    };

filePath = '';
for k = 1:numel(baseline_candidates)
    if isfile(baseline_candidates{k})
        filePath = baseline_candidates{k};
        break;
    end
end
if isempty(filePath)
    error('Could not find baseline calibration file in ../baseline_no_NsNb_target/results/');
end

load(filePath);

% Clear unnecessary variables to maintain a clean workspace
clearvars -except x;

xT = x;
gam = xT(end);
x_baseline = x;

%% Load best available mechanical estimate
[si_in,best_fval,meta] = load_best_mechanical_estimate();
if isnan(best_fval)
    fprintf('Using mechanical estimate from %s (%s), fval unavailable.\n', ...
        meta.source_type, meta.source_file);
else
    fprintf('Using mechanical estimate from %s (%s), fval=%.4f\n', ...
        meta.source_type, meta.source_file, best_fval);
end

%initial guess
si = struct; %search intensity

si.buyer = si_in(1:30)';
si.seller = si_in(31:32)';
xT(4) = si_in(33); %share of "high type" sellers
xT(7) = si_in(34); %number of sellers relative to buyers

%Define fixed parameters
define_parameters;

%Define the static payoff functions at each state
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Solve the terminal steady state equilibrium objects, 2011
[thetasT,thetab1T,thetab2T,ApT,U1T,U2T,VT,mMbT,MbxT,VbxT,sbxT,u1T,u2T,Vs1xT,Vs2xT,Ms1T,Ms2T,QbxT,QS1T,QS2T,...
    net_prof_bT,CsT,Cs1T,Cs2T,net_prof_s1T,net_prof_s2T,tauxs1,tauxs2,profxs,pbs,profx] = ...
    solve_model_mechanical_cf(si,xT,param_indx,param_state,param_fix);

NsT = xT(7);
w2_xT = xT(4);

%Summarize a few statistics to compare with data
disp('mass of active suppliers')
nsellerT= xT(7)*(xT(4)*sum(Ms2T(2:end))+(1-xT(4))*sum(Ms1T(2:end)))
disp('total net profit seller')
tsellerT = sum(sum(mMbT.*(repmat(s1,1,Nx).*net_prof_s1T+repmat(s2,1,Nx).*net_prof_s2T)))/Nx
disp('total net profit buyer')
tbuyerT = sum(sum(mMbT.*net_prof_bT))/Nx
disp('double check profit share')
[1/xT(end) tsellerT+tbuyerT]

%% Solve the interim steady state equilibrium objects, 2004
x1 = xT;
% Policy-shock experiment mapping:
% 1) Use the baseline transition calibration to infer how potential low/high
%    supplier masses change from 2004 to 2011 (type-specific scale factors).
% 2) Apply those same relative scale factors to the mechanical model's own
%    estimated 2011 potential low/high supplier masses.
% This keeps the policy experiment comparable across models without forcing
% the mechanical model into the baseline's absolute 2004 supplier mass.
E1 = 1.83;
entrant_high_share = 0.015;

NsT_base = x_baseline(7);
w2_xT_base = x_baseline(4);
Ns1_base = NsT_base - E1;
w2_x1_base = (NsT_base*w2_xT_base - E1*entrant_high_share) / Ns1_base;

low_scale = (Ns1_base*(1-w2_x1_base)) / (NsT_base*(1-w2_xT_base));
high_scale = (Ns1_base*w2_x1_base) / (NsT_base*w2_xT_base);

low_mass_T = NsT*(1-w2_xT);
high_mass_T = NsT*w2_xT;
low_mass_2004 = low_scale*low_mass_T;
high_mass_2004 = high_scale*high_mass_T;

Ns1 = low_mass_2004 + high_mass_2004;
w2_x1 = high_mass_2004 / Ns1;

x1(7) = Ns1;   % potential suppliers per buyer in 2004
x1(4) = w2_x1; % high-type supplier share in 2004

[thetas1,thetab11,thetab21,Ap1,U11,U21,V1,mMb1,Mbx1,Vbx1,sbx1,u11,u21,Vs1x1,Vs2x1,Ms11,Ms21,Qbx1,QS11,QS21,...
    net_prof_b1,Cs1,Cs11,Cs21,net_prof_s11,net_prof_s21,~,~,~,~,~] = ...
    solve_model_mechanical_cf(si,x1,param_indx,param_state,param_fix);

%mass of suppliers and buyers
disp('mass of active suppliers')
nseller1= x1(7)*(x1(4)*sum(Ms21(2:end))+(1-x1(4))*sum(Ms11(2:end)));
disp('total net profit seller')
tseller1 = sum(sum(mMb1.*(repmat(s1,1,Nx).*net_prof_s11+repmat(s2,1,Nx).*net_prof_s21)))/Nx
disp('total net profit buyer')
tbuyer1 = sum(sum(mMb1.*net_prof_b1))/Nx
disp('double check profit share')
[1/gam tseller1+tbuyer1]

disp('changes in number of sellers, changes in sales per seller')
[nsellerT/nseller1-1 ((1-1/xT(end)+tsellerT)/nsellerT)/((1-1/x1(end)+tseller1)/nseller1)-1]

%% Solve the initial steady state equilibrium objects, 1996
x0 = x1;
x0(1) = x1(1)*1.8;

[thetas0,thetab10,thetab20,Ap0,U10,U20,V0,mMb0,Mbx0,Vbx0,sbx0,u10,u20,Vs1x0,Vs2x0,Ms10,Ms20,Qbx0,QS10,QS20,...
    net_prof_b0,Cs0,Cs10,Cs20,net_prof_s10,net_prof_s20,~,~,~,~,~] = ...
    solve_model_mechanical_cf(si,x0,param_indx,param_state,param_fix);

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

%% Summarize steady state comparisons
summary_mechanical_policy_shock;
