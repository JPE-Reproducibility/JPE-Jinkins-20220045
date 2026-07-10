 // written by Yingyan Zhao

clear all
set more off
capture log close


log using "$OutputLog/13_lfttd_aggregates.log", replace

*************************************************************************************
**** Trade Volume Aggregates by missing alpha and related/nonrelated trade       ****
*************************************************************************************
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""

	collapse (sum) value_imp,by(missing_alpha relate)
	gen year = `y'
	save "$OutputTemp/Value_imp_by_missing_alpha_related_`y'.dta", replace
}

//Append
use "$OutputTemp/Value_imp_by_missing_alpha_related_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/Value_imp_by_missing_alpha_related_`y'.dta"
}
label var value_imp "Import values"
export excel "$Result/Value_imp_by_missing_alpha_related_1996_2011.xlsx",replace firstrow(variables)
save "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",replace

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
	
	collapse (sum) value_imp,by(missing_id_exp)
	gen year = `y'
	save "$OutputTemp/Value_imp_by_missing_id_exp_with_nonmissing_alpha_`y'.dta", replace
}
//Append
use "$OutputTemp/Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/Value_imp_by_missing_id_exp_with_nonmissing_alpha_`y'.dta"
}
export excel "$Result/Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996_2011.xlsx",replace firstrow(variables)
save "$Output/Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996_2011.dta",replace

set scheme s2color  
**** graph of value imports by missing/nonmissing alpha
// graph "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta" -- missing nonmissing
use "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",clear
collapse (sum) value_imp,by(missing_alpha year)
gen import_value = value_imp/10^9
twoway line import_value year if missing_alpha == 0 ///
	|| line import_value year if missing_alpha == 1 ///
	, legend(col(2) lab(1 "with alpha") lab(2 "missing alpha")) ///
	ytitle("Import value ($ Billion)") ///
	xlabel(1996(2)2011)
graph export "$Result/Value_imp_by_missing_alpha_related_1996_2011_missing_alpha.eps",as(eps) replace

set scheme s2color  
**** graph of value imports by missing/nonmissing id_exp	
// graph Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996_2011
use "$Output/Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996_2011.dta",clear
gen import_value = value_imp/10^9
egen max_import_value = max(import_value),by(year)
gen miss_ratio = import_value / max_import_value * 100
twoway (line import_value year if missing_id_exp == 0, yaxis(1)) ///
	(line miss_ratio year if missing_id_exp == 1, yaxis(2)) ///
	, legend(col(2) lab(1 "import value with export id") lab(2 "missing ratio")) ///
	ytitle("Import value ($ Billion)",axis(1)) ///
	ytitle("Missing ratio (%)",axis(2)) ///
	xlabel(1996(2)2011)
graph export "$Result/Value_imp_by_missing_id_exp_with_nonmissing_alpha_1996_2011.eps",as(eps) replace


************************************
**** Total number of buyers     ****
**** keep only alpha nonmissing
************************************
**** Total number of buyers
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""
	drop if missing_alpha == 1 
	
	collapse (sum) value_imp,by(alpha)
	collapse (count) NoBuyer = value_imp
	gen year = `y'
	save "$OutputTemp/NoBuyer_`y'.dta", replace
}
//Append
use "$OutputTemp/NoBuyer_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoBuyer_`y'.dta"
}
label var NoBuyer "# of buyers"
// round to 10;50;100
gen NoBuyer_r = 0
replace NoBuyer_r = round(NoBuyer,10) if NoBuyer<=100
replace NoBuyer_r = round(NoBuyer,50) if NoBuyer<=1000 & NoBuyer>100
replace NoBuyer_r = round(NoBuyer,100) if NoBuyer>1000
label var NoBuyer_r "# of buyers(10;50;100)"
keep year NoBuyer_r
export excel "$Result/NoBuyer_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoBuyer_1996_2011.dta",replace

**** graph of number of buyers
// graph "$Output/NoBuyer_1996_2011.dta"
use "$Output/NoBuyer_1996_2011.dta",clear
replace NoBuyer_r = NoBuyer_r/1000
twoway line NoBuyer_r year ///
	, ytitle("Num. of Buyers (1,000)") ///
	xlabel(1996(2)2011)
graph export "$Result/NoBuyer_1996_2011.eps",as(eps) replace


************************************
**** Total number of Sellers     ****
**** keep only alpha nonmissing
************************************
**** Total number of sellers
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
	collapse (sum) value_imp,by(export_id)
	collapse (count) NoSeller= value_imp
	gen year = `y'
	save "$OutputTemp/NoSeller_`y'.dta", replace
}
//Append
use "$OutputTemp/NoSeller_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoSeller_`y'.dta"
}
label var NoSeller "# of sellers"
// round to 10;50;100
gen NoSeller_r = 0
replace NoSeller_r = round(NoSeller,10) if NoSeller<=100
replace NoSeller_r = round(NoSeller,50) if NoSeller<=1000 & NoSeller>100
replace NoSeller_r = round(NoSeller,100) if NoSeller>1000
label var NoSeller_r "# of seller (10;50;100)"
keep year NoSeller_r
export excel "$Result/NoSeller_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoSeller_1996_2011.dta",replace

**** graph of number of sellers
// graph "$Output/No`x'_1996_2011.dta"
use "$Output/NoSeller_1996_2011.dta",clear
replace NoSeller_r = NoSeller_r/1000
twoway line NoSeller_r year ///
	, ytitle("Num. of Sellers (1,000)") ///
	xlabel(1996(2)2011)
graph export "$Result/NoSeller_1996_2011.eps",as(eps) replace

log close
