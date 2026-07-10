function [ratio, samples] = compute_within_firm_growth_ratio(sales_by_age, target_age)
%COMPUTE_WITHIN_FIRM_GROWTH_RATIO Average sales ratio for firms surviving to target_age.
%   Input `sales_by_age` is a cell array with one matrix per productivity
%   type. Each matrix stores per-seller average export sales (transfer plus
%   rebate) for integer tenure bins. The function returns the mean ratio of
%   tenure-`target_age` sales to tenure-1 sales across firms that have valid
%   observations at both horizons, along with the underlying sample of
%   individual ratios (used for bootstrapping).

arguments
    sales_by_age cell
    target_age (1, 1) double {mustBeInteger, mustBeNonnegative}
end

samples = [];
if target_age <= 0
    ratio = NaN;
    return;
end

for j = 1:numel(sales_by_age)
    data = sales_by_age{j};
    if isempty(data) || size(data, 2) < target_age
        continue;
    end
    base_sales = data(:, 1);
    target_sales = data(:, target_age);
    valid = isfinite(base_sales) & isfinite(target_sales) & base_sales > 0 & target_sales > 0;
    if any(valid)
        ratios = target_sales(valid) ./ max(base_sales(valid), 1e-8);
        samples = [samples; ratios]; %#ok<AGROW>
    end
end

if isempty(samples)
    ratio = NaN;
else
    ratio = mean(samples);
end
end
