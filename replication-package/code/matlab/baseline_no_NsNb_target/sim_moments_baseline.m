
%Moments of Heterogeneous Seller Model, Updated Dec 2023

%% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
N  = param_fix{3};
Nx = param_fix{4};
%Ns = param_fix{5};
rho = param_fix{6};
alp = param_fix{7};
%gam = param_fix{8};
%kappa = param_fix{9};
delta_B = param_fix{10};
delta_S = param_fix{11};
delta = param_fix{12};
wt_old = param_fix{13};
wt_x = param_fix{14};
Mmax = param_fix{15};
%kap_s = param_fix{16};

%% States
ns = param_state{1};
s1 = param_state{2};
s2 = param_state{3};


%% Parameters
param = x2param(x);

w2_x = param{7};        % JT: probability of better seller type
w1_x = 1 - w2_x;        % JT: probability of worse seller type

sbarg   = param{10};    % JT: seller bargaining weight
Ns = param{11};
Nstates = (N1+1)*(N2+1);

%types of sellers
c1 = 1;  %normalized to 1
c2 = param{8};

%types of buyers
var_mu = param{9};

% cross-store elasticity of substitution
gam = param{12};

kappa = 1/(1+(gam-1)/(alp-1));  %see note model_writeup on Overleaf
kap_s = (1/(alp-1))*(gam/(gam-1))^(-gam); % see note model_writeup on Overleaf

%% 1. Degree distributions

%%Cross-sectional Moments
%Sellers per Buyer 
tMb=mean(mMb,2); % Takes equal weights for all buyer types as given
%construct density of seller per buyer
spb_dist=zeros(N1+N2+1,0);
for s=0:1:N1+N2
    spb_dist(s+1,1)=sum(tMb(ns==s));
end
%normalize for all ns>0
spb_cdf=cumsum(spb_dist(2:end)./sum(spb_dist(2:end)));

%Buyers per Seller
tMs=Ms1.*w1_x+Ms2.*w2_x;
bps_dist=tMs;
bps_cdf=cumsum(bps_dist(2:end)./sum(bps_dist(2:end)));

%% 2. Transition Matrix for sellers per buyer

TB=zeros((N1+1)*(N2+1),(N1+1)*(N2+1));
%weight by the prob[type k|state (s1,s2)] to aggregate transition
wt_trb = mMb./repmat(sum(mMb,2),1,Nx);
for b=1:1:Nx
    TB=TB+repmat(wt_trb(:,b),1,(N1+1)*(N2+1)).*expm(Qbx{b});
end
%%%calculate transition based on number of sellers
spb_trans=zeros(N1+N2+1,N1+N2+1);
for s=0:1:N1+N2
    %for all the states ns==s, adjust for their frequency
    TBs=repmat(tMb(ns==s)./sum(tMb(ns==s)),1,(N1+1)*(N2+1)).*TB(ns==s,:);
    for sn=0:1:N1+N2
        TBsn=TBs(:,ns==sn);
    spb_trans(s+1,sn+1)=sum(sum(TBsn));
    end
end
%calculate sum of unconditional prob
tabTSPB=zeros(11,11); tabTSPB(1:10,1:10)=spb_trans(1:10,1:10); 
tabTSPB(1:10,11)=sum(spb_trans(1:10,11:end),2); 
%Pr(n|10+)=\sum_{k>10} Prob(n|k)wt(k|10+)
pwt=spb_dist(11:end)/sum(spb_dist(11:end));
tabTSPB(11,1:10)=pwt'*spb_trans(11:end,1:10); 
tabTSPB(11,11)=1-sum(tabTSPB(11,1:10));

%Transition Matrix for buyers per seller
%weight by the prob[type k|state n]
zflag = Ms1+Ms2 == 0; Ms2(zflag) = 1e-12; % patch needed for older versions of Matlab
wt_trs = [w1_x.*Ms1 w2_x.*Ms2]./repmat(w1_x.*Ms1+w2_x.*Ms2,1,2);
bps_trans=repmat(wt_trs(:,1),1,N+1).*expm(QS1)+repmat(wt_trs(:,2),1,N+1).*expm(QS2);   
%calculate sum of unconditional prob
tabTBPS=zeros(11,11); tabTBPS(1:10,1:10)=bps_trans(1:10,1:10); 
tabTBPS(1:10,11)=sum(bps_trans(1:10,11:end),2); 
%Pr(n|10+)=\sum_{k>10} Prob(n|k)wt(k|10+)
pwt=bps_dist(11:end)/sum(bps_dist(11:end));
tabTBPS(11,1:10)=pwt'*bps_trans(11:end,1:10); 
tabTBPS(11,11)=1-sum(tabTBPS(11,1:10));


