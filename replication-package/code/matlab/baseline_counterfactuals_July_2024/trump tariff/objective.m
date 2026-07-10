
function out = objective(x,param_indx,param_state,param_fix,data_moments,cov_v)

try

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,net_prof_b,Cs,Cs1,Cs2,net_prof_s1,net_prof_s2]=...
    solve_model(x,param_indx,param_state,param_fix);
   

% Generate model-based moments (analytical) at current parameter values
sim_moments_baseline;

wgt_mat = param_fix{17};
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

out = (data_moments - model_moments)'*W*(data_moments - model_moments);

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

    fprintf('\r\n EXOGENOUSLY FIXED PARAMETERS:  ');   
    fprintf('\r\n buyer search cost exponent   = %.5f\n',coefvec(2));
    fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
    fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
    fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});


fprintf('\r\n OBJECTIVE FUNCTION = %.5f\n',out);

   fileID1 = fopen('Output/ga_running_output.txt','a');
   
%      fprintf(fileID1,'\n fit metric: ');
%      dlmwrite('Output/ga_running_output.txt',out, '-append','precision',12);
      fprintf(fileID1, '\r\n fit metric: %9.5f',out);
      fprintf(fileID1, '\r\n parameters: ');
      fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(1:6)');
      fprintf(fileID1, '\r\n%9.5f %9.5f %9.5f %9.5f %9.5f %9.5f',x(7:end)');
      fprintf(fileID1, '\r\n  ');   
      
   fclose(fileID1);

catch
    fprintf('\r\nProblem evaluating objective function \r')
    out = 1e+10;
end

plot_fit

 
end

