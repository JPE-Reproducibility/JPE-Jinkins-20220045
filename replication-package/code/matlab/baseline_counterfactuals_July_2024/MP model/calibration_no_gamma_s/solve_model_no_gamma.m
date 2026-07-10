function [thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match,profit_matrix,Ms1,Ms2,QS1,QS2,match_death_reg_coef, avg_flow_profit,median_flow_profit] = ...
    solve_model_no_gamma(cand_params,param_indx,param_state,param_fix)

%% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
N = param_fix{3};
Nx = param_fix{4};
alp = param_fix{7};
wt_old = param_fix{13}; 
wt_x=param_fix{14}; %equal size of each type 

%% Parameters
param = x2param(cand_params);

w2_x = param{7};        % JT: probability of better seller type
w1_x = 1 - w2_x;        % JT: probability of worse seller type

sbarg   = param{10};    % JT: buyer bargaining weight
Ns = param{11};
Nstates = (N1+1)*(N2+1);

%types of sellers
c1 = 1;  %normalized to 1
c2 = param{8};

%types of buyers
var_mu = param{9};

% cross-store elasticity of substitution
gam = param{12}; 

% Model Parameters
cb0 = param{1};
cb1 = param{2};
gamB = param{5};
rho = param_fix{6};
delta_B = param_fix{10};
delta_S = param_fix{11};
delta = param_fix{12};

kappa = 1/(1+(gam-1)/(alp-1));            %see note model_writeup on Overleaf
kap_s = (1/(alp-1))*(gam/(gam-1))^(-gam); % see note model_writeup on Overleaf

% Parameters additional for endogenous destruction 
lambda = param{13}; % shock to profit function 
sigma = param{14}; % standard deviation of shock to profit function. For now standard log normal
%pareto_shape = param_fix{22}; 
F = param{15}; % Fixed cost to keep a match alive. 

%% States
s1 = param_state{2};    % # of type 1 sellers, by state
s2 = param_state{3};    % # of type 2 sellers, by state

%% Define payoffs

%% Type of buyers and sellers, now need to be jointly estimated
%weights for types of buyers
quantile=NaN(1,Nx);
for i=1:Nx
    quantile(i)=(2*i-1)/(2*Nx); %Evenly split the interval [1/(2*Nx),(2*Nx - 1)/(2*Nx)]
end
logn_param_1 = 0; %underlying normal mean 
logn_param_2 = sqrt(var_mu); %sqrt(underlying normal variance) -- var(mu) in text (v20)
profx=icdf('logn',quantile,logn_param_1,logn_param_2); 
profx=profx.^(gam - 1);  

%% define the total surplus function (without buyer appeal)
sales=zeros((N1+1)*(N2+1),1);
proft=zeros((N1+1)*(N2+1),1); 
pbs=zeros((N1+1)*(N2+1),1);   % buyer price index at each state

for j=0:1:N2
    for i=0:1:N1
        proft((j)*(N1+1)+(i+1))=(gam^(-gam))*((gam-1)^(gam-1))*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        % sales to be used later
        sales((j)*(N1+1)+(i+1))=((gam-1)/gam)^(gam-1)*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        % construct price index, buyer in state state (i=n1,j=n2)
        pbs((j)*(N1+1)+(i+1)) = (gam/(gam-1))*([i j]*([c1 c2]'.^(1-alp)))^(1/(1-alp));  
    end
end

profxs=cell(Nx,1);

for b=1:1:Nx % add buyer profit scaling factor to profit expression
    profxs{b}=proft*profx(b); % gross profits for buyer type b
end

%% Define the total surplus function for each buyer-seller type 
% We can do this by extracting the relevant values from the total surplus function: i.e. for each buyer type when it had one seller of each type
profit_matrix = zeros(Nx,2); % initialize profit matrix
for j=1:1:2
    if j==1
        val = 2; % row index for having 1 seller of type 1 and 0 seller of type 2
    else
        val = (N1+2); % row index for having 0 seller of type 1 and 1 seller of type 2
    end
    for i=1:1:Nx
        profit_matrix(i,j) = proft(val)*profx(i);
    end
end 

%% Compute the shock cutoffs for each buyer-seller type.
% algebraic solution which David likes!
% determinant = (F./profit_matrix).^2 - 4 * pareto_scale^2 * lambda / (rho + delta + delta_B + delta_S + lambda);
% determinant(determinant < 0) = 0;
% epsilon_cutoffs_matrix = 1/2 * (F./profit_matrix + sqrt(determinant));
% epsilon_cutoffs_matrix(determinant <= 0 | epsilon_cutoffs_matrix <= pareto_scale) = pareto_scale + 1e-12; %no cutoff

% Define the conditional expectation function for LN(0,sigma^2) shocks (Appendix E, eq. A-21)
expected_value_epsilon_greater = @(epsilon, sigma) exp(sigma^2 / 2) .* ...
    normcdf((sigma.^2 - log(epsilon)) ./ sigma) ./ (1 - logncdf(epsilon, 0, sigma));

% Log normal version (mean zero, std dev sigma)
%epsilon_cutoffs_matrix = calculate_epsilon_star(sigma, sbarg, F, lambda, profit_matrix, rho, delta, delta_B, delta_S, expected_value_epsilon_greater);
%epsilon_cutoffs_matrix = ones(size(epsilon_cutoffs_matrix)); %shut down cutoff

% % Plot the surplus values against the cutoffs
% % figure as scatter plot
% fig = figure();
% scatter(log(profit_matrix(:,1)),epsilon_cutoffs_matrix(:,1),'r')
% hold on
% scatter(log(profit_matrix(:,2)),epsilon_cutoffs_matrix(:,2),'b')
% ylabel('Cutoffs')
% xlabel('Log Surplus')
% title('Surplus vs. Cutoff')
% legend('Type 1 Seller','Type 2 Seller')
% hold off
% saveas(fig,"results/epsilon_scatter.png","png")

%% Compute the probability of endogenous destruction for each buyer-seller type.
% phi_ij = F(epsilon_ij) where F is the Pareto CDF
%phi = logncdf(epsilon_cutoffs_matrix,0,sigma);
%phi = zeros(size(phi)); %shut down cutoffs

% print phi to check
%phi

% % Plot the surplus values against the cutoffs
% % figure as scatter plot
% fig = figure();
% scatter(log(profit_matrix(:,1)),phi(:,1),'r')
% hold on
% scatter(log(profit_matrix(:,2)),phi(:,2),'b')
% xlabel('Log Surplus')
% ylabel('Probability endogenous destruction')
% title('Surplus vs. Probability of Endogenous Destruction')
% legend('Type 1 Seller','Type 2 Seller')
% hold off
% saveas(fig,"results/endog_destruction_vs_type_scatter.png","png")

%% Solve the expected match-specific value functions for each buyer-seller type.
% Solve for the expected surplus CONDITIONAL on a positive match, this is simply the discounted flow of profits minus the fixed cost of keeping a match alive. 

% Compute E(e|e>e*)
%cond_surplus_match =  (profit_matrix .* expected_value_epsilon_greater(epsilon_cutoffs_matrix,sigma) - F) ./ (rho + delta + delta_B + delta_S + lambda*phi);
%cond_surplus_match = profit_matrix / (rho + delta + delta_B + delta_S);; %shut down cutoffs
%uncond_surplus_match =  (1 - phi).* cond_surplus_match;
%uncond_surplus_match(uncond_surplus_match<0) = 0;

%% Solve for market tightness
% We will iterate on thetab and thetas until convergence.
% Save some objects for parallel computing, they are buyer-type specific.
Qbx  = cell(Nx,1);
Mbx  = cell(Nx,1);
sbx  = cell(Nx,1);

%initialize parameters
thetas=0;  
thetab=0; 
thetas_new=0.05; 
thetab_new=0.99;
Ap=1;             %Ap will be loaded with the price index P^(1-gam) 
iter=0;
old_delta=0;

while norm(thetas_new-thetas)>1e-6||norm(thetab_new-thetab)>1e-6||norm(old_delta-delta)>1e-6
    iter=iter+1;
    %fprintf('Iter: %d, thetas: %f, thetab: %f\n', iter, thetas, thetab);
    
    thetas=wt_old*thetas + (1-wt_old)*thetas_new;  % JT: update seller match rate
    thetab=wt_old*thetab + (1-wt_old)*thetab_new;  % JT: update buyer match rate

    if iter==1
        thetab1=thetab*w1_x;  
        thetab2=thetab*w2_x;  
    else % JT: use relative search intensities of 2 buyer types if iter > 1
        thetab1=thetab*(U1/(U1+U2)); % JT: buyer match rate for worse sellers 
        thetab2=thetab*(U2/(U1+U2)); % JT: buyer match rate for better sellers
    end

    %% Compute the cutoffs and phi values.
    profit_matrix_scaled = profit_matrix / Ap; % scale profits by price index
    % Compute the cutoffs matrix. Option 1: use non-linear solver. Option 2: Use bisection method.
    epsilon_cutoffs_matrix = calculate_epsilon_star(sigma, sbarg, F, lambda, profit_matrix_scaled, rho, delta, delta_B, delta_S, expected_value_epsilon_greater);
    %[epsilon_cutoffs_matrix] = solve_eps_cutoff(rho, delta, delta_B, delta_S, lambda, F, sigma, sbarg, profit_matrix_scaled);
    % Compute phi_ij 
    phi = logncdf(epsilon_cutoffs_matrix,0,sigma);
    % Compute E(e|e>e*)
    cond_surplus_match =  (profit_matrix_scaled .* expected_value_epsilon_greater(epsilon_cutoffs_matrix,sigma) - F) ./ (rho + delta + delta_B + delta_S + lambda*phi);
    %cond_surplus_match = profit_matrix_scaled / (rho + delta + delta_B + delta_S);; %shut down cutoffs
    uncond_surplus_match =  (1 - phi).* cond_surplus_match;
    uncond_surplus_match(uncond_surplus_match<0) = 0;

    % JT: thetab1 and thetab2 correspond to theta^B*prob(type1) & theta^B*prob(type2)

    % JT: thetab1 and thetab2 correspond to theta^B*prob(type1) & theta^B*prob(type2)

    %% Start the loop for calculating buyer value function
    %net_prof_b  = zeros(Nstates,Nx);
    %net_prof_s1 = zeros(Nstates,Nx);
    %net_prof_s2 = zeros(Nstates,Nx);

    % JT: each iteration deals with a particular buyer type, given mkt. tightness.
    parfor b=1:Nx  
    
        % JT: adjust flow payoffs for price deflator and bargaining weights 
        %tau1 = tauxs1{b}/Ap;  
        %tau2 = tauxs2{b}/Ap;
        %prof = profxs{b}/Ap - (s1.*tau1 + s2.*tau2);   
        
        %net_prof_b(:,b)  = prof;
        %net_prof_s1(:,b) = tau1;
        %net_prof_s2(:,b) = tau2;

        phi_b_1 = phi(b,1); % get the phi values for the buyer type
        phi_b_2 = phi(b,2); % get the phi values for the buyer type
        surp_b_1 = uncond_surplus_match(b,1); % get the surplus values for the buyer type
        surp_b_2 = uncond_surplus_match(b,2); % get the surplus values for the buyer type

        % iterate to obtain buyer value, search effort, intensity matrix
        %Search effort 
        %sb=((netB.*(thetab1*(adds1-zero1)*Vb + thetab2*(adds2-zero2)*Vb)) ...
        %            ./(cb0*cb1) + 1).^(1/(cb1-1)) - 1;  
        
        netB=(s1+s2+1).^gamB; % network effect (denom.) in search cost function
        % iterate to obtain buyer value, search effort, intensity matrix
        %Search effort 
        %%% EDIT NU: sb=((netB.*(thetab1*sbarg*surp_b_1 + thetab2*sbarg*surp_b_2)))/(2*cb0) -1;
        sb = repmat((thetab1*uncond_surplus_match(b,1) + thetab2*uncond_surplus_match(b,2))*sbarg/(2*cb0),(N1+1)*(N2+1),1); % same search intensity no matter the state for each buyer type.

        %protect against numerical error
        sb=(sb>0).*sb;
        %csb=cb0*((1+sb).^cb1 - (1+cb1*sb))./netB; % search costs 

        % Construct cont. time intensity matrix
        Qb = intensity_b_no_gamma(sb,thetab1,thetab2,phi_b_1,phi_b_2,param_indx,param_state,param_fix,lambda);

        % Mass of buyers
        Mb=(ones((N1+1)*(N2+1),(N1+1)*(N2+1))+Qb')\ones((N1+1)*(N2+1),1); 
        %%%correct for small numerical errors
        Mb=Mb.*(Mb>0);

        Mbx{b}=Mb; % JT: conditional prob. distribution of type b buyers across states (sum(Mb)=1)
        Qbx{b}=Qb; % JT: intensity matrix for type b buyer
        %Vbx{b}=Vb; % JT: matrix of value function evaluations for type b buyer
        sbx{b}=sb; % JT: vector of search intensities, type b buyer
        
        %Vs1x{b}=Vs1; % JT: value of being matched to type b buyer in all states, type 1 seller
        %Vs2x{b}=Vs2; % JT: value of being matched to type b buyer in all states, type 2 seller
        
        %Cs{b}  = csb; % JT: search costs (used for diagnostics only)
    end

    %% calculate seller's search for new matches

    msb=zeros((N1+1)*(N2+1),Nx); % JT: ea. column will give search intensities 
    % in all possible states for a partic. buyer type
    for b=1:Nx
        msb(:,b)=sbx{b};
        mMb(:,b)=Mbx{b};
    end

    %now aggregate up to V/U
    visibility_by_type = sum(msb.*mMb.*repmat(wt_x,size(msb,1),1),1)';
    V=sum(visibility_by_type); % total buyer search (vacancy)

    %value of new matches
    prob_buyer_type = visibility_by_type / (sum(visibility_by_type));
    EVs1 = prob_buyer_type' * uncond_surplus_match(:,1) * (1-sbarg);
    EVs2 = prob_buyer_type' * uncond_surplus_match(:,2) * (1-sbarg);
    
    %%visibility of top third of buyer types:
    %disp('top 50% buyer types cumulative visibility')
    %disp(sum(prob_buyer_type(16:30)));

    [u1,u2]=search_newbuyer_no_gamma(EVs1,EVs2,thetas,param,param_fix);
    
    % % JT: Ms1 and Ms2 are probability distributions of sellers, given type, across states.
    % Compute ex-ante expected endogenous destruction for each seller type
    
    %Steady state mass by pair type
    ss_mass_by_pair = zeros(Nx, 2);
    for b = 1:Nx
        % Calculate total mass for each seller type
        ss_mass_by_pair(b, 1) = sum(mMb(:, b) .* s1); % Type 1 sellers
        ss_mass_by_pair(b, 2) = sum(mMb(:, b) .* s2); % Type 2 sellers
    end
    prob_ss_buyer_type1 = ss_mass_by_pair(:,1) / sum(ss_mass_by_pair(:,1));
    prob_ss_buyer_type2 = ss_mass_by_pair(:,2) / sum(ss_mass_by_pair(:,2));

    phi_1= prob_ss_buyer_type1'*phi(:,1);
    phi_2= prob_ss_buyer_type2'*phi(:,2);
    % %Intensity Matrix for Two-types (QS1', QS2' are intensity matrix)
    QS1 = intensity_s_expected(u1,thetas,param_fix,param,phi_1);
    QS2 = intensity_s_expected(u2,thetas,param_fix,param,phi_2);
    Ms1=(ones((N+1),(N+1))+QS1')\ones((N+1),1);
    Ms2=(ones((N+1),(N+1))+QS2')\ones((N+1),1);
    % %correct for small numerical errors
    Ms1=Ms1.*(Ms1>0);
    Ms2=Ms2.*(Ms2>0);

    % Death hazard regression
    [match_death_reg_coef, avg_death_haz] = match_death_reg(N,Ms1,Ms2,delta + lambda*phi_1,delta + lambda*phi_2,w1_x,w2_x,delta_S,delta_B);

    % adjust delta to hit the observed total match death hazard (0.774)
    target_match_death_haz = 0.774;
    old_delta = delta;
    param_fix{12} = param_fix{12} + target_match_death_haz - avg_death_haz;
    delta = param_fix{12};

    %average flow profit calculation (for interpretation of fixed costs F)

    % First, compute the total number of matches across all buyer types and seller types:
    total_matches = sum(ss_mass_by_pair(:));  % sum of all elements in ss_mass_by_pair

    % Compute fraction of matches of each (buyer_type = b, seller_type = s):
    frac_bs = ss_mass_by_pair / total_matches;  

    % Now compute the weighted average of flow profit over all active matches:
    avg_flow_profit = 0;
    for b = 1:Nx
        for s = 1:2
            avg_flow_profit = avg_flow_profit + frac_bs(b,s) * profit_matrix(b,s);
        end
    end

    % Create vectors of all possible flow-profit values and their weights:
    flow_values  = reshape(profit_matrix, [], 1);   % Nx*2 by 1 vector of profits
    flow_weights = reshape(frac_bs,       [], 1);   % Nx*2 by 1 vector of weights

    % Sort by flow-profit values:
    [sorted_flow_values, sort_idx] = sort(flow_values);
    sorted_flow_weights = flow_weights(sort_idx);

    % Compute cumulative sum of weights, find where it crosses 0.5:
    cum_weights = cumsum(sorted_flow_weights);
    median_idx  = find(cum_weights >= 0.5, 1, 'first');
    median_flow_profit = sorted_flow_values(median_idx);


    %U1=sum(u1(1:N).*Ms1(1:N)*w1_x)*Ns; % total type 1 seller search, by state   
    %U2=sum(u2(1:N).*Ms2(1:N)*w2_x)*Ns; % total type 2 seller search, by state 
    U1=u1(1)*w1_x*Ns; % total type 1 seller search (constant)    
    U2=u2(1)*w2_x*Ns; % total type 2 seller search (constant)  
    
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


end
%stop
end
