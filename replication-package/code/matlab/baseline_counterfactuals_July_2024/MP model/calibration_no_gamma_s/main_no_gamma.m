
%This code solves the model once and experiment w/the calculation of model moments
%% We are making chages in terms that there are no seller interdependencies

%% Clear
clear;

clc;

if ~exist('Output','dir')
    mkdir('Output');
end
if ~exist('results','dir')
    mkdir('results');
end

% %% Define basellers per buyerseline parameters
% workingFolder = '.';
% subdirectory = '../../../baseline_no_NsNb_target/results/';
% filename = 'se_results_no_M_target.mat';
% 
% filePath = fullfile(workingFolder, subdirectory, filename);
% load(filePath)
% 
% %true parameters, search cost/network buyer/network seller/
% %frac. high type/high type seller/type buyer/mass of sellers/elas. of sub.
% clearvars -except param_vec;
% x0 = param_vec;
% x0(2) = 0; %shut down buyer gamma
% x0(3) = x0(1); %set seller network is now seller cost)
% %x0(end-2:end) = 0; %shut down match shocks/fixed costs
% %x0(3) = 0; %set cost scalar cs = cb (also changed in x2param)
% %x0(8) = 0; %do not estimate eos (also changed in x2param)
% 
% %% Parameters additional for endogenous destruction 
% x0 = [x0;2;0.1];

%% Best fit (gammaB set to zero, fix shock arrival rate)
%x0 = [0.0305728220723054 0 0.00489830177817786 0.0142304035075620 0.0506115073452684 4.06143374246236 42.5037888978692 1.92208400334610	0.153856847595365 0.213761866989002]';
% (new) fval = 18702.2682003173 (old) fval = 18630.46223

%%% Rerunning
x0 = [0.00669 0 0.00183 0.03431 0.05356 5.48040 8.56411 1.86338 0.04029 0.00198]';
%% (new) fval = 19841.27419 (old) fval = 18956.21169

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%% Solve the model underbaseline parameters
D0 = objective(x0,param_indx,param_state,param_fix)

% generate initial population around initial parameter vector
theta = x0';
K = length(theta);
PS = 2*K;
disp(['Population size ' num2str(PS)])
H = rand(PS,K);

bounds = [theta - 0.15*abs(theta); theta + 0.15*abs(theta)]';

lb = bounds(:,1);
ub = bounds(:,2);
lb(10) = 0; %fixed cost lower bound is zero
IR = bounds';
lb = lb(:,ones(PS,1))';
ub = ub(:,ones(PS,1))';
rng = abs(ub-lb);
X0 = lb + rng.*H;
clear lb ub rng
% initial population
population = X0;
population(1,:) = theta;
cf = 0.30;          % crossover fraction
EC = 4;             % elite count
shrink = 1;
SF = 5; 

GN = 30; % number of generations per run (front-loaded exploration)
R = 5;   % total number of GA runs

%Bounds for estimation
lb_ga = -Inf(size(theta)); % No lower bounds for other parameters
ub_ga = Inf(size(theta));  % No upper bounds for any parameter
lb_ga(10) = 0;             % Set lower bound for fixed costs to 0

scale0 = 0.15;
t = 1;
flag = true;
best_ga_x = x0;
best_ga_val = inf;
while t<=R
    scale = ((R-t)/R)*scale0;
    mut_fn = @(parents,options,GenomeLength,FitnessFcn,state,thisScore,...
        thisPopulation) ...
        TSS_mutationgaussian(parents,options,GenomeLength,FitnessFcn,...
        state,thisScore,thisPopulation,scale,shrink,t,R,GN);
    disp(['optimization run ',num2str(t),' of ',num2str(R)])
    options = gaoptimset('TolFun',1e-20,'StallGenLimit',50,'MutationFcn',mut_fn,...
        'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
        'UseParallel','always','Vectorized', 'off','CrossoverFraction',cf,'EliteCount',EC,...
        'PopInitRange',IR,'FitnessScaling',@fitscalingrank);
    disp('optimization starting')
    tic
    [x,fval_ga,exitflag,output,population] = ...
      ga(@(X) objective(X,param_indx,param_state,param_fix),...
         K,[],[],[],[],lb_ga,ub_ga,[],options);

    if fval_ga < best_ga_val
        best_ga_val = fval_ga;
        best_ga_x = x(:);
    end
    FileName = ['Output/' 'Optimization','_',datestr(now,'yyyy_mmdd_HHMM'),...
        '_Run',num2str(t),'of',num2str(R)];
    save(FileName,'x','fval_ga','population')
    time_elapsed1 = toc;
    disp(['time elapsed in total: '...
    num2str(time_elapsed1/60) ...
    ' minutes'])
    disp(['time elapsed per generation: ' ...
    num2str(time_elapsed1/(GN+1)) ...
    ' seconds'])
   pop_range_t = [min(population',[],2) max(population',[],2)];
   IRt = IR';
   pop_range0 = round(100*mean(abs(pop_range_t(:,2)-pop_range_t(:,1))./abs(IRt(:,2)-IRt(:,1))));
   disp(['Average (max minus min) population range as percentage of initial range: ' num2str(pop_range0)])
   pop_range1 = round(100*(sum(pop_range_t(:,1)<IRt(:,1)) + sum(pop_range_t(:,2)>IRt(:,2)))/(2*K));
   disp(['Percentage of initial bounds that are violated by at least one parameter vector in the current population: ' ...
       num2str(pop_range1)])

    t = t + 1;
end         

objective(x0,param_indx,param_state,param_fix)

%% Local search refinement using patternsearch
best_solution = best_ga_x;
best_value = best_ga_val;
try
    disp('Starting local search (patternsearch)...');
    ps_options = optimoptions('patternsearch','Display','iter','UseParallel',true,...
        'MaxIterations',200,'MaxFunctionEvaluations',2000);
    [x_local,fval_local] = patternsearch(@(X) objective(X,param_indx,param_state,param_fix),...
        best_ga_x.',[],[],[],[],lb_ga,ub_ga,[],ps_options);
    fprintf('Patternsearch completed. Objective = %.5f\n',fval_local);
    if fval_local < best_value
        best_value = fval_local;
        best_solution = x_local(:);
    end
catch ME
    warning('Patternsearch skipped: %s', ME.message);
    fprintf('Warning with parameters: %s\n', mat2str(best_ga_x'));
end

% Generate final figures/standard errors once for paper outputs
try
    global GENERATE_FINAL_OUTPUTS
    GENERATE_FINAL_OUTPUTS = true;
    objective(best_solution,param_indx,param_state,param_fix);
catch ME
    warning('Final output generation failed: %s', ME.message);
end
