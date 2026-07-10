
function out = objective(x,param_indx,param_state,param_fix)

global REPORT_MATCH_SHOCK_STATS
if isempty(REPORT_MATCH_SHOCK_STATS)
    REPORT_MATCH_SHOCK_STATS = false;
end

global GENERATE_FINAL_OUTPUTS
if isempty(GENERATE_FINAL_OUTPUTS)
    GENERATE_FINAL_OUTPUTS = false;
end

%try
param = x2param(x);
param_fix{7} = param{12}; %within store and across store elasticities are the same

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match,profit_matrix,Ms1,Ms2,QS1,QS2,match_death_reg_coef,avg_flow_profit,median_flow_profit]=...
    solve_model_no_gamma(x,param_indx,param_state,param_fix);

% load data moments (need them here for comparison plots
data_moments_baseline;

% save the moments as the target
sim_moments_baseline;

if REPORT_MATCH_SHOCK_STATS
    report_match_shock_stats(phi, uncond_surplus_match, msb, mMb, param_state, param_fix);
end

wgt_mat = param_fix{17};
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

out = (data_moments - model_moments)'*W*(data_moments - model_moments);

% Old objective uses the baseline moment set (includes NS_NB, excludes match-death regression)
if exist('baseline_data_moments','var') && exist('model_moments_old','var') && exist('baseline_cov_v','var')
    if wgt_mat == 1
        W_old = inv(baseline_cov_v);
    else
        W_old = eye(size(baseline_data_moments,1));
    end
    out_old = (baseline_data_moments - model_moments_old)' * W_old * (baseline_data_moments - model_moments_old);
else
    out_old = NaN;
end

coefvec = cell2mat(param);

    fprintf('\r\n PARAMETER ESTIMATES: ');  
    fprintf('\r\n buyer search cost scalar     = %.5f\n',coefvec(1));
    fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));    
    fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
    fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
    fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
    fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
    fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
    fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
    fprintf(' arrival rate of match shocks = %.5f\n',4);
    fprintf(' Match shock scale            = %.5f\n',coefvec(14));
    fprintf(' Fixed cost (frac of tot surp)= %.5f\n',coefvec(15)/median_flow_profit);

    fprintf('\r\n EXOGENOUSLY FIXED PARAMETERS:  ');   
    fprintf('\r\n buyer search cost exponent   = %.5f\n',coefvec(2));
    fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
    fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
    fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});

    fprintf('\r\n ENDOGENOUS VARIABLES:  ');   
    fprintf('\r\nMarket tightness (Theta S)   = %.5f\n',thetas);
    fprintf(' Market tightness (Theta B)   = %.5f\n',thetab);
    fprintf(' active sellers per buyer     = %.5f\n',model_NS_NB);
    fprintf(' seller search high           = %.5f\n',u2(1));
    fprintf(' seller search low            = %.5f\n',u1(1)); 
    fprintf(' buyer average search         = %.5f\n',mean(msb(1,:)));
    fprintf(' match death reg coef         = %.5f\n',match_death_reg_coef);
    
fprintf('\r\n OBJECTIVE FUNCTION = %.5f\n',out);
fprintf('\r\n OLD OBJECTIVE FUNCTION = %.5f\n',out_old);  

   if ~exist('Output','dir')
      mkdir('Output');
   end
   fileID1 = fopen('Output/ga_running_output.txt','a');
   
%      fprintf(fileID1,'\n fit metric: ');
%      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
      fprintf(fileID1, '\r\n fit metric: %9.5f',out);
      fprintf(fileID1, '\r\n parameters: ');
      fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
      fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');
      fprintf(fileID1, '\r\n  ');   
      
   fclose(fileID1);

%catch
%    fprintf('\r\nProblem evaluating objective function \r')
%    out = 1e+10;
% end


 % comparison_plots(...)
 if GENERATE_FINAL_OUTPUTS && isempty(getCurrentTask)
     plot_fit;
     std_errors;
     GENERATE_FINAL_OUTPUTS = false;
 end

end
