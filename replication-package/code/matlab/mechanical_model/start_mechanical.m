% START_MECHANICAL
% Full estimation routine for the mechanical model.
% Writes optimization checkpoints and diagnostics to `results/`.
% Run from the `mechanical_model` directory.

clear;

clc;

if ~exist('results','dir')
    mkdir('results');
end

 fileID1 = fopen('results/fitlog_mechanical.txt','a');
 fprintf(fileID1,'\r\n STARTING A NEW RUN (No Ms mechanical) %s\n', datestr(now,'yyyy_mmdd_HHMM') );
 fclose(fileID1);

%% Start with model fundamentals
filepath = fullfile('../baseline_no_NsNb_target/results/se_results_baseline_no_M_target.mat');
load(filepath)

x = param_vec;

%Define fixed parameters
define_parameters;

%Define the static payoff functions
define_payoffs;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%Input parameters
si_in = [5.30475970194135	2.54322006301519	0.348565315964827 ...
    0.369505098908116	9.35562288711672	0.441813632503381 ...
    7.87504269207164	0.340689355526077	22.9491963021357 ...
    28.2005129010624	2.66627677681297	1.98610727953777 ...
    0.517564937662059	0.367303303415852	0.321406045111434 ...
    0.300434151091727	0.385153971571320	0.332210230982581 ...
    2.00214162149974	0.319917507402888	2.16833653770023 ...
    0.354051646421266	0.892034393568599	0.377314705140029 ...
    2.19396527483993	0.335786031814243	0.336829230525515 ...
    0.305377065853247	0.358834912727211	0.405293209243906 ...
    1.30757293276676	14.2853658011404	0.0373113278254231 ...
    8.71516134851435];
%fval_ga = 6643.75311595123

%initial guess
si = struct; %search intensity

si.buyer = si_in(1:30)';
si.seller = si_in(31:32)';
x(4) = si_in(33); %share of "high type" sellers
x(7) = si_in(34); %number of sellers relative to buyers

% %evaluate the objective function at starting vector (optional)

obj = objective_mechanical([si.buyer;si.seller;x(4);x(7)],x,param_indx,param_state,param_fix);

%std_errors
[Degree_dist_table,Transmat_table,NS_NB_table] =...
    tables_mechanical(si,x,param_indx,param_state,param_fix)

%% Estimation procedure based on Tomassen et al (AER, 2017)

%This first part is all to get the initial population paramter vectors
theta = [si.buyer;si.seller;x(4);x(7)]; %last two are fraction of high skill w2_x and relative number of sellers Ns
D  = length(theta); % number of estimated parameters
PS = 2*D;
disp(['Population size ' num2str(PS)])
H = rand(PS,D);

bounds = [theta - 0.99*abs(theta), theta + 2*abs(theta)];
bounds(end-1,:) = [1e-5,1-1e-5]; %bounds for share of high skill
bounds(end,:) = [0.01,100]; %bounds for relative number of sellers to buyers
lb = bounds(:,1);
ub = bounds(:,2);
IR = bounds';
lb = lb(:,ones(PS,1))';
ub = ub(:,ones(PS,1))';


gap = abs(ub-lb);
%rng = 4;
X0 = lb + gap.*H;
clear lb ub rng
population = X0;

% This is the actual upper and lower bounds
 lb=ones(1,D)*0.0001;
 ub=ones(1,D)*50;
 ub(end-1) = 1; %can't have a higher share of quality than one


cf = 0.30;          % crossover fraction
EC = 2;             % elite count
shrink = 0.75;
SF = 5; 

GN = 30; % number of generations per run
R =  60; % total number of runs

