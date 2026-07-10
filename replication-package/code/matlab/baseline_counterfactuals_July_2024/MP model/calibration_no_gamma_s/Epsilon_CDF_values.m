function [CDF_eps_x,expect_cond_eps_x] =  Epsilon_CDF_values(x,sigma_eps)
    CDF_eps1_x = normcdf(sigma_eps - log(x)/sigma_eps);
    CDF_eps_x = normcdf(log(x)/sigma_eps);
    expect_cond_eps_x = min(exp((sigma_eps^2/2))*CDF_eps1_x/(1-CDF_eps_x), 1e5);
end

