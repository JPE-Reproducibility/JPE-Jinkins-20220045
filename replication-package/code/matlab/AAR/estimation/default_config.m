function cfg = default_config()
%DEFAULT_CONFIG Centralises numerical and economic inputs.
%   The structure mirrors the objects described in AAR.pdf. Where possible
%   we reference the relevant equation numbers in inline comments.

cfg = struct();
this_dir = fileparts(mfilename('fullpath'));

%% Economic primitives (calibrated)
cfg.rho         = 0.05;    % EJTX continuous-time discount rate
cfg.beta        = exp(-cfg.rho); % discrete-time discount factor in Eq. (9)
cfg.sigma       = 3.25;    % Intermediate elasticity (geometric mean of EJTX elasticities)
cfg.tau         = 1.0;     % trade cost tau normalised per instruction (Eq. (4))
cfg.wage        = 1.0;     % wage normalisation
cfg.shock_mu    = 0.0;   % mean of additive normal fixed-cost shock ε ~ N(μ, σ²)
cfg.shock_sigma = 1.0;   % standard deviation of the normal shock (fixed)
cfg.mass_M      = 1.0;     % total incumbent mass M in Sec. 4
cfg.import_expenditure = 1.0; % Import expenditure normalisation E* used in Eq. (AAR_r_pi_xi)
cfg.delta_f     = 0.12;    % default re-entry wedge Δf (now estimated; kept for legacy use)

% Productivity dynamics Φ in Eq. (13); default keeps types permanent (identity)
cfg.phi = eye(2);

%% Loader settings for empirical moments
cfg.num_exit_bins       = 10;  % retained for diagnostics on the EJTX baseline moments
cfg.life_cycle_horizon  = 10;  % number of life-cycle points simulated for diagnostics
cfg.hazard_horizon      = 5;   % exporter-duration hazard horizon used in data diagnostics
cfg.life_cycle_target_age = 2;  % tenure used in the just-identified MSM system

%% Baseline guesses for the estimated parameters (θ = {f_bar, δ_f, ξ_H, ρ_ξ})
cfg.init_theta.f_bar    = 2.40;
cfg.init_theta.delta_f  = 0.25;
cfg.init_theta.xi_H     = 2.00;  % exporter-specific iceberg wedge ξ_H > ξ_L=1 (Eq. (AAR_price))
cfg.init_theta.rho_xi   = 0.95;  % persistence of the trade-cost shock (Eq. (AAR_Xi))

cfg.bounds.f_bar      = [1e-3, 50.0];
cfg.bounds.delta_f    = [1e-3, 5.0];
cfg.bounds.xi_H       = [1 + 1e-4, 5.0];
cfg.bounds.rho_xi     = [0.05, 0.999];

cfg.calib_z_ratio   = [];
cfg.calib_type_share = [];
cfg.override_calibration = struct('z_ratio', 1.574598, 'omega_H', 0.03);

cfg.use_lsqnonlin = exist('lsqnonlin', 'file') == 2;
cfg.num_starts = 1;
cfg.random_start_draws = 100;

%% Initial guesses for parameters estimated by MSM
cfg.init_delta_f  = []; %#ok<NASGU> retained for backwards compatibility

%% Numerical tolerances for the nested fixed-point routine (Sec. 5)
cfg.inner_tol   = 1.0e-10;
cfg.outer_tol   = 1.0e-8;
cfg.max_inner   = 5000;
cfg.max_outer   = 5000;
cfg.damping     = 0.35;
cfg.damping_min = 0.05;   % minimum relaxation step for outer loop
cfg.damping_max = 0.85;   % cap on relaxation step
cfg.damping_shrink = 0.5; % factor applied when outer loop stalls
cfg.damping_growth = 1.1; % factor applied when convergence improves

%% Moment bookkeeping (data ↔ model)
cfg.moment_labels = {
    'entry_rate_conditional_on_non_exporters', ...
    'duration_hazard_year_01', ...
    'within_firm_sales_ratio_year_02_over_01', ...
    'within_firm_sales_ratio_year_03_over_01' ...
};

%% Weighting matrix (identity by default; can be overridden downstream)
cfg.weight_matrix = eye(numel(cfg.moment_labels));

%% Output directory (always anchored in the estimation folder)
cfg.output_dir = fullfile(this_dir, 'output');
if ~exist(cfg.output_dir, 'dir')
    mkdir(cfg.output_dir);
end
end