scale0 = 0.15;
t = 1;
flag = true;
while t<=R
    
    %scale = ((R-t)/R)*scale0;
    %mut_fn = @(parents,options,GenomeLength,FitnessFcn,state,thisScore,...
    %    thisPopulation) ...
    %    TSS_mutationgaussian(parents,options,GenomeLength,FitnessFcn,...
    %    state,thisScore,thisPopulation,scale,shrink,t,R,GN);
    %DAVID NOTE: I removed this mutation function, because it causes ga to
    %violate bounds constraints (see here:
    %https://de.mathworks.com/help/gads/constraints.html).  we now use
    %default
    disp(['optimization run ',num2str(t),' of ',num2str(R)])
    options = gaoptimset('TolFun',1e-8,'StallGenLimit',800,...
        'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
        'UseParallel','always','Vectorized', 'off','CrossoverFraction',cf,'EliteCount',EC,...
        'PopInitRange',IR,'FitnessScaling',@fitscalingrank,'UseParallel', true);
    disp('optimization starting')
    tic
     
     [si_in,fval_ga,exitflag,output,population,SCORES]= ga(@(si_in) objective_mechanical(si_in,x,param_indx,param_state,param_fix),...
                D,[],[],[],[],lb,ub,[],options);
 %    FileName = ['D:\Dropbox\Networks project\matlab code\model calibration Dec 2019\Estimation\Restrictive Curv\' ...
    FileName = fullfile('results', ...
        ['Optimization','_',datestr(now,'yyyy_mmdd_HHMM'),...
        '_Run',num2str(t),'of',num2str(R),'.mat']);
    save(FileName,'si_in','fval_ga','population')
    
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
   pop_range1 = round(100*(sum(pop_range_t(:,1)<IRt(:,1)) + sum(pop_range_t(:,2)>IRt(:,2)))/(2*D));
   disp(['Percentage of initial bounds that are violated by at least one parameter vector in the current population: ' ...
       num2str(pop_range1)])
   
    t = t + 1;
end

%% Generate summary tables and save them
si.buyer = si_in(1:30)';
si.seller = si_in(31:32)';
x(4) = si_in(33);
x(7) = si_in(34);

%std_errors
[Degree_dist_table,Transmat_table,NS_NB_table] =...
    tables_mechanical(si,x,param_indx,param_state,param_fix);

    FileName2 = fullfile('results', ...
    ['std_errors','_',datestr(now,'yyyy_mmdd_HHMM'),'.mat']);
    save(FileName2,'si','param_vec','x')

%% Some plots for the paper
figure(1)
set(gcf, 'Position', [100, 100, 1200, 500]) % Increase figure size
set(gcf, 'Color', 'w')

subplot(1,2,1)
buyer_levels = sort(si.buyer);
hb = bar(1:numel(buyer_levels),buyer_levels);
xlabel('Type', 'FontSize', 12)
ylabel('Search Intensity (levels, log y-axis)', 'FontSize', 12)
title('Estimated Buyer Search Intensities', 'FontSize', 14)
ax1 = gca;
set(ax1,'YScale','log');
set(ax1,'Color','w','XColor','k','YColor','k');
ax1.YLim = [0.14 55];
hb.BaseValue = 0.14;
yt1 = [0.14 0.37 1 2.7 7.4 20 55];
ax1.YTick = yt1;
ax1.YTickLabel = compose('%.2g', yt1);
xlim([0.5, numel(buyer_levels)+0.5]);

subplot(1,2,2)
seller_levels = sort(si.seller);
hs = bar(1:numel(seller_levels),seller_levels);
xlabel('Type', 'FontSize', 12)
ylabel('Search Intensity (levels, log y-axis)', 'FontSize', 12)
title('Estimated Seller Search Intensities', 'FontSize', 14)
ax2 = gca;
set(ax2,'YScale','log');
set(ax2,'Color','w','XColor','k','YColor','k');
ax2.YLim = [1 33];
hs.BaseValue = 1;
yt2 = [1 1.6 2.7 4.5 7.4 12 20 33];
ax2.YTick = yt2;
ax2.YTickLabel = compose('%.2g', yt2);
xlim([0.5, numel(seller_levels)+0.5]);

sg = sgtitle('Mechanical Model: Estimated Search Intensities', 'FontSize', 16); % Overall title
set(sg,'Color','k');

saveas(gcf,fullfile('results','combined_search_intensities.png')) % Save combined figure


%Equivalent of Figure 8: Data-based versus model based moments
f2 = figure(2);
comp_fig = subplot(2,2,1);
scatter([Transmat_table.data_moms3;Transmat_table.data_moms4],[Transmat_table.sim_moms3;Transmat_table.sim_moms4],'b')
hold on;
plot(0:1,0:1,'r');
title("Buyer and Seller Transition Matricies")
xlabel("data")
ylabel("model")
hold off;

subplot(2,2,2);
scatter([Degree_dist_table.data_moms1],[Degree_dist_table.sim_moms1],'b')
hold on;
plot(0:1,0:1,'r');
title("Sellers per Buyer")
xlabel("data")
ylabel("model")
hold off;

subplot(2,2,3);
scatter([Degree_dist_table.data_moms2],[Degree_dist_table.sim_moms2],'b')
hold on;
plot(0:1,0:1,'r');
title("Buyers per Seller")
xlabel("data")
ylabel("model")
hold off;

subplot(2,2,4);
scatter(NS_NB_table.data_active_SPB,NS_NB_table.sim_active_SPB,'b')
hold on;
maxN = max(NS_NB_table.data_active_SPB,NS_NB_table.sim_active_SPB);
plot(0:maxN+1,0:maxN+1,'r');
title("Active Sellers per Active Buyer")
xlabel("data")
ylabel("model")
hold off;

% subplot(2,2,4);
% scatter([Seller_concen_table.data_moms5],[Seller_concen_table.sim_moms5],'b')
% hold on;
% plot(0:1,0:1,'r');
% title("Share of sales due to largest supplier")
% xlabel("data")
% ylabel("model")
% hold off;

saveas(f2,fullfile('results','comp_mech.png'))
