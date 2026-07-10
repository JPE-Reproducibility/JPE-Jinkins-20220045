
function [Vb,Mb,Qb,sb,csb] = val_b(prof,thetab1,thetab2,param,param_indx,param_state,param_fix)

% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
rho =param_fix{6};

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

%******** Value func iteration ***********
 Vb=zeros((N1+1)*(N2+1),1);
 Vbn=prof/rho;
 netB=(ns+1).^gamB; % network effect (denom.) in search cost function

tic
while norm(Vb-Vbn)>1e-6
%   norm(Vb-Vbn)
    Vb=Vbn;
    %Search effort 
    sb=((netB.*(thetab1*(adds1-zero1)*Vb + thetab2*(adds2-zero2)*Vb)) ...
                ./(cb0*cb1) + 1).^(1/(cb1-1)) - 1;       

    %protect against numerical error
    sb=(sb>0).*sb;
    csb=cb0*((1+sb).^cb1 - (1+cb1*sb))./netB; % search costs 
    
    % Construct cont. time intensity matrix
    Qb = intensity_b(sb,thetab1,thetab2,param_indx,param_state,param_fix);
    
    %Update buyer value function % JT: inv(rho*I-Q)*net profits = expected value vector
    Vbn =(rho*eye((N1+1)*(N2+1))-Qb)\(prof-csb);
     
    Vbn=(Vbn>0).*Vbn; % stabilize convergence
    
%         if toc > 60
%            disp("ERROR: buyer value function iteration taking too long")
%            fprintf('norm(Vb-Vbn) = %.6f\n',norm(Vb-Vbn));
%            my_flag = 1;
%            return
%         end     
          
end

Mb=(ones((N1+1)*(N2+1),(N1+1)*(N2+1))+Qb')\ones((N1+1)*(N2+1),1); 
%%%correct for small numerical errors
Mb=Mb.*(Mb>0);

end


