// written by Yingyan Zhao
// edited by J. Tybout 8-18-16

clear all
set more off
capture log close

/*
This code calculates the tenure of buyers/sellers. Two defintions of 
tenure are considered: (1) partnerships continue to endure when they are dormant for a 
year or more but become active again (dur2), and (2) partnernships are considered dead 
if the partnership is dormant for at least a year, and further transactions between 
the pair after a dormnt period are considered to reflect a new partnership (dur1). 

The size distribution is explored for different tenure in two ways.
(1) "$Result/05_Kernel_estimates_lnvalue_imp_by_Importer_tenure.eps"
    "$Result/Kernel_estimates_lnvalue_imp_by_Exporter_tenure.eps"
(2) "$Result/Regression_value_imp_by_Importer_tenure.csv"
    "$Result/Regression_value_imp_by_Exporter_tenure.csv"
*/

log using "$OutputLog/A10_lfttd_tenure_of_BuyerSeller.log", text replace

***********************
**** Prepare for Life Cycle of Importer (Buyer) / Exporter (Seller)   ****
***********************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta",clear
egen alpha_id = group(alpha)
egen id_exp_id = group(id_exp country)
drop if alpha_id == .
drop if id_exp_id == .
// collapse at the level of the buyer-seller pair, year by year 
// "$OutputTemp/lfttd_m_apparel_pair_1996_2011.dta" should be at this level. 
// To do this again is just to reassure this is the case
collapse (sum) value_imp,by(alpha_id id_exp_id year)
save "$OutputTemp/lfttd_m_apparel_pair_1996_2011_collapsed.dta",replace

***********************
**** Life Cycle of An Importer (Buyer)   ****
***********************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011_collapsed.dta",replace
// collapse at importer level
collapse (sum) value_imp (count) NoSeller = id_exp_id,by(alpha_id year)
// log trade volume
gen lnvalue_imp = log(value_imp)
// log NoSeller
gen lnNoSeller = log(NoSeller)

tsset alpha_id year
***************************
**** Generate Tenure
// duration -- consecutive years in the business
gen ten1 = 1 
forvalues n = 2(1)17 {
	replace ten1 = `n' if l.ten1 == `n'-1
}
// drop pairs which starts at 1996; the numbering is wrong.
drop if ten1 == year - 1996 + 1
// get another definition of alpha_id -- if business is suspended (either permanent or temporary), start a new alpha_id later
sort alpha_id year ten1
gen temp = alpha_id if ten1 == 1
egen alpha_idd = rank(temp),unique
sort alpha_id year ten1
replace alpha_idd = alpha_idd[_n-1] if alpha_idd == .
drop temp alpha_id

// distribution of trade volume by different tenure
gen ten1_age = ten1
replace ten1_age = 6 if ten1_age >= 6
***************************
twoway kdensity lnvalue_imp if ten1_age == 1  ///
	|| kdensity lnvalue_imp if ten1_age == 2 ///
	|| kdensity lnvalue_imp if ten1_age == 3 ///
	|| kdensity lnvalue_imp if ten1_age == 4 ///
	|| kdensity lnvalue_imp if ten1_age == 5 ///
	|| kdensity lnvalue_imp if ten1_age == 6 ///
	, legend(cols(3) label(1 "tenure=1") label(2 "tenure=2") label(3 "tenure=3") ///
	label(4 "tenure=4") label(5 "tenure=5") label(6 "tenure=6+"))
graph export "$Result/Kernel_estimates_lnvalue_imp_by_Importer_tenure.eps" ///
	,as(eps) replace

tsset alpha_idd year
***************************
**** regression
reg lnvalue_imp i.ten1 i.year
est sto reg_1
xtreg lnvalue_imp i.ten1, fe
est sto reg_2
xtreg lnvalue_imp i.ten1 i.year, fe
est sto reg_3
reg lnNoSeller i.ten1 i.year
est sto reg_4
xtreg lnNoSeller i.ten1, fe
est sto reg_5
xtreg lnNoSeller i.ten1 i.year, fe
est sto reg_6
esttab reg_* using "$Result/Regression_value_imp_by_Importer_tenure.csv" ///
	,replace b(%9.4f) se(%9.4f) r2(%9.4f) nogaps ///
	mtitle("log Import Value: Year FE" "log Import Value: Importer FE" "log Import Value: Importer FE; Year FE" ///
	"log Num of Sellers: Year FE" "log Num of Sellers: Importer FE" "log Num of Sellers: Importer FE; Year FE")
est clear


***********************
**** Life Cycle of An Exporter(Seller)   ****
***********************
use "$OutputTemp/lfttd_m_apparel_pair_1996_2011_collapsed.dta",replace
// collapse at importer level
collapse (sum) value_imp (count) NoBuyer = alpha_id,by(id_exp_id year)
// log trade volume
gen lnvalue_imp = log(value_imp)
// log NoSeller
gen lnNoBuyer = log(NoBuyer)

tsset id_exp_id year
***************************
**** Generate Tenure
// duration -- consecutive years in the business
gen ten1 = 1 
forvalues n = 2(1)17 {
	replace ten1 = `n' if l.ten1 == `n'-1
}
// drop pairs which starts at 1996; the numbering is wrong.
drop if ten1 == year - 1996 + 1
// get another definition of id_exp_id-- if business is suspended (either permanent or temporary), start a new alpha_id later
sort id_exp_id year ten1
gen temp = id_exp_id if ten1 == 1
egen id_exp_idd = rank(temp),unique
sort id_exp_id year ten1
replace id_exp_idd = id_exp_idd[_n-1] if id_exp_idd == .
drop temp id_exp_id

// distribution of trade volume by different tenure
gen ten1_age = ten1
replace ten1_age = 6 if ten1_age >= 6
***************************
twoway kdensity lnvalue_imp if ten1_age == 1  ///
	|| kdensity lnvalue_imp if ten1_age == 2 ///
	|| kdensity lnvalue_imp if ten1_age == 3 ///
	|| kdensity lnvalue_imp if ten1_age == 4 ///
	|| kdensity lnvalue_imp if ten1_age == 5 ///
	|| kdensity lnvalue_imp if ten1_age == 6 ///
	, legend(cols(3) label(1 "tenure=1") label(2 "tenure=2") label(3 "tenure=3") ///
	label(4 "tenure=4") label(5 "tenure=5") label(6 "tenure=6+"))
graph export "$Result/Kernel_estimates_lnvalue_imp_by_Exporter_tenure.eps" ///
	,as(eps) replace

tsset id_exp_idd year
***************************
**** regression
reg lnvalue_imp i.ten1 i.year
est sto reg_1
xtreg lnvalue_imp i.ten1, fe
est sto reg_2
xtreg lnvalue_imp i.ten1 i.year, fe
est sto reg_3
reg lnNoBuyer i.ten1 i.year
est sto reg_4
xtreg lnNoBuyer i.ten1, fe
est sto reg_5
xtreg lnNoBuyer i.ten1 i.year, fe
est sto reg_6
esttab reg_* using "$Result/Regression_value_imp_by_Exporter_tenure.csv" ///
	,replace b(%9.4f) se(%9.4f) r2(%9.4f) nogaps ///
	mtitle("log Value: Year FE" "log Value: Exporter FE" "log Value: Exporter FE; Year FE" ///
	"log Num of Buyers: Year FE" "log Num of Buyers: Exporter FE" "log Num of Buyers: Exporter FE; Year FE")
est clear


log close
