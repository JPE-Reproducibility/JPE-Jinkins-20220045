function theta = unpack_theta(x)
%UNPACK_THETA Maps an unconstrained vector to the economic parameters.

arguments
    x double
end

if numel(x) ~= 4
    error('Expected a 4-element input for the parameter vector.');
end

theta = struct();
theta.f_bar      = exp(x(1));
theta.delta_f    = exp(x(2));
theta.xi_H       = exp(x(3));
theta.rho_xi     = 1 ./ (1 + exp(-x(4)));
end
