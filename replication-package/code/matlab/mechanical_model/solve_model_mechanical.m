
function [thetas,thetab,U1,U2,V,u1,u2,Ms1,Ms2,Qbx,QS1,QS2,Cs,mMb,msb] = ...
    solve_model_mechanical(si,x,param_indx,param_state,param_fix)

%% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
N = param_fix{3};
Nx = param_fix{4};

param = x2param(x);
Ns = param{11};

wt_x  = param_fix{14};  % JT: weights for the buyer mass points

wt_old = param_fix{17}; % JT: weight on previous theta for updating algorithm

w2_x = param{7};        % JT: probability of better seller type
w1_x = 1 - w2_x;        % JT: probability of worse seller type

%% Save each type buyer's problem in a cell array, prepare for future parallel
%%%%%save for parallel computing, buyer-type specific
Vbx  = cell(Nx,1);
Qbx  = cell(Nx,1);
Mbx  = cell(Nx,1);
sbx  = cell(Nx,1);
Cs   = cell(Nx,1);

%% Iterate on thetab, thetas as outer loop for convergence

%initialize parameters
thetas=0;  
thetab=0; 
thetas_new=0.5; 
thetab_new=0.5;
iter=0;

while norm(thetas_new-thetas)>1e-6||norm(thetab_new-thetab)>1e-6

    %display(norm(thetas_new-thetas))
    iter=iter+1;
    
    thetas=wt_old*thetas + (1-wt_old)*thetas_new;  % JT: update seller match rate
    thetab=wt_old*thetab + (1-wt_old)*thetab_new;  % JT: update buyer match rate

    if iter==1
        thetab1=thetab*w1_x;  
        thetab2=thetab*w2_x;  
    else % JT: use relative search intensities of 2 buyer types if iter > 1
        thetab1=thetab*(U1/(U1+U2)); % JT: buyer match rate for worse sellers 
        thetab2=thetab*(U2/(U1+U2)); % JT: buyer match rate for better sellers
    end
    
    % JT: thetab1 and thetab2 correspond to theta^B*prob(type1) & theta^B*prob(type2)
    
    %% Start the loop for calculating transition probabilities
%    for b=1:1:Nx % (JT: uncomment to shut down parallel processing for debugging)    
    
    % JT: each iteration deals with a particular buyer type, given mkt. tightness.
    for b=1:Nx          
        
        % iterate to obtain buyer value, search effort, intensity matrix
        [Mb,Qb,sb] = val_b_mechanical(si.buyer(b),thetab1,thetab2,param_indx,param_state,param_fix);
      
        Mbx{b}=Mb; % JT: conditional prob. distribution of type b buyers across states (sum(Mb)=1)
        Qbx{b}=Qb; % JT: intensity matrix for type b buyer
        sbx{b}=sb; % JT: vector of search intensities, type b buyer
        
    end
    
    %% calculate seller's search for new matches
    [u1,u2,QS1,QS2,Ms1,Ms2,mMb,msb]=search_new_mechanical(si,thetas,param_fix,Mbx,sbx);
   
    %now aggregate up to V/U
    V=sum(sum(msb.*mMb.*repmat(wt_x,(N1+1)*(N2+1),1))); % total buyer search (vacancy)
    U1=sum(u1(1:N).*Ms1(1:N)*w1_x)*Ns; % total type 1 seller search, by state   
    U2=sum(u2(1:N).*Ms2(1:N)*w2_x)*Ns; % total type 2 seller search, by state   

    % JT: Ms1 and Ms2 are probability distributions of sellers, given type, across states.
    
    X=V*(1-exp(-(U1+U2)/V));
    thetab_new=X/V;       % JT: match rate per effective match seeking buyer
    thetas_new=X/(U1+U2); % JT: match rate per effective match seeking selle  

    if iter>500
        break
        disp('WARNING: solve_model did not converge')
    end
%     [norm(thetas_new-thetas) norm(thetab_new-thetab)]
%     disp('Ap')
%     [Ap]
%  fprintf('\r\n thetas and thetab: %5.3f %5.3f', [thetas thetab]);
end
