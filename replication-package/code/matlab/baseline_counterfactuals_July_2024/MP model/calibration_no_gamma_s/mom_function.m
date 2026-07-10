function moments = mom_function(x)

%% Define structural parameters
% cost parameter of buyer search and seller search

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

% Run data moments script to generate Nmom, topcat_B, etc.
data_moments_baseline;

%Set the elasticities to be identical
param = x2param(x);
param_fix{7} = param{12}; %within store and across store elasticities are the same

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match,profit_matrix,Ms1,Ms2,QS1,QS2,match_death_reg_coef]=...
    solve_model_no_gamma(x,param_indx,param_state,param_fix);

% save the moments as the target
sim_moments_baseline;

moments = model_moments;
end