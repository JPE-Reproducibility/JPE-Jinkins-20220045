function [thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Ms1, Ms2, Qbx, QS1, QS2, ...
          net_prof_b, Cs, Cs1, Cs2, net_prof_s1, net_prof_s2] = solve_model(x, param_indx, param_state, param_fix)

%% Fixed Parameters
% Extract fixed parameters from `param_fix`
N1 = param_fix{1};
N2 = param_fix{2};
N = param_fix{3};
Nx = param_fix{4};
alp = param_fix{7};
wt_old = param_fix{13}; 
wt_x = param_fix{14}; % Equal size of each type 

%% Parameters
% Map `x` to model parameters
param = x2param(x);

% Extract specific parameters
w2_x = param{7};        % Probability of better seller type
w1_x = 1 - w2_x;        % Probability of worse seller type
sbarg = param{10};      % Seller bargaining weight
Ns = param{11};
Nstates = (N1 + 1) * (N2 + 1);

% Types of sellers
c1 = 1;  % Normalized to 1
c2 = param{8};

% Types of buyers
var_mu = param{9};

% Cross-store elasticity of substitution
gam = param{12};

% Derived constants
kappa = 1 / (1 + (gam - 1) / (alp - 1));
kap_s = (1 / (alp - 1)) * (gam / (gam - 1))^(-gam);

%% States
s1 = param_state{2};    % # of type 1 sellers, by state
s2 = param_state{3};    % # of type 2 sellers, by state

%% Payoff Definitions
quantile = (2 * (1:Nx) - 1) / (2 * Nx); % Evenly split interval [1/(2*Nx), (2*Nx-1)/(2*Nx)]
logn_param_1 = 0; % Log-normal mean
logn_param_2 = sqrt(var_mu); % Log-normal standard deviation
profx = icdf('logn', quantile, logn_param_1, logn_param_2).^(gam - 1);  

%% Total Surplus and State-specific Calculations
sales = zeros(Nstates, 1);
proft = zeros(Nstates, 1); 
pbs = zeros(Nstates, 1);   % Buyer price index
taus1_app = zeros(Nstates, 1); % Approx. transfer to type 1 sellers
taus2_app = zeros(Nstates, 1); % Approx. transfer to type 2 sellers

for j = 0:N2
    for i = 0:N1
        idx = j * (N1 + 1) + (i + 1);
        aggregate = [i j] * ([c1 c2]'.^(1 - alp));
        
        proft(idx) = (gam^(-gam)) * ((gam - 1)^(gam - 1)) * aggregate^((1 - gam) / (1 - alp));
        sales(idx) = ((gam - 1) / gam)^(gam - 1) * aggregate^((1 - gam) / (1 - alp));
        pbs(idx) = (gam / (gam - 1)) * aggregate^(1 / (1 - alp));  
        
        if i > 0
            taus1_app(idx) = kappa * kap_s * c1^(1 - alp) * aggregate^((1 - gam) / (1 - alp) - 1);
        end 
        if j > 0
            taus2_app(idx) = kappa * kap_s * c2^(1 - alp) * aggregate^((1 - gam) / (1 - alp) - 1);
        end 
    end
end

%% solve precisely using the difference equation

taus1_update= taus1_app;
taus2_update= taus2_app;

taus1 = zeros((N1+1)*(N2+1),1);
taus2 = zeros((N1+1)*(N2+1),1);

iterp =1; 

while norm(taus1-taus1_update)>1e-10||norm(taus2-taus2_update)>1e-10
% disp('iteration')
% [iter]

%make sure taus
taus1 = taus1_update*0.01+taus1*0.99;
taus2 = taus2_update*0.01+taus2*0.99;

%iterate on two types sequentially
for j=0:1:N2 %# of type 2 seller

    for i=0:1:N1 %# of type 1 seller
        if i>0
            taus1_update((j)*(N1+1)+(i+1)) = sbarg * (proft((j)*(N1+1)+(i+1))-proft((j)*(N1+1)+(i))-j*(taus2((j)*(N1+1)+(i+1))-taus2((j)*(N1+1)+i))...
               -(i-1)*((taus1((j)*(N1+1)+(i+1))-taus1((j)*(N1+1)+i))));
        else
            taus1_update((j)*(N1+1)+(i+1)) = 0;
        end 


        if j>0
            taus2_update((j)*(N1+1)+(i+1)) = sbarg * (proft((j)*(N1+1)+(i+1))-proft((j-1)*(N1+1)+(i+1))-(j-1)*(taus2((j)*(N1+1)+(i+1))-taus2((j-1)*(N1+1)+(i+1)))...
               -(i)*((taus1((j)*(N1+1)+(i+1))-taus1((j-1)*(N1+1)+(i+1)))));
        else
            taus2_update((j)*(N1+1)+(i+1)) = 0;
        end 
    end
end

iterp = iterp+1;
    if iterp>500
        break
        disp('WARNING: payoff functions did not converge')
    end
end

%% Save Buyer-Type Specific Problem for Parallel Computation
profxs = cell(Nx, 1);
tauxs1 = cell(Nx, 1);
tauxs2 = cell(Nx, 1);

for b = 1:Nx
    profxs{b} = proft * profx(b); % Adjusted profits for buyer type `b`
    tauxs1{b} = taus1 * profx(b); % Adjusted incremental profits for type 1 sellers
    tauxs2{b} = taus2 * profx(b); % Adjusted incremental profits for type 2 sellers
end

%% Save each type buyer's problem in a cell array, prepare for future parallel
%%%%%save for parallel computing, buyer-type specific
Vbx  = cell(Nx,1);
Qbx  = cell(Nx,1);
Mbx  = cell(Nx,1);
sbx  = cell(Nx,1);
Vs1x = cell(Nx,1);
Vs2x = cell(Nx,1);
Cs   = cell(Nx,1);

%% Iterate on thetab, thetas as outer loop for convergence

%initialize parameters
thetas=0;  
thetab=0; 
thetas_new=0.5; 
thetab_new=0.5;
Ap=1;             %Ap will be loaded with the price index P^(1-gam) 
iter=0;

while norm(thetas_new-thetas)>1e-6||norm(thetab_new-thetab)>1e-6
    iter=iter+1;
    
    thetas=wt_old*thetas + (1-wt_old)*thetas_new;  % JT: update seller match rate
    thetab=wt_old*thetab + (1-wt_old)*thetab_new;  % JT: update buyer match rate

    if iter==1
        thetab1=thetab*w1_x;  
        thetab2=thetab*w2_x;  
    else % JT: use relative search intensities of 2 buyer types if iter > 1
        thetab1=thetab*(U1/(U1+U2)); % JT: buyer match rate for worse sellers 
        thetab2=thetab*(U2/(U1+U2)); % JT: buyer match rate for better sellers
    end
    
    % JT: thetab1 and thetab2 correspond to theta^B*prob(type1) & theta^B*prob(type2)
    
    %% Start the loop for calculating buyer value function
    net_prof_b  = zeros(Nstates,Nx);
    net_prof_s1 = zeros(Nstates,Nx);
    net_prof_s2 = zeros(Nstates,Nx);
    
    
    % JT: each iteration deals with a particular buyer type, given mkt. tightness.
    parfor b=1:Nx  

      % JT: adjust flow payoffs for price deflator and bargaining weights 
        tau1 = tauxs1{b}/Ap;  
        tau2 = tauxs2{b}/Ap;
        prof = profxs{b}/Ap - (s1.*tau1 + s2.*tau2);   
        
        net_prof_b(:,b)  = prof;
        net_prof_s1(:,b) = tau1;
        net_prof_s2(:,b) = tau2;

        % iterate to obtain buyer value, search effort, intensity matrix
        [Vb,Mb,Qb,sb,csb] = val_b(prof,thetab1,thetab2,param,param_indx,param_state,param_fix);
        
        % given buyer search policies, compute seller-match value
        [Vs1,Vs2] = val_s(tau1,tau2,sb,thetab1,thetab2,param_indx,param_state,param_fix);

        Mbx{b}=Mb; % JT: conditional prob. distribution of type b buyers across states (sum(Mb)=1)
        Qbx{b}=Qb; % JT: intensity matrix for type b buyer
        Vbx{b}=Vb; % JT: matrix of value function evaluations for type b buyer
        sbx{b}=sb; % JT: vector of search intensities, type b buyer
        
        Vs1x{b}=Vs1; % JT: value of being matched to type b buyer in all states, type 1 seller
        Vs2x{b}=Vs2; % JT: value of being matched to type b buyer in all states, type 2 seller
        
        Cs{b}  = csb; % JT: search costs (used for diagnostics only)
    end
    
    %% calculate seller's search for new matches

    %value of new matches
    [EVs1,EVs2,msb,mMb] = eval_s(Vs1x,Vs2x,Mbx,sbx,param_fix);
 

    [u1,u2,Cs1,Cs2]=search_newbuyer(EVs1,EVs2,thetas,param,param_fix);
    

    % JT: Ms1 and Ms2 are probability distributions of sellers, given type, across states.
    %Intensity Matrix for Two-types (QS1', QS2' are intensity matrix)
    QS1 = intensity_s(u1,thetas,param_fix);
    QS2 = intensity_s(u2,thetas,param_fix);
    Ms1=(ones((N+1),(N+1))+QS1')\ones((N+1),1);
    Ms2=(ones((N+1),(N+1))+QS2')\ones((N+1),1);
    %correct for small numerical errors
    Ms1=Ms1.*(Ms1>0);
    Ms2=Ms2.*(Ms2>0);

    %now aggregate up to V/U
    V=sum(sum(msb.*mMb.*repmat(wt_x,(N1+1)*(N2+1),1))); % total buyer search (vacancy)
    U1=sum(u1(1:N).*Ms1(1:N)*w1_x)*Ns; % total type 1 seller search, by state   
    U2=sum(u2(1:N).*Ms2(1:N)*w2_x)*Ns; % total type 2 seller search, by state   

    
    X=V*(1-exp(-(U1+U2)/V));
    thetab_new=X/V;       % JT: match rate per effective match seeking buyer
    thetas_new=X/(U1+U2); % JT: match rate per effective match seeking seller
    
    %aggregate up to update price index
    Ap= wt_old*Ap+(1-wt_old)*sum(sum(repmat(pbs.^(1-gam),1,Nx).*mMb.*repmat(profx,(N1+1)*(N2+1),1).*repmat(wt_x,(N1+1)*(N2+1),1)));
    % Ap: State-specific price indices raised to (1-gam), weighted by store 
    % appeal factor raised to (gam-1) and summed over store types and 
    % current states. Consumer price index is Ap^(1/(1-gam))

    if iter>500
        break
        disp('WARNING: solve_model did not converge')
    end
%     [norm(thetas_new-thetas) norm(thetab_new-thetab)]
%     disp('Ap')
%     [Ap]
%  fprintf('\r\n thetas and thetab: %5.3f %5.3f', [thetas thetab]);
end

