function y = log1pexp(x)
%LOG1PEXP Numerically stable log(1 + exp(x)).
%   Used in Eq. (11) when integrating over logit shocks.

y = log1p(exp(-abs(x))) + max(x, 0);
end
