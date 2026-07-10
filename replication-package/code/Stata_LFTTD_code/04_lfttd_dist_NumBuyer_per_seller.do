// written by Yingyan Zhao
// edited by J. Tybout 8-16-16
// edited by Yingyan Zhao 8-30-16

/*
  Year by year, number of buyers for each seller are calculated. These are saved in 
  annual data files, lfttd_m_apparel_Num_Buyers_per_seller_`y'.dta. 

  It explores the distribution of num of buyers per seller in several ways.
  (1) density: tab_num_buyers_per_seller_`y'.xls.
  (2) kdensity graph and table of estimates: 
      "$Result/Kernel_estimates_numSperB_`depv'NoBuyer_`y'_10points.eps"
      "$Result/Kernel_estimates_numSperB_`depv'NoBuyer_1996_2011_10points.xlsx"
  (3) Take the log linear form - test pareto : ln( # firms with at least x partners) vs ln( # partners)
      "$Result/logLinear_Num_buyers_per_seller_`y'.eps"
      "$Result/Regression_logLinear_Num_buyers_per_seller.csv"

  Finally, for disclosure purpose, numbers have to be rounded.
*/
clear all
set more off
capture log close

log using "$OutputLog/04_lfttd_dist_NumBuyer_per_seller.log", text replace

***********************************************
**** distribution of # buyers per seller ****
***********************************************
capture erase "$Result/Regression_logLinear_Num_buyers_per_seller.csv"
forvalues y = 1996(1)2011 {
use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta",clear
collapse (count) NoBuyer = value_imp,by(id_exp country)
label var NoBuyer "Num of Buyers per Seller in year `y'"

************
tab NoBuyer
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
rename temp Freq
egen sum_Freq = sum(Freq)
gen Percent = Freq / sum_Freq
keep NoBuyer Freq Percent

label var Percent "Percentage"
label var Freq "Frequency"
export excel "$Result/tab_num_buyers_per_seller_1996_2011.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("NumBPerS`y'") 
restore
************

gen lnNoBuyer = log(NoBuyer) 

foreach depv in "ln" {
	preserve
	kdensity `depv'NoBuyer,gen(x_`depv'NoBuyer d_`depv'NoBuyer) n(10) title("`y'; 10 points")
	graph export "$Result/Kernel_estimates_numBperS_`depv'NoBuyer_`y'_10points.eps" ///
		,as(eps) replace
	keep x_`depv'NoBuyer d_`depv'NoBuyer
	keep if x_`depv'NoBuyer !=.
	export excel "$Result/Kernel_estimates_numBperS_`depv'NoBuyer_1996_2011_10points.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
}
foreach depv in "ln" {
	preserve
	kdensity `depv'NoBuyer,gen(x_`depv'NoBuyer d_`depv'NoBuyer) n(20) title("`y'; 20 points")
	graph export "$Result/Kernel_estimates_numBperS_`depv'NoBuyer_`y'_20points.eps" ///
		,as(eps) replace 
	keep x_`depv'NoBuyer d_`depv'NoBuyer
	keep if x_`depv'NoBuyer !=.
	export excel "$Result/Kernel_estimates_numBperS_`depv'NoBuyer_1996_2011_20points.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
}

******************
**** log linear - test pareto : ln( # firms with at least x partners) vs ln( # partners)
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
rename temp Freq

gsort - NoBuyer
// calculate # firms with at least x partners
gen Freq_upsum = sum(Freq)
// take log
gen lnFreq_upsum = log(Freq_upsum)
gen lnNoBuyer = log(NoBuyer)
gen lnNoBuyer_sq = lnNoBuyer*lnNoBuyer

twoway line lnFreq_upsum lnNoBuyer || lfit lnFreq_upsum lnNoBuyer ///
	,ytitle("log(# sellers with at least x buyers)") ///
	xtitle("log(# buyers)") title("year `y'")
graph export "$Result/logLinear_Num_buyers_per_seller_`y'.eps" ///
	,as(eps) replace 

reg lnFreq_upsum lnNoBuyer
est sto reg1
reg lnFreq_upsum lnNoBuyer lnNoBuyer_sq
est sto reg2
esttab reg* using "$Result/Regression_logLinear_Num_buyers_per_seller.csv" ///
	,append b(%9.4f) se(%9.4f) r2(%9.4f) label star(* 0.10 ** 0.05 *** 0.01) ///
	title("Relation between log(# sellers with at least x buyers) and log(# buyers), year = `y'")
est clear
restore 

gen year = `y'
drop lnNoBuyer
save "$OutputTemp/lfttd_m_apparel_Num_buyers_per_seller_`y'.dta",replace
}


