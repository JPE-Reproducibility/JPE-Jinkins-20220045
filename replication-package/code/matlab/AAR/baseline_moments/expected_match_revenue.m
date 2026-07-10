function [rev_type1, rev_type2] = expected_match_revenue(net_prof_s1, net_prof_s2, msb, mMb, param_fix)
%EXPECTED_MATCH_REVENUE Expected transfer per new match for each seller type.
%   Mirrors the probability weighting used in EVAL_S to keep notation
%   consistent with the legacy baseline simulation code.

N1   = param_fix{1};
N2   = param_fix{2};
Nx   = param_fix{4};
wt_x = param_fix{14};

% Preallocate containers that mirror eval_s.m
mNet1 = zeros(N1 * (N2 + 1), Nx);
mNet2 = zeros((N1 + 1) * N2, Nx);
msb1  = zeros(N1 * (N2 + 1), Nx);
msb2  = zeros((N1 + 1) * N2, Nx);
mMb1  = zeros(N1 * (N2 + 1), Nx);
mMb2  = zeros((N1 + 1) * N2, Nx);

for b = 1:Nx
    % Buyer specific objects reshaped to match eval_s.m bookkeeping
    sb_mat  = reshape(msb(:, b), N1 + 1, N2 + 1);
    Mb_mat  = reshape(mMb(:, b), N1 + 1, N2 + 1);
    np1_mat = reshape(net_prof_s1(:, b), N1 + 1, N2 + 1);
    np2_mat = reshape(net_prof_s2(:, b), N1 + 1, N2 + 1);

    msb1(:, b)  = reshape(sb_mat(1:end-1, :), N1 * (N2 + 1), 1);
    msb2(:, b)  = reshape(sb_mat(:, 1:end-1), (N1 + 1) * N2, 1);
    mMb1(:, b)  = reshape(Mb_mat(1:end-1, :), N1 * (N2 + 1), 1);
    mMb2(:, b)  = reshape(Mb_mat(:, 1:end-1), (N1 + 1) * N2, 1);
    mNet1(:, b) = reshape(np1_mat(2:end, :), N1 * (N2 + 1), 1);
    mNet2(:, b) = reshape(np2_mat(:, 2:end), (N1 + 1) * N2, 1);
end

% Probability a new match involves a specific buyer state/type
Psi1 = msb1 .* mMb1 .* repmat(wt_x, N1 * (N2 + 1), 1);
Psi2 = msb2 .* mMb2 .* repmat(wt_x, (N1 + 1) * N2, 1);

sumPsi1 = sum(Psi1, 'all');
sumPsi2 = sum(Psi2, 'all');

if sumPsi1 <= 0
    rev_type1 = 0;
else
    rev_type1 = sum(sum(mNet1 .* Psi1)) / sumPsi1;
end

if sumPsi2 <= 0
    rev_type2 = 0;
else
    rev_type2 = sum(sum(mNet2 .* Psi2)) / sumPsi2;
end

end
