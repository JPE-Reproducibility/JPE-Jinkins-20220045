// written by Zi Wang and Yingyan Zhao
// edited by J. Tybout 8-16-16

clear all
set more off

log using "$OutputLog/02_lfttd_imp_apparel_alpha_id_exp.log", text replace

**********************************************************************************************
// The following block calculates importance of missing alpha obs. and creates a new dataset.
// in which obs. with missing alpha values or non-business importers are dropped. It generates 
// a dataset at buyer-seller-hs10-country-year level
// lfttd_m_apparel_alpha_id_exp_1996_2011.dta
**********************************************************************************************
forvalues y = 1996/2011{
use "$Output/lfttd_m_apparel_`y'.dta", clear
//Statistics for the missing values in "alpha"
tabstat value_imp, stats(sum) by(ssn_flag)
gen missing_alpha = 0
replace missing_alpha = 1 if alpha == ""
tabstat value_imp if ssn_flag == "N", stats(sum) by(missing_alpha)

//Drop the observations without alpha or with ssn_flag = "Y" (non-firm importers)
drop if alpha == "" | ssn_flag == "Y"

keep alpha related hs10 value_imp id_exp country iso_exp hs2
collapse (sum) value_imp,by(alpha related hs10 id_exp country iso_exp hs2)
gen year = `y'
save "$OutputTemp/lfttd_m_apparel_alpha_id_exp_`y'.dta", replace
}

//Append
use "$OutputTemp/lfttd_m_apparel_alpha_id_exp_1996.dta", clear
forvalues y = 1997/2011{
append using "$OutputTemp/lfttd_m_apparel_alpha_id_exp_`y'.dta"
}
save "$OutputTemp/lfttd_m_apparel_alpha_id_exp_1996_2011.dta",replace

**********************************************************************************************
// The following code documents importance of obs. with missing exporter IDs and related party trade.
// Dropping both types of observations, imports are aggregated to the level of the buyer-seller pair,
// year by year and saved to lfttd_m_apparel_pair_1996_2011.dta.
**********************************************************************************************
forvalues y = 1996(1)2011 {
use "$OutputTemp/lfttd_m_apparel_alpha_id_exp_`y'.dta", clear
keep if hs2 == 61 | hs2 == 62
sort id_exp country

// get some sense how large sample miss exporter id
gen missing_exp_id = 0
replace missing_exp_id = 1 if id_exp == "" | country == ""
tabstat value_imp, stats(sum) by(missing_exp_id)
tabstat value_imp, stats(sum) by(related)
// drop if there is no exporter id and related trade
drop if id_exp == "" | country == "" | related =="Y"

// collapse at the level of the buyer-seller pair, year by year 
collapse (sum) value_imp,by(alpha id_exp country year)
save "$OutputTemp/lfttd_m_apparel_pair_`y'.dta",replace
}

use "$OutputTemp/lfttd_m_apparel_pair_1996.dta", clear
forvalues y = 1997(1)2011 {
	append using "$OutputTemp/lfttd_m_apparel_pair_`y'.dta"
}
save "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",replace



log close
