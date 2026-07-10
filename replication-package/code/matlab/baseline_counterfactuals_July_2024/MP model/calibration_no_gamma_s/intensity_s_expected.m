function QS = intensity_s_expected(u,thetas,param_fix,param,phi)

    % Fixed Parameters
    N = param_fix{3};
    delta_B = param_fix{10};
    delta_S = param_fix{11};
    delta = param_fix{12};
    lambda = param{13};

    QS=zeros(N+1,N+1); 
    %boundaries
    QS(1,2)=u(1)*thetas; QS(1,1)=-QS(1,2); 
    QS(end,end-1)=(delta+delta_B+lambda*phi)*N; QS(end,end)=-QS(end,end-1)-delta_S;
    %
    for i=2:1:N    %number of buyers n = i-1
        QS(i,i+1)=u(i)*thetas; QS(i,i-1)=(delta+delta_B+lambda*phi)*(i-1); QS(i,i)=-(QS(i,i+1)+QS(i,i-1))-delta_S;
    end 
    QS(2:end,1)=QS(2:end,1)+delta_S;
end