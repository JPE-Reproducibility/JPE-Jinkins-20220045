
d dsf
 sd
 s f
 
 %% Create the covariance matrix for the LC moments and the baseline+LC moments
buyer_growth = data_life(1:8,2)- data_life(1,2);
seller_growth = data_life(1:8,5)- data_life(1,5);

data_moments_LC = [buyer_growth; seller_growth]';