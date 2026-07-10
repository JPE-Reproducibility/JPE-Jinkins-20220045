%%%%%%%%% Estimation Code, Updated 2024 %%%%%%%%%%%%%%%%%%  

clear;
clc;

if ~exist('Output','dir')
    mkdir('Output');
end
if ~exist('results','dir')
    mkdir('results');
end

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Define data moments
data_moments_baseline;

%% Estimation procedure 


% x0 = [0.000703601651058875, 0.205444929183100, 0.379201523279817,0.034691950475348...
%      0.450429447009274, 9.80129366907417, 10.0571675688598, 2.50598242772316];
% OBJECTIVE FUNCTION =  9924.17623758453

% x0 = [0.000936625410970870	0.179975275303972	0.528352266072876	0.0313994062192726...
%       0.458124403279351	10.2854318378267	11.2670644485353	2.49234044616565];
  % 
  % x0 = [0.01732   0.38107   0.20826   0.02971   0.44274   4.99617  3.72127   2.39926 ];
 x0= [ 0.00945610159077022	0.328405888208306	0.229729202367540	0.0303627427733110...
  	0.454124065271806	7.32064657468461	4.19004349697171	2.43268886413272];
 
% evaluate initial parameter vector
D0 = objective(x0,param_indx,param_state,param_fix,data_moments,cov_v);

 
% generate initial population around initial parameter vector
theta = x0;
K = length(theta);
PS = 2*K;
disp(['Population size ' num2str(PS)])
H = rand(PS,K);

bounds = [theta - 0.10*abs(theta); theta + 0.10*abs(theta)]';

lb = bounds(:,1);
ub = bounds(:,2);
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

GN = 15; % number of generations per run
R =  100; % total number of runs

scale0 = 0.15;
t = 1;
flag = true;
while t<=R
    scale = ((R-t)/R)*scale0;
    mut_fn = @(parents,options,GenomeLength,FitnessFcn,state,thisScore,...
        thisPopulation) ...
        TSS_mutationgaussian(parents,options,GenomeLength,FitnessFcn,...
        state,thisScore,thisPopulation,scale,shrink,t,R,GN);
    disp(['optimization run ',num2str(t),' of ',num2str(R)])
    options = gaoptimset('TolFun',1e-20,'StallGenLimit',800,'MutationFcn',mut_fn,...
        'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
        'UseParallel','always','Vectorized', 'off','CrossoverFraction',cf,'EliteCount',EC,...
        'PopInitRange',IR,'FitnessScaling',@fitscalingrank);
    disp('optimization starting')
    tic
    [x,fval_ga,exitflag,output,population] = ...
      ga(@(X) objective(X,param_indx,param_state,param_fix,data_moments,cov_v),...
         K,[],[],[],[],[],[],[],options);
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

FileName = ['results/' 'all_objects_',datestr(now,'yyyy_mmdd_HHMM')];
 save(FileName)
plot_fit
std_errors
