// written by Yingyan Zhao

clear all
set more off
capture log close

/* 
This file looks at the change of the aggregates by countries (Top 10 countries).
*/

log using "$OutputLog/12_lfttd_aggregates_by_country.log", replace


**************************************************************
**** distribution of value shr among all countries in both 2011 and 2000
**************************************************************
foreach yr in "2011" "2000" {
	use "$Output/lfttd_m_apparel_`yr'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"

	collapse (sum) value_imp,by(country)
	egen tot_value_imp = sum(value_imp)

	egen invrank = rank(value_imp),unique
	gen rank = _N+1 - invrank

	sort rank
	gen value_shr = value_imp / tot_value_imp
	gen cum_value_shr`yr' = sum(value_shr)

	keep rank cum_value_shr`yr'
	save "$Output/lfttd_m_apparel_cum_value_shr`yr'.dta", replace
}

use "$Output/lfttd_m_apparel_cum_value_shr2000.dta",clear
merge 1:1 rank using "$Output/lfttd_m_apparel_cum_value_shr2011.dta"
drop _merge

twoway line cum_value_shr2000 rank ///
	|| line cum_value_shr2011 rank ///
	, ytitle("Cummulative Import value share") ///
	xtitle("rank") ///
	xline(10) ///
	legend(col(2) lab(1 "year 2000") lab(2 "year 2011"))
graph export "$Result/cummulative_import_shr.eps",as(eps) replace


**************************************************************
**** choose ten most important country of origin in 2011
**************************************************************
foreach yr in "1996" "2000" "2004" "2008" "2011"  {
	use "$Output/lfttd_m_apparel_`yr'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"

	collapse (sum) value_imp,by(country)
	egen tot_value_imp = sum(value_imp)

	egen invrank = rank(value_imp),unique
	gen rank = _N+1 - invrank

	keep if rank < = 10
	gen top_country = 1

	gen value_shr = value_imp / tot_value_imp
	keep country top_country value_shr rank
	save "$OutputTemp/Top_Country_List_`yr'.dta",replace
	export excel using "$Result/Top_Country_List_`yr'.xls",replace
}

**********************************************************
**** Trade Volume Aggregates by Country of origin     ****
**********************************************************
**** Trade Volume Aggregates of top 10 country list

**** table of value imports
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""
	
	merge m:1 country using "$OutputTemp/Top_Country_List_2011.dta"
	keep if _merge == 3
	drop _merge
	keep if top_country == 1
	
	collapse (sum) value_imp,by(missing_alpha country)
	gen year = `y'
	save "$OutputTemp/Value_imp_by_missing_alpha_country_`y'.dta", replace
}

//Append
use "$OutputTemp/Value_imp_by_missing_alpha_country_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/Value_imp_by_missing_alpha_country_`y'.dta"
}
label var value_imp "Import values"
export excel "$Result/Value_imp_by_missing_alpha_country_1996_2011.xlsx",replace firstrow(variables)
save "$Output/Value_imp_by_missing_alpha_country_1996_2011.dta",replace


**** graph of value imports
set scheme s2color  
// graph Value_imp_by_missing_alpha_country_1996_2011
use "$Output/Value_imp_by_missing_alpha_country_1996_2011.dta",clear
gen country_eng = ""
replace country_eng = "China" if country == "5700"
replace country_eng = "Indonesia" if country == "5600"
replace country_eng = "Cambobia" if country == "5550"
replace country_eng = "Vietnam" if country == "5520"
replace country_eng = "Bangladesh" if country == "5380"
replace country_eng = "Pakistan" if country == "5350"
replace country_eng = "India" if country == "5330"
replace country_eng = "Honduras" if country == "2150"
replace country_eng = "El Salvador" if country == "2110"
replace country_eng = "Mexico" if country == "2010"
keep if missing_alpha == 1

gen import_value = value_imp/10^9
twoway line import_value year if country == "2010" ///
	|| line import_value year if country == "2110" ///
	|| line import_value year if country == "2150" ///
	|| line import_value year if country == "5330" ///
	|| line import_value year if country == "5350" ///
	|| line import_value year if country == "5380" ///
	|| line import_value year if country == "5520" ///
	|| line import_value year if country == "5550" ///
	|| line import_value year if country == "5600" ///
	|| line import_value year if country == "5700" ///
	, legend(col(4) lab(1 "Mexico") lab(2 "El Salvador") ///
	lab(3 "Honduras") lab(4 "India") lab(5 "Pakistan") ///
	lab(6 "Bangladesh") lab(7 "Vietnam") lab(8 "Cambobia") ///
	lab(9 "Indonesia") lab(10 "China")) ///
	ytitle("Import value ($ Billion)") ///
	xlabel(1996(2)2011)
graph export "$Result/Value_imp_by_missing_alpha_country_1996_2011.eps",as(eps) replace


************************************
**** Total number of buyers by Country of origin    ****
**** keep only alpha nonmissing
************************************
**** Total number of buyers of top 10 country list

**** table of number of buyers
forvalues y = 1996(1)2011{
	use "$Output/lfttd_m_apparel_`y'.dta", clear
	//Drop the observations with ssn_flag = "Y" (non-firm importers)
	drop if ssn_flag == "Y"
	
	//Statistics for the missing values in "alpha"
	gen missing_alpha = 0
	replace missing_alpha = 1 if alpha == ""
	drop if missing_alpha == 1 
	
	merge m:1 country using "$OutputTemp/Top_Country_List_2011.dta"
	keep if _merge == 3	
	drop _merge
	keep if top_country == 1
	
	collapse (sum) value_imp,by(alpha country)
	collapse (count) NoBuyer = value_imp,by(country)
	gen year = `y'
	save "$OutputTemp/NoBuyer_by_country_`y'.dta", replace
}
//Append
use "$OutputTemp/NoBuyer_by_country_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoBuyer_by_country_`y'.dta"
}
label var NoBuyer "# of buyers"
// round to 10;50;100
gen NoBuyer_r = 0
replace NoBuyer_r = round(NoBuyer,10) if NoBuyer<=100
replace NoBuyer_r = round(NoBuyer,50) if NoBuyer<=1000 & NoBuyer>100
replace NoBuyer_r = round(NoBuyer,100) if NoBuyer>1000
label var NoBuyer_r "# of buyers(10;50;100)"
keep year NoBuyer_r country
export excel "$Result/NoBuyer_by_country_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoBuyer_by_country_1996_2011.dta",replace

