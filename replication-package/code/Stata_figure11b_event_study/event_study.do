/*
Replication code for Figure 11b: event-study estimates and model predictions.

Usage from Stata:
    do code/Stata_figure11b_event_study/event_study.do "/path/to/replication_package"

If no path is supplied, the current working directory is treated as the
replication-package root.
*/

version 17
clear all
set more off
set seed 42

local root `"`0'"'
if `"`root'"' == "" {
    local root "`c(pwd)'"
}

local data_dir `"`root'/data/US_ITC_figure11b_event_study"'
local out_dir  `"`root'/output/figures/paper"'
cap mkdir `"`root'/output"'
cap mkdir `"`root'/output/figures"'
cap mkdir `"`out_dir'"'

foreach cmd in ebalance ftools require reghdfe {
    cap which `cmd'
    if _rc {
        di as error "Required Stata command `cmd' is not installed."
        di as error "Install it from SSC inside Stata, then rerun this script."
        exit 199
    }
}

use `"`data_dir'/merged_apparel_2017_2025_importVQT.dta"', clear

preserve
duplicates drop Country HTSNumber, force

gen hs6 = substr(HTSNumber, 1, 6)
gen hs4 = substr(HTSNumber, 1, 4)
destring hs4, replace
xi i.hs4

ebalance T _I*
rename _w w_entropy

keep Country HTSNumber T w*
tempfile weights
save `weights'
restore

preserve
drop if Year > 2018

collapse (sum) m_val, by(Country)
gsort -m_val
label var m_val "Total Import Values (mil) from 2017:1 to 2018:12"
gen rank = _n
tempfile rank
save `rank'
restore

merge m:1 Country using `rank', gen(_m)
tab Country if _m != 3
drop if rank > 10

drop if T == 0 & Country == "China"

collapse (sum) m_val (sum) m_q1 (mean) m_p, by(Country rank HTSNumber Year T hs8)
rename m_p ref_m_p
gen m_p = m_val / m_q1

replace m_val = m_val / 7 * 12 if Year == 2025

gen event_date = 2019
gen event_time = Year - event_date

egen ht = group(HTSNumber Year)
egen id = group(Country HTSNumber)

gsort id Year
tsset id Year

gen lm_p = 100 * log(m_p)
gen lm_val = 100 * log(m_val)

egen event_time_pos = group(event_time)

gen sum_et = 0
sum event_time_pos
local tmax = r(max)
forval i = 2/`tmax' {
    gen et_`i' = (T == 1 & event_time_pos == `i')
    qui replace sum_et = sum_et + et_`i'
}

merge m:1 Country HTSNumber using `weights', gen(m_w)
drop if m_w == 2

local y = "val"
local w = "entropy"
local rankcap = 5

preserve
drop if rank > `rankcap'

reghdfe lm_`y' et_* [pw=w_entropy], a(id ht) cluster(hs8 Country)

gen b_target = .
gen se_target = .
qui sum event_time_pos
local tmax = r(max)
qui forval i = 2/`tmax' {
    cap replace b_target = _b[et_`i'] if event_time_pos == `i'
    cap replace se_target = _se[et_`i'] if event_time_pos == `i'
}

collapse (mean) b_* se_*, by(event_time event_time_pos Year)
mvencode b_* se_*, mv(0) override

gen b_target_hi = b_target + 1.96 * se_target
gen b_target_lo = b_target - 1.96 * se_target

merge 1:1 Year using `"`data_dir'/model_prediction.dta"'
drop if Year == 2025

local ylab "-100(20)0"
local v "Log Value"
local xlab "2017(1)2024"

set scheme s2color
twoway ///
    (rspike b_target_hi b_target_lo Year, lw(vthin) lc(gs6)) ///
    (scatter b_target Year, msize(medium) ms(oh) mcolor(red)) ///
    (scatter model_prediction Year, ms(Th) msize(medium) mcolor(blue)), ///
    legend(order(2 "Event Study Estimates" 3 "Model Predictions") size(vsmall) region(lstyle(none)) ring(0) pos(5)) ///
    xtitle("Year", size(small)) ///
    ytitle("Percent", size(small)) ///
    xlabel(`xlab', labsize(small) nogrid) ///
    ylabel(`ylab', labsize(small) nogrid) ///
    xline(2019, lpattern(dash) lcolor(gs8) lw(vthin)) ///
    yline(0, lpattern(shortdash) lcolor(sky)) ///
    title("`v'", size(small)) ///
    graphregion(color(white)) plotregion(color(white))

graph export `"`out_dir'/figure_11b_event_study_china_vs_other_exporters.png"', replace width(1600)
restore
