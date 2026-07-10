function profile = compute_lifecycle_profile(thetas, thetab, U1, U2, msb, u1, u2, param_fix, param, TT, rng_seed, revenue_per_type)
%COMPUTE_LIFECYCLE_PROFILE Snapshot of exporter moments from the baseline simulator.
%   This function mirrors the legacy `sim_growth_moments.m` script and
%   concentrates the resulting statistics into a struct that downstream
%   routines can consume. In particular we track:
%     • Age-specific mass and match counts for buyers and sellers.
%     • Cumulative life-cycle growth measured relative to the first year in
%       the export market (hence age-one growth equals zero).
%     • Tenure-specific exit hazards built from simulated spell histories.
%     • The ratio of high-type to low-type exporters in each tenure bin and
%       overall, which lets us inspect selection dynamics directly.

if nargin < 10 || isempty(TT)
    TT = 30;
end
if nargin >= 11 && ~isempty(rng_seed)
    rng(rng_seed);
end
if nargin < 12 || isempty(revenue_per_type)
    revenue_per_type = ones(2, 1);
end

Nx = param_fix{4};

thetab1 = thetab * (U1 / max(U1 + U2, eps));
thetab2 = thetab * (U2 / max(U1 + U2, eps));

cnt_traj_b  = zeros(TT, Nx);
mean_traj_b = zeros(TT, Nx);
std_traj_b  = zeros(TT, Nx);

for j = 1:Nx
    vx = msb(:, j);
    [cnt_traj_b(:, j), mean_traj_b(:, j), std_traj_b(:, j)] = ...
        sim_b(vx, thetab1, thetab2, param_fix, TT);
end

mean_gph_b = mean_traj_b(2:end, :);
cnt_gph_b  = cnt_traj_b(2:end, :);

agg_cnt_gph_b  = sum(cnt_traj_b(1:end-1, :), 2);
agg_mean_gph_b = sum(mean_traj_b(1:end-1, :) .* cnt_traj_b(1:end-1, :), 2) ./ ...
    max(agg_cnt_gph_b, eps);

u = [u1, u2];

cnt_traj_s  = zeros(TT, 2);
mean_traj_s = zeros(TT, 2);
std_traj_s  = zeros(TT, 2);
hazard_stats = cell(2,1);

sales_by_age = cell(2, 1);
for j = 1:2
    [cnt_traj_s(:, j), mean_traj_s(:, j), std_traj_s(:, j), hazard_stats{j}, seller_sales] = ...
        simulate_sellers_with_hazard(j, u(:, j), thetas, param_fix, param, TT, revenue_per_type(j));
    sales_by_age{j} = seller_sales;
end

cnt_gph_s  = cnt_traj_s(1:end-1, :);
mean_gph_s = mean_traj_s(1:end-1, :);
std_gph_s  = std_traj_s(1:end-1, :);

% Cross-sectional mass and average matches for all active exporters in each age bin
agg_cnt_gph_s  = sum(cnt_traj_s(1:end-1, :), 2);
agg_mean_gph_s = sum(mean_traj_s(1:end-1, :) .* cnt_traj_s(1:end-1, :), 2) ./ ...
    max(agg_cnt_gph_s, eps);

weights = cnt_gph_s ./ max(sum(cnt_gph_s, 2), 1);
var_components = (weights .^ 2) .* (std_gph_s .^ 2 ./ max(cnt_gph_s, 1));
agg_se = sqrt(sum(var_components, 2));

ages = (1:(TT - 1))';

profile = struct();
profile.ages             = ages;
profile.agg_mean_buyer   = agg_mean_gph_b;
profile.agg_count_buyer  = agg_cnt_gph_b;
profile.buyer_mean       = mean_gph_b;
profile.buyer_count      = cnt_gph_b;
profile.buyer_std        = std_traj_b(2:end, :);

profile.agg_mean_seller  = agg_mean_gph_s;
profile.agg_count_seller = agg_cnt_gph_s;
profile.seller_mean      = mean_gph_s;
profile.seller_std       = std_gph_s;
profile.seller_count     = cnt_gph_s;

% Ratio of high (type 2) to low (type 1) exporters by age bin
low_counts = cnt_gph_s(:, 1);
high_counts = cnt_gph_s(:, 2);

profile.type_ratio = zeros(size(low_counts));
positive_low = low_counts > 0;
profile.type_ratio(positive_low) = high_counts(positive_low) ./ low_counts(positive_low);

no_low = ~positive_low & high_counts > 0;
profile.type_ratio(no_low) = Inf;

total_low = sum(low_counts);
total_high = sum(high_counts);
if total_low > 0
    profile.type_ratio_overall = total_high / total_low;
elseif total_high > 0
    profile.type_ratio_overall = Inf;
else
    profile.type_ratio_overall = 0;
end

