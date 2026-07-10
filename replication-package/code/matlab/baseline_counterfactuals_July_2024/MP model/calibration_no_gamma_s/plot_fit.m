
% data_moments = [cdf_SPB,cdf_BPS,PTran_mSPB,...
%                  PTran_mBPS,data_moments_concen',NS_NB,data_interm_sh]';
% model_moments = [model_cdf_moments; model_mTB; model_mTS;...
%                   model_moments_concen; model_NS_NB; model_interm_sh];
sim_moments_baseline
data_moments_baseline
moment_compare_cdf = [model_cdf_moments, [cdf_SPB';cdf_BPS']];
moment_compare_mTS = [model_mTB, PTran_mSPB'];
moment_compare_mTB = [model_mTS, PTran_mBPS'];
moment_compare_concen = [model_moments_concen,data_moments_concen];
moment_compare_NS_NB = [model_NS_NB,NS_NB];
moment_compare_interm_sh = [model_interm_sh,data_interm_sh];

mkr ='.';
gran = 70;
z = [0:(1/gran):1];
zmax2 = max(max(moment_compare_concen(1:9,:)));
zmax2 = ceil(zmax2);
z2 = [0:(zmax2/gran):zmax2];
zmax3 = max(max(moment_compare_concen(10:end,:)));
zmax3 = ceil(zmax3);
z3 = [0:(zmax3/gran):zmax3];
zmax4 = max(max([moment_compare_mTS(:,1),moment_compare_mTS(:,2)]));
zmax4 = ceil(zmax4);
z4 = [0:(zmax4/gran):zmax4];
zmax5 = max(model_NS_NB,NS_NB);
zmax5 = ceil(zmax5);
z5 = [0:(zmax5/gran):zmax5];


figure(1)

% 1) Set figure size on your screen (in inches) so you can see a tall figure:
set(gcf, 'Units', 'inches', 'Position', [1, 1, 8, 12]); 
% This will place the figure's lower-left corner at (1,1) on your screen
% and make the figure 8 inches wide and 12 inches tall.

title('Targeted and simulated moments')
subplot(3,2,1)
scatter(z4,z4,mkr)
title('suppliers per buyer transition matrix')
hold on
scatter(moment_compare_mTS(:,1),moment_compare_mTS(:,2))
xlabel('model');
ylabel('data');
hold off

subplot(3,2,2)
scatter(z4,z4,mkr)
title('buyers per supplier transition matrix')
hold on
scatter(moment_compare_mTB(:,1),moment_compare_mTB(:,2))
xlabel('model');
ylabel('data');
hold off

subplot(3,2,3)
scatter(z,z,mkr)
title('suppliers per buyer degree distribution')
hold on
scatter(model_cdf_moments(1:7),cdf_SPB')
xlabel('model');
ylabel('data');
hold off

subplot(3,2,4)
scatter(z,z,mkr)
title('buyers per supplier degree distribution')
hold on
scatter(model_cdf_moments(8:14),cdf_BPS')
xlabel('model');
ylabel('data');
hold off

subplot(3,2,5)
scatter(z2,z2,mkr)
title('payment per supplier by # suppliers');
hold on
scatter(moment_compare_concen(1:9,1),moment_compare_concen(1:9,2))
xlabel('model');
ylabel('data');
hold off 

subplot(3,2,6)
scatter(z3,z3,mkr)
title('supplier share by supplier rank, all buyer sizes');
hold on
scatter(moment_compare_concen(10:end,1),moment_compare_concen(10:end,2))
xlabel('model');
ylabel('data');
hold off

% Ensure the figure saves with the adjusted size
set(gcf, 'PaperPositionMode', 'auto');  
saveas(gcf,'results/MP_fit_panel.png')


figure(2)
subplot(2,1,1)
scatter(z5,z5,mkr)
hold on
scatter(model_NS_NB,NS_NB);
xlabel('model');
ylabel('data');
title('active suppliers per active buyer (marketwide)')
hold off

subplot(2,1,2)
scatter(z,z,mkr)
hold on
scatter(model_interm_sh,data_interm_sh);
xlabel('model');
ylabel('data');
title('intermed. expend. over retail sales')
hold off


save results/figures_est_eta