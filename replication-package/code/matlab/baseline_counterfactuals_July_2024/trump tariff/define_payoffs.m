% Define the Payoff Functions

%% UPDATED December 2023. Use the precise difference equations to solve the buyer and seller payoffs!

%types of sellers
c1 = 1+t_f;  %normalized to 1
c2 = param{8};

%types of buyers
var_mu  = param{9};
mean_mu = 0;
% mean_mu = param{12};

%% Type of buyers and sellers, now need to be jointly estimated
%weights for types of buyers
quantile=NaN(1,Nx);
for i=1:Nx
    quantile(i)=(2*i-1)/(2*Nx); %Evenly split the interval [1/(2*Nx),(2*Nx - 1)/(2*Nx)]
end
wt_x=param_fix{14}; %equal size of each type 
logn_param_1 = mean_mu; %underlying normal mean 
logn_param_2 = sqrt(var_mu); %sqrt(underlying normal variance) -- var(mu) in text (v20)
profx=icdf('logn',quantile,logn_param_1,logn_param_2); 
profx=profx.^(gam - 1);  

%% define the total surplus function (without buyer appeal)
sales=zeros((N1+1)*(N2+1),1);
proft=zeros((N1+1)*(N2+1),1); 
pbs=zeros((N1+1)*(N2+1),1);   % buyer price index at each state
cs=zeros((N1+1)*(N2+1),1); %unit cost index at each state

taus1_app=zeros((N1+1)*(N2+1),1); % transfer to type 1 seller, at each state, approximated
taus2_app=zeros((N1+1)*(N2+1),1); % transfer to type 2 seller, at each state, approximated
tr1 = zeros((N1+1)*(N2+1),1); % within buyer share of the cost born by type 1 seller
tr2 = zeros((N1+1)*(N2+1),1); % within buyer share of the cost born by type 2 seller

for j=0:1:N2
    for i=0:1:N1
        proft((j)*(N1+1)+(i+1))=(gam^(-gam))*((gam-1)^(gam-1))*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        sales((j)*(N1+1)+(i+1))=((gam-1)/gam)^(gam-1)*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        % construct price index, buyer in state (i=n1,j=n2)
        pbs((j)*(N1+1)+(i+1)) = (gam/(gam-1))*([i j]*([c1 c2]'.^(1-alp)))^(1/(1-alp));  
        % construct cost index, buyer in state (i=n1,j=n2)
        cs((j)*(N1+1)+(i+1)) = ([i j]*([c1 c2]'.^(1-alp)))^(1/(1-alp));  
        if i>0
    
              taus1_app((j)*(N1+1)+(i+1)) = kappa*kap_s*c1^(1-alp)*...
                                              ([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp) -1);
              tr1((j)*(N1+1)+(i+1)) = c1^(1-alp)/...
                                              ([i j]*([c1 c2]'.^(1-alp)));
        end 
      
        if j>0

              taus2_app((j)*(N1+1)+(i+1)) = kappa*kap_s*c2^(1-alp)*...
                                              ([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp) -1);
              tr2((j)*(N1+1)+(i+1)) = c2^(1-alp)/...
                                              ([i j]*([c1 c2]'.^(1-alp)));
        end 
    end
end

%disp('check')
%[(s1.*taus1_app+s2.*taus2_app+profb_app)./proft]

%% solve precisely using the difference equation

taus1_update= taus1_app;
taus2_update= taus2_app;

taus1 = zeros((N1+1)*(N2+1),1);
taus2 = zeros((N1+1)*(N2+1),1);

iter =1; 

while norm(taus1-taus1_update)>1e-10||norm(taus2-taus2_update)>1e-10
% disp('iteration')
% [iter]

%make sure taus
taus1 = taus1_update*0.01+taus1*0.99;
taus2 = taus2_update*0.01+taus2*0.99;

%iterate on two types sequentially
for j=0:1:N2 %# of type 2 seller

    for i=0:1:N1 %# of type 1 seller
        if i>0
            taus1_update((j)*(N1+1)+(i+1)) = 0.5 * (proft((j)*(N1+1)+(i+1))-proft((j)*(N1+1)+(i))-j*(taus2((j)*(N1+1)+(i+1))-taus2((j)*(N1+1)+i))...
               -(i-1)*((taus1((j)*(N1+1)+(i+1))-taus1((j)*(N1+1)+i))));
        else
            taus1_update((j)*(N1+1)+(i+1)) = 0;
        end 


        if j>0
            taus2_update((j)*(N1+1)+(i+1)) = 0.5 * (proft((j)*(N1+1)+(i+1))-proft((j-1)*(N1+1)+(i+1))-(j-1)*(taus2((j)*(N1+1)+(i+1))-taus2((j-1)*(N1+1)+(i+1)))...
               -(i)*((taus1((j)*(N1+1)+(i+1))-taus1((j-1)*(N1+1)+(i+1)))));
        else
            taus2_update((j)*(N1+1)+(i+1)) = 0;
        end 
    end
end


iter = iter+1;
end

%profb = proft - s1.*taus1 - s2.*taus2;
%disp('check')
%[profb_app profb]

profxs=cell(Nx,1);
tauxs1=cell(Nx,1);
tauxs2=cell(Nx,1);

for b=1:1:Nx % add buyer profit scaling factor to profit expression
    profxs{b}=proft*profx(b); % gross profits for buyer type b
    tauxs1{b}=taus1*profx(b); % incremental profits, adding type 1 seller
    tauxs2{b}=taus2*profx(b); % incremental profits, adding type 2 seller
end

%% Calculate the total cost reimbursement 
cost = sales - proft; 


