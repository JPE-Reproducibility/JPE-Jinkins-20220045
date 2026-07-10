function results = estimate_parameters(empirical_summary, cfg)
%ESTIMATE_PARAMETERS Random-search MSM estimator tailored to the new moments.

arguments
    empirical_summary struct
    cfg struct
end

data_vec = empirical_summary.data_moments(:);
% MSM objective uses (m(θ)-m̂)' W (m(θ)-m̂); for now set W = I.
W = eye(numel(data_vec));

clamp = @(name, value) min(max(value, cfg.bounds.(name)(1)), cfg.bounds.(name)(2));

initial_theta = struct();
initial_theta.f_bar   = clamp('f_bar',   cfg.init_theta.f_bar);
initial_theta.delta_f = clamp('delta_f', cfg.init_theta.delta_f);
initial_theta.xi_H    = clamp('xi_H',    cfg.init_theta.xi_H);
initial_theta.rho_xi  = clamp('rho_xi',  cfg.init_theta.rho_xi);
x0 = pack_theta(initial_theta);

if isfield(cfg, 'random_start_draws') && ~isempty(cfg.random_start_draws)
    num_draws = cfg.random_start_draws;
else
    num_draws = 200;
end

obj_handle = @(x) msm_objective(x, data_vec, W, cfg);
residual_handle = @(x) msm_residual_vector(x, data_vec, cfg);

bounds_matrix = [cfg.bounds.f_bar; cfg.bounds.delta_f; cfg.bounds.xi_H; cfg.bounds.rho_xi];
lb_actual = bounds_matrix(:, 1);
ub_actual = bounds_matrix(:, 2);

best = evaluate_candidate(x0, obj_handle, struct('x', x0, 'f', Inf, 'model', [], 'sol', [], 'exitflag', [], 'output', []));
for j = 1:num_draws
    theta_rand = random_theta_within_bounds(cfg);
    x_rand = pack_theta(theta_rand);
    best = evaluate_candidate(x_rand, obj_handle, best);
end

use_lsq = isfield(cfg, 'use_lsqnonlin') && cfg.use_lsqnonlin && exist('lsqnonlin', 'file') == 2;
need_nelder = true;
if use_lsq
    Wsqrt = weight_matrix_factor(W);
    lsq_options = optimoptions('lsqnonlin', 'Display', 'off', ...
        'FunctionTolerance', 1e-12, 'StepTolerance', 1e-12, ...
        'MaxIterations', 400, 'MaxFunctionEvaluations', 2000);
    lsq_starts = {x0};
    if isempty(best.x) || norm(best.x - x0) > 1e-10
        lsq_starts{end+1} = best.x; %#ok<AGROW>
    end
    for idx = 1:numel(lsq_starts)
        try
            start_x = lsq_starts{idx};
            theta_start = unpack_theta(start_x);
            p_start = [theta_start.f_bar; theta_start.delta_f; theta_start.xi_H; theta_start.rho_xi];
            [p_lsq, resnorm, residual, exitflag_lsq, output_lsq] = ...
                lsqnonlin(@(p) msm_residual_actual(p, data_vec, cfg, Wsqrt), p_start, lb_actual, ub_actual, lsq_options);
            theta_candidate = theta_struct_from_vec(p_lsq, cfg);
            x_lsq = pack_theta(theta_candidate);
            [~, model_vec_lsq, sol_lsq] = evaluate_model_residual(x_lsq, data_vec, cfg);
            fval_lsq = residual' * (W * residual);
            if fval_lsq < best.f
                best = struct('x', x_lsq, 'f', fval_lsq, 'model', model_vec_lsq, ...
                    'sol', sol_lsq, 'exitflag', exitflag_lsq, ...
                    'output', struct('solver', 'lsqnonlin', 'resnorm', resnorm, ...
                        'residual', residual, 'info', output_lsq));
                if exitflag_lsq > 0
                    need_nelder = false;
                end
            end
        catch lsq_err %#ok<NASGU>
            continue;
        end
    end
end

if need_nelder
    nm_options = optimset('Display', 'off', 'TolFun', 1e-12, 'TolX', 1e-12, ...
        'MaxIter', 800, 'MaxFunEvals', 4000);
    [x_hat_nm, fval_nm, exitflag_nm, output_nm] = fminsearch(obj_handle, best.x, nm_options);
    [obj_final, model_vec_nm, sol_nm] = obj_handle(x_hat_nm);
    if obj_final < best.f
        best = struct('x', x_hat_nm, 'f', obj_final, 'model', model_vec_nm, 'sol', sol_nm, ...
            'exitflag', exitflag_nm, 'output', output_nm);
    end
