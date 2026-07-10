
% Define the Payoff Functions, Dec 2019

%% Define a vectors of payoffs for each within-buyer state

sales=zeros((N1+1)*(N2+1),1); % JT: added this line (copied from baseline version of define-payoffs.m)
profb=zeros((N1+1)*(N2+1),1); % buyer profits before search costs and transfers at each state
pbs=zeros((N1+1)*(N2+1),1);   % buyer price index at each state

taus1=zeros((N1+1)*(N2+1),1); % increment to profit, additional type 1 seller, at each state
taus2=zeros((N1+1)*(N2+1),1); % increment to profit, additional type 2 seller, at each state

kap_b = param_fix{9};
kap_s = param_fix{20};

%record number of sellers for each within-buyer state
ns=zeros((N1+1)*(N2+1),1);  %total
s1=zeros((N1+1)*(N2+1),1);  %# of type 1
s2=zeros((N1+1)*(N2+1),1);  %# of type 2

for j=0:1:N2
    for i=0:1:N1
        
        % define the payoff function and price index (JT: without buyer effect)
        profb((j)*(N1+1)+(i+1))=kap_b*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        
        % JT: I added this line (copied from baseline version of define_payoffs.m
        sales((j)*(N1+1)+(i+1))=((gam-1)/gam)^(gam-1)*([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp));
        
        % construct price index, buyer in state state (i=n1,j=n2)
        pbs((j)*(N1+1)+(i+1)) = (gam/(gam-1))*([i j]*([c1 c2]'.^(1-alp)))^(1/(1-alp));     
        
        % transfer to sellers (JT: without buyer appeal effect)
        if i>0

              taus1((j)*(N1+1)+(i+1)) = kap_s*c1^(1-alp)*...
                  ([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp) -1);
        end 
      
        if j>0

             taus2((j)*(N1+1)+(i+1)) = kap_s*c2^(1-alp)*...
                 ([i j]*([c1 c2]'.^(1-alp)))^((1-gam)/(1-alp) - 1);  
  
        end  
        
        % auxiliary variables for buyer's problem
        ns((j)*(N1+1)+(i+1))=j+i;
        s1((j)*(N1+1)+(i+1))=i;
        s2((j)*(N1+1)+(i+1))=j;
    end
end

param_state = cell(3,1);
param_state{1}=ns;
param_state{2}=s1;
param_state{3}=s2;

profxs=cell(Nx,1);
tauxs1=cell(Nx,1);
tauxs2=cell(Nx,1);

for b=1:1:Nx % JT: add buyer profit scaling factor to profit expression
    profxs{b}=profb*profx(b); % gross profits for buyer type b
    tauxs1{b}=taus1*profx(b); % incremental profits, adding type 1 seller
    tauxs2{b}=taus2*profx(b); % incremental profits, adding type 2 seller
end

%% Calculate the total cost reimbursement (added by JT)
cost = sales - profb; 
