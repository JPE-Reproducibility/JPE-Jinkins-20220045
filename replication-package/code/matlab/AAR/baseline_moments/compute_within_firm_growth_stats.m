function stats = compute_within_firm_growth_stats(seller_sales_by_age, target_ages)
%COMPUTE_WITHIN_FIRM_GROWTH_STATS Mean ratios and samples for multiple tenures.
%   seller_sales_by_age: cell array with revenue-by-age matrices (per type).
%   target_ages: vector of tenure indices (>=1).

arguments
    seller_sales_by_age cell
    target_ages (1, :) double {mustBeInteger, mustBePositive}
end

num_targets = numel(target_ages);
mean_vals = NaN(num_targets, 1);
samples = cell(num_targets, 1);

for t = 1:num_targets
    age = target_ages(t);
    ratio_list = [];
    for j = 1:numel(seller_sales_by_age)
        data = seller_sales_by_age{j};
        if isempty(data) || size(data, 2) < age
            continue;
        end
        base_sales = data(:, 1);
        target_sales = data(:, age);
        valid = isfinite(base_sales) & isfinite(target_sales) & base_sales > 0 & target_sales > 0;
        if any(valid)
            ratio_list = [ratio_list; target_sales(valid) ./ max(base_sales(valid), 1e-8)]; %#ok<AGROW>
        end
    end
    samples{t} = ratio_list;
    if ~isempty(ratio_list)
        mean_vals(t) = mean(ratio_list);
    end
end

stats = struct('mean', mean_vals, 'samples', {samples});
end
