
function [Vs1,Vs2] = val_s(tau1,tau2,sb,thetab1,thetab2,param,param_indx,param_state,param_fix)
    
N1 = param_fix{1};
N2 = param_fix{2};
rho =param_fix{6};

%Construct cont. time intensity matrix
 [Ts1,Ts2] = transition_s(sb,thetab1,thetab2,param,param_indx,param_state,param_fix);
           
 Vs1=(rho*eye((N1+1)*(N2+1))-Ts1)\tau1;
 Vs2=(rho*eye((N1+1)*(N2+1))-Ts2)\tau2;
            
            
end
