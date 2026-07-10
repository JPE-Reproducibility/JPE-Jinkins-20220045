function x = pack_theta(theta)
%PACK_THETA Maps economic parameters into an unconstrained vector.
%   θ = (f_bar, δ_f, ξ_H, ρ_ξ). Positivity and (0,1) bounds use
%   log / logit transforms.

arguments
    theta struct
end

x = [
    log(theta.f_bar);
    log(theta.delta_f);
    log(theta.xi_H);
    log(theta.rho_xi / (1 - theta.rho_xi))
];
end
