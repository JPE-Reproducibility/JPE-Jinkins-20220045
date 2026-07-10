function Qb = intensity_b(sb,thetab1,thetab2,param_indx,param_state,param_fix)

% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};

delta_B = param_fix{10};
delta_S = param_fix{11};
delta = param_fix{12};

% Index
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

thetaSum = thetab1.*(s1 ~= N1) + thetab2.*(s2 ~= N2);
nSum = s1.*(s1 ~= 0) + s2 .*(s2 ~= 0); %nSum = ns if (s1,s2)>>0

%Intensity matrix Qb
    Qb = diag(-sb.*thetaSum - (delta+delta_S)*nSum - delta_B);
    % filling in the off-diagonal elements            
    Qb(ms1ind2) = (delta+delta_S).*s1(ms1ind); %sk - 1, k = 1 JT: lose a low quality seller
    Qb(ms2ind2) = (delta+delta_S).*s2(ms2ind); %sk - 1, k = 2 JT: lose a high quality seller
    Qb(ps1ind2) = sb(ps1ind).*thetab1;  %sk + 1, k = 1 JT: gain low quality seller (revised for compat.)
    Qb(ps2ind2) = sb(ps2ind).*thetab2;  %sk + 1, k = 2 JT: gain high quality seller (revised ffor compat.)
    Qb(:,1) = Qb(:,1) + delta_B; % doesn't normalize Vb(0,0)