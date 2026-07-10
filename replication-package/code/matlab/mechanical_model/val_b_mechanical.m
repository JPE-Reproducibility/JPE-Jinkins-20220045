
function [Mb,Qb,sb] = val_b_mechanical(sib,thetab1,thetab2,param_indx,param_state,param_fix)

    % Fixed Parameters
    N1 = param_fix{1};
    N2 = param_fix{2};

    delta_B = param_fix{10};
    delta_S = param_fix{11};
    delta = param_fix{12};

    ms1ind = param_indx{3};
    ms1ind2 = param_indx{4};
    ms2ind = param_indx{5};
    ms2ind2 = param_indx{6};

    ps1ind = param_indx{7};
    ps1ind2 = param_indx{8};
    ps2ind = param_indx{9};
    ps2ind2 = param_indx{10};

    s1 = param_state{2};
    s2 = param_state{3};

    % Arrival hazards by supplier type (Appendix A Mechanical Model, Eq. eom_buy1):
    % lambda_i,j^B(s) = sigma_i^B * theta_j^B, with truncation at state bounds.
    arr1 = sib * thetab1 .* (s1 ~= N1);
    arr2 = sib * thetab2 .* (s2 ~= N2);
    arr_total = arr1 + arr2;
    nSum = s1.*(s1 ~= 0) + s2 .*(s2 ~= 0); % nSum = ns if (s1,s2) >> 0

    % Mechanical model search intensity is type-specific and state-invariant
    % (except at the capped state where adding any partner is impossible).
    sb = sib * ((s1 ~= N1) | (s2 ~= N2));
    %protect against numerical error
    sb=(sb>0).*sb;
    
    %Intensity matrix Qb
    Qb = diag(-arr_total - (delta+delta_S)*nSum - delta_B);
    % JT: filling in the off-diagonal elements            
    Qb(ms1ind2) = (delta+delta_S).*s1(ms1ind); %sk - 1, k = 1 JT: lose a low quality seller
    Qb(ms2ind2) = (delta+delta_S).*s2(ms2ind); %sk - 1, k = 2 JT: lose a high quality seller
    Qb(ps1ind2) = arr1(ps1ind);  % sk + 1, k = 1: gain low-quality seller
    Qb(ps2ind2) = arr2(ps2ind);  % sk + 1, k = 2: gain high-quality seller
    Qb(:,1) = Qb(:,1) + delta_B; % doesn't normalize Vb(0,0) JT: what?
    
    Mb=(ones((N1+1)*(N2+1),(N1+1)*(N2+1))+Qb')\ones((N1+1)*(N2+1),1); %JT: I don't know the derivation here
    %%%correct for small numerical errors
    Mb=Mb.*(Mb>0);

end


