
function out = objective_mechanical(si_in,x,param_indx,param_state,param_fix)

try

si = struct;
si.buyer = si_in(1:30);
si.seller = si_in(31:32);
x(4) = si_in(33); %share of high sellers 
x(7) = si_in(34); %number of sellers relative to buyers

[thetas,thetab,U1,U2,V,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,Cs,mMb,msb]=...
    solve_model_mechanical(si,x,param_indx,param_state,param_fix);

% Generate data-based and model-based moments (analytical)
% define_data_moments_v4;
% sim_moments_v4;
data_moments_mechanical;
sim_moments_mechanical;

% Generate simulated moments for experiments (not needed for estimation)
%sim_moments;
% simulate profits and transfers (not needed for estimation)n
%sim_profits;

wgt_mat = cell2mat(param_fix(18));
if wgt_mat == 1
      W = inv(cov_v);
else
      W = eye(size(data_moments,2)); % use for unweighted estimates
end

out = (data_moments - model_moments)'*W*(data_moments - model_moments);

%% welfare calculation
ns = param_state{1};
N1 = param_fix{1};
N2 = param_fix{2};
gam = param_fix{8};
welfare = welfare_calc(mMb,N1,N2,ns,alp,gam);

%coefvec = cell2mat(param);

%    fprintf('\r\n PARAMETER ESTIMATES: ');  
%    fprintf('\r\n buyer search cost scalar     = %.5f\n',coefvec(1));
%    fprintf(' buyer search cost exponent   = %.5f\n',coefvec(2));
%    fprintf(' seller search cost scalar    = %.5f\n',coefvec(3));
%    fprintf(' seller search cost exponent  = %.5f\n',coefvec(4));
%    fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
%    fprintf(' seller network parameter     = %.5f\n',coefvec(6));
%    fprintf(' share of high-type sellers   = %.5f\n',coefvec(7));
%    fprintf(' intercept parameter, compat. = %.5f\n',coefvec(8));
%    fprintf(' slope parameter, compat.     = %.5f\n',coefvec(9));
%    fprintf(' seller bargaining parameter  = %.5f\n',coefvec(10));
%    fprintf(' seller to buyer ratio        = %.5f\n',coefvec(11));

	% Keep objective evaluation quiet during GA runs to avoid overwhelming
	% terminal buffers. Fit history is still logged to fitlog_mechanical.txt.
	verbose = false;
	if verbose
	    fprintf(' Buyer search params        = %.5f\n',si.buyer);
	    fprintf('\n');
	    fprintf(' Seller search params        = %.5f\n',si.seller);
	    fprintf('\n');
	    fprintf(' Share of high type sellers        = %.5f\n',x(4));
	    fprintf('\n');
	    fprintf(' Relative number of sellers        = %.5f\n',x(7));
	    fprintf('\n');
	    fprintf(' OBJECTIVE FUNCTION = %.5f\n',out);  
	    fprintf('\n');
	    fprintf(' Welfare (no prices) = %.5f\n',welfare);
	end

 fileID1 = fopen('results/fitlog_mechanical.txt','a');
 fprintf(fileID1,'\r\n fit metric:  %9.5f', out);
 fclose(fileID1);

catch ME

    out = 1e9;
    fprintf('objective_mechanical error: %s\n', ME.message);

end

%save('results/se_results_mechanical')

end

