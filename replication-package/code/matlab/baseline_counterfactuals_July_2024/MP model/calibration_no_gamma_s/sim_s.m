function [cnt_traj,mean_traj,std_traj] = sim_s(stype, ux, thetas, param_fix, param, TT, lambda, phi_scalar)
%% Simulation of number of buyers for each seller type

N = param_fix{3};
delta_B = param_fix{10};
delta_S = param_fix{11};
delta = param_fix{12};
if nargin < 7 || isempty(lambda)
    lambda = param{13};
end
if nargin < 8 || isempty(phi_scalar)
    phi_scalar = 0;
end

N_sim = param_fix{18}; 
I_simS    = param_fix{19}; 
I_simBurn = param_fix{20};

Ns        = param{11};     % JT: # sellers / # buyers
w2_x      = param{7};      % JT: share of high-type sellers

if stype == 1
  N_simS = round((1-w2_x)*N_sim*Ns);  % JT: # type-1 seller simulations
else
  N_simS = round(w2_x*N_sim*Ns);      % JT: # type-2 seller simulations 
end


%matrix to record # of matches
mb=zeros(N_simS,I_simS);
%matrix to record time
mtime=zeros(N_simS,I_simS);
%matrix to record age
ages=zeros(N_simS,I_simS);

%time elasped
% measures age from first match
t_elaps=zeros(N_simS,I_simS);

%random matrix
mrnd=rand(N_simS,I_simS);

   for i=2:1:I_simS
   
   state=mb(:,i-1)+1;
   %birth rate
   brate=ux(state)*thetas;
   brate((state==N+1))=0;
   %death rate includes endogenous destruction λ·φ for this seller type
   drate=mb(:,i-1)*(delta+delta_B+lambda*phi_scalar);
   %reset rate is delta_S
   
   %time
   agg_haz = brate+drate+delta_S;  
   mtime(:,i)=exprnd(1./agg_haz); % JT: draw time to next event from exponential dist.
   reset = (mrnd(:,i)>(brate+drate)./agg_haz); % =1 if event is seller death shock

    
   %event
   %event (add,drop,reset)
   mb(:,i)=mb(:,i-1)+(mrnd(:,i)<=(brate./agg_haz))...
       -(mrnd(:,i)>(brate./agg_haz)&mrnd(:,i)<=(brate+drate)./agg_haz);
   mb(:,i)=mb(:,i).*(1 - reset)+0.*reset; %reset to zero
   
   %record age
   ages(:,i)=(ages(:,i-1)+mtime(:,i)).*(mb(:,i)>0);
   t_elaps(:,i) = t_elaps(:,i-1) + mtime(:,i);
   end

ctime=ages;

%drop burn-in simulations
mb = mb(:,I_simBurn+1:I_simS);
ctime = ctime(:,I_simBurn+1:I_simS);

%%      
        cnt_traj  = zeros(TT,1);  % number of active exporters, age t
        mean_traj = zeros(TT,1);  % age-specific average # matches
        std_traj  = zeros(TT,1);  % age-specific dispersion in # matches
        for tt=1:TT
            cct = ctime<=tt&ctime>tt-1; % find times bewteen tt-1 and t
           % count active buyers, age tt, per yr elaspsed
            cnt_traj(tt) = sum(sum(cct)); 
           
            if (cnt_traj(tt)>0)
            mean_traj(tt) = sum(sum(cct.*mb))./sum(sum(cct));   
            std_traj(tt) =...
                sqrt(sum(sum(cct.*(mb-mean_traj(tt)).^2))/sum(sum(cct))); 
            end
        end
%%    
        
end



