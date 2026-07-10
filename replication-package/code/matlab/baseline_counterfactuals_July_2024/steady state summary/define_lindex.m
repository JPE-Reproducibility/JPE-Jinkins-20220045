%% Create matrix that will help extract current state (s1,s2) and "adjacent value" for (s1+1,s2),(s1,s2+1)

%% initialization  

sdim = 1:(N1+1)*(N2+1); %linear index of state (s1,s2)
mdim = [size(sdim,2) size(sdim,2)];   %dimension of all transition matrix, Ts1, Ts2, Qb  
%define the adjacency cells for all possible future states
%Case I, (s1-1,s2) for all s1~=0  (JT: lose a low quality seller)
ms1ind = sdim(s1 ~= 0); %sk - 1, k = 1
ms1ind2 = sub2ind(mdim, ms1ind, (ms1ind-1)); %find linear index (s1-1,s2)
%Case II, (s1,s2-1) for all s2~=0  (JT: lose a high quality seller)
ms2ind = sdim(s2 ~= 0); %sk - 1, k = 2  
ms2ind2 = sub2ind(mdim, ms2ind, (ms2ind-(N1+1))); %find linear index (s1,s2-1)
%Case III, (s1+1,s2) for all s1~=N1  (JT: gain a low quality seller)
ps1ind = sdim(s1 ~= N1); %sk + 1, k = 1
ps1ind2 = sub2ind(mdim, ps1ind, (ps1ind+1)); %find linear index (s1+1,s2)
%Case IV, (s1,s2+1) for all s2~=N2  (JT: gain a high quality seller)
ps2ind = sdim(s2 ~= N2); %sk + 1, k = 2
ps2ind2 = sub2ind(mdim, ps2ind, (ps2ind+(N1+1)));

%define matrix useful for value function iterations 
% (s1+1,s2) is a block diagonal matrix
adds1=zeros(N1+1,N1+1); 
for i=1:1:N1
    adds1(i,i+1)=1;
end
adds1=kron(eye(N2+1,N2+1),adds1);
%(s1,s2+1) is a diag matrix at upper right corner 
adds2=[ [zeros(N2*(N1+1),N1+1) eye((N1+1)*N2)]; zeros(N1+1,(N1+1)*(N2+1))];
%create matrix that equals zeros when s1==N1; 
zero1=eye((N1+1)*(N2+1)).*repmat(repmat([ones(1,N1) 0],1,N2+1),(N1+1)*(N2+1),1);
%creat matrix that equals zeros when s2=N2
zero2=eye((N1+1)*(N2+1)).*repmat([ones(1,(N1+1)*N2),zeros(1,N1+1)],(N1+1)*(N2+1),1);

param_indx=cell(14,1);

param_indx{1} = sdim;
param_indx{2} = mdim;
param_indx{3}= ms1ind;
param_indx{4}= ms1ind2;
param_indx{5}= ms2ind;
param_indx{6}= ms2ind2;
param_indx{7}= ps1ind;
param_indx{8}= ps1ind2;
param_indx{9}= ps2ind;
param_indx{10} = ps2ind2;
param_indx{11}=adds1;
param_indx{12}=adds2;
param_indx{13}=zero1;
param_indx{14}=zero2;


