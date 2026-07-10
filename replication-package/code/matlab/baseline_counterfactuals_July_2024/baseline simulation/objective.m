
function out = objective(x, param_indx, param_state, param_fix, data_moments, cov_v)
    try
        % Solve the model and extract results
        [thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Ms1, Ms2, Qbx, QS1, QS2, ...
            net_prof_b, Cs, Cs1, Cs2, net_prof_s1, net_prof_s2] = ...
            solve_model(x, param_indx, param_state, param_fix);

        % Generate model-based moments
        sim_moments_baseline;

        % Weight matrix setup
        wgt_mat = param_fix{17};
        W = (wgt_mat == 1) * inv(cov_v) + (wgt_mat ~= 1) * eye(size(data_moments, 2));

        % Compute objective function value
        residual = data_moments - model_moments;
        out = residual' * W * residual;

        % Print parameter estimates
        coefvec = cell2mat(param);
        print_parameters(coefvec, param_fix, out);

        % Log output to file
        log_output(x, out);

    catch
        fprintf('\r\nProblem evaluating objective function \r\n');
        out = 1e+10;
    end

    % Plot fit
    plot_fit;
end

% Helper function to print parameter estimates
function print_parameters(coefvec, param_fix, out)
    fprintf('\r\n PARAMETER ESTIMATES: \n');
    fprintf(' Buyer search cost scalar     = %.5f\n', coefvec(1));
    fprintf(' Seller search cost scalar    = %.5f\n', coefvec(3));
    fprintf(' Buyer network parameter      = %.5f\n', coefvec(5));
    fprintf(' Seller network parameter     = %.5f\n', coefvec(6));
    fprintf(' Share of high-type sellers   = %.5f\n', coefvec(7));
    fprintf(' High-type seller cost adv.   = %.5f\n', coefvec(8));
    fprintf(' Buyer type dispersion        = %.5f\n', coefvec(9));
    fprintf(' Seller-to-buyer ratio        = %.5f\n', coefvec(11));
    fprintf(' Cross-store elasticity       = %.5f\n', coefvec(12));

    fprintf('\r\n EXOGENOUSLY FIXED PARAMETERS: \n');
    fprintf(' Buyer search cost exponent   = %.5f\n', coefvec(2));
    fprintf(' Seller search cost exponent  = %.5f\n', coefvec(4));
    fprintf(' Seller bargaining parameter  = %.5f\n', coefvec(10));
    fprintf(' Cross-product elasticity     = %.5f\n', param_fix{7});

    fprintf('\r\n OBJECTIVE FUNCTION = %.5f\n', out);
end

% Helper function to log output to a file
function log_output(x, out)
    fileID1 = fopen('Output/ga_running_output.txt', 'a');
    if fileID1 == -1
        warning('Unable to open log file.');
        return;
    end

    fprintf(fileID1, '\r\n Fit metric: %9.5f', out);
    fprintf(fileID1, '\r\n Parameters: \n');
    fprintf(fileID1, '%9.5f ', x);
    fprintf(fileID1, '\r\n\n');
    fclose(fileID1);
end

