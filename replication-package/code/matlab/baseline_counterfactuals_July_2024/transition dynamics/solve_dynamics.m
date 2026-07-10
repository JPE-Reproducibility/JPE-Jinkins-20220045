function [Vbx_seq,sbx_seq,Cs_seq,Qbx_seq,Vs1x_seq,Vs2x_seq,Mbx_seq,EVs1_seq,EVs2_seq,u1_seq,u2_seq,QS1_seq,QS2_seq,Ms1_seq,Ms2_seq,Ap_new]...
    = solve_dynamics(xT,x1,T,param_indx,param_state,param_fix,thetab1_old,thetab2_old,thetas_old,Ap_old,VbxT,sbxT,CsT,QbxT,Vs1xT,Vs2xT,Mbx1,u11,u21,QS11,QS21,Ms11,Ms21,tauxs1,tauxs2,profxs,pbs,profx)

%% Define estimated parameters
% baseline parameter vector at the ending equilibrium
paramT = x2param(xT);
NsT = paramT{11}; 
w2_xT = paramT{7}; 
w1_xT = 1-w2_xT;
gam = paramT{12}; 

% baseline parameter vector at the beginning equilibrium
param1 = x2param(x1);
Ns1 = param1{11}; 
w2_x1 = param1{7}; 

%% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
N = param_fix{3};
Nx = param_fix{4};
%alp = param_fix{7};
wt_old = param_fix{13}; 
wt_x=param_fix{14}; %equal size of each type 
dt = param_fix{21};
%% States
%ns = param_state{1};    % state index, (N1+1)*(N2*1) by 1
s1 = param_state{2};    % # of type 1 sellers, by state
s2 = param_state{3};    % # of type 2 sellers, by state

%% Structure Array to save the time sequence 
Vbx_seq = cell(T,1);
sbx_seq = cell(T,1);
Cs_seq = cell(T,1);
Qbx_seq = cell(T,1);

Vs1x_seq = cell(T,1);
Vs2x_seq = cell(T,1);

Mbx_seq = cell(T,1);
EVs1_seq = cell(T,1);
EVs2_seq = cell(T,1);

u1_seq=cell(T,1); u2_seq=cell(T,1); 
QS1_seq=cell(T,1); QS2_seq=cell(T,1);
Ms1_seq=cell(T,1); Ms2_seq=cell(T,1);

%initialize value function and policy function with terminal period
Vbx_seq{T}  = VbxT;
sbx_seq{T}  = sbxT;
Cs_seq{T}   = CsT;
Qbx_seq{T}  = QbxT;

Vs1x_seq{T} = Vs1xT;
Vs2x_seq{T} = Vs2xT;

%initialize industry structure with initial period
Mbx_seq{1} = Mbx1;

u1_seq{1} = u11;  u2_seq{1} = u21; 
QS1_seq{1} = QS11; QS2_seq{1} = QS21; 

%adjust for total mass at zero buyers if ending mass of sellers is not equal to beginning mass
if NsT~=Ns1
mass1 = Ms11*(1-w2_x1)*Ns1; mass1(1) = mass1(1)+(NsT-Ns1); %mass2 = Ms21*w2_x1*Ns1;
%reweight
Ms1 = mass1/sum(mass1);
%disp('check mix of sellers')
%[sum(mass2)/sum(mass1+mass2) w2_xT]
Ms1_seq{1}= Ms1; Ms2_seq{1}= Ms21;
else
    Ms1_seq{1}= Ms11; Ms2_seq{1}= Ms21;
end

%% Update on sequence of equilibrium objects
thetab1_new=zeros(T,1); thetab2_new=zeros(T,1); thetas_new=zeros(T,1);
Ap_new=zeros(T,1); 

