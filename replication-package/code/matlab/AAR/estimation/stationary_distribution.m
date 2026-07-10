function mu = stationary_distribution(T)
%STATIONARY_DISTRIBUTION Left eigenvector associated with eigenvalue 1.
%   Normalised so that mu sums to one. T must be row-stochastic.

arguments
    T double {mustBeSquareMatrix(T)}
end

[V, D] = eig(T.');
[~, idx] = min(abs(diag(D) - 1));
mu = real(V(:, idx)).';
mu = mu / sum(mu);
end

function mustBeSquareMatrix(M)
if size(M,1) ~= size(M,2)
    error('Transition matrix must be square.');
end
end
