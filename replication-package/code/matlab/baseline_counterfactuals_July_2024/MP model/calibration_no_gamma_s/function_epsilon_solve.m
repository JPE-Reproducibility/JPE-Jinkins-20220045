function funct_solve_z = function_epsilon_solve(z,profitsval,expect_cond_eps,CDF_eps, rho, delta, deltaB, deltaS, lambda, F, sbarg)    

    funct_solve_z =  (profitsval*z-F)*(1-sbarg) + lambda*(1-CDF_eps)*(1-sbarg)*((profitsval*expect_cond_eps - (profitsval*z))/(rho + delta + deltaB + deltaS + lambda));
end
