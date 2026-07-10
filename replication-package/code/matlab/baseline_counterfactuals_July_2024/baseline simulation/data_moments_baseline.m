
% Calculate Moments and Objective Function

%%1. Buyer/Seller Degree Dist.

%%%Use the value directly from log-log plot

% seller frequency counts, from Xuan electronic ruler, 2011 graph "x-axis log buyers"
Freq_ge_BPS =...
[116926  
23562
10384
5700
3535
2310
1574
1084
800
566
427
321
249
196
157
128
105
87
72
66
56
49
]';

% buyer frequency counts, from Xuan's electronic ruler, 2011 graph "x-axis log sellers"
Freq_ge_SPB =...
[13786 
8180
6143
4900
4012
3550
3027
2640
2434
2242
1996
1864
1714
1627
1492
1384
1287
1207
1143
1082
1034
975
]';

% cumulative probabilities of partner counts

degSPB = cumsum((Freq_ge_SPB(1:end-1)-Freq_ge_SPB(2:end))./Freq_ge_SPB(1));
degBPS = cumsum((Freq_ge_BPS(1:end-1)-Freq_ge_BPS(2:end))./Freq_ge_BPS(1));


cutoffs = [1 2 3 4 5 10 15]; % Choice of cutoffs somewhat arbitrary

cdf_BPS =  degBPS(cutoffs); % data-based fractions of sellers below cutoffs
cdf_SPB =  degSPB(cutoffs); % data-based fractions of buyers below cutoffs

N_S = Freq_ge_BPS(1); % 
N_B = Freq_ge_SPB(1); % 
% N_S = 23562;
% N_B = 8180;

[varF_BPS] = cum_cov(cdf_BPS,N_S);
[varF_SPB] = cum_cov(cdf_SPB,N_B);

var_deg_cdf = blkdiag(varF_SPB, varF_BPS);

%% 2. Transition Matrices 

% #sellers per buyer
data_TB =...
[0.5799	0.2551	0.0869	0.0355	0.0156	0.0086	0.0054	0.0027	0.002	0.0013	0.0065;
0.3441	0.2356	0.1878	0.1014	0.0518	0.0266	0.0162	0.0099	0.0065	0.0041	0.0152;
0.2536	0.1596	0.1788	0.1448	0.092	0.0579	0.034	0.023	0.0159	0.008	0.0324;
0.2064	0.1088	0.1352	0.1421	0.1261	0.0824	0.0597	0.0375	0.0264	0.0171	0.0579;
0.1907	0.074	0.1004	0.1181	0.1158	0.1059	0.0716	0.0608	0.0417	0.0308	0.0896;
0.1685	0.0564	0.0764	0.0904	0.1061	0.1062	0.0914	0.0718	0.0535	0.0447	0.1342;
0.1562	0.045	0.0522	0.0701	0.0885	0.1041	0.0912	0.092	0.0577	0.0557	0.1867;
0.1524	0.0373	0.0498	0.059	0.0734	0.0781	0.0847	0.0778	0.074	0.0631	0.25;
0.1497	0.0252	0.031	0.0417	0.0649	0.0707	0.0807	0.0804	0.0701	0.0653	0.3195;
0.1191	0.0111	0.012	0.0127	0.0156	0.0195	0.0219	0.0245	0.0254	0.0283	0.7091];

%normalize for continuing relationships
data_TB = data_TB(:,2:end)./(repmat(sum(data_TB(:,2:end),2),1,10));
topcat_B = size(data_TB,2);

% #buyers per seller
data_TS = ...
[0.6536	0.2739	0.05	0.0132	0.0048	0.0019	0.0008	0.0005	0.0003	0.0001	0.0005;
0.3213	0.3149	0.2093	0.0866	0.0348	0.0153	0.0071	0.0037	0.002	0.0013	0.003;
0.1902	0.2212	0.2274	0.1693	0.0904	0.0465	0.0233	0.0127	0.0068	0.0041	0.0076;
0.1307	0.1455	0.1828	0.1803	0.1431	0.0917	0.0526	0.0293	0.0165	0.0092	0.0177;
0.0996	0.1006	0.1345	0.1597	0.1564	0.1213	0.0846	0.0535	0.0329	0.0175	0.0386;
0.0807	0.071	0.097	0.1295	0.1394	0.1345	0.1106	0.0837	0.0549	0.0315	0.0668;
0.0737	0.0615	0.0764	0.0934	0.1182	0.1305	0.119	0.0992	0.0675	0.052	0.108;
0.0663	0.0504	0.0538	0.0746	0.0995	0.1088	0.1137	0.1093	0.0904	0.0744	0.1582;
0.0579	0.0452	0.0461	0.059	0.0791	0.086	0.1008	0.1014	0.1023	0.0778	0.2439;
0.0461	0.0296	0.0266	0.0303	0.0366	0.041	0.0485	0.0529	0.0601	0.0628	0.5652];

%normalize for continuing relationships
data_TS = data_TS(:,2:end)./(repmat(sum(data_TS(:,2:end),2),1,10));
topcat_S = size(data_TS,2);

assert(topcat_B == topcat_S)
Ncat = topcat_B;

