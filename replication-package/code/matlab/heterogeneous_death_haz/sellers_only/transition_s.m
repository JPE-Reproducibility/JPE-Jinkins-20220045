function [Ts1,Ts2] = transition_s(sb,thetab1,thetab2,param,param_indx,param_state,param_fix)

% This is the transition matrix for a specific relation from seller's perspective

 N1 = param_fix{1};
 N2 = param_fix{2};

 delta_B = param_fix{10};
 delta_S = param_fix{11};
 %delta = param_fix{12};

 ms1ind = param_indx{3};
 ms1ind2 = param_indx{4};
 ms2ind = param_indx{5};
 ms2ind2 = param_indx{6};

 ps1ind = param_indx{7};
 ps1ind2 = param_indx{8};
 ps2ind = param_indx{9};
 ps2ind2 = param_indx{10};

 delta1 = param{13};
 delta2 = param{14};

 s1 = param_state{2};  %# of type 1 sellers
 s2 = param_state{3};  %# of type 2 sellers

 thetaSum = thetab1.*(s1 ~= N1) + thetab2.*(s2 ~= N2);
 %nSum = s1.*(s1 ~= 0) + s2 .*(s2 ~= 0); %nSum = ns if (s1,s2)>>0  
 n1Sum = s1.*(s1 ~= 0); %DJ: don't know why we have this (s1~=0) thing, but looks like some
 n2Sum = s2 .*(s2 ~= 0); %DJ: numerical check, so I am leaving it
 
 % transition matrix T, given sb: used for sellers' match continuation values
                 
 % Transition matrix Ts1 and Ts2
                %Define the diagonal
                Ts1 = diag(-sb.*thetaSum - (delta1+delta_S)*n1Sum - (delta2+delta_S)*n2Sum - delta_B);
                Ts2 = diag(-sb.*thetaSum - (delta1+delta_S)*n1Sum - (delta2+delta_S)*n2Sum - delta_B);
                
                %Define the four cases of adjacency cell
                %(s1-1,s2)
                Ts1(ms1ind2) = (delta1+delta_S).*(s1(ms1ind) - 1);
                Ts2(ms1ind2) = (delta1+delta_S).*s1(ms1ind);
                %(s1,s2-1)
                Ts1(ms2ind2) = (delta2+delta_S).*s2(ms2ind);
                Ts2(ms2ind2) = (delta2+delta_S).*(s2(ms2ind)-1);
                %(s1+1,s2)
                Ts1(ps1ind2) = sb(ps1ind).*thetab1;
                Ts2(ps1ind2) = sb(ps1ind).*thetab1;               
                %(s1,s2+1) 
                Ts1(ps2ind2) = sb(ps2ind).*thetab2;
                Ts2(ps2ind2) = sb(ps2ind).*thetab2;
                
        %Destruction of seller-match itself (can happen either match terminated, buyer exit, or seller exit
            
                Ts1(:,1) = delta1+delta_B+delta_S;
                Ts2(:,1) = delta2+delta_B+delta_S;
                
                %Adjust for boundary, these values not defined
                Ts1(s1==0,:) = 0; %adjust for sj = 0
                Ts2(s2==0,:) = 0;
