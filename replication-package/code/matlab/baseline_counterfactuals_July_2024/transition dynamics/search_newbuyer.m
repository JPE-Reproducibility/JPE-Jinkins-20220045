%% seller's search decision for new matches
function [u1,u2,Cs1,Cs2]=search_newbuyer(EVs1,EVs2,thetas,param,param_fix)

% Fixed Parameters
N = param_fix{3};

% Model Parameters
cs0 = param{3};
cs1 = param{4};
gamS = param{6};
netS=(1:1:N+1)'.^gamS; 

    %% search intensities   
    u1=((netS.*EVs1*thetas)./(cs0*cs1) + 1).^(1/(cs1-1)) - 1; % type 1 seller search function   
    u2=((netS.*EVs2*thetas)./(cs0*cs1) + 1).^(1/(cs1-1)) - 1; % type 2 seller search function 
    %%largest status no search
    u1(end)=0; u2(end)=0;
    
  % cost of search    
    nbuy = (1:1:N+1)';
    netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
    Cs1 = cs0*((1+u1).^cs1 - (1+cs1*u1))./netS;
    Cs2 = cs0*((1+u2).^cs1 - (1+cs1*u2))./netS;    
end