% Intermediate goods share in total revenues 
% (Based on 2007 and 2012 Census data for retail apparel sector)

data_interm_sh = 0.7308;
var_interm_sh  = 0.00203^2; % previously 0.0029^2; 

%% Targetted partner count moments and their covariance matricies

% variance-covariance matrices for transition moments

Freq_BPS = [Freq_ge_BPS(1:topcat_S-1)-Freq_ge_BPS(2:topcat_S), Freq_ge_BPS(topcat_S)] ;
Freq_SPB = [Freq_ge_SPB(1:topcat_B-1)-Freq_ge_SPB(2:topcat_B), Freq_ge_SPB(topcat_B)] ;

cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions

[Tvar_BPS] = cum_cov(cdf_TS,Freq_BPS);
[Tvar_SPB] = cum_cov(cdf_TB,Freq_SPB);

A_diff = zeros(Ncat);
A_diff(1,1) = 1;
for i =2:Ncat
    A_diff(i,i-1:i)= [-1 1];
end

% First get covariance matrix for all possible transition moments

PsiTrans_allBPS = zeros(Ncat^2);
PsiTrans_allSPB = zeros(Ncat^2);
lb = 0;
ub = 0;
for i=1:Ncat
    lb = ub + 1;
    ub = lb + Ncat-1;
    PsiTrans_allBPS(lb:ub,lb:ub) = A_diff*Tvar_BPS(:,:,i)*A_diff';
    PsiTrans_allSPB(lb:ub,lb:ub) = A_diff*Tvar_SPB(:,:,i)*A_diff';
end

% Caution: This covariance matrix is singlular. Need to drop a row and column
% from each block before using it for estimation.

% Now get covariance matricies for transition rates to closest M categories
                     
  PTran_mSPB    = []; % vector of transition probabilities, sellers per buyer 
  PTran_mBPS    = []; % vector of transition probabilities, buyers per seller
  PsiTrans_mSPB = []; % covariance matrix for sellers per buyer moments
  PsiTrans_mBPS = []; % covariance matrix for buyers per seller moments
  
  lb_cum = 0;
  ub_cum = 0;

  Mmax = param_fix{15}; % Maximum distance off diagonal of targeted moments in 
                     % transition matrices. Must be <= Ncat/2
  
 for i=1:Ncat
    PsiTrans_tempSPB = A_diff*Tvar_SPB(:,:,i)*A_diff'; % var(buyer trans.)
    PsiTrans_tempBPS = A_diff*Tvar_BPS(:,:,i)*A_diff'; % var(seller trans.)
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
      PsiTrans_mSPB = PsiTrans_tempSPB(lb:ub,lb:ub);       
      PsiTrans_mBPS = PsiTrans_tempBPS(lb:ub,lb:ub);   
      PTran_mBPS    = data_TS(1,lb:ub);
      PTran_mSPB    = data_TB(1,lb:ub);
      
  else
    aa = ub-lb+1;
    [bb1,bb2] = size(PsiTrans_mSPB);
    [ss1,ss2] = size(PsiTrans_mBPS);
    
    PsiTrans_mSPB = [[PsiTrans_mSPB, zeros(bb1,aa)];...
        [zeros(aa,bb2),PsiTrans_tempSPB(lb:ub,lb:ub)]]; 
    PsiTrans_mBPS = [[PsiTrans_mBPS, zeros(ss1,aa)];...
        [zeros(aa,ss2),PsiTrans_tempBPS(lb:ub,lb:ub)]];
    
    PTran_mBPS = [PTran_mBPS,data_TS(i,lb:ub)];
    PTran_mSPB = [PTran_mSPB,data_TB(i,lb:ub)];
  end
 end

%  %% summary statistics (for checking only)
%    PTran_mBPS*inv(PsiTrans_mBPS)* PTran_mBPS'
%    PTran_mSPB*inv(PsiTrans_mSPB)* PTran_mSPB' 
%    sum(sum(PsiTrans_mBPS))
%    sum(sum(PsiTrans_mSPB))
 
%% 3. Within buyer concentration 
data_moments_concen = csvread('data_moments_concen.csv',0,0);
data_moments_concen = data_moments_concen(data_moments_concen ~=0);

var_concen = csvread('variance_moments_concen.csv',0,0);
var_concen = diag(var_concen(var_concen ~=0));


%% 4. Sellers per buyer

N_S = Freq_ge_BPS(1); % 
N_B = Freq_ge_SPB(1);  % 

NS_NB = N_S/N_B;
Sprob = N_S/(N_B + N_S);
V_Sprob = Sprob*(1-Sprob)/(N_B + N_S);
var_NS_NB = V_Sprob /((1-Sprob)^4);

%% 5. Consolidate moments and covariances

% consolidate moment vectors
data_moments = [cdf_SPB,cdf_BPS,PTran_mSPB,...
                 PTran_mBPS,data_moments_concen',NS_NB, data_interm_sh]';
Nmom = length(data_moments);
            
% consolidate blocks of covariance matrix
cov_v  = blkdiag(var_deg_cdf, PsiTrans_mSPB, PsiTrans_mBPS, var_concen, var_NS_NB, var_interm_sh);  

