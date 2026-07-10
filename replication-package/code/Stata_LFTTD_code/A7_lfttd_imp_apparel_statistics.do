// written by Yingyan Zhao

clear all
set more off
capture log close

/* 
This file generates additional statistics of buyers and sellers

(1) Share of Largest Seller by importers with different numbers of sellers
(2) average failure rate and the size of imports in the final year of import
(3) The change of "avg # of seller / # in year 1": The growth of number of sellers
(4) The change of "avg # of buyer / # in year 1": The growth of number of buyers

*/

log using "$OutputLog/A7_lfttd_imp_apparel_statistics.txt", text replace

***********************************************
**** 	Share of Largest Seller 	   ****
***********************************************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",clear
egen buyer = group(alpha)
egen seller = group(id_exp country)

egen NoSeller = count(value_imp), by(buyer year)
egen TotImports = sum(value_imp), by(buyer year)
gen SellerShr = value_imp/TotImports

collapse (max) MaxSellerShr = SellerShr (first) NoSeller, by(buyer year)
save "$OutputTemp/Share_LargestSeller.dta",replace
/*
preserve
collapse (mean) MaxSellerShrAvg = MaxSellerShr ///
	(sd) MaxSellerShrSd = MaxSellerShr ///
	(count) MaxSellerShrCount = MaxSellerShr,by(NoSeller year)
export excel using "$Result/Share_LargestSeller_1996_2011.xlsx",replace firstrow(variables)
restore
*/
preserve
tabstat MaxSellerShr, by(NoSeller) s(n mean sd) save
collapse (mean) MaxSellerShrAvg = MaxSellerShr ///
	(sd) MaxSellerShrSd = MaxSellerShr ///
	(count) MaxSellerShrCount = MaxSellerShr,by(NoSeller)
keep if NoSeller <=5
export excel using "$Result/Share_LargestSeller_allyear.xlsx",replace firstrow(variables)
restore

***********************************************
**** 	average failure rate and the size of imports in the final year of import	   ****
***********************************************
local dur dur1
use "$Output/lfttd_m_apparel_pair_1996_2011_`dur'.dta",clear
egen `dur'_max = max(`dur'),by(pair_id)
gen `dur'_end = 0 if year != 2011
replace `dur'_end = 1 if `dur' == `dur'_max & year != 2011

collapse (count) event = `dur'_end (sum) fail = `dur'_end, by(`dur')
gen hr = fail / event
rename `dur' match_age
save "$Output/average_failure_rate.dta",replace

local dur dur1
use "$Output/lfttd_m_apparel_pair_1996_2011_`dur'.dta",clear
egen `dur'_max = max(`dur'),by(pair_id)
gen `dur'_end = 0 if year != 2011
replace `dur'_end = 1 if `dur' == `dur'_max & year != 2011

keep if `dur'_end == 1
gen lnvalue_imp = log(value_imp)
collapse (mean) value_imp lnvalue_imp ///
	(sd) sd_value_imp = value_imp sd_lnvalue_imp = lnvalue_imp ///
	,by(`dur'_max)
rename `dur'_max match_age
rename value_imp avg_value
rename lnvalue_imp avg_lnvalue
rename sd_value_imp sd_value
rename sd_lnvalue_imp sd_lnvalue
save "$Output/average_value_endyear.dta",replace

use "$Output/average_failure_rate.dta",clear
merge 1:1 match_age using "$Output/average_value_endyear.dta"
keep if _merge == 3
drop _merge
keep if match_age <= 10
keep match_age avg_lnvalue sd_lnvalue
save "$Output/match_age_failrate_avgvalue.dta",replace
export excel using "$Result/match_age_failrate_avgvalue.xlsx",replace firstrow(variables)

***********************************************
**** avg # of seller / # in year 1   	   ****
***********************************************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",clear
egen buyer = group(alpha)
egen seller = group(id_exp country)

collapse (count) NoSeller = value_imp, by(buyer year)
gen NoSeller_2 = NoSeller

tsset buyer year
tsappend, add(1) // add one more year at the end
drop if year == 2012
replace NoSeller_2 = 0 if NoSeller_2 == .

egen yr_in_market = rank(year),by(buyer)
egen start_yr = min(year),by(buyer)
drop if start_yr == 1996

gen NoSeller_1st = NoSeller if yr_in_market == 1

sort buyer year
replace NoSeller_1st = NoSeller_1st[_n-1] if NoSeller_1st == . & buyer == buyer[_n-1]
gen NoSellerRatio = NoSeller / NoSeller_1st
gen NoSellerRatio_2 = NoSeller_2 / NoSeller_1st

collapse (mean) NoSellerRatio NoSellerRatio_2 ///
	(sd) sd_NoSellerRatio = NoSellerRatio sd_NoSellerRatio_2 = NoSellerRatio_2 ///
	(count) No_Buyer = NoSellerRatio, by(yr_in_market)
save "$OutputTemp/avg_number_seller_by_yr_in_market.dta",replace

***********************************************
**** 	avg # of buyer / # in year 1 
***********************************************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",clear
egen buyer = group(alpha)
egen seller = group(id_exp country)

collapse (count) NoBuyer = value_imp, by(seller year)
gen NoBuyer_2 = NoBuyer

tsset seller year
tsappend, add(1) // add one more year at the end
drop if year == 2012
replace NoBuyer_2 = 0 if NoBuyer_2 == .

egen yr_in_market = rank(year),by(seller)
egen start_yr = min(year),by(seller)
drop if start_yr == 1996

gen NoBuyer_1st = NoBuyer if yr_in_market == 1

sort seller year
replace NoBuyer_1st = NoBuyer_1st[_n-1] if NoBuyer_1st == . & seller == seller[_n-1]
gen NoBuyerRatio = NoBuyer / NoBuyer_1st
gen NoBuyerRatio_2 = NoBuyer_2 / NoBuyer_1st

collapse (mean) NoBuyerRatio NoBuyerRatio_2 ///
	(sd) sd_NoBuyerRatio = NoBuyerRatio sd_NoBuyerRatio_2 = NoBuyerRatio_2 ///
	(count) No_Seller = NoBuyerRatio, by(yr_in_market)
save "$OutputTemp/avg_number_buyer_by_yr_in_market.dta",replace

**** merge together and export
use "$OutputTemp/avg_number_seller_by_yr_in_market.dta",clear
merge 1:1 yr_in_market using "$OutputTemp/avg_number_buyer_by_yr_in_market.dta"
drop _merge
keep if yr_in_market <= 10
keep yr_in_market NoSellerRatio_2 sd_NoSellerRatio_2 No_Buyer ///
	NoBuyerRatio_2 sd_NoBuyerRatio_2 No_Seller
export excel using "$Result/avg_number_seller_buyer_by_yr_in_market.xlsx",replace firstrow(variables)

log close
