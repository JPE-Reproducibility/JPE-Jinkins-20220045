// written by Yingyan Zhao

clear all
set more off
capture log close


log using "$OutputLog/14_lfttd_aggregates_by_related.log", replace


*************************************************************************************
**** Trade Volume Aggregates of related/nonrelated trade       ****
*************************************************************************************
**** The dataset is generated in 13_lfttd_aggregates.do
**** The excel data is exported in 13_lfttd_aggregates.do
set scheme s2color  
// graph "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta" -- related nonralated
use "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",clear
keep if missing_alpha == 0
gen import_value = value_imp/10^9
twoway line import_value year if related == "Y" ///
	|| line import_value year if related == "N" ///
	|| line import_value year if related == "" ///
	, legend(col(3) lab(1 "Related") lab(2 "Non-related") lab(3 "Missing")) ///
	ytitle("Import value ($ Billion)") ///
	xlabel(1996(2)2011)
graph export "$Result/Value_imp_by_missing_alpha_related_1996_2011_related_nonralated.eps",as(eps) replace
	

************************************
**** Total number of buyers     ****
**** keep only alpha nonmissing
**** related/nonrelated trade
************************************
**** By Related/Nonrelated party trade 
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""
	drop if missing_alpha == 1 
	
	collapse (sum) value_imp,by(alpha relate)
	collapse (count) NoBuyer = value_imp,by(relate)
	gen year = `y'
	save "$OutputTemp/NoBuyer_by_related_`y'.dta", replace
}
//Append
use "$OutputTemp/NoBuyer_by_related_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoBuyer_by_related_`y'.dta"
}
label var NoBuyer "# of buyers"
// round to 10;50;100
gen NoBuyer_r = 0
replace NoBuyer_r = round(NoBuyer,10) if NoBuyer<=100
replace NoBuyer_r = round(NoBuyer,50) if NoBuyer<=1000 & NoBuyer>100
replace NoBuyer_r = round(NoBuyer,100) if NoBuyer>1000
label var NoBuyer_r "# of buyers(10;50;100)"
keep year NoBuyer_r relate
export excel "$Result/NoBuyer_by_related_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoBuyer_by_related_1996_2011.dta",replace

**** graph of number of buyers
// graph "$Output/No`x'_by_related_1996_2011.dta"
use "$Output/NoBuyer_by_related_1996_2011.dta",clear
replace NoBuyer_r = NoBuyer_r/1000
egen sum_NoBuyer_r = sum(NoBuyer_r),by(year)
gen miss_ratio = NoBuyer_r / sum_NoBuyer_r * 100
twoway line NoBuyer_r year if related == "Y"  ///
	|| line NoBuyer_r year if related == "N" ///
	, legend(col(3) lab(1 "Related") lab(2 "Non-related")) ///
	ytitle("Num. of Buyers (1,000)",) ///
	xlabel(1996(2)2011)
graph export "$Result/NoBuyer_by_related_1996_2011.eps",as(eps) replace

************************************
**** Total number of Sellers     ****
**** keep only alpha nonmissing
**** related/nonrelated trade
************************************
**** By Related/Nonrelated party trade 
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""
	drop if missing_alpha == 1 

	// drop missing seller id
	gen missing_id_exp = 0
	replace missing_id_exp = 1 if id_exp == "" | country == ""
	drop if missing_id_exp == 1
	
	egen export_id = group(id_exp country)
	collapse (sum) value_imp,by(export_id relate)
	collapse (count) NoSeller = value_imp,by(relate)
	gen year = `y'
	save "$OutputTemp/NoSeller_by_related_`y'.dta", replace
}
//Append
use "$OutputTemp/NoSeller_by_related_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoSeller_by_related_`y'.dta"
}
label var NoSeller "# of sellers"
replace relate = "missing" if relate == ""
// round to 10;50;100
gen NoSeller_r = 0
replace NoSeller_r = round(NoSeller,10) if NoSeller<=100
replace NoSeller_r = round(NoSeller,50) if NoSeller<=1000 & NoSeller>100
replace NoSeller_r = round(NoSeller,100) if NoSeller>1000
label var NoSeller_r "# of seller (10;50;100)"
keep year NoSeller_r relate
export excel "$Result/NoSeller_by_related_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoSeller_by_related_1996_2011.dta",replace

**** graph of number of sellers
// graph "$Output/NoSeller_by_related_1996_2011.dta"
use "$Output/NoSeller_by_related_1996_2011.dta",clear
replace NoSeller_r = NoSeller_r/1000
egen sum_NoSeller_r = sum(NoSeller_r),by(year)
gen miss_ratio = NoSeller_r / sum_NoSeller_r * 100
twoway line NoSeller_r year if related == "Y"  ///
	|| line NoSeller_r year if related == "N" ///
	, legend(col(3) lab(1 "Related") lab(2 "Non-related")) ///
	ytitle("Num. of Sellers (1,000)",) ///
	xlabel(1996(2)2011)
graph export "$Result/NoSeller_by_related_1996_2011.eps",as(eps) replace

log close
