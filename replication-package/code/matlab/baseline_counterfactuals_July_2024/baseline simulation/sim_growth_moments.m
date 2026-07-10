%% Simulate firm life cycle in export/import 

thetab1=thetab*(U1/(U1+U2)); 
thetab2=thetab*(U2/(U1+U2));

nmatch_year_buyer=zeros(4,Nx);

TT = 30; % maximum age to graph
cnt_traj_b  = zeros(TT,Nx);
mean_traj_b = zeros(TT,Nx);
std_traj_b  = zeros(TT,Nx);

parfor j=1:Nx
     vx=msb(:,j); % buyer-type specific search intensity
    [cnt_traj_b(:,j),mean_traj_b(:,j),std_traj_b(:,j)] = sim_b(vx, thetab1, thetab2, param_fix, TT);

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

for j=1:1:2      
    [cnt_traj_s(:,j),mean_traj_s(:,j),std_traj_s(:,j)] = sim_s(j, u(:,j), thetas, param_fix, param, TT);  
end

cnt_gph_s  = cnt_traj_s(1:end-1,:);
mean_gph_s = mean_traj_s(1:end-1,:);
std_gph_s  = std_traj_s(1:end-1,:);

agg_cnt_gph_s  = sum(cnt_traj_s(1:end-1,:),2);
agg_mean_gph_s = sum(mean_traj_s(1:end-1,:).*cnt_traj_s(1:end-1,:),2)./agg_cnt_gph_s;








