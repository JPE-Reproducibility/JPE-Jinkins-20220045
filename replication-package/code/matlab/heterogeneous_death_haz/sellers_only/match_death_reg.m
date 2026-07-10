function match_death_reg_coef = match_death_reg(N,Ms1,Ms2,delta1,delta2,w1_x,w2_x,delta_S,delta_B)

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
    [b, ~, ~, stats] = lscov(X, match_death_prob, match_weight);

    match_death_reg_coef = b(2);
end
