function exit_stats = compute_size_exit_rates(QS1, QS2, Ms1, Ms2, w2_x, rev_type1, rev_type2)
%COMPUTE_SIZE_EXIT_RATES Exit probabilities as a function of exporter size.

% Continuous-time transition matrices cover states {0,1,...,N}
N = size(QS1, 1) - 1;
states = (1:N)';

% One-year transition matrices
P1 = expm(QS1);
P2 = expm(QS2);

exit_prob1 = P1(2:end, 1);  % Pr(exiting | type-1 seller, n matches)
exit_prob2 = P2(2:end, 1);  % Pr(exiting | type-2 seller, n matches)

% Expected export sales per state
sales1 = rev_type1 * states;
sales2 = rev_type2 * states;

% Stationary mass of exporters (exclude zero match state)
mass1 = (1 - w2_x) * Ms1(2:end);
mass2 = w2_x * Ms2(2:end);

total_mass = sum(mass1) + sum(mass2);
if total_mass <= 0
    error('Total exporter mass is non-positive. Check stationary distributions.');
end

mass_share1 = mass1 / total_mass;
mass_share2 = mass2 / total_mass;

type = [repmat("type1", N, 1); repmat("type2", N, 1)];
matches = [states; states];
sales = [sales1; sales2];
exit_prob = [exit_prob1; exit_prob2];
mass_share = [mass_share1; mass_share2];

by_state = table(type, matches, sales, exit_prob, mass_share);

% Weighted exit rates by export-sales deciles (10 bins)
num_bins = 10;
quantile_edges = linspace(0, 1, num_bins + 1);

[sorted_sales, idx] = sort(sales);
sorted_exit = exit_prob(idx);
sorted_mass = mass_share(idx);

bin_exit_num = zeros(num_bins, 1);
bin_sales_num = zeros(num_bins, 1);
bin_mass = zeros(num_bins, 1);

current_bin = 1;
lower_edge = quantile_edges(current_bin);
upper_edge = quantile_edges(current_bin + 1);
mass_in_bin = 0;

for i = 1:numel(sorted_mass)
    mass_i = sorted_mass(i);
    exit_i = sorted_exit(i);
    sales_i = sorted_sales(i);

    while mass_i > 1e-14 && current_bin <= num_bins
        capacity = upper_edge - (lower_edge + mass_in_bin);
        if capacity <= 1e-14
            current_bin = current_bin + 1;
            if current_bin > num_bins
                break;
            end
            lower_edge = quantile_edges(current_bin);
            upper_edge = quantile_edges(current_bin + 1);
            mass_in_bin = 0;
            continue;
        end

        allocate = min(mass_i, capacity);
        bin_mass(current_bin) = bin_mass(current_bin) + allocate;
        bin_exit_num(current_bin) = bin_exit_num(current_bin) + allocate * exit_i;
        bin_sales_num(current_bin) = bin_sales_num(current_bin) + allocate * sales_i;
        mass_i = mass_i - allocate;
        mass_in_bin = mass_in_bin + allocate;

        if mass_in_bin >= (upper_edge - lower_edge) - 1e-14
            current_bin = current_bin + 1;
            if current_bin > num_bins
                break;
            end
            lower_edge = quantile_edges(current_bin);
            upper_edge = quantile_edges(current_bin + 1);
            mass_in_bin = 0;
        end
    end
end

bin_exit = bin_exit_num ./ bin_mass;
bin_sales = bin_sales_num ./ bin_mass;

bin_exit(bin_mass < 1e-14) = NaN;
bin_sales(bin_mass < 1e-14) = NaN;

total_share = sum(bin_mass);
if abs(total_share - 1) > 1e-6
    warning('Quantile mass shares sum to %.6f (expected 1).', total_share);
end

bin_index = (1:num_bins)';
cdf_lower = quantile_edges(1:end-1)';
cdf_upper = quantile_edges(2:end)';

by_quantile = table(bin_index, cdf_lower, cdf_upper, bin_sales, bin_exit, bin_mass);

exit_stats = struct();
exit_stats.by_state = by_state;
exit_stats.by_quantile = by_quantile;
exit_stats.total_mass = total_mass;
exit_stats.rev_type1 = rev_type1;
exit_stats.rev_type2 = rev_type2;

end
