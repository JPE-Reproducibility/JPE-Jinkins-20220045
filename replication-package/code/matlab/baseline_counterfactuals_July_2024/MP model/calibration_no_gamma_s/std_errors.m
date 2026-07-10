% %This script constructs standard errors for estimated coefficients

% % 1. Find dM/dP, the dependence of moments on parameters
% % 2. Combine to recover standard errors
% % 3. Calculate AGS sensitivity matrix

%% 1. Generate Jacobian

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Define data moments
data_moments_baseline; % get the # moments, Nmom, & moment coviance, cov_v 

wgt_mat = cell2mat(param_fix(17));
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

param_vec     = x(:);
param_vec_new = param_vec;
param_moments = zeros(Nmom,length(x));

pct_del  = 1e-1;   % percentage change in parameters used to calcuate gradients

base_moments = mom_function(param_vec);
NaNmoms = sum(sum(isnan(base_moments)));
if NaNmoms > 0
disp('Missing values in the moment vector: std error calculations doomed');
end

grad_del = pct_del * param_vec; % absolute changes in the size of parameters
dMdP     = zeros(size(param_moments));
NaNflag  = 1;
k        = 1;


 while NaNflag > 0 && k<20
   for loop_ind = 1:length(x)
      if loop_ind ~= 2 %don't waste time on gammaB (will produce NaN)
            param_vec_new = param_vec;
            param_vec_new(loop_ind) = param_vec(loop_ind) + grad_del(loop_ind) * k;      
            param_moments(:,loop_ind) = mom_function(param_vec_new);
            dMdP(:,loop_ind) = (param_moments(:,loop_ind) - base_moments) / (grad_del(loop_ind) * k);
      end
   end
   
   NaNflag = sum(sum(isnan(dMdP)))
   if NaNflag > 0
      display('Forward diffs generate NaN elements of dMdP. Trying smaller diffs');
      dMdP = zeros(size(param_moments));
      k=k+1
   end

 end

% To exclude gammaB from the parameeter vector and gradient matrix:
param_vec = [param_vec(1); param_vec(3:end)];
dMdP = [dMdP(:,1), dMdP(:,3:end)];

G = -dMdP; % just change the notation to fit Joris' note 
%% 2. Construct covariance matrix for parameters and print results table

%%
V_coef      = inv(G' * W * G) * G' * W * cov_v * W * G * inv(G' * W * G);
% param_names = {'cb0 ','cs0 ','gamB','gamS','w2_x','sbarg'}';
param_names = {'cb0','cs0','w2_x','c2','var ln(mu)','Ms/Mb','subs elas','match_scale','F'}';
stderr      = sqrt(diag(V_coef));
z_ratio     = param_vec./stderr;

se_table = table(param_names,param_vec,stderr,z_ratio)

save results/se_results_est_eta

%% 3. calculate AGS sensitivity matrix (needs checking)

AGS_sens = -inv(G' * W * G) * G' * W;
% AGS_elas = AGS_sens .* repmat((W * base_moments)',size(AGS_sens,1),1) ./ repmat(param_vec,1,size(AGS_sens,2));

save results/AGS_sens_est_eta
