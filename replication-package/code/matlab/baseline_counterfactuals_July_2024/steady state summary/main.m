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

%% Start with model fundamentals
%Define fixed parameters
define_parameters;

%Define the relevant states
define_states;

%Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)
define_lindex;


%% Solve the model underbaseline parameters

[thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Ms1, Ms2, Qbx, QS1, QS2, ...
          net_prof_b, Cs, Cs1, Cs2, net_prof_s1, net_prof_s2, pbs, profx] = solve_model(x, param_indx, param_state, param_fix);

%% Number of sellers and rent sharing
%double check
disp('total gross profit')
net_prof = net_prof_b + net_prof_s1.*s1 + net_prof_s2.*s2;
[sum(sum(net_prof.*mMb))/Nx 1/x(end)]

%first, summarize the nubmer and type mix of sellers using mMb
%take out the first row of zeros and re-weight

%summarize the number of sellers for active buyers
type_mMb = mMb(2:end,:)./repmat(sum(mMb(2:end,:)),size(mMb(2:end,:),1),1);
type_ns = sum(repmat(ns(2:end),1,Nx).*type_mMb);
share_high = sum(repmat(s2(2:end)./ns(2:end),1,Nx).*type_mMb); %the mix of sellers are pretty constant across buyer types. 

%summarize the rent sharing 
net_prof = net_prof_b + repmat(s1,1,Nx).*net_prof_s1 + repmat(s2,1,Nx).*net_prof_s2;
type_rent =  sum((net_prof_b(2:end,:)./net_prof(2:end,:)).*type_mMb); %ranges from equal share to 0.66 for the retailer of top type. 

%% plot the number of sellers/rent share
% Define the folder and filename
folder = 'D:\Dropbox\Apps\Overleaf\EJTX\figures\'; % Change to your desired folder

% Create the plot with two y-axes
figure;

% Plot the first line with the left y-axis
yyaxis right;
plot(type_ns, 'r--', 'LineWidth', 2.5);
%ylabel('Left Y-axis');
grid on; % Turn on the grid for the left y-axis

% Plot the second line with the right y-axis
yyaxis left;
plot(type_rent, 'b-', 'LineWidth', 2.5);
%ylabel('Right Y-axis');
grid on; % Turn on the grid for the right y-axis

% Additional plot settings
xlabel('Type of Buyers');
%title('Buyer Share of Gross Profit');
legend('profit share','avg. number of suppliers','Location','northwest');

filename = fullfile(folder, 'buyer_profit_share.png');

% Save the figure as a PNG file
saveas(gcf, filename);

%% Overall market share 
param = x2param(x); gam = param{12};
type_P = sum(repmat(pbs.^(1-gam),1,Nx).*mMb.*repmat(profx,(N1+1)*(N2+1),1).*repmat(wt_x,(N1+1)*(N2+1),1));
type_share = type_P/Ap;

%% summarize search effort and cost -- buyer

mCs = zeros((N1+1)*(N2+1),Nx);
parfor b=1:Nx
    mCs(:,b) = Cs{b};
end
type_cbs = sum(mCs.*mMb);
type_profb = sum(net_prof_b.*mMb);
type_cshare = type_cbs./type_profb;

type_cshare0 = mCs(1,:).*mMb(1,:)./type_cbs;

% plot the number of sellers/rent share
type_idx = [1;5;10;15;(20:30)'];
% Create the plot with two y-axes
figure;

% Plot the first line with the left y-axis
%yyaxis right;
%plot(type_idx,type_cshare0(type_idx), 'r--', 'LineWidth', 2.5);
%ylabel('Left Y-axis');
%grid on; % Turn on the grid for the left y-axis

% Plot the second line with the right y-axis
%yyaxis left;
plot(type_idx,type_cshare(type_idx), 'b-', 'LineWidth', 2.5);
%ylabel('Right Y-axis');
grid on; % Turn on the grid for the right y-axis

% Additional plot settings
xlabel('Type of Buyers');
%title('Buyer Share of Gross Profit');
legend('search cost as share of buyer profit','Location','southwest');

filename = fullfile(folder, 'buyer_search_cost_share.png');

% Save the figure as a PNG file
saveas(gcf, filename);
    
%% summarize search effort and cost -- seller
type_profs = [mean(sum((repmat(s1,1,Nx).*net_prof_s1).*mMb)) mean(sum((repmat(s2,1,Nx).*net_prof_s2).*mMb))];
disp('total seller profit')
[sum(type_profs)]

type_css = [sum(Cs1.*Ms1)*(1-x(4))*x(7) sum(Cs2.*Ms2)*x(4)*x(7)];