% Cumulative growth relative to the first export year (age-one value is zero)
profile.agg_growth = agg_mean_gph_s - agg_mean_gph_s(1);
profile.type1_avg  = mean_gph_s(:, 1);
profile.type2_avg  = mean_gph_s(:, 2);
profile.type1_growth = profile.type1_avg - profile.type1_avg(1);
profile.type2_growth = profile.type2_avg - profile.type2_avg(1);
profile.agg_se     = agg_se;
profile.seller_sales_by_age = sales_by_age;

max_horizon = max(TT - 1, 0);
hazard_type = zeros(max_horizon, 2);
hazard_risk = zeros(max_horizon, 1);
hazard_exit = zeros(max_horizon, 1);

for j = 1:2
    stats = hazard_stats{j};
    if isempty(stats)
        continue;
    end

    risk = stats.risk_counts(:);
    exit_counts = stats.exit_counts(:);
    len = min(numel(risk), max_horizon);
    if len == 0
        continue;
    end

    hazard_risk(1:len) = hazard_risk(1:len) + risk(1:len);
    hazard_exit(1:len) = hazard_exit(1:len) + exit_counts(1:len);

    positive = risk(1:len) > 0;
    h_type = zeros(len, 1);
    h_type(positive) = exit_counts(positive) ./ risk(positive);
    hazard_type(1:len, j) = h_type;
end

hazard_agg = zeros(max_horizon, 1);
positive_total = hazard_risk > 0;
hazard_agg(positive_total) = hazard_exit(positive_total) ./ hazard_risk(positive_total);

profile.hazard_type = hazard_type;
profile.hazard_agg = hazard_agg;
profile.hazard_risk = hazard_risk;
profile.hazard_exit = hazard_exit;
profile.reentry_exits = 0;
profile.reentry_success = 0;
for j = 1:2
    if ~isempty(hazard_stats{j}) && isfield(hazard_stats{j}, 'reentry_exits')
        profile.reentry_exits = profile.reentry_exits + hazard_stats{j}.reentry_exits;
        profile.reentry_success = profile.reentry_success + hazard_stats{j}.reentry_success;
    end
end

end

%% -------------------------------------------------------------------------
function [cnt_traj, mean_traj, std_traj, stats, sales_by_age] = simulate_sellers_with_hazard(stype, ux, thetas, param_fix, param, TT, revenue_per_match)
%SIMULATE_SELLERS_WITH_HAZARD Seller-side simulation with exporter-level hazard stats.
%   1. Simulates exporter match dynamics using the EJTX baseline transition
%      rules, drawing inter-arrival times and updating the active match count.
%   2. Records, for each integer tenure window [t-1, t), the number of
%      observations and average match counts across all **active** exporters.
%   3. Tracks full spell histories so that we can compute duration hazards
%      consistent with the MSM moment construction.

N = param_fix{3};
delta_B = param_fix{10};
delta_S = param_fix{11};
delta = param_fix{12};

N_sim = param_fix{18};
I_simS    = param_fix{19};
I_simBurn = param_fix{20};

Ns   = param{11};
w2_x = param{7};

if stype == 1
    N_simS = round((1 - w2_x) * N_sim * Ns);
else
    N_simS = round(w2_x * N_sim * Ns);
end

cnt_traj = zeros(TT, 1);
mean_traj = zeros(TT, 1);
std_traj = zeros(TT, 1);
max_interval = max(TT - 1, 0);
stats = struct('risk_counts', zeros(max_interval, 1), 'exit_counts', zeros(max_interval, 1));
sales_by_age = [];

if N_simS <= 0
    return;
end

mb    = zeros(N_simS, I_simS);
mtime = zeros(N_simS, I_simS);
ages  = zeros(N_simS, I_simS);
t_elaps = zeros(N_simS, I_simS); %#ok<NASGU>

mrnd = rand(N_simS, I_simS);

for i = 2:I_simS
    state = mb(:, i - 1) + 1;
    brate = ux(state) * thetas;
    brate(state == N + 1) = 0;
    drate = mb(:, i - 1) * (delta + delta_B);
    agg_haz = brate + drate + delta_S;
    mtime(:, i) = exprnd(1 ./ agg_haz);
    reset = (mrnd(:, i) > (brate + drate) ./ agg_haz);

    mb(:, i) = mb(:, i - 1) + (mrnd(:, i) <= (brate ./ agg_haz)) ...
        - (mrnd(:, i) > (brate ./ agg_haz) & mrnd(:, i) <= (brate + drate) ./ agg_haz);
    mb(:, i) = mb(:, i) .* (1 - reset);

    ages(:, i) = (ages(:, i - 1) + mtime(:, i)) .* (mb(:, i) > 0);
    t_elaps(:, i) = t_elaps(:, i - 1) + mtime(:, i);
end

ctime = ages;
mb = mb(:, I_simBurn + 1:I_simS);
ctime = ctime(:, I_simBurn + 1:I_simS);
etime = t_elaps(:, I_simBurn + 1:I_simS);

[risk_counts, exit_counts, reentry_exits, reentry_success] = ...
    exporter_hazard_counts(mb, ctime, etime, max_interval, 1.0);