for iter=1:1:60 %iterate for the path convergence
%% iterate backwards
tic
for t = T:-1:2
    thetab1 = thetab1_old(t); thetab2 = thetab2_old(t); Ap = Ap_old(t); 

    %Feed in the current period value function, policy function.
    Vbx = Vbx_seq{t}; sbx = sbx_seq{t}; Cs = Cs_seq{t}; 
    Vs1x = Vs1x_seq{t}; Vs2x = Vs2x_seq{t};

    parfor b=1:Nx 
       % define flow payoff at each state (s1,s2)
        tau1 = tauxs1{b}/Ap;  
        tau2 = tauxs2{b}/Ap;
        prof = profxs{b}/Ap - (s1.*tau1 + s2.*tau2); 

        Vb = Vbx{b}; sb = sbx{b}; csb = Cs{b};
        Vs1 = Vs1x{b}; Vs2 = Vs2x{b};

    % use backward induction to solve value func of buyer
    [Vbt,sbt,csbt,Qbt] = val_bt(prof,thetab1,thetab2,Vb,sb,csb,paramT,param_indx,param_state,param_fix);
    % use backward induction to solve value func of a match
    [Vs1t,Vs2t] = val_st(tau1,tau2,sb,thetab1,thetab2,Vs1,Vs2,param_indx,param_state,param_fix); 
    
    % save the t-1 value func, policy func, and int. matrix 
        Vbx{b} = Vbt;
        sbx{b}  = sbt;
        Cs{b} = csbt;
        Qbx{b} = Qbt; 

        Vs1x{b} = Vs1t;
        Vs2x{b} = Vs2t;
    end
    % save to update period t-1
    Vbx_seq{t-1}=Vbx; sbx_seq{t-1}=sbx; Cs_seq{t-1}=Cs; 
    Vs1x_seq{t-1}=Vs1x; Vs2x_seq{t-1}=Vs2x; Qbx_seq{t-1}=Qbx;
end
toc

%% iterate forward to obtain Mbt, Mst, and equilibrium objects

tic
for t = 1:1:T
    
    %1. compute seller search intensity given Mb
    Mbx = Mbx_seq{t}; sbx=sbx_seq{t}; Vs1x=Vs1x_seq{t}; Vs2x=Vs2x_seq{t};
    % expected value of a new relationship
   [EVs1,EVs2,msb,mMb] = eval_s(Vs1x,Vs2x,Mbx,sbx,param_fix);
    %search effort
    thetas = thetas_old(t);
   [u1,u2,Cs1,Cs2]=search_newbuyer(EVs1,EVs2,thetas,paramT,param_fix);
    u1_seq{t} = u1; u2_seq{t} = u2;
    %intensity matrix
    QS1 = intensity_s(u1,thetas,param_fix);
    QS2 = intensity_s(u2,thetas,param_fix);
    QS1_seq{t} = QS1; QS2_seq{t} = QS2; 

    %2. feed in current Mb and compute Mb', given Qb
    Qbx=Qbx_seq{t}; 
    for b = 1:Nx
     Mb = Mbx{b}; 
     Mbt = Mb + Qbx{b}'*Mb*dt;
    %update
     Mbx{b}=Mbt;
    end

    %3. feed in current Ms and compute Ms', given Qs
    Ms1 = Ms1_seq{t};  Ms2 = Ms2_seq{t};
    Ms1t = Ms1 + QS1'*Ms1*dt;
    Ms2t = Ms2 + QS2'*Ms2*dt;
    
    if t<T
    Mbx_seq{t+1} = Mbx; Ms1_seq{t+1}= Ms1t; Ms2_seq{t+1}= Ms2t;
    end
    
    %4. compute the equilibrium objects. 
    %now aggregate up to V/U
    V=sum(sum(msb.*mMb.*repmat(wt_x,(N1+1)*(N2+1),1))); % total buyer search (vacancy)
    U1=sum(u1(1:N).*Ms1(1:N)*w1_xT)*NsT; % total type 1 seller search, by state   
    U2=sum(u2(1:N).*Ms2(1:N)*w2_xT)*NsT; % total type 2 seller search, by state   

    X=V*(1-exp(-(U1+U2)/V));
    thetab=X/V;       % JT: match rate per effective match seeking buyer
    thetas=X/(U1+U2); % JT: match rate per effective match seeking seller
    thetab1=thetab*(U1/(U1+U2)); % JT: buyer match rate for worse sellers 
    thetab2=thetab*(U2/(U1+U2)); % JT: buyer match rate for better sellers

    thetab1_new(t)=thetab1; thetab2_new(t)=thetab2; thetas_new(t) = thetas;

    %aggregate up to update price index
    Ap= sum(sum(repmat(pbs.^(1-gam),1,Nx).*mMb.*repmat(profx,(N1+1)*(N2+1),1).*repmat(wt_x,(N1+1)*(N2+1),1)));
    Ap_new(t)=Ap; 

end


toc

disp('iter')
[iter]
disp('error')
[norm(thetas_old-thetas_new) norm(Ap_old-Ap_new)]

%update
thetab1_old=thetab1_old*wt_old+thetab1_new*(1-wt_old);
thetab2_old=thetab2_old*wt_old+thetab2_new*(1-wt_old);
thetas_old=thetas_old*wt_old+thetas_new*(1-wt_old);
Ap_old=Ap_old*wt_old+Ap_new*(1-wt_old);


end
