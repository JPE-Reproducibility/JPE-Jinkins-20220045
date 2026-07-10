// written by Yingyan Zhao
// edited by J. Tybout 8-16-16
// edited by Yingyan Zhao 8-30-16

/*
  Year by year, number of sellers for each buyer are calculated. These are saved in 
  annual data files, lfttd_m_apparel_Num_sellers_per_buyer_`y'.dta. 

  It explores the distribution of num of sellers per buyer in several ways.
  (1) density: tab_num_sellers_per_buyer_`y'.xls.
  (2) kdensity graph and table of estimates: 
      "$Result/Kernel_estimates_numSperB_`depv'NoSeller_`y'_10points.eps"
      "$Result/Kernel_estimates_numSperB_`depv'NoSeller_1996_2011_10points.xlsx"
  (3) Take the log linear form - test pareto : ln( # firms with at least x partners) vs ln( # partners)
      "$Result/logLinear_Num_sellers_per_buyer_`y'.eps"
      "$Result/Regression_logLinear_Num_sellers_per_buyer.csv"

  Finally, for disclosure purpose, numbers have to be rounded.
*/
clear all
set more off
capture log close

log using "$OutputLog/03_lfttd_dist_NumSeller_per_buyer.log", text replace

***********************************************
**** distribution of # sellers per buyer   ****
***********************************************
capture erase "$Result/Regression_logLinear_Num_sellers_per_buyer.csv"
**** kernel distribution
forvalues y = 1996(1)2011{
    use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
    collapse (count) NoSeller= value_imp,by(alpha)
    label var NoSeller "Num of Sellers per Buyer in year `y'"
    ************
    tab NoSeller
    {
	preserve
	gen temp = 1 
	collapse (sum) temp,by(NoSeller)
	rename temp Freq
	egen sum_Freq = sum(Freq)
	gen Percent = Freq / sum_Freq
	keep NoSeller Freq Percent

	label var Percent "Percentage"
	label var Freq "Frequency"
	export excel "$Result/tab_num_sellers_per_buyer_1996_2011.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
    }
    
    *****************
    **** kdensity
    gen lnNoSeller = log(NoSeller) 
    foreach depv in "ln" {
	    preserve
	    kdensity `depv'NoSeller,gen(x_`depv'NoSeller d_`depv'NoSeller) n(10) title("`y'; 10 points")
	    graph export "$Result/Kernel_estimates_numSperB_`depv'NoSeller_`y'_10points.eps" ///
		    ,as(eps) replace 
	    keep x_`depv'NoSeller d_`depv'NoSeller
	    keep if x_`depv'NoSeller != .
	    export excel "$Result/Kernel_estimates_numSperB_`depv'NoSeller_1996_2011_10points.xlsx" ///
		    ,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	    restore
    }
    foreach depv in "ln" {
	    preserve
	    kdensity `depv'NoSeller,gen(x_`depv'NoSeller d_`depv'NoSeller) n(20) title("`y'; 20 points")
	    graph export "$Result/Kernel_estimates_numSperB_`depv'NoSeller_`y'_20points.eps" ///
		    ,as(eps) replace
	    keep x_`depv'NoSeller d_`depv'NoSeller
	    keep if x_`depv'NoSeller != .
	    export excel "$Result/Kernel_estimates_numSperB_`depv'NoSeller_1996_2011_20points.xlsx" ///
		    ,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	    restore
    }

    ******************
    **** log linear - test pareto : ln( # firms with at least x partners) vs ln( # partners)
    preserve
    gen temp = 1 
    collapse (sum) temp,by(NoSeller)
    rename temp Freq

    gsort - NoSeller
    // calculate # firms with at least x partners
    gen Freq_upsum = sum(Freq)
    // take log
    gen lnFreq_upsum = log(Freq_upsum)
    gen lnNoSeller = log(NoSeller)
    gen lnNoSeller_sq = lnNoSeller*lnNoSeller

    twoway line lnFreq_upsum lnNoSeller || lfit lnFreq_upsum lnNoSeller ///
	    ,ytitle("log(# buyers with at least x sellers)") ///
	    xtitle("log(# sellers)") title("year `y'")
    graph export "$Result/logLinear_Num_sellers_per_buyer_`y'.eps" ///
	    ,as(eps) replace 

    reg lnFreq_upsum lnNoSeller
    est sto reg1
    reg lnFreq_upsum lnNoSeller lnNoSeller_sq
    est sto reg2
    esttab reg* using "$Result/Regression_logLinear_Num_sellers_per_buyer.csv" ///
	    ,append b(%9.4f) se(%9.4f) r2(%9.4f) label star(* 0.10 ** 0.05 *** 0.01) ///
	    title("Relation between log(# buyers with at least x sellers) and log(# sellers), year = `y'")
    est clear
    restore

    gen year = `y'
    drop lnNoSeller
    save "$OutputTemp/lfttd_m_apparel_Num_sellers_per_buyer_`y'.dta",replace
}