stats = struct('risk_counts', risk_counts, 'exit_counts', exit_counts, ...
    'reentry_exits', reentry_exits, 'reentry_success', reentry_success);

for tt = 1:TT
    cct = ctime <= tt & ctime > tt - 1;
    cnt = sum(sum(cct));
    cnt_traj(tt) = cnt;
    if cnt > 0
        mean_traj(tt) = sum(sum(cct .* mb)) / cnt;
        std_traj(tt) = sqrt(sum(sum(cct .* (mb - mean_traj(tt)).^2)) / cnt);
    end
end

num_bins = max(TT - 1, 0);
sales_by_age = first_spell_sales_by_age(mb, ctime, revenue_per_match, num_bins);

end

%% -------------------------------------------------------------------------
function [risk_counts, exit_counts, reentry_exits, reentry_success] = exporter_hazard_counts(mb, ages, calendar_time, max_interval, reentry_window)
%EXPORTER_HAZARD_COUNTS Aggregate exporter-level risk, exit, and re-entry statistics.
%   Inputs track each seller's match count (`mb`) and tenure in years
%   (`ages`) at the sequence of simulated jump times returned by the EJTX
%   baseline code. For every uninterrupted export spell we record
%   (i) exposure in integer-year bins and (ii) the interval in which the
%   spell terminates. These objects line up with the hazard construction
%   used in assemble_moment_vector.

if max_interval <= 0
    risk_counts = zeros(0, 1);
    exit_counts = zeros(0, 1);
    reentry_exits = 0;
    reentry_success = 0;
    return;
end

[num_sellers, num_events] = size(mb);
risk_counts = zeros(max_interval, 1);
exit_counts = zeros(max_interval, 1);
reentry_exits = 0;
reentry_success = 0;

for seller = 1:num_sellers
    active = mb(seller, :) > 0;
    if ~any(active)
        continue;
    end

    seller_ages = ages(seller, :);
    seller_time = calendar_time(seller, :);
    ongoing = false;
    last_age = 0;
    spell_start_age = 0;

    for idx = 1:num_events
        if active(idx)
            if ~ongoing
                ongoing = true;
                spell_start_age = seller_ages(idx);
                last_age = seller_ages(idx);
            else
                last_age = max(last_age, seller_ages(idx));
            end
        elseif ongoing
            risk_counts = accumulate_risk(risk_counts, spell_start_age, last_age, max_interval);
            exit_interval = min(floor(last_age) + 1, max_interval);
            if exit_interval >= 1 && exit_interval <= max_interval
                exit_counts(exit_interval) = exit_counts(exit_interval) + 1;
            end
            reentry_exits = reentry_exits + 1;
            exit_time = seller_time(idx);
            for look = idx + 1:num_events
                if active(look)
                    if seller_time(look) - exit_time <= reentry_window
                        reentry_success = reentry_success + 1;
                    end
                    break;
                end
            end
            ongoing = false;
            last_age = 0;
            spell_start_age = 0;
        end
    end

    if ongoing
        risk_counts = accumulate_risk(risk_counts, spell_start_age, last_age, max_interval);
    end
end

end

%% -------------------------------------------------------------------------
function risk_counts = accumulate_risk(risk_counts, start_age, end_age, max_interval)
%ACCUMULATE_RISK Adds survival exposure for a spell of given end-of-period age.
%   We treat ages as continuous but record exposure in one-year bins.
%   A seller contributes to the interval [t-1, t) whenever their tenure at
%   the end of the observation window exceeds t-1.

if end_age < 0
    return;
end

start_interval = max(ceil(start_age), 1);

for interval = start_interval:max_interval
    lower_bound = interval - 1;
    if end_age >= lower_bound
        risk_counts(interval) = risk_counts(interval) + 1;
    else
        break;
    end
end

end

%% -------------------------------------------------------------------------
function sales_by_age = first_spell_sales_by_age(match_counts, tenures, revenue_scalar, num_bins)
%FIRST_SPELL_SALES_BY_AGE Average revenue by tenure for each seller's initial export spell.
if num_bins <= 0
    sales_by_age = zeros(size(match_counts, 1), 0);
    return;
end

num_sellers = size(match_counts, 1);
num_events = size(match_counts, 2);
sales_by_age = NaN(num_sellers, num_bins);

for seller = 1:num_sellers
    active = match_counts(seller, :) > 0;
    idx_start = find(active, 1, 'first');
    if isempty(idx_start)
        continue;
    end
    idx_end = idx_start;
    while idx_end <= num_events && active(idx_end)
        idx_end = idx_end + 1;
    end

    spell_mask = false(1, num_events);
    spell_mask(idx_start:idx_end - 1) = true;
    spell_ages = tenures(seller, spell_mask);
    spell_matches = match_counts(seller, spell_mask);

    for bin = 1:num_bins
        in_bin = (spell_ages > bin - 1) & (spell_ages <= bin);
        if any(in_bin)
            sales_by_age(seller, bin) = mean(spell_matches(in_bin)) * revenue_scalar;
        end
    end
end

end
