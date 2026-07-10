function [beta, se, R2] = ...
       match_death_reg_MP(Q)
%   Regresses model-implied "match death probability" on
%   the number of partners (s) in each state, using OLS.
%   Major help from chatGPT here
%
%   INPUT:
%       Q  = (N+1)x(N+1) transition-rate matrix for states 0..N,
%            in continuous time.  Q(i,j) is rate of going from
%            state (i-1) to state (j-1), with i,j = 1..(N+1).
%
%   OUTPUT:
%       beta = [alpha; slope],  i.e. the 2x1 vector of OLS estimates
%       se   =  2x1 vector of standard errors for alpha and slope
%       R2   =  R-squared from the regression
%
%   In the code below, we:
%     - For s=1..N, compute p_loss(s) = Q(s->s-1) / -Q(s,s).
%     - Then run OLS:  p_loss(s) = alpha + beta * s + e_s.
%
%   NOTE: If your indexing differs, you may need to adjust how
%         Q is referenced.  The example assumes the row # = (s+1).

    % Figure out how many states we have.
    % If Q is (N+1)x(N+1), then max state = N:
    N = size(Q,1) - 1;
    if N < 1
        error('Not enough states in Q, or Q not sized (N+1)x(N+1).');
    end

    % Preallocate array for the "loss probability"
    p_loss = nan(N,1);   % we only define for s=1..N, ignoring s=0

    % Loop over states s=1..N
    for s = 1:N
        % Rate from s to s-1 is  Q(s+1, s).
        % Rate out of s = -Q(s+1, s+1).
        num   = Q(s+1, s);
        denom = - Q(s+1, s+1);

        % "Death probability" = fraction of outflow that results in losing a partner
        p_loss(s) = num / denom;
    end

    % Now do a simple OLS:  p_loss(s) on [1, s].
    % The regressor vector s is 1..N
    svals = (1:N)';
    X = [ones(N,1), svals];   % N x 2
    % OLS estimates:
    bhat = X \ p_loss;        % 2x1

    % Fitted values & residuals
    p_hat = X * bhat;
    resid = p_loss - p_hat;

    % Compute standard errors from usual OLS formula
    SSR = sum(resid.^2);
    SST = sum( (p_loss - mean(p_loss)).^2 );
    R2  = 1 - (SSR / SST);

    K = size(X,2);      % 2 regressors (constant & slope)
    sigma2 = SSR / (N - K);
    covB   = sigma2 * inv(X' * X);
    seB    = sqrt(diag(covB));

    % Prepare output
    beta = bhat;   % [alpha; slope]
    se   = seB;    % standard errors

    % OPTIONAL: print or display results
    fprintf('\n--- OLS: p_loss(s) on s ---\n');
    fprintf('Intercept (alpha)  = %.4f   (SE=%.4f)\n', beta(1), se(1));
    fprintf('Slope     (beta)   = %.4f   (SE=%.4f)\n', beta(2), se(2));
    fprintf('R^2 = %.4f\n\n', R2);
end

