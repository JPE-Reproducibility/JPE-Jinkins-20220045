% %This script constructs standard errors for estimated coefficients

% % 1. Find dM/dP, the dependence of moments on parameters
% % 2. Combine to recover standard errors
% % 3. Calculate AGS sensitivity matrix

% x = [0.0208235156070959,0.533836940132876,2.58302378926168e-05,0.0306054114966558,...
%      20.8543850811222,0.389585504781911,3.01447950461815];
 
%% 1. Generate Jacobian

%define_parameters;


data_moments_baseline; % get the # moments, Nmom, & moment coviance, cov_v 

wgt_mat = cell2mat(param_fix(18));
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end


param_vec     = x;
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
       param_vec_new = param_vec;
       param_vec_new(loop_ind) = param_vec(loop_ind) + grad_del(loop_ind)/k;      
       param_moments(:,loop_ind) = mom_function(param_vec_new);
       dMdP(:,loop_ind) = (param_moments(:,loop_ind) - base_moments) / (grad_del(loop_ind)/k);
   end
   
   NaNflag = sum(sum(isnan(dMdP)))
   if NaNflag > 0
      display('Forward diffs generate NaN elements of dMdP. Trying smaller diffs');
      dMdP = zeros(size(param_moments));
      k=k+1
   end

end

G = -dMdP; % just change the notation to fit Joris' note 
%% 2. Construct covariance matrix for parameters and print results table

%%
V_coef      = inv(G' * W * G) * G' * W * cov_v * W * G * inv(G' * W * G);
% param_names = {'cb0 ','cs0 ','gamB','gamS','w2_x','sbarg'}';
param_names = {'cb0 and cs0','gamB','gamS','w2_x','Delta','var ln(mu)','Ms/Mb','eta'}';
param_vec   = x';
stderr      = sqrt(diag(V_coef));
z_ratio     = param_vec./stderr;

se_table = table(param_names,param_vec,stderr,z_ratio)

save results/se_results_no_M_target

%% 3. calculate AGS sensitivity matrix (needs checking)

AGS_sens = -inv(G' * W * G) * G' * W;
% AGS_elas = AGS_sens .* repmat((W * base_moments)',size(AGS_sens,1),1) ./ repmat(param_vec,1,size(AGS_sens,2));

save results/AGS_sens_no_M_target