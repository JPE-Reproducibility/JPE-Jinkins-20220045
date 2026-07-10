
%% seller's search decision for new matches
function [u1,u2,QS1,QS2,Ms1,Ms2,mMb,msb]=search_new_mechanical(si,thetas,param_fix,Mbx,sbx)

    N1 = param_fix{1};
    N2 = param_fix{2};
    N = param_fix{3};
    Nx = param_fix{4};
    
    delta_B = param_fix{10};
    delta_S = param_fix{11};
    delta = param_fix{12};
     
    msb=zeros((N1+1)*(N2+1),Nx); % JT: ea. column will give search intensities 
                                 % in all possible states for a partic. buyer type
    mMb=zeros((N1+1)*(N2+1),Nx); % JT: ea. column will give dist. of a partic.
                                 % buyer type across states
    
    for b=1:1:Nx
        msb(:,b)=sbx{b};
        mMb(:,b)=Mbx{b};
        % JT: differences in shapes reflect zeros in buyers' s1 vs. s2
        % states. (Seller can't be linked to a buyer with none of its type.)
        
    end

    % Mechanical model: seller search intensities are type-specific constants.
    % Matching arrival hazard is sigma_j^S * theta^S (Appendix transitions).
    u1 = si.seller(1) * ones(N+1,1);
    u2 = si.seller(2) * ones(N+1,1);
    u1(end)=0; u2(end)=0;  
   
    %Intensity Matrix for Two-types (QS1', QS2' are intensity matrix)
    QS1=zeros(N+1,N+1); QS2=zeros(N+1,N+1);
    QS1(1,2)=u1(1)*thetas; QS1(1,1)=-QS1(1,2); 
    QS1(end,end-1)=(delta+delta_B)*N; QS1(end,end)=-QS1(end,end-1)-delta_S;
    QS2(1,2)=u2(1)*thetas; QS2(1,1)=-QS2(1,2); 
    QS2(end,end-1)=(delta+delta_B)*N; QS2(end,end)=-QS2(end,end-1)-delta_S;
    % JT: hazards of jumping up to one more client now adjusted for expected success rate, aS
    for i=2:1:N
        QS1(i,i+1)=u1(i)*thetas; QS1(i,i-1)=(delta+delta_B)*(i-1); QS1(i,i)=-(QS1(i,i+1)+QS1(i,i-1))-delta_S;
        QS2(i,i+1)=u2(i)*thetas; QS2(i,i-1)=(delta+delta_B)*(i-1); QS2(i,i)=-(QS2(i,i+1)+QS2(i,i-1))-delta_S;
    end 
    QS1(2:end,1)=QS1(2:end,1)+delta_S;
    QS2(2:end,1)=QS2(2:end,1)+delta_S;

    Ms1=(ones((N+1),(N+1))+QS1')\ones((N+1),1);
    Ms2=(ones((N+1),(N+1))+QS2')\ones((N+1),1);
    
    %correct for small numerical errors
    Ms1=Ms1.*(Ms1>0);
    Ms2=Ms2.*(Ms2>0);
    
end
