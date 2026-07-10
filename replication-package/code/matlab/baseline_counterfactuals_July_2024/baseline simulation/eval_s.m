
function [EVs1,EVs2,msb,mMb] = eval_s(Vs1x,Vs2x,Mbx,sbx,param_fix)

%calculate the expected value of a new relationship
% Fixed Parameters
N1 = param_fix{1};
N2 = param_fix{2};
Nx = param_fix{4};
wt_x = param_fix{14};

% Read in all the values for matches
    mVs1=zeros((N1)*(N2+1),Nx); mVs2=zeros((N1+1)*N2,Nx);
    msb1=zeros((N1)*(N2+1),Nx); msb2=zeros((N1+1)*N2,Nx);
    mMb1=zeros((N1)*(N2+1),Nx); mMb2=zeros((N1+1)*N2,Nx);

    msb=zeros((N1+1)*(N2+1),Nx); % JT: ea. column will give search intensities 
                                 % in all possible states for a partic. buyer type
    mMb=zeros((N1+1)*(N2+1),Nx); % JT: ea. column will give dist. of a partic.
                                 % buyer type across states

    for b=1:Nx
        msb(:,b)=sbx{b};
        mMb(:,b)=Mbx{b};
        % JT: differences in shapes reflect zeros in buyers' s1 vs. s2
        % states. (Seller can't be linked to a buyer with none of its type.)
        Vs1=reshape(Vs1x{b},N1+1,N2+1);
        mVs1(:,b)=reshape(Vs1(2:end,:),N1*(N2+1),1);
        Vs2=reshape(Vs2x{b},N1+1,N2+1);
        mVs2(:,b)=reshape(Vs2(:,2:end),(N1+1)*N2,1);    

        sb1=reshape(sbx{b},N1+1,N2+1);
        msb1(:,b)=reshape(sb1(1:end-1,:),N1*(N2+1),1); 
        sb2=reshape(sbx{b},N1+1,N2+1);
        msb2(:,b)=reshape(sb2(:,1:end-1),(N1+1)*N2,1);

        Mb1=reshape(Mbx{b},N1+1,N2+1);
        mMb1(:,b)=reshape(Mb1(1:end-1,:),N1*(N2+1),1); 
        Mb2=reshape(Mbx{b},N1+1,N2+1);
        mMb2(:,b)=reshape(Mb2(:,1:end-1),(N1+1)*N2,1);
    end

  % Probability next match is with each possible buyer type in each
  % possible state. Type 1 seller's perspective. 
    Ps1=msb1.*mMb1.*repmat(wt_x,N1*(N2+1),1)/sum(sum(msb1.*mMb1.*repmat(wt_x,N1*(N2+1),1)));
    EVs1=sum(sum(mVs1.*Ps1)');
  % Probability next match is with each possible buyer type in each
  % possible state.  
    Ps2=msb2.*mMb2.*repmat(wt_x,(N1+1)*(N2),1)/sum(sum(msb2.*mMb2.*repmat(wt_x,(N1+1)*(N2),1)));
    EVs2=sum(sum(mVs2.*Ps2)');
