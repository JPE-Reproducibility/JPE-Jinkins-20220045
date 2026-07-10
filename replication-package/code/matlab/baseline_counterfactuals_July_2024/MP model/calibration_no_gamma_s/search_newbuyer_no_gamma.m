%% seller's search decision for new matches
function [u1,u2]=search_newbuyer_no_gamma(EVs1,EVs2,thetas,param,param_fix)

% Fixed Parameters
N = param_fix{3};

% Model Parameters
cs0 = param{3};

    %% search intensities   
    u1=ones(size((1:1:N+1)'))*(EVs1*thetas)./(2*cs0); % type 1 seller search function   
    u2=ones(size((1:1:N+1)'))*(EVs2*thetas)./(2*cs0); % type 2 seller search function 
    %%largest status no search
    u1(end)=0; u2(end)=0;
    
end
