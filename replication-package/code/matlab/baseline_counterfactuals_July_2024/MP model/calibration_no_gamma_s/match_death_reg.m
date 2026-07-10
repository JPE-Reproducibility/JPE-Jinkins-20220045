function [match_death_reg_coef,avg_haz] = match_death_reg(N,Ms1,Ms2,delta1,delta2,w1_x,w2_x,delta_S,delta_B)

    % Initialize arrays to store our data
    match_death_prob = [];
    ln_num_buyers = [];
    match_weight = [];

    % For Type 1 sellers
    for i = 2:N
        if Ms1(i) > 0
            match_death_prob = [match_death_prob; 1 - exp(-(delta1 + delta_S + delta_B))];
            ln_num_buyers = [ln_num_buyers; log(i-1)];
            match_weight = [match_weight; w1_x * Ms1(i) * (i-1)];
        end
    end

    % For Type 2 sellers
    for i = 2:N
        if Ms2(i) > 0
            match_death_prob = [match_death_prob; 1 - exp(-(delta2 + delta_S + delta_B))];
            ln_num_buyers = [ln_num_buyers; log(i-1)];
            match_weight = [match_weight; w2_x * Ms2(i) * (i-1)];
        end
    end

    % Run the weighted regression
    X = [ones(length(ln_num_buyers), 1), ln_num_buyers];
    match_death_reg_coef = 0;
    if ~isempty(match_death_prob) && size(X,1) >= 2 && std(ln_num_buyers) ~= 0
        warnState1 = warning('off','MATLAB:singularMatrix');
        warnState2 = warning('off','MATLAB:nearlySingularMatrix');
        warnState3 = warning('off','MATLAB:illConditionedMatrix');
        [b, ~, ~, stats] = lscov(X, match_death_prob, match_weight);
        warning(warnState1);
        warning(warnState2);
        warning(warnState3);
        % lscov can report the MP design as rank deficient even when it
        % returns a finite slope. The Results2026 estimates use that finite
        % weighted-regression slope as the match-death moment.
        if numel(b) >= 2 && isfinite(b(2))
            match_death_reg_coef = b(2);
        end
    end

   %average hazard
    match_hazard = -log(1 - match_death_prob);
    if isempty(match_weight)
        avg_haz = 0;
    else
        avg_haz = sum(match_weight .* match_hazard) / sum(match_weight);
    end
end
