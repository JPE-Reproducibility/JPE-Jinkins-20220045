
function [Vbt,sbt,csbt,Qbt] = val_bt(prof,thetab1,thetab2,Vb,sb,csb,param,param_indx,param_state,param_fix)

% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
rho =param_fix{6};
dt = param_fix{21}; 

% Index Parameters

adds1 = param_indx{11};
adds2 = param_indx{12};
zero1 = param_indx{13};
zero2 = param_indx{14};

% Model Parameters
cb0 = param{1};
cb1 = param{2};
gamB = param{5};

% State Parameters
ns = param_state{1};
netB=(ns+1).^gamB;

%******** use the sb, thetab1, thetatb2 to construct Qb ***********
    Qbt = intensity_b(sb,thetab1,thetab2,param_indx,param_state,param_fix);

%******** compute the value function for t using backward induction
    Vbt = ((rho+1/dt)*eye((N1+1)*(N2+1))-Qbt)\(prof-csb+1/dt*Vb);
% update search effort and cost
    sb=((netB.*(thetab1*(adds1-zero1)*Vbt + thetab2*(adds2-zero2)*Vbt)) ...
                ./(cb0*cb1) + 1).^(1/(cb1-1)) - 1;  
    %protect against numerical error
    sbt=(sb>0).*sb;
    csbt=cb0*((1+sb).^cb1 - (1+cb1*sb))./netB; % search costs 





