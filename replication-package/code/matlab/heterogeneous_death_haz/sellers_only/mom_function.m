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
% data_moments_baseline;
data_moments_hetero;

% [thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,~,~,~,~,~,~]=...
% solve_model(profxs,pbs,tauxs1,tauxs2,x,param_indx,param_state,param_fix);

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,~,~,~,~,~,~,avg_match_death_haz,match_death_reg_coef]=...
    solve_model(x,param_indx,param_state,param_fix);

%sim_moments_baseline;
sim_moments_hetero;
moments = model_moments;
end