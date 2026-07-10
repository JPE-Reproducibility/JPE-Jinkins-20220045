
function [Vs1t,Vs2t] = val_st(tau1,tau2,sb,thetab1,thetab2,Vs1,Vs2,param_indx,param_state,param_fix) 
    
N1 = param_fix{1};
N2 = param_fix{2};
rho =param_fix{6};
dt = param_fix{21}; 

%Construct cont. time intensity matrix
 [Ts1,Ts2] = transition_s(sb,thetab1,thetab2,param_indx,param_state,param_fix);

 %******** compute the value function for t using backward induction
 Vs1t=((rho+1/dt)*eye((N1+1)*(N2+1))-Ts1)\(tau1+1/dt*Vs1);
 Vs2t=((rho+1/dt)*eye((N1+1)*(N2+1))-Ts2)\(tau2+1/dt*Vs2);
            
            
end