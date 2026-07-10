%Define Fixed Parameters

%Start by bounding state space - maximum number of connections
N1=45;    % JT: max number of low type sellers
N2=5;     % JT: max number of high type sellers
N=N1+N2;  % JT: max number of buyers
% Ns= 8.48; % relative seller to buyer ratio (used to be 1) 
Nx=30;    % number of types of buyers to approximate log-normal

% Maximum distance off diagonal of transition matricies to target
Mmax = 4; % Must be < 1/2 dimension of matrix.

%Payoff function
alp=4.35;
gam=2.389;   % JT: corresponds to eta in the paper (draft v20)

%profit split under equal bargaining weights
% kap=1/(1+(1-gam)/(1-alp));  % JT: no longer used
kap_b = (gam^(-gam))*((gam-1)^(gam-1));   % JT: see note of 3/28/21
kap_s = (1/(alp-1))*(gam/(gam-1))^(-gam); % JT: see note of 3/28/21

%discounting rate and exogenous destruction rate
rho=0.05;
delta_B = 0.07;  % JT: figure doesn't match paper (v20)
delta_S = 0.15;  % JT: figure doesn't match paper (v20)
delta = 0.774 - delta_B - delta_S;

%weighting matrix for MSM estimator
wgt_mat = 1; % set =1 for inverse of cov. matrix, set=0 for identity matrix


%weights for types of buyers
quantile=NaN(1,Nx);
for i=1:Nx
    quantile(i)=(2*i-1)/(2*Nx); %Evenly split the interval [1/(2*Nx),(2*Nx - 1)/(2*Nx)]
end
wt_x=ones(1,Nx)/Nx; %equal size of each type 
logn_param_1 = 0; %underlying normal mean 
logn_param_2 = sqrt(0.7302); %sqrt(underlying normal variance) JT: var(mu) in text (v20)?
profx=icdf('logn',quantile,logn_param_1,logn_param_2); 
profx=profx.^(gam - 1);  % JT: type-specific buyer profit scaling factor

%weights for types of sellers
%w2_x=0.05;w1_x=1-w2_x; 
%seller_type_dist=[w2_x,w1_x]; %choose distribution to match quantile choice
logn_param_1 = 0; %underlying normal mean 
logn_param_2 = sqrt(5.360); %sqrt(underlying normal variance) JT: var(xi) in text (v20)?
quantiles=[0.25,0.75];
seller_type=icdf('logn',quantiles,logn_param_1,logn_param_2);
c1 = 1/seller_type(1); %the worse type  JT: 25th percentile, xi distr.
c2 = 1/seller_type(2); %the better type JT: 25th percentile, xi distr.

%update weights
wt_old=0.8;  % JT: weight on previous theta for updating algorithm

% simulation size and burin-in
N_sim=3000;   % N_simB and N_simS
I_sim = 3000; % I_simB and N_simS
I_simBurn = 1000;

%save fixed parameters in cell variable
param_fix = cell(23,1);
param_fix{1} = N1;
param_fix{2} = N2;
param_fix{3} = N; 
param_fix{4} = Nx;
% param_fix{5} will contain switch for base case vs. counterfactual;

param_fix{6} = rho;
param_fix{7} = alp;
param_fix{8} = gam;
param_fix{9} = kap_b;

param_fix{10} = delta_B;
param_fix{11} = delta_S;
param_fix{12} = delta;

param_fix{13} = profx;
param_fix{14} = wt_x;
param_fix{15} = c1;
param_fix{16} = c2;
param_fix{17} = wt_old;
param_fix{18} = wgt_mat;
param_fix{19} = Mmax;
param_fix{20} = kap_s;

param_fix{21} = N_sim; 
param_fix{22} = I_sim; 
param_fix{23} = I_simBurn;















