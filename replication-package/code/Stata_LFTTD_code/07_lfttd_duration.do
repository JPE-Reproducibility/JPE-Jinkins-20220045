// written by Yingyan Zhao
// edited by J. Tybout 8-18-16

/*
This code calculates the duration of each business relationship. Two defintions of 
duration are considered: (1) partnerships continue to endure when they are dormant for a 
year or more but become active again (dur2), and (2) partnernships are considered dead 
if the partnership is dormant for at least a year, and further transactions between 
the pair after a dormnt period are considered to reflect a new partnership (dur1). 

Distributions of durations are graphed (duration_hist`dur'.xlsx) and related to sales
values, both using regression (Regression_value_imp_duration_`dur'.xlxs) and kernels
(lnvalue_imp_by_tenure_`dur'.pdf") 
*/

clear all
set more off
capture log close

log using "$OutputLog/07_lfttd_duration.log", text replace

***************************************
**** Calculate Duration		   ****
***************************************

**** consecutive number years in the business
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta", clear
// generate pair id origin -- just group importer and exporter by their id
egen pair_id_origin = group(alpha id_exp country)
tsset pair_id_origin year

// duration -- consecutive years in the business
gen dur1 = 1 
forvalues n = 2(1)17 {
	replace dur1 = `n' if l.dur1 == `n'-1
}
// drop pairs which starts at 1996; the numbering is wrong.
drop if dur1 == year - 1996 + 1

// get another definition of pair_id -- if business is suspended (either permanent or temporary), start a new pair_id later
sort alpha id_exp country year dur1
gen temp = pair_id_origin if dur1 == 1
egen pair_id = rank(temp),unique
sort alpha id_exp country year dur1
replace pair_id = pair_id[_n-1] if pair_id == .
drop temp
save "$Output/lfttd_m_apparel_pair_1996_2011_dur1.dta",replace

**********************************************
**** number years in the business allowing gap
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",clear
// generate pair id 
egen pair_id_origin = group(alpha id_exp country)
tsset pair_id_origin year
gen pair_id = pair_id_origin

// duration -- number years in the business allowing gap
egen dur2 = rank(year),by(pair_id)

// drop pairs which starts at 1996; the numbering is wrong.
drop if dur2 == year - 1996 + 1
save "$Output/lfttd_m_apparel_pair_1996_2011_dur2.dta",replace

***************************************
**** Simple analysis on Duration   ****
***************************************

foreach dur in "dur1" "dur2" {
use "$Output/lfttd_m_apparel_pair_1996_2011_`dur'.dta",clear
// get the start year
gen year_start_temp = year if `dur' == 1
egen year_start = min(year_start_temp), by(pair_id)
drop year_start_temp

// get the end year
egen `dur'_max = max(`dur'), by(pair_id)
gen year_end_temp = year if `dur' == `dur'_max
egen year_end = min(year_end_temp), by(pair_id)
drop year_end_temp

// collapse data -- one obs for for pair
collapse (mean) value_imp, by(pair_id id_exp country alpha year_start year_end)
gen duration  = year_end - year_start + 1 if year_end != 2011 // if the relation has not end at 2011, it is censored

// simple summary statistics for distribution of duration
***************************
tab duration
preserve
gen temp = 1
replace duration = 13 if duration == 14 & "`dur'" == "dur1"
collapse (sum) Freq = temp,by(duration)
drop if duration == .
// round to 10;50;100
gen Freq_r = 0
replace Freq_r = round(Freq,10) if Freq<=100
replace Freq_r = round(Freq,50) if Freq<=1000 & Freq>100
replace Freq_r = round(Freq,100) if Freq>1000
label var duration "duration 1 - 13+, group at the end"
label var Freq_r "Frequency"
keep duration Freq_r
export excel "$Result/duration_distr.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("`dur'")
save "$Output/duration_distr_`dur'.dta",replace 	
restore
sum duration,d
***************************

// simple regression duration with trade volume
gen lnvalue_imp = log(value_imp)
label var lnvalue_imp "log (average trade volume during the relation)"

egen alpha_id = group(alpha)
egen export_id = group(id_exp country)
***************************

