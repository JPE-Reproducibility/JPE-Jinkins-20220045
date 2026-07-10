%%%%%%%%% Estimation Code, Updated 2025 %%%%%%%%%%%%%%%%%%  

clear;
clc;

if ~exist('Output','dir')
    mkdir('Output');
end
if ~exist('results','dir')
    mkdir('results');
end


 fileID1 = fopen('results/fitlog_heterogeneous_death.txt','a');
 fprintf(fileID1,'\r\n STARTING A NEW RUN (Heterogeneous death hazards) %s\n', datestr(now,'yyyy_mmdd_HHMM') );
 fclose(fileID1);


%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Define data moments
%data_moments_hetero_reg_coef_zero; %for testing
data_moments_hetero;

%% Estimation procedure 

% best fit with reg coef zero (for testing)
%x0 = [0.00956146005090706	0.330189801449791	0.219604830598328	0.0303997761931385	0.453161553841973	7.32780844275308	4.14599033418063	2.43134077299700	0.553993967511284]';
% fval 10462.1507632021

%% best fit hetero delta (old reg)
%x0 = [0.00899253936128899	0.331315431963304	0.258451583001122	0.0303800065325126	0.457368466866821	7.06968637695934	4.44036030268518	2.44296872665957	0.554466532366635 ];
%% fval 10482.5098202313 (with extra moments)

% best fit hetero delta 
x0 = [0.00800149670142449	0.311412680597366	0.176627736944740	0.0306233133085443	0.457037217583970	7.12118405670129	4.49554048853843	2.43536849736572	0.563213343051187];
% fval 10672.6246332165 (with extra moments) 10657.57747 (without)

% evaluate initial parameter vector
D0 = objective(x0,param_indx,param_state,param_fix,data_moments,cov_v,data_life);
  
% generate initial population around initial parameter vector%cost_exp = 2;

theta = x0;
K = length(theta);
PS = 2*K;
disp(['Population size ' num2str(PS)])
H = rand(PS,K);

bounds = [theta - 0.15*abs(theta); theta + 0.15*abs(theta)]';

lb = bounds(:,1);
lb(end) = 1.3; %about as low as we can set the cost curvature
ub = bounds(:,2);
ub(end) = 3; %about as low as we can set the cost curvature
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
      ga(@(X) objective(X,param_indx,param_state,param_fix,data_moments,cov_v,data_life),...
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
 
% std_errors
% plot_fit
