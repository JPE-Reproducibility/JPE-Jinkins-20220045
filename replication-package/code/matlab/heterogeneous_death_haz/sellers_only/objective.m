
function out = objective(x,param_indx,param_state,param_fix,data_moments,cov_v,data_life)

try

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,net_prof_b,Cs,Cs1,Cs2,net_prof_s1,net_prof_s2,avg_match_death_haz,match_death_reg_coef,delta2]=...
    solve_model(x,param_indx,param_state,param_fix);

% Generate model-based moments (analytical) at current parameter values
sim_moments_hetero;

% For Testing
%sim_seller_matches

wgt_mat = param_fix{17};
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

out = (data_moments - model_moments)'*W*(data_moments - model_moments);
out_old = (data_moments(1:end-2) - model_moments(1:end-2))'*W(1:end-2,1:end-2)*(data_moments(1:end-2) - model_moments(1:end-2));

coefvec = cell2mat(param);

    fprintf('\r\n PARAMETER ESTIMATES: ');  
    fprintf('\r\n buyer search cost scalar     = %.5f\n',coefvec(1));
    fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));    
    fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
    fprintf(' seller network parameter     = %.5f\n',coefvec(6));
    fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
    fprintf(' high type seller cost adv.   = %.5f\n',coefvec(8));
    fprintf(' buyer type dispersion        = %.5f\n',coefvec(9));
    fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));
    fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
    fprintf(' death hazard low type seller = %.5f\n',coefvec(13));
    fprintf(' death hazard high type seller    = %.5f\n',delta2);
    fprintf('\r\n buyer search cost exponent   = %.5f\n',coefvec(2));
    fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));

    fprintf('\r\n EXOGENOUSLY FIXED PARAMETERS:  ');   
    fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
    fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});

        fprintf('\r\n NEW MOMENTS:  ');   
    fprintf(' model avg match death hazard (0.774)  = %.5f\n',avg_match_death_haz);
    fprintf(' model reg: hazard on buyers (-0.0119)= %.5f\n',match_death_reg_coef);

fprintf('\r\n OBJECTIVE FUNCTION = %.5f\n',out);  
fprintf('\r\n OLD OBJECTIVE FUNCTION = %.5f\n',out_old);  

 if ~exist('Output','dir')
    mkdir('Output');
 end
 fileID1 = fopen('Output/fitlog_heterogeneous_death.txt','a');
      fprintf(fileID1,'\r\n fit metric): ');
%     dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
 fclose(fileID1);

fileID2 = fopen('Output/ga_running_output.txt','a');
      fprintf(fileID2, '\r\n fit metric: %9.5f',out);
      fprintf(fileID2, '\r\n parameters: ');
      fprintf(fileID2, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
      fprintf(fileID2, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');
fprintf(fileID2, '\r\n  ');
      
std_errors

catch
    disp('Error in objective.m')
    out = 1e12;
end

