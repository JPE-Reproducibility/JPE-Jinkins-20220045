function [beta, se, R2, pi1, pi2] = ...
    regressDeathOnNumPartnersWithTypes(QS1, QS2, w1_x, w2_x, doWeighted)
%REGRESSDEATHONNUMPARTNERSWITHTYPES - MATCH-LEVEL DEATH HAZARD
%
% This version interprets Q(s+1,s) as the hazard that a firm in state s
% loses "at least one" of its s matches. From the match perspective, each
% match's hazard is Q(s+1,s)/s. We then regress that match-level hazard
% on s, weighting by how many matches are in state s.

    %% 0) Check inputs
    if abs(w1_x + w2_x - 1) > 1e-12
        error('w1_x + w2_x must sum to 1.');
    end
    [n1r, n1c] = size(QS1);
    [n2r, n2c] = size(QS2);
    if (n1r~=n1c) || (n2r~=n2c)
        error('QS1, QS2 must be square matrices.');
    end
    if n1r~=n2r
        error('QS1, QS2 must be same dimension (N+1 x N+1).');
    end
    N = n1r - 1;  % states = 0..N

    %% 1) Steady-state distributions
    pi1 = computeSteadyStateCTMC(QS1);
    pi2 = computeSteadyStateCTMC(QS2);

    %% 2) Compute the MATCH-level hazard in each state, then combine types
    p_loss_match_combined = nan(N,1);  % match-level hazard in state s
    mass_s = nan(N,1);  % fraction of suppliers in state s
    for s = 1:N
        % Rate that a type-1 firm in s goes to s-1 (i.e. loses "a" match):
        p_loss_firm_1_s = QS1(s+1, s) / -QS1(s+1, s+1);
        % => Per-match hazard = p_loss_firm_1_s / s
        p_loss_match_1_s = p_loss_firm_1_s / s

        % Rate that a type-2 firm in s goes to s-1
        p_loss_firm_2_s = QS2(s+1, s) / -QS2(s+1, s+1);
        p_loss_match_2_s = p_loss_firm_2_s / s

        % Fraction of all suppliers in state s
        mass_s_1 = w1_x * pi1(s+1);
        mass_s_2 = w2_x * pi2(s+1);
        mass_s_total = mass_s_1 + mass_s_2;

        % Weighted average across the two types, for the match-level hazard
        p_loss_match_combined(s) = ...
            (mass_s_1*p_loss_match_1_s + mass_s_2*p_loss_match_2_s) ...
            / mass_s_total;

        mass_s(s) = mass_s_total;
    end

    % "match_mass(s)" = s * mass_s(s) is the fraction of *all matches* in state s
    svals = (1:N)';
    match_mass = svals .* mass_s;

    %% 3) Regress the match-level hazard p_loss_match_combined(s) on s
    X = [ones(N,1), svals];
    if doWeighted
        % Weighted OLS, weighting each state by # of matches in that state
        w = sqrt(match_mass);
        Z = diag(w) * X;
        y = w .* p_loss_match_combined;
        bhat = Z \ y;
        resid = y - Z*bhat;
        SSR = sum(resid.^2);

        % Weighted R^2
        ybar_w = sum(w .* p_loss_match_combined) / sum(w);
        T = w .* (p_loss_match_combined - ybar_w);
        SST = sum(T.^2);
        R2 = 1 - SSR/SST;

        % Standard errors
        K = size(X,2);
        N_eff = sum(w.^2);  % approximate "effective" sample size
        sigma2 = SSR / (N_eff - K);
        covB = sigma2 * inv(Z'*Z);
        seB = sqrt(diag(covB));
    else
        % Unweighted OLS
        bhat = X \ p_loss_match_combined;
        p_hat = X*bhat;
        resid = p_loss_match_combined - p_hat;
        SSR = sum(resid.^2);
        SST = sum((p_loss_match_combined - mean(p_loss_match_combined)).^2);
        R2 = 1 - SSR/SST;

        K = size(X,2);
        sigma2 = SSR/(N-K);
        covB = sigma2*inv(X'*X);
        seB = sqrt(diag(covB));
    end

    beta = bhat;
    se   = seB;

    %% 4) Print summary
    if doWeighted
        wstr = 'Weighted OLS (match-level)';
    else
        wstr = 'Unweighted OLS (match-level)';
    end
    fprintf('\n--- %s on p_loss_match_combined(s) vs s ---\n', wstr);
    fprintf('Intercept (alpha) = %.4f   (SE=%.4f)\n', beta(1), se(1));
    fprintf('Slope (beta)      = %.4f   (SE=%.4f)\n', beta(2), se(2));
    fprintf('R^2 = %.4f\n\n', R2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pi = computeSteadyStateCTMC(Q)
% Same as your existing code:
%   Solves pi^T Q = 0, sum(pi)=1, pi>=0
    n = size(Q,1);
    if any(abs(sum(Q,2))>1e-10)
        warning('Some row(s) of Q do not sum to 0? Check Q''s construction.');
    end
    A = Q';
    b = zeros(n,1);
    A(n,:) = ones(1,n);
    b(n) = 1;

    pi_raw = A \ b;
    pi_raw(pi_raw<0) = 0;
    pi_sum = sum(pi_raw);
    if pi_sum<=0
        error('No valid stationary distribution found.');
    end
    pi = pi_raw / pi_sum;
end