%% 2.Within Buyer Concentration. Expand to Buyers with n = 1, 2, ..., N number of sellers
define_payoffs;

%compute the total transfer from buyer to sellers at each state
total_transfer = s1.*taus1 + s2.*taus2 + cost;
%scale up by type
mtotal_transfer = repmat(profx,(N1+1)*(N2+1),1).*repmat(total_transfer,1,Nx);
%low type share
share_1 = (taus1 +tr1.*cost)./total_transfer;
%high type share
share_2 = (taus2 +tr2.*cost)./total_transfer;

%compute the share of the k = 1,2,..,K ranked seller
K = 10;
share_k = zeros((N1+1)*(N2+1),K+1);
for k = 1:K
  %when #of high type larger/equal to k, use high type share
  %otherwise use low type share
  share_k(:,k) = (s2>=k).*share_2 + (s2<k).*share_1;
end

%weighted by mass of buyers at each state
N = 10;
tops=zeros(N,K);
taus_n=zeros(N,1);

for n=1:1:N 
    %given the number of sellers, compute total mass of buyer at each state 
    mass_n = mean(mMb(ns==n,:),2);
    %per seller transfer
    taus_n(n) = sum(sum(log(mtotal_transfer(ns==n,:)./n).*mMb(ns==n,:)))/sum(sum(mMb(ns==n,:)));
    %check share of high type
    %type_n(n) = sum((s1(ns==n)./ns(ns==n)).*mass_n./sum(mass_n));
    for k=1:1:n %kth ranked seller
      tops(n,k) = sum((share_k(ns==n,k).*mass_n)./sum(mass_n));
    end
end

% compute aggregate share of "intermediate input" 
%scale up by type
m_sales = repmat(profx,(N1+1)*(N2+1),1).*repmat(sales,1,Nx);
%sum up across all mass of buyers
model_interm_sh = sum(sum(mMb.*mtotal_transfer))/sum(sum(mMb.*m_sales));

%% 3. Extract all targetted moments and consolidate in a vector

cutoffs = [1 2 3 4 5 10 15]';
%model_moments(1:4) = [spb_reg_coefs;bps_reg_coefs];
model_cdf_moments = [spb_cdf(cutoffs); bps_cdf(cutoffs)];

model_TB = tabTSPB(2:end,:);
model_TB = model_TB(:,2:end)./(repmat(sum(model_TB(:,2:end),2),1,10)); % JT: same

model_TS = tabTBPS(2:end,:);
model_TS = model_TS(:,2:end)./(repmat(sum(model_TS(:,2:end),2),1,10));  % JT same

Ncat = size(model_TB,2);

  model_mTB     = []; % vector of targetted transition probabilities, sellers per buyer 
  model_mTS     = []; % vector of targetted transition probabilities, buyers per seller

  lb_cum = 0;
  ub_cum = 0;
 
 for i=1:Ncat
    if i <= Mmax 
      lb = 1; 
      ub = i + Mmax;
    elseif i> Mmax && i < Ncat - Mmax
      lb = i - Mmax; 
      ub = i + Mmax;
    elseif i >= Ncat - Mmax
      lb = i - Mmax; 
      ub = Ncat;
    end
    
  if i==1
      model_mTB    = model_TB(1,lb:ub)';
      model_mTS    = model_TS(1,lb:ub)';
      
  else 
      model_mTB = [model_mTB;model_TB(i,lb:ub)'];
      model_mTS = [model_mTS;model_TS(i,lb:ub)'];

  end
  
 end

%% Active buyers and sellers

ac_b = sum(mMb(ns>0,:));     % probability that type-b buyers are active
adj_mMb = mMb(ns>0,:)./ac_b; % dist. of buyer types, conditional on being active. 

active_buy = sum(ac_b)/Nx;   % total active buyers
MS1=sum(Ms1(2:N+1)*w1_x)*Ns; % total type 1 seller search, by state   
MS2=sum(Ms2(2:N+1)*w2_x)*Ns; % total type 2 seller search, by state 

model_NS_NB = (MS1+MS2)/active_buy;

%% Concentration of sales within buyers
tops_wo_diag = tril(tops,-1);
model_moments_concen = [taus_n(2:end)-taus_n(1); tops_wo_diag(tops_wo_diag ~= 0 )];  

%%
 
% model_moments = [model_cdf_moments; model_mTB; model_mTS; model_moments_concen; model_NS_NB; model_interm_sh];
% dropping NS_NB:
model_moments = [model_cdf_moments; model_mTB; model_mTS; model_moments_concen; model_interm_sh];

Nmom = length(model_moments);

