function stats = report_match_shock_stats(phi, uncond_surplus_match, msb, mMb, param_state, param_fix)
%REPORT_MATCH_SHOCK_STATS Summarize buyer-type exposure to match shocks (Appendix E, eq. A-34).
%   Uses phi_{ij} cutoffs and unconditional surplus to classify buyer types into
%   (i) always rejected by low-type sellers, (ii) accepted only when the match
%   shock exceeds epsilon* (positive phi), and (iii) always accepted.  Also
%   reports visibility shares so the text can quote match-weighted fractions.

    Nx   = param_fix{4};
    wt_x = param_fix{14}(:);  % buyer-type mass weights
    tol  = 1e-10;

    % Low-type seller (column 1) acceptance indicators based on eq. (A-34)
    never_matches = uncond_surplus_match(:,1) <= tol;
    shock_gated   = (~never_matches) & (phi(:,1) > tol);
    always_accept = (~never_matches) & ~shock_gated;

    % Type-count shares
    stats.type_share.never_matches = mean(never_matches);
    stats.type_share.shock_gated   = mean(shock_gated);
    stats.type_share.always_accept = mean(always_accept);

    % Mass-weighted shares
    stats.mass_share.never_matches = wt_x' * never_matches;
    stats.mass_share.shock_gated   = wt_x' * shock_gated;
    stats.mass_share.always_accept = wt_x' * always_accept;

    % Visibility-based shares (probability a random match involves a buyer type)
    wt_mat = repmat(wt_x', size(msb,1), 1);
    visibility_by_type = sum(msb .* mMb .* wt_mat, 1)';
    visibility_by_type = visibility_by_type / sum(visibility_by_type);

    stats.visibility_share.never_matches = visibility_by_type' * never_matches;
    stats.visibility_share.shock_gated   = visibility_by_type' * shock_gated;
    stats.visibility_share.always_accept = visibility_by_type' * always_accept;

    % Top-half visibility share (used in the paper text)
    %top_half_count = floor(Nx/2);
    %top_half_idx = (Nx - top_half_count + 1):Nx;
    %stats.visibility_share.top_half = sum(visibility_by_type(top_half_idx));

    % Helper printout
    fprintf('\n--- Match-shock segmentation (Appendix E, eq. A-34) ---\n');
    fprintf('Buyer types never keeping low-type sellers: %4.1f%%%% of types, %4.1f%%%% of matches.\n', ...
        100*stats.type_share.never_matches, 100*stats.visibility_share.never_matches);
    fprintf('Buyer types needing favorable shocks:      %4.1f%%%% of types, %4.1f%%%% of matches.\n', ...
        100*stats.type_share.shock_gated, 100*stats.visibility_share.shock_gated);
    fprintf('Buyer types always accepted:               %4.1f%%%% of types, %4.1f%%%% of matches.\n', ...
        100*stats.type_share.always_accept, 100*stats.visibility_share.always_accept);
    %fprintf('Top 50%%%% of buyer types supply %4.1f%%%% of visibility.\n', 100*stats.visibility_share.top_half);
    fprintf('Matches subject to endogenous separation:  %4.1f%%%% (visibility-weighted).\n', ...
        100*stats.visibility_share.shock_gated);
end
