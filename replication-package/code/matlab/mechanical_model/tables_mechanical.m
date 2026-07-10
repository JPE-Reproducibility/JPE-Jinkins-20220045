
function [Degree_dist_table,Transmat_table,NS_NB_table ] = ...
    tables_mechanical(si,x,param_indx,param_state,param_fix)

    %Define structural parameters
%% cost parameter of buyer search and seller search
%simple quadratic

[thetas,thetab,U1,U2,V,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,Cs,mMb,msb]=...
    solve_model_mechanical(si,x,param_indx,param_state,param_fix);

param = x2param(x);

data_moments_mechanical;
sim_moments_mechanical;

wgt_mat = cell2mat(param_fix(18));
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

out = (data_moments - model_moments)'*W*(data_moments - model_moments);


coefvec = cell2mat(param);
fprintf('\r\n')
    fprintf('\r\n PARAMETER ESTIMATES: ');  
    fprintf('\r\n buyer search cost scalar     = %.4f\n',coefvec(1));
    fprintf(' buyer search cost exponent   = %.4f\n',coefvec(2));
    fprintf(' seller search cost scalar    = %.4f\n',coefvec(3));
    fprintf(' seller search cost exponent  = %.4f\n',coefvec(4));
    fprintf(' buyer network parameter      = %.4f\n',coefvec(5));
    fprintf(' seller network parameter     = %.4f\n',coefvec(6));
    fprintf(' share of high-type sellers   = %.4f\n',coefvec(7));
    fprintf(' intercept parameter, compat. = %.4f\n',coefvec(8));
    fprintf(' slope parameter, compat.     = %.4f\n',coefvec(9));
    

fprintf('\r\n OBJECTIVE FUNCTION = %.5f\n',out);  
  

moms_compare = [data_moments model_moments];

param_names3 = [];
param_names4 = [];

for i=1:Ncat
    if i <= Mmax 
      lb = 1; 
      ub = i + Mmax;
    elseif i> Mmax && i < Ncat - Mmax
      lb = i - Mmax; 
      ub = i + Mmax;
    elseif i >= Ncat - Mmax
      lb = i - Mmax; 
      ub = Ncat;
    end
    
    tmp_ndx = lb:ub;
    tmp_str = string(lb:ub);
    
    for j=lb:ub
      param_names3 = [param_names3,strcat('TransTB_',string(i),'_',string(j))];
      param_names4 = [param_names4,strcat('TransTS_',string(i),'_',string(j))];
    end
end
param_names3 = param_names3';
param_names4 =  param_names4';

 param_names1 = {'cdf_SPB1 ','cdf_SPB2 ','cdf_SPB3 ','cdf_SPB4 ','cdf_SPB5 ','cdf_SPB10 ','cdf_SPB15 '}';   
 param_names2 = {'cdf_BPS1 ','cdf_BPS2 ','cdf_BPS3 ','cdf_BPS4 ','cdf_BPS5 ','cdf_BPS10 ','cdf_BPS15 '}';
 param_names5 = {'concen1 ','concen2 ','concen3 ','concen4 '}';     
 param_names6 = {'active sellers per buyer '};     

 data_moms1 = moms_compare(1:7,1);
 data_moms2 = moms_compare(8:14,1);
 NN1 = size(data_moms1,1) + size(data_moms2,1);
 NN2 = length(param_names3);
 data_moms3 = moms_compare(NN1+1:NN1+NN2,1);
 data_moms4 = moms_compare(NN1+ NN2+1:NN1+2*NN2,1);
% data_moms5 = moms_compare(NN1+2*NN2+1:NN1+2*NN2+4,1); 

 
 sim_moms1 = moms_compare(1:7,2);
 sim_moms2 = moms_compare(8:14,2);
 sim_moms3 = moms_compare(NN1+1:NN1+NN2,2);
 sim_moms4 = moms_compare(NN1+ NN2+1:NN1+2*NN2,2);
% sim_moms5 = moms_compare(NN1+2*NN2+1:NN1+2*NN2+4,2); 
 
 % Active sellers per active buyer is computed separately in both scripts.
 data_active_SPB  = NS_NB;
 sim_active_SPB   = model_NS_NB;
 
 
SPB_table     = table(param_names1,data_moms1,sim_moms1);
BPS_table     = table(param_names2,data_moms2,sim_moms2);
TransTB_table = table(param_names3,data_moms3,sim_moms3);
TransTS_table = table(param_names4,data_moms4,sim_moms4);
% Concen_table  = table(param_names5,data_moms5,sim_moms5);
NS_NB_table   = table(param_names6,data_active_SPB ,sim_active_SPB );

% Print the following table when the model has converged.

% fprintf('\r\n  COMPARE DATA-BASED AND SIMULATED MOMENTS ');  
Degree_dist_table   = [SPB_table,BPS_table];
Transmat_table      = [TransTB_table,TransTS_table];
% Seller_concen_table = Concen_table;


end

