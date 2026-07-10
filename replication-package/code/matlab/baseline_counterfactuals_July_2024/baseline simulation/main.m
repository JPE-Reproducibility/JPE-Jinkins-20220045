% This code solves the model once and experiments with the calculation of model moments

%% Clear Workspace and Console
clear;  % Clear workspace
clc;    % Clear command window

%% Set File Paths
% Define the working folder and subdirectory
workingFolder = 'D:\Dropbox\Networks project\matlab code';
% Alternative path for macOS or Linux (commented out for now)
% workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';

subdirectory = '/baseline_no_NsNb_target/results';
filename = 'se_results_no_M_target.mat';

% Construct full file path
filePath = fullfile(workingFolder, subdirectory, filename);

%% Load Data
% Load the specified .mat file
load(filePath);

% Clear unnecessary variables to maintain a clean workspace
clearvars -except x;

%% Notes
% `x` contains the loaded data, and all unnecessary variables are cleared.

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;

%% Solve the model underbaseline parameters

[thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,net_prof_b,Cs,Cs1,Cs2,net_prof_s1,net_prof_s2]=...
    solve_model(x,param_indx,param_state,param_fix);

[thetas_old,thetab_old,Ap_old,U1_old,U2_old,V_old,mMb_old,msb_old,u1_old,u2_old,Ms1_old,Ms2_old,Qbx_old,QS1_old,QS2_old,net_prof_b_old,Cs_old,Cs1_old,Cs2_old,net_prof_s1_old,net_prof_s2_old] = ...
    solve_model_old(x,param_indx,param_state,param_fix);

% save the moments as the target
sim_moments_baseline;
data_moments_baseline;

%% Degree comparison
[model_cdf_moments [cdf_SPB';cdf_BPS']]

%% Transition matrix buyer
[model_mTB PTran_mSPB']

%% Transition matrix seller
[model_mTS PTran_mBPS']

%% Within buyer concentration
[model_moments_concen data_moments_concen]

%% Relative ratio
[model_NS_NB NS_NB]

%% Start with any starting value to see if we can estimate the true parameters
%check objective function at baseline value
%objective(x,param_indx,param_state,param_fix,data_moments,cov_v)

%% Simulate firm life cycle
sim_growth_moments

%% Compare simulation with data
data_life = readmatrix('05_avg_number_partners_by_yr_in_market', 'NumHeaderLines', 1);

%normalize against first year
age = data_life(1:10,1);

buyer_growth = data_life(age,2)- data_life(1,2);
seller_growth = data_life(age,5) - data_life(1,5);

model_buyer_growth = agg_mean_gph_b(age) - agg_mean_gph_b(1); 
%model_seller_growth = agg_mean_gph_s(age)- agg_mean_gph_s(1); 
model_seller_growth1 = mean_traj_s(age,1)- mean_traj_s(1,1); 
model_seller_growth2 = mean_traj_s(age,2)- mean_traj_s(1,2); 

% Plot the two lines
figure; % Create a new figure
plot(age, buyer_growth, 'b--', 'LineWidth', 2); 
hold on; % Hold the current plot
plot(age, model_buyer_growth, 'r-', 'LineWidth', 2); 
hold on
plot(age, seller_growth, 'g--', 'LineWidth', 2); 
hold on; % Hold the current plot
plot(age, model_seller_growth1, 'm-', 'LineWidth', 2); 
hold on; % Hold the current plot
plot(age, model_seller_growth2, 'y-', 'LineWidth', 2); 

% Add labels and title
xlabel('number of years in the international market');
ylabel('culmulative increase of business connections');
%title('Life Cycle of Buyers and Sellers');

% Add legend
legend('data: buyer', 'model: buyer', 'data: seller', 'model: seller type1', 'model: seller type2','Location','Northwest');

% Define the folder and filename
folder = 'D:\Dropbox\Apps\Overleaf\EJTX\figures\'; % Change to your desired folder
filename = fullfile(folder, 'life_cycle.png');

% Save the figure as a PNG file
saveas(gcf, filename);
