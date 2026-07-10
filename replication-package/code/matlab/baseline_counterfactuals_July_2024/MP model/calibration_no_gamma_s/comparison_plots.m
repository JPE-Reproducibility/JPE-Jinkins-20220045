function comparison_plots(model_cdf_moments, cdf_SPB,cdf_BPS,model_mTB,PTran_mSPB,model_mTS,PTran_mBPS,model_moments_concen,data_moments_concen,model_NS_NB,NS_NB,thetab,thetas,U1,U2,Nx,msb,param_fix,u1,u2,param)
% This function creates plots to evaluate fit of the MP model

%% Degree comparison
[model_cdf_moments [cdf_SPB';cdf_BPS']]
%[model_cdf_moments [cdf_SPB']]

%% Transition matrix buyer
[model_mTB PTran_mSPB']

%% Transition matrix seller
[model_mTS PTran_mBPS']

%% Within buyer concentration
[model_moments_concen data_moments_concen]

%% Relative ratio
[model_NS_NB NS_NB]

% Plot the degree comparison and the transition matrix of the buyer. scatter plot with Y-axis for the data, X-axis for the model. Add a 45 degree line to see how well the model fits the data. Make dots orange without fill
figure; % Create a new figure
scatter(model_cdf_moments(1:7), cdf_SPB, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('sellers per buyer degree distribution'); % Add title
hold on; % Hold the current plot
saveas(gcf, 'results/spb_dist.png');

% Plot the degree comparison and the transition matrix of the seller. scatter plot with Y-axis for the data, X-axis for the model. Add a 45 degree line to see how well the model fits the data. Make dots orange without fill
figure; % Create a new figure
scatter(model_cdf_moments(8:end), cdf_BPS, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('buyers per seller degree distribution'); % Add title
hold on; % Hold the current plot
saveas(gcf, 'results/bps_dist.png');

figure 
scatter(model_mTB, PTran_mSPB, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('sellers per buyer transition matrix'); % Add title
saveas(gcf, 'results/spb_trans.png');

figure 
scatter(model_mTS, PTran_mBPS, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('buyers per seller transition matrix'); % Add title
saveas(gcf, 'results/bps_trans.png');

figure 
scatter(model_moments_concen, data_moments_concen, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('within buyer concentration'); % Add title
saveas(gcf, 'results/within_buyer_concentration.png');

figure  
scatter(model_NS_NB, NS_NB, 'MarkerEdgeColor', [1, 0.5, 0], 'MarkerFaceColor', 'none'); % Create a scatter plot with orange circles
hold on; % Hold the current plot
plot([0 1], [0 1], 'k--'); % Add a 45 degree line
xlabel('Model Moments'); % Add labels
ylabel('Data Moments');
title('Number of sellers to number of buyers'); % Add title
saveas(gcf, 'results/sellers_to_buyers.png');

%% Simulate firm life cycle
sim_growth_moments
%% Compare simulation with data
data_life = readmatrix('05_avg_number_partners_by_yr_in_market', 'NumHeaderLines', 1);

%normalize against first year
age = data_life(1:8,1);

buyer_growth = data_life(1:8,2)- data_life(1,2);
seller_growth = data_life(1:8,5)- data_life(1,5);

model_buyer_growth = agg_mean_gph_b(1:8)- agg_mean_gph_b(1); 
model_seller_growth = agg_mean_gph_s(1:8)- agg_mean_gph_s(1); 

% Plot the two lines
figure; % Create a new figure
plot(age, buyer_growth, 'b--', 'LineWidth', 2); 
hold on; % Hold the current plot
plot(age, model_buyer_growth, 'r-', 'LineWidth', 2); 
hold on
plot(age, seller_growth, 'g--', 'LineWidth', 2); 
hold on; % Hold the current plot
plot(age, model_seller_growth, 'm-', 'LineWidth', 2); 

% Add labels and title
xlabel('number of years in the international market');
ylabel('culmulative increase of business connections');
%title('Life Cycle of Buyers and Sellers');

% Add legend
legend('data: buyer', 'model: buyer', 'data: seller', 'model: seller');
saveas(gcf, 'results/growth_not_targeted.png');
