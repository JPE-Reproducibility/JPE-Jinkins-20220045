%% Define Fixed Parameters

%Start by bounding state space - maximum number of connections
N1=45;    % max number of low type sellers
N2=5;     % max number of high type sellers
N=N1+N2;  % max number of buyers 
Nx=30;    % number of types of buyers to approximate log-normal -- reduce to 20 to save computational burden


%Payoff function
alp = 4.35;

%discounting rate and exogenous destruction rate
rho=0.05;
delta_B = 0.07;  % should be updated
delta_S = 0.15;  % should be updated
delta = 0.78 - delta_B - delta_S;

% %% Type of buyers and sellers, now need to be jointly estimated
wt_x=ones(1,Nx)/Nx; %equal size of each type 

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
I_simBurn = 2000;

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

param_fix{13} = wt_old;
param_fix{14} = wt_x;
param_fix{15} = Mmax;
% param_fix{16} = kap_s;

param_fix{17} = wgt_mat;

param_fix{18} = N_sim; 
param_fix{19} = I_sim; 
param_fix{20} = I_simBurn;
param_fix{21} = dt; 