reg duration lnvalue_imp
est sto reg1_1
// by controlling importers' effect; the more important relation is, the longer the duration
xtreg duration lnvalue_imp,fe i(alpha_id) 
est sto reg1_2
// by controlling exporters' effect; the more important relation is, the longer the duration
xtreg duration lnvalue_imp,fe i(export_id) 
est sto reg1_3

reg lnvalue_imp duration 
est sto reg2_1
// by controlling importers' effect; the more important relation is, the longer the duration
xtreg lnvalue_imp duration,fe i(alpha_id) 
est sto reg2_2
// by controlling exporters' effect; the more important relation is, the longer the duration
xtreg lnvalue_imp duration,fe i(export_id) 
est sto reg2_3

reg lnvalue_imp i.duration 
est sto reg3_1
// by controlling importers' effect; the more important relation is, the longer the duration
xtreg lnvalue_imp i.duration,fe i(alpha_id) 
est sto reg3_2
// by controlling exporters' effect; the more important relation is, the longer the duration
xtreg lnvalue_imp i.duration,fe i(export_id) 
est sto reg3_3
esttab reg* using "$Result/Regression_value_imp_duration_`dur'.csv" ///
	,replace b(%9.4f) se(%9.4f) r2(%9.4f) label star(* 0.10 ** 0.05 *** 0.01) ///
	title("Relation between duration and trade volume") ///
	mtitle("lnvalue_imp - OLS" "lnvalue_imp - Importer FE" "lnvalue_imp - Exporter FE" ///
	"OLS" "lnvalue_imp - Importer FE" "lnvalue_imp - Exporter FE" ///
	"lnvalue_imp - OLS" "lnvalue_imp - Importer FE" "lnvalue_imp - Exporter FE")
est clear
***************************

// distribution of mean trade volume by different duration pair
gen duration_cut = duration
replace duration_cut = 6 if duration_cut >= 6 & duration_cut != .
***************************
preserve 
egen lnvalue_imp95 = pctile(lnvalue_imp),p(95) by(duration_cut)
egen lnvalue_imp5 = pctile(lnvalue_imp),p(5) by(duration_cut)
drop if lnvalue_imp > lnvalue_imp95 | lnvalue_imp < lnvalue_imp5

twoway kdensity lnvalue_imp if duration_cut == 1 ///
	|| kdensity lnvalue_imp if duration_cut == 2 ///
	|| kdensity lnvalue_imp if duration_cut == 3 ///
	|| kdensity lnvalue_imp if duration_cut == 4 ///
	|| kdensity lnvalue_imp if duration_cut == 5 ///
	|| kdensity lnvalue_imp if duration_cut == 6 ///
	, legend(label(1 "dur=1") label(2 "dur=2") label(3 "dur=3") ///
	label(4 "dur=4") label(5 "dur=5") label(6 "dur=6+")) 
graph export "$Result/Kernel_estimates_lnvalue_imp_by_duration_`dur'.eps",as(eps) replace


***************************
// for disclosure purpose, the following table show that each duration category constains more than 10 firms.
drop if duration_cut==.
gen band_no = 0
gen bwidth = 0
forvalues i = 1(1)6 {
	kdensity lnvalue_imp if duration_cut == `i', nograph
	replace bwidth = r(bwidth) if duration_cut == `i'
	replace band_no = floor(lnvalue_imp / bwidth) + 1 if duration_cut == `i'
}
egen Cells_count = count(lnvalue_imp), by(band_no duration_cut)
egen band_no_min = min(band_no),by(duration_cut)
replace band_no = band_no - band_no_min + 1
duplicates drop duration_cut band_no Cells_count,force
keep duration_cut band_no Cells_count
sort duration_cut band_no Cells_count
label var duration_cut "duration type 1, 2,...6+"
label var band_no "band number in each kernel"
label var Cells_count "Number of obs in each cell"
export excel "$Result/Kernel_estimates_lnvalue_imp_by_duration_support.xlsx" ///
	,sheetreplace firstrow(varlabels) sheet("`dur'")
restore

***************************
}

log close
