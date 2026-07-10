% Define the relevant state vectors

%% UPDATED December 2023.

%record number of sellers for each within-buyer state
ns=zeros((N1+1)*(N2+1),1);  %total
s1=zeros((N1+1)*(N2+1),1);  %# of type 1
s2=zeros((N1+1)*(N2+1),1);  %# of type 2

for j=0:1:N2
    for i=0:1:N1
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




