function [cnt_traj,mean_traj,std_traj] = sim_b(vx, thetab1, thetab2, param_fix, TT, phi_vector, lambda)

N1 = param_fix{1};
N2 = param_fix{2};

delta_B = param_fix{10}; % buyer death hazard
delta_S = param_fix{11}; % seller death hazard
delta = param_fix{12};   % match death hazard
if nargin < 6 || isempty(phi_vector)
    phi_vector = [0; 0];
end
if nargin < 7 || isempty(lambda)
    lambda = 0;
end
phi_vector = phi_vector(:);
phi_1 = phi_vector(1);
phi_2 = phi_vector(min(2,length(phi_vector)));

% simulate the path for each buyer in stationary equilibrium

N_simB    = param_fix{18};
I_simB    = param_fix{19};
I_simBurn = param_fix{20};

state = ones(N_simB,1);  

%matrix to record # of matches
ms1=zeros(N_simB,I_simB); % # type-1 matches
ms2=zeros(N_simB,I_simB); % # type-2 matches  
ms=zeros(N_simB,I_simB);  % total # matches

%matrix to record time
mtime=zeros(N_simB,I_simB);
%matrix to record age since firms exogenously exit
ageb     = zeros(N_simB,I_simB); % measures from birth of firm
%alt_ageb = zeros(N_simB,I_simB); % measures age from first match
t_elaps  = zeros(N_simB,I_simB);

%random matrix
mrnd=rand(N_simB,I_simB);

for i=2:1: I_simB % JT: i will index events for a given buyer
   
   %birth rate
   brate1=vx(state)*thetab1; % JT: vx is the search policy function
   brate1(ms1(:,i-1)==N1)=0; % JT: can't exceed N1 type-1 sellers
   brate2=vx(state)*thetab2; 
   brate2(ms2(:,i-1)==N2)=0; % JT: can't exceed N2 type-2 sellers
   %death rate (add endogenous λ·φ hazard)
   drate1=ms1(:,i-1)*(delta+delta_S+lambda*phi_1); % JT: death of match or seller, type-1
   drate2=ms2(:,i-1)*(delta+delta_S+lambda*phi_2); % JT: death of match or seller, type-2
   %reset rate is delta_B
   
   %time
   agg_haz = brate1+brate2+drate1+drate2+delta_B;  
   mtime(:,i)=exprnd(1./agg_haz); % JT: draw time to next event from exponential dist.
   reset = (mrnd(:,i)>(brate1+brate2+drate1+drate2)./agg_haz); % =1 if event is buyer death shock

   
   % cumulate events (add1, add2, drop1, drop2, reset)
   ms1(:,i)=ms1(:,i-1)+(mrnd(:,i)<=(brate1./agg_haz)...  
       -(mrnd(:,i)>(brate1+brate2)./agg_haz&mrnd(:,i)<=(brate1+brate2+drate1)./agg_haz));
   ms2(:,i)=ms2(:,i-1)+((mrnd(:,i)<=(brate1+brate2)./agg_haz & mrnd(:,i)>brate1./agg_haz)...
       -(mrnd(:,i)>(brate1+brate2+drate1)./agg_haz & mrnd(:,i)<=(brate1+brate2+drate1+drate2)./agg_haz));
   ms1(:,i)=ms1(:,i).*(1 - reset)+0.*reset; %reset to zero
   ms2(:,i)=ms2(:,i).*(1 - reset)+0.*reset; %reset to zero
   ms(:,i)=ms1(:,i)+ms2(:,i);  % total matches
   
   ageb(:,i)=(ageb(:,i-1)+mtime(:,i)).*(ms(:,i)>0);
   t_elaps(:,i) = t_elaps(:,i-1) + mtime(:,i);
   %update state of each buyer (i.e. index for (s1,s2) pairs)
   state=ms2(:,i)*(N1+1)+(ms1(:,i)+1); 
end

ctime=ageb; % matrix of buyer ages at their event times

% drop burn-ins
ctime = ctime(:,I_simBurn+1:I_simB);
%ms1   = ms1(:,I_simBurn+1:I_simB);  % # type-1 matches
%ms2   = ms2(:,I_simBurn+1:I_simB);  % # type-2 matches  
ms    = ms(:,I_simBurn+1:I_simB);   % total # matches

        cnt_traj  = zeros(TT,1);  % number of active exporters, age t
        mean_traj = zeros(TT,1);  % age-specific average # matches
        std_traj  = zeros(TT,1);  % age-specific dispersion in # matches
        for tt=1:TT
            cct = ctime<=tt&ctime>tt-1; % pick off events for buyers aged tt-1, entire sim. 
            cnt_traj(tt) = sum(sum(cct));
            
            if (cnt_traj(tt)>0)
             mean_traj(tt) = sum(sum(cct.*ms))./sum(sum(cct));              
              % avg # matches among age tt buyers

             std_traj(tt) =...
                sqrt(sum(sum(cct.*(ms-mean_traj(tt)).^2))/sum(sum(cct)));                       
              % std. dev., # matches across age tt buyers
            end
        end
 