****************************************************************************
**** For disclosure purpose
/*
    Redacted [EG]
*/
****************************************************************************

**** tab with group
** 1996 / 2010
capture erase "$Result/tab_num_sellers_per_buyer_1996_2011_group.xlsx"
foreach y in "1996" "2010" {
    use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
    collapse (count) NoSeller= value_imp,by(alpha)
    label var NoSeller "Num of Sellers per Buyer in year `y'"
    ************
    // group to make each cell has at least 10 firms
    {
	preserve
	gen temp = 1 
	collapse (sum) temp,by(NoSeller)
	gen NoSellerGr = NoSeller
	forvalues n = 31(10)120 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+10-1
	}
	forvalues n = 121(60)240 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+60-1
	}
	replace NoSellerGr = 241 if NoSeller >= 241 & NoSeller <= 800
	replace NoSellerGr = 801 if NoSeller >= 801
	collapse (sum) temp,by(NoSellerGr)
	rename temp Freq
	egen sum_Freq = sum(Freq)
	gen Percent = Freq / sum_Freq
	keep NoSeller Freq Percent
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
	keep NoSeller Freq_r Percent
	export excel "$Result/tab_num_sellers_per_buyer_1996_2011_group.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
    }
    ************
}

** 1997 - 2008
foreach y in "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2011" {
    use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
    collapse (count) NoSeller= value_imp,by(alpha)
    label var NoSeller "Num of Sellers per Buyer in year `y'"
    ************
    // group to make each cell has at least 10 firmss
    {
	preserve
	gen temp = 1 
	collapse (sum) temp,by(NoSeller)
	gen NoSellerGr = NoSeller
	forvalues n = 41(10)120 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+10-1
	}
	forvalues n = 121(60)240 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+60-1
	}
	replace NoSellerGr = 241 if NoSeller >= 241 & NoSeller <= 800
	replace NoSellerGr = 801 if NoSeller >= 801
	collapse (sum) temp,by(NoSellerGr)
	rename temp Freq
	egen sum_Freq = sum(Freq)
	gen Percent = Freq / sum_Freq
	keep NoSeller Freq Percent
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
	keep NoSeller Freq_r Percent
	export excel "$Result/tab_num_sellers_per_buyer_1996_2011_group.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
    }
    ************
}

** 2009
forvalues y = 2009(1)2009 {
    use "$OutputTemp/lfttd_m_apparel_pair_`y'.dta", clear
    collapse (count) NoSeller= value_imp,by(alpha)
    label var NoSeller "Num of Sellers per Buyer in year `y'"
    ************
    // group to make each cell has at least 10 firmss
    {
	preserve
	gen temp = 1 
	collapse (sum) temp,by(NoSeller)
	gen NoSellerGr = NoSeller
	forvalues n = 40(10)120 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+10-1
	}
	forvalues n = 121(60)240 {
		replace NoSellerGr = `n' if NoSeller >= `n' & NoSeller <= `n'+60-1
	}
	replace NoSellerGr = 241 if NoSeller >= 241 & NoSeller <= 700
	replace NoSellerGr = 701 if NoSeller >= 701
	collapse (sum) temp,by(NoSellerGr)
	rename temp Freq
	egen sum_Freq = sum(Freq)
	gen Percent = Freq / sum_Freq
	keep NoSeller Freq Percent
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
	keep NoSeller Freq_r Percent
	export excel "$Result/tab_num_sellers_per_buyer_1996_2011_group.xlsx" ///
		,sheetreplace firstrow(varlabels) sheet("NumSPerB`y'") 
	restore
    }
************
}


log close
