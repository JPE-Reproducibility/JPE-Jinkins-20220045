// written by Yingyan Zhao
// edited by J. Tybout 8-16-16
// edited by Yingyan Zhao 8-30-16

/*
  Transition matrices are constructed for both types of counts:
  transition_matrix_num_sellers_per_buyer.xls, transition_matrix_num_buyers_per_seller.xls
*/
clear all
set more off
capture log close

log using "$OutputLog/05_lfttd_NumSellerBuyer_transition_matrix.log", text replace

***********************************************
**** Transition of # sellers per buyer  ****
***********************************************
// append all years together
use "$OutputTemp/lfttd_m_apparel_Num_sellers_per_buyer_1996.dta",clear
forvalues y = 1997(1)2011 {
append using "$OutputTemp/lfttd_m_apparel_Num_sellers_per_buyer_`y'.dta"
}
// generate importer id
egen alpha_id = group(alpha)
tsset alpha_id year
// group Num of sellers into 1,2,....,9,10+
gen NoSeller_gr = NoSeller 
replace NoSeller_gr = 10 if NoSeller_gr >= 10
// generate Num of sellers in t+1 year
gen NoSeller_gr_f = f.NoSeller_gr
replace NoSeller_gr_f = 0 if NoSeller_gr_f == .
drop if year == 2011

// transition matrix 
************
tab NoSeller_gr NoSeller_gr_f,row nofreq
preserve
gen temp = 1 
collapse (sum) temp,by(NoSeller_gr NoSeller_gr_f)
reshape wide temp,i(NoSeller_gr) j(NoSeller_gr_f)

//////////// 
// For disclosure purpose, supporting documents show the number of obs in each category.
egen temp_sum = rowtotal(temp0-temp10)

label var NoSeller_gr "Num of Sellers per buyer 1-10+"
label var temp_sum "Num of buyers in this group"
export excel NoSeller_gr temp_sum using "$Result/transition_matrix_num_sellers_per_buyer_supporting.xlsx",replace firstrow(varlabels)
///////////

// create percentage
forvalues i = 0(1)10 {
	gen temp_shr`i' = temp`i'/temp_sum
}
// rename variables
forvalues i = 0(1)10 {
	rename temp_shr`i' NoSeller_gr_shr_f`i'
	rename temp`i' NoSeller_gr_f`i'
}
keep NoSeller_gr NoSeller_gr_shr_f0 - NoSeller_gr_shr_f10
forvalues i = 0(1)10 {
	replace NoSeller_gr_shr_f`i' = round(NoSeller_gr_shr_f`i',0.0001)
	replace NoSeller_gr_shr_f`i' = int(NoSeller_gr_shr_f`i'*10000)
	label var NoSeller_gr_shr_f`i' "NoSeller_gr_shr_f`i';*10000"
}
export excel "$Result/transition_matrix_num_sellers_per_buyer.xlsx",replace firstrow(varlabels)
restore 
************



***********************************************
**** Transition of # buyers per seller ****
***********************************************
// append all years together
use "$OutputTemp/lfttd_m_apparel_Num_buyers_per_seller_1996.dta",clear
forvalues y = 1997(1)2011 {
append using "$OutputTemp/lfttd_m_apparel_Num_buyers_per_seller_`y'.dta"
}
// exporter id - redefined - assume id_exp and country uniquely define an exporter
egen id_exp_new = group(id_exp country)
tsset id_exp_new year
// group Num of buyers into 1,2,....,9,10+
gen NoBuyer_gr = NoBuyer 
replace NoBuyer_gr = 10 if NoBuyer_gr >= 10
// generate Num of sellers in t+1 year
gen NoBuyer_gr_f = f.NoBuyer_gr
replace NoBuyer_gr_f = 0 if NoBuyer_gr_f == .
drop if year == 2011

************
tab NoBuyer_gr NoBuyer_gr_f,row nofreq 
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer_gr NoBuyer_gr_f)
reshape wide temp,i(NoBuyer_gr) j(NoBuyer_gr_f)
// row sum
egen temp_sum = rowtotal(temp0-temp10)

label var NoBuyer_gr "Num of buyers per seller 1-10+"
label var temp_sum "Num of sellers in this group"
export excel NoBuyer_gr temp_sum using "$Result/transition_matrix_num_buyers_per_seller_supporting.xlsx",replace firstrow(varlabels)

// create percentage
forvalues i = 0(1)10 {
	gen temp_shr`i' = temp`i'/temp_sum
}
// rename variables
forvalues i = 0(1)10 {
	rename temp_shr`i' NoBuyer_gr_shr_f`i'
	rename temp`i' NoBuyer_gr_f`i'
}
keep NoBuyer_gr NoBuyer_gr_shr_f0 - NoBuyer_gr_shr_f10
forvalues i = 0(1)10 {
	replace NoBuyer_gr_shr_f`i' = round(NoBuyer_gr_shr_f`i',0.0001)
	replace NoBuyer_gr_shr_f`i' = int(NoBuyer_gr_shr_f`i'*10000)
	label var NoBuyer_gr_shr_f`i' "NoBuyer_gr_shr_f`i';*10000"
}
export excel "$Result/transition_matrix_num_buyers_per_seller.xlsx",replace firstrow(varlabels)
restore 
************

log close
