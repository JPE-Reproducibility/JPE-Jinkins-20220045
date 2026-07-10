function param = x2param(x) 

%cost shifter
cb0=x(1);
cs0=x(3); 
%cs0=x(1); 


%network effects
%gamB= x(2);
gamB = 0;
gamS= 0;

%share of high type
w2_x = x(4); 
%w1_x = 1 - w2_x;

%type heterogeneity
c2 = x(5);
var_mu = x(6);
% mean_mu = x(8);

% Relative number of agents
Ns = x(7);

% cross store elasticity of substitution
gam = x(8);
%gam = 4.35;

% cost function exponent
cost_exp = 2;
sbarg  = 0.5; 

%endogenous destruction and match shock
lambda = 4; % shock to profit function (EEJKT, assume once per quarter)
pareto_scale = x(9); % standard deviation of shock to profit function. For now standard log normal
F = x(10); % Fixed cost to keep a match alive. We will need to play with this.

param    = cell(12,1);
param{1} = cb0;      % JT: buyer search cost scalar
param{2} = cost_exp; % JT: buyer search cost exponent
param{3} = cs0;      % JT: seller search cost scalar
param{4} = cost_exp; % JT: seller search cost exponent
param{5} = gamB;     % JT: buyer network effect
param{6} = gamS;     % JT: seller network effect
param{7} = w2_x;     % JT: share of high-type sellers
param{8} =  c2;
param{9} =  var_mu;   
param{10} = sbarg;  % JT: seller's bargaining weight
param{11} = Ns;     % JT: # sellers / # buyers
param{12} = gam;    % cross store elasticity of substitution
param{13} = lambda;    % arrival rate of match productivity shock
param{14} = pareto_scale;    % match prod shock dist param
param{15} = F;    % size of fixed cost

end