****************************************************************************
**** For disclosure purpose
/*
    In order to disclose "tab_num_buyers_per_seller_1996_2011.xlsx", each cell 
    should have at least 10 firms and the number has to be rounded 10;50;100.
*/
****************************************************************************
**** tab group to make each cell has at least 10 firmss
** 1996 2005-2008
foreach y in "1996" "2005" "2006" "2007" "2008" {
use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
collapse (count) NoBuyer = value_imp,by(id_exp country)
label var NoBuyer "Num of Buyers per Seller in year `y'"
************
// group to make each cell has at least 10 firmss
{
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
gen NoBuyerGr = NoBuyer
forvalues n = 21(2)30 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+2-1
}
forvalues n = 31(10)50{
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+10-1
}
replace NoBuyerGr = 51 if NoBuyerGr >= 51
collapse (sum) temp,by(NoBuyerGr)
rename temp Freq
egen sum_Freq = sum(Freq)
gen Percent = Freq / sum_Freq
keep NoBuyerGr Freq Percent
// round to 0.0001
replace Percent = round(Percent,0.0001)
replace Percent = int(Percent*10000)
// round to 10;50;100
gen Freq_r = 0
replace Freq_r = round(Freq,10) if Freq<=100
replace Freq_r = round(Freq,50) if Freq<=1000 & Freq>100
replace Freq_r = round(Freq,100) if Freq>1000
label var Percent "Percentage (*10000)"
label var Freq_r "Frequency rounded(10;50;100)"
keep NoBuyer Freq_r Percent
export excel "$Result/tab_num_buyers_per_seller_1996_2011_group.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("NumBPerS`y'") 
restore
}
************
}

** 1997-1998
foreach y in "1997" "1998" {
use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
collapse (count) NoBuyer = value_imp,by(id_exp country)
label var NoBuyer "Num of Buyers per Seller in year `y'"
************
// group to make each cell has at least 10 firmss
{
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
gen NoBuyerGr = NoBuyer
forvalues n = 29(3)40 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+3-1
}
forvalues n = 41(10)70 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+10-1
}
replace NoBuyerGr = 71 if NoBuyerGr >= 71
collapse (sum) temp,by(NoBuyerGr)
rename temp Freq
egen sum_Freq = sum(Freq)
gen Percent = Freq / sum_Freq
keep NoBuyerGr Freq Percent
// round to 0.0001
replace Percent = round(Percent,0.0001)
replace Percent = int(Percent*10000)
// round to 10;50;100
gen Freq_r = 0
replace Freq_r = round(Freq,10) if Freq<=100
replace Freq_r = round(Freq,50) if Freq<=1000 & Freq>100
replace Freq_r = round(Freq,100) if Freq>1000
label var Percent "Percentage (*10000)"
label var Freq_r "Frequency rounded(10;50;100)"
keep NoBuyer Freq_r Percent
export excel "$Result/tab_num_buyers_per_seller_1996_2011_group.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("NumBPerS`y'") 
restore
}
************
}
** 1999-2004
foreach y in "1999" "2000" "2001" "2002" "2003" "2004" {
use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
collapse (count) NoBuyer = value_imp,by(id_exp country)
label var NoBuyer "Num of Buyers per Seller in year `y'"
************
// group to make each cell has at least 10 firmss
{
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
gen NoBuyerGr = NoBuyer
forvalues n = 29(2)40 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+2-1
}
forvalues n = 41(10)80 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+10-1
}
replace NoBuyerGr = 81 if NoBuyerGr >= 81
collapse (sum) temp,by(NoBuyerGr)
rename temp Freq
egen sum_Freq = sum(Freq)
gen Percent = Freq / sum_Freq
keep NoBuyerGr Freq Percent
// round to 0.0001
replace Percent = round(Percent,0.0001)
replace Percent = int(Percent*10000)
// round to 10;50;100
gen Freq_r = 0
replace Freq_r = round(Freq,10) if Freq<=100
replace Freq_r = round(Freq,50) if Freq<=1000 & Freq>100
replace Freq_r = round(Freq,100) if Freq>1000
label var Percent "Percentage (*10000)"
label var Freq_r "Frequency rounded(10;50;100)"
keep NoBuyer Freq_r Percent
export excel "$Result/tab_num_buyers_per_seller_1996_2011_group.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("NumBPerS`y'") 
restore
}
************
}

** 2009 - 2011
foreach y in "2009" "2010" "2011" {
use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
collapse (count) NoBuyer = value_imp,by(id_exp country)
label var NoBuyer "Num of Buyers per Seller in year `y'"
************
// group to make each cell has at least 10 firmss
{
preserve
gen temp = 1 
collapse (sum) temp,by(NoBuyer)
gen NoBuyerGr = NoBuyer
forvalues n = 18(4)29 {
	replace NoBuyerGr = `n' if NoBuyerGr >= `n' & NoBuyerGr <= `n'+4-1
}
replace NoBuyerGr = 30 if NoBuyerGr >= 30
collapse (sum) temp,by(NoBuyerGr)
rename temp Freq
egen sum_Freq = sum(Freq)
gen Percent = Freq / sum_Freq
keep NoBuyerGr Freq Percent
// round to 0.0001
replace Percent = round(Percent,0.0001)
replace Percent = int(Percent*10000)
// round to 10;50;100
gen Freq_r = 0
replace Freq_r = round(Freq,10) if Freq<=100
replace Freq_r = round(Freq,50) if Freq<=1000 & Freq>100
replace Freq_r = round(Freq,100) if Freq>1000
label var Percent "Percentage (*10000)"
label var Freq_r "Frequency rounded(10;50;100)"
keep NoBuyer Freq_r Percent
export excel "$Result/tab_num_buyers_per_seller_1996_2011_group.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("NumBPerS`y'") 
restore
}
************
}


log close
