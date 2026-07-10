% Rebuild mechanical appendix artifacts from the latest estimation campaign.
% Run this script from the mechanical_model directory.

clear; clc;

if ~exist('results','dir')
    mkdir('results');
end

%% 1) Pick best estimate from latest/most complete optimization campaign
[best_si,best_fval,meta] = load_best_mechanical_estimate();

if isnan(best_fval)
    fprintf('Using best estimate from %s: %s (fval unavailable)\n', ...
        meta.source_type, meta.source_file);
else
    fprintf('Using best estimate from %s: %s (fval=%.6f)\n', ...
        meta.source_type, meta.source_file, best_fval);
end

summary_path = fullfile('results','mechanical_best_estimate_summary.txt');
fid = fopen(summary_path,'w');
fprintf(fid,'source_type=%s\n',meta.source_type);
fprintf(fid,'source_file=%s\n',meta.source_file);
if isnan(best_fval)
    fprintf(fid,'fval_ga=NaN\n');
else
    fprintf(fid,'fval_ga=%.10f\n',best_fval);
end
fprintf(fid,'omega=%.10f\n',best_si(33));
fprintf(fid,'Ns=%.10f\n',best_si(34));
fclose(fid);

%% 2) Regenerate search-intensity figure (bars; ln y-axis; tick labels in levels)
si = best_si;
f = figure('Visible','off','Color','w');
set(f,'Position',[100,100,1200,500]);

buyer_levels = sort(si(1:30));
subplot(1,2,1);
hb = bar(1:numel(buyer_levels), buyer_levels);
xlabel('Type','FontSize',12);
ylabel('Search Intensity (levels, ln y-axis)','FontSize',12);
title('Estimated Buyer Search Intensities','FontSize',14);
ax1 = gca;
set(ax1,'YScale','log');
set(ax1,'Color','w','XColor','k','YColor','k');
ax1.YLim = [0.14 55];
hb.BaseValue = 0.14;
yt1 = [0.14 0.37 1 2.7 7.4 20 55];
ax1.YTick = yt1;
ax1.YTickLabel = compose('%.2g', yt1);
xlim([0.5, numel(buyer_levels)+0.5]);

seller_levels = sort(si(31:32));
subplot(1,2,2);
hs = bar(1:numel(seller_levels), seller_levels);
xlabel('Type','FontSize',12);
ylabel('Search Intensity (levels, ln y-axis)','FontSize',12);
title('Estimated Seller Search Intensities','FontSize',14);
ax2 = gca;
set(ax2,'YScale','log');
set(ax2,'Color','w','XColor','k','YColor','k');
ax2.YLim = [1 33];
hs.BaseValue = 1;
yt2 = [1 1.6 2.7 4.5 7.4 12 20 33];
ax2.YTick = yt2;
ax2.YTickLabel = compose('%.2g', yt2);
xlim([0.5, numel(seller_levels)+0.5]);

sg = sgtitle('Mechanical Model: Estimated Search Intensities','FontSize',16);
set(sg,'Color','k');
saveas(f, fullfile('results','combined_search_intensities.png'));
close(f);

%% 3) Recompute counterfactual table using latest estimate
mechanical_counterfactual_main;
fprintf('Counterfactual table written to %s\n', ...
    fullfile('output','tables','counterfactual_table_policy_only.tex'));

fprintf('Mechanical appendix artifacts are up to date.\n');
