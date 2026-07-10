%% Simulate firm life cycle in export/import 

thetab1=thetab*(U1/(U1+U2)); 
thetab2=thetab*(U2/(U1+U2));
lambda = param{13};
Nx = param_fix{4};
s1 = param_state{2};
s2 = param_state{3};

% Steady-state buyer-type weights for each seller type (needed for λφ hazards)
ss_mass_by_pair = zeros(Nx, 2);
for b = 1:Nx
    ss_mass_by_pair(b, 1) = sum(mMb(:, b) .* s1);
    ss_mass_by_pair(b, 2) = sum(mMb(:, b) .* s2);
end
if sum(ss_mass_by_pair(:,1)) > 0
    prob_ss_buyer_type1 = ss_mass_by_pair(:,1) / sum(ss_mass_by_pair(:,1));
else
    prob_ss_buyer_type1 = ones(Nx,1) / Nx;
end
if sum(ss_mass_by_pair(:,2)) > 0
    prob_ss_buyer_type2 = ss_mass_by_pair(:,2) / sum(ss_mass_by_pair(:,2));
else
    prob_ss_buyer_type2 = ones(Nx,1) / Nx;
end
phi_type1 = prob_ss_buyer_type1' * phi(:,1);
phi_type2 = prob_ss_buyer_type2' * phi(:,2);

nmatch_year_buyer=zeros(4,Nx);

TT = 35; % maximum age to graph
cnt_traj_b  = zeros(TT,Nx);
mean_traj_b = zeros(TT,Nx);
std_traj_b  = zeros(TT,Nx);

parfor j=1:Nx
     vx=msb(:,j); % buyer-type specific search intensity
    phi_vec_j = phi(j,:);
    [cnt_traj_b(:,j),mean_traj_b(:,j),std_traj_b(:,j)] = sim_b(vx, thetab1, thetab2, param_fix, TT, phi_vec_j, lambda);

end

% age-specific mean # matches, 1:TT
mean_gph_b = mean_traj_b(2:end,:);
% measure of active buyers, by age 1:TT
cnt_gph_b = cnt_traj_b(2:end,:);   
% age-specific dispersion in # matches, 1:TT
std_gph_b = std_traj_b(2:end,:);   

agg_cnt_gph_b  = sum(cnt_traj_b(1:end-1,:),2);
% agg_mean_gph_b = sum(mean_traj_b(1:end-1,:).*cnt_traj_b(1:end-1,:),2);
% agg_gph_b = [agg_cnt_gph_b(2:end,:) agg_mean_gph_b(2:end,:)];
agg_mean_gph_b = sum(mean_traj_b(1:end-1,:).*cnt_traj_b(1:end-1,:),2)./agg_cnt_gph_b;
% agg_gph_b = [agg_cnt_gph_b(2:end,:)./agg_cnt_gph_b(2) agg_mean_gph_b(2:end,:)./agg_mean_gph_b(2)];


%% Cohort maturation: Seller

u=[u1 u2]; %  concatenate type-specific seller search policy functions

cnt_traj_s  = zeros(TT,2); % measure of active exporters by type, age 1:TT
mean_traj_s = zeros(TT,2); % average # matches by type, age 1:TT
std_traj_s  = zeros(TT,2); % dispersion in # matches, age 1:TT

phi_seller_types = [phi_type1, phi_type2];
for j=1:1:2      
    [cnt_traj_s(:,j),mean_traj_s(:,j),std_traj_s(:,j)] = sim_s(j, u(:,j), thetas, param_fix, param, TT, lambda, phi_seller_types(j));  
end

cnt_gph_s  = cnt_traj_s(1:end-1,:);
mean_gph_s = mean_traj_s(1:end-1,:);
std_gph_s  = std_traj_s(1:end-1,:);

agg_cnt_gph_s  = sum(cnt_traj_s(1:end-1,:),2);
agg_mean_gph_s = sum(mean_traj_s(1:end-1,:).*cnt_traj_s(1:end-1,:),2)./agg_cnt_gph_s;