**** graph of number of buyers
// graph "$Output/NoBuyer_by_country_1996_2011
use "$Output/NoBuyer_by_country_1996_2011.dta",replace
gen country_eng = ""
replace country_eng = "China" if country == "5700"
replace country_eng = "Indonesia" if country == "5600"
replace country_eng = "Cambobia" if country == "5550"
replace country_eng = "Vietnam" if country == "5520"
replace country_eng = "Bangladesh" if country == "5380"
replace country_eng = "Pakistan" if country == "5350"
replace country_eng = "India" if country == "5330"
replace country_eng = "Honduras" if country == "2150"
replace country_eng = "El Salvador" if country == "2110"
replace country_eng = "Mexico" if country == "2010"

replace NoBuyer_r = NoBuyer_r/1000
twoway line NoBuyer_r year if country == "2010" ///
	|| line NoBuyer_r year if country == "2110" ///
	|| line NoBuyer_r year if country == "2150" ///
	|| line NoBuyer_r year if country == "5330" ///
	|| line NoBuyer_r year if country == "5350" ///
	|| line NoBuyer_r year if country == "5380" ///
	|| line NoBuyer_r year if country == "5520" ///
	|| line NoBuyer_r year if country == "5550" ///
	|| line NoBuyer_r year if country == "5600" ///
	|| line NoBuyer_r year if country == "5700" ///
	, legend(col(3) lab(1 "Mexico") lab(2 "El Salvador") ///
	lab(3 "Honduras") lab(4 "India") lab(5 "Pakistan") ///
	lab(6 "Bangladesh") lab(7 "Vietnam") lab(8 "Cambobia") ///
	lab(9 "Indonesia") lab(10 "China")) ///
	ytitle("Num. of Buyers (1,000)") ///
	xlabel(1996(2)2011)
graph export "$Result/NoBuyer_by_country_1996_2011.eps",as(eps) replace


************************************
**** Total number of Sellers by Country of origin    ****
**** keep only alpha nonmissing
************************************
**** By Country of origin: Top 10 countries
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
	merge m:1 country using "$OutputTemp/Top_Country_List_2011.dta"
	keep if _merge == 3
	drop _merge
	keep if top_country == 1
	
	collapse (sum) value_imp,by(export_id country)
	collapse (count) NoSeller = value_imp,by(country)
	gen year = `y'
	save "$OutputTemp/NoSeller_by_country_`y'.dta", replace
}
//Append
use "$OutputTemp/NoSeller_by_country_1996.dta", clear
forvalues y = 1997(1)2011{
	append using "$OutputTemp/NoSeller_by_country_`y'.dta"
}
label var NoSeller "# of sellers"
// round to 10;50;100
gen NoSeller_r = 0
replace NoSeller_r = round(NoSeller,10) if NoSeller<=100
replace NoSeller_r = round(NoSeller,50) if NoSeller<=1000 & NoSeller>100
replace NoSeller_r = round(NoSeller,100) if NoSeller>1000
label var NoSeller_r "# of seller (10;50;100)"
keep year NoSeller_r country
export excel "$Result/NoSeller_by_country_1996_2011.xlsx",replace firstrow(varlabels)
save "$Output/NoSeller_by_country_1996_2011.dta",replace

**** graph of number of sellers
// graph "$Output/NoSeller_by_country_1996_2011
use "$Output/NoSeller_by_country_1996_2011.dta",replace
gen country_eng = ""
replace country_eng = "China" if country == "5700"
replace country_eng = "Indonesia" if country == "5600"
replace country_eng = "Cambobia" if country == "5550"
replace country_eng = "Vietnam" if country == "5520"
replace country_eng = "Bangladesh" if country == "5380"
replace country_eng = "Pakistan" if country == "5350"
replace country_eng = "India" if country == "5330"
replace country_eng = "Honduras" if country == "2150"
replace country_eng = "El Salvador" if country == "2110"
replace country_eng = "Mexico" if country == "2010"

replace NoSeller_r = NoSeller_r/1000
twoway line NoSeller_r year if country == "2010" ///
	|| line NoSeller_r year if country == "2110" ///
	|| line NoSeller_r year if country == "2150" ///
	|| line NoSeller_r year if country == "5330" ///
	|| line NoSeller_r year if country == "5350" ///
	|| line NoSeller_r year if country == "5380" ///
	|| line NoSeller_r year if country == "5520" ///
	|| line NoSeller_r year if country == "5550" ///
	|| line NoSeller_r year if country == "5600" ///
	|| line NoSeller_r year if country == "5700" ///
	, legend(col(3) lab(1 "Mexico") lab(2 "El Salvador") ///
	lab(3 "Honduras") lab(4 "India") lab(5 "Pakistan") ///
	lab(6 "Bangladesh") lab(7 "Vietnam") lab(8 "Cambobia") ///
	lab(9 "Indonesia") lab(10 "China")) ///
	ytitle("Num. of Sellers (1,000)") ///
	xlabel(1996(2)2011)
graph export "$Result/NoSeller_by_country_1996_2011.eps",as(eps) replace


log close
