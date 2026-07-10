%This function calculates welfare in the mechanical model style -- with no prices
function welfare = welfare_calc(mMb,N1,N2,ns,alp,gam)

    %Sellers per Buyer 
    tMb=mean(mMb,2); % Takes equal weights for all buyer types as given
    spb_dist=zeros(N1+N2+1,0);
    for s=0:1:N1+N2
        spb_dist(s+1,1)=sum(tMb(ns==s));
    end
    spb_dist = spb_dist(2:end)/sum(spb_dist(2:end));
    support = (1:(N1+N2))';
    price = alp/(alp-1) * ((support.^((alp-1)/(alp*(1-gam))))' * spb_dist)^(alp/(alp-1));
    welfare = 1/price;
end