end

x_hat = best.x;
fval = best.f;
model_vec = best.model;
sol = best.sol;
exitflag = best.exitflag;
output = best.output;

theta_hat = unpack_theta(x_hat);
theta_hat.f_bar   = clamp('f_bar',   theta_hat.f_bar);
theta_hat.delta_f = clamp('delta_f', theta_hat.delta_f);
theta_hat.xi_H    = clamp('xi_H',    theta_hat.xi_H);
theta_hat.rho_xi  = clamp('rho_xi',  theta_hat.rho_xi);
theta_hat.z_ratio = cfg.calib_z_ratio;
theta_hat.omega_H = cfg.calib_type_share;
theta_hat.shock_sigma = cfg.shock_sigma;

results = struct();
results.theta         = theta_hat;
results.model_moments = model_vec;
results.data_moments  = data_vec;
results.fval          = fval;
results.exitflag      = exitflag;
results.output        = output;
results.solution      = sol;
results.weight_matrix = W;
results.empirical_summary = empirical_summary;
results.cfg = cfg;
results.residuals = model_vec - data_vec;
results.cost_shares = compute_cost_shares(sol, theta_hat, cfg);

end

function best = evaluate_candidate(x0, obj_handle, best)
[obj_try, model_try, sol_try] = obj_handle(x0);
if obj_try < best.f
    best.x = x0;
    best.f = obj_try;
    best.model = model_try;
    best.sol = sol_try;
    best.exitflag = [];
    best.output = [];
end
end

function [obj, model_vec, sol] = msm_objective(x, data_vec, W, cfg)
[resid, model_vec, sol] = evaluate_model_residual(x, data_vec, cfg);
if any(~isfinite(resid))
    obj = 1e12;
    return;
end
obj = resid' * (W * resid);
end

function theta = random_theta_within_bounds(cfg)
fields = fieldnames(cfg.bounds);
theta = struct();
for k = 1:numel(fields)
    name = fields{k};
    bnd = cfg.bounds.(name);
    theta.(name) = bnd(1) + (bnd(2) - bnd(1)) * rand();
end
theta.z_ratio = cfg.calib_z_ratio;
theta.omega_H = cfg.calib_type_share;
end

function resid = msm_residual_vector(x, data_vec, cfg)
[resid, ~, ~] = evaluate_model_residual(x, data_vec, cfg);
end

function resid = msm_residual_actual(p, data_vec, cfg, Wsqrt)
theta = theta_struct_from_vec(p, cfg);
try
    sol = solve_model(theta, cfg);
    model_vec = model_moments(sol, theta, cfg);
    resid = Wsqrt * (model_vec - data_vec);
    if any(~isfinite(resid))
        resid = 1e6 * ones(size(data_vec));
    end
catch err %#ok<NASGU>
    resid = 1e6 * ones(size(data_vec));
end
end

function Wsqrt = weight_matrix_factor(W)
%WEIGHT_MATRIX_FACTOR Symmetric square root for MSM weighting.
Wsym = 0.5 * (W + W');
if isempty(Wsym)
    Wsqrt = [];
    return;
end
try
    Wsqrt = chol(Wsym, 'lower');
catch
    [V, D] = eig(Wsym);
    D = max(real(D), 0);
    Wsqrt = V * sqrt(D) * V';
end
end

function [resid, model_vec, sol] = evaluate_model_residual(x, data_vec, cfg)
theta = unpack_theta(x);
fields = fieldnames(cfg.bounds);
for k = 1:numel(fields)
    name = fields{k};
    theta.(name) = min(max(theta.(name), cfg.bounds.(name)(1)), cfg.bounds.(name)(2));
end
theta.z_ratio = cfg.calib_z_ratio;

try
    sol = solve_model(theta, cfg);
    model_vec = model_moments(sol, theta, cfg);
    resid = model_vec - data_vec;
    if any(~isfinite(resid))
        resid = 1e6 * ones(size(data_vec));
    end
catch err %#ok<NASGU>
    sol = [];
    model_vec = NaN(size(data_vec));
    resid = 1e6 * ones(size(data_vec));
end
end

function theta = theta_struct_from_vec(p, cfg)
names = {'f_bar', 'delta_f', 'xi_H', 'rho_xi'};
theta = struct();
for k = 1:numel(names)
    bnd = cfg.bounds.(names{k});
    theta.(names{k}) = min(max(p(k), bnd(1)), bnd(2));
end
theta.z_ratio = cfg.calib_z_ratio;
end
