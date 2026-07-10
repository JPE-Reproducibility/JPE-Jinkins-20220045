%% Define Fixed Parameters

%Start by bounding state space - maximum number of connections
N1=45;    % max number of low type sellers
N2=5;     % max number of high type sellers
N=N1+N2;  % max number of buyers 
Nx=30;    % number of types of buyers to approximate log-normal -- reduce to 20 to save computational burden


%Payoff function
% gam = 3.68;   %corresponds to eta in the paper (draft v20)
% gam = 2.67; 
% gam = 2.346;
% gam = 2.42; % For this run, let gam be an estimated parameter
alp = 4.35;

% profit split under equal bargaining weights/constant share approximation
% we don't use them anymore
% kappa = 1/(1+(gam-1)/(alp-1));  %see note model_writeup on Overleaf
% kap_s = (1/(alp-1))*(gam/(gam-1))^(-gam); % see note model_writeup on Overleaf

%discounting rate and exogenous destruction rate
rho=0.05;
delta_B = 0.07;  % should be updated
delta_S = 0.15;  % should be updated
delta = 0.774 - delta_B - delta_S;

% %% Type of buyers and sellers, now need to be jointly estimated
% %weights for types of buyers
% quantile=NaN(1,Nx);
% for i=1:Nx
%     quantile(i)=(2*i-1)/(2*Nx); %Evenly split the interval [1/(2*Nx),(2*Nx - 1)/(2*Nx)]
% end
wt_x=ones(1,Nx)/Nx; %equal size of each type 
% logn_param_1 = 0; %underlying normal mean 
% logn_param_2 = sqrt(0.3); %sqrt(underlying normal variance) -- var(mu) in text (v20)
% profx=icdf('logn',quantile,logn_param_1,logn_param_2); 
% profx=profx.^(gam - 1);  % JT: type-specific buyer profit scaling factor
% 
% %types of sellers
% c1 =1;  %normalized to 1
% c2 = 0.5;

%% Auxiliary parameters for computation and moment construction
% Maximum distance off diagonal of transition matricies to target
Mmax = 4; % Must be < 1/2 dimension of matrix.

%weighting matrix for MSM estimator
wgt_mat = 1; % set =1 for inverse of cov. matrix, set=0 for identity matrix

%update weights
wt_old=0.8;  % weight on previous theta for updating algorithm

%% Parameters for simulation size and burin-in
N_sim=5000;   % N_simB and N_simS
I_sim = 5000; % I_simB and N_simS
I_simBurn = 1000;

% discretized time increment
dt = 0.015; 

%% save all fixed parameters in cell variable
param_fix = cell(23,1);
param_fix{1} = N1;
param_fix{2} = N2;
param_fix{3} = N; 
param_fix{4} = Nx;
param_fix{5} = 1;  %switch for base case vs. counterfactual;

param_fix{6} = rho;
param_fix{7} = alp;
% param_fix{8} = gam;
% param_fix{9} = kappa;

param_fix{10} = delta_B;
param_fix{11} = delta_S;
param_fix{12} = delta;

%param_fix{13} = profx;
%param_fix{14} = wt_x;
%param_fix{15} = c1;
%param_fix{16} = c2;
param_fix{13} = wt_old;
param_fix{14} = wt_x;
param_fix{15} = Mmax;
% param_fix{16} = kap_s;

param_fix{17} = wgt_mat;

param_fix{18} = N_sim; 
param_fix{19} = I_sim; 
param_fix{20} = I_simBurn;
param_fix{21} = dt; 















