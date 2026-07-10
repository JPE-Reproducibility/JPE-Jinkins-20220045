// written by Zi Wang and Yingyan Zhao
// edited by J. Tybout 8-12-16

clear all
set more off
capture log close
/*
global Data       "/rdcprojects/ps/ps01109/data"
global Output     "/rdcprojects/ps/ps01109/programs/jt/EJTX/apparel/Output"
global OutputTemp "/rdcprojects/ps/ps01109/programs/jt/EJTX/apparel/OutputTemp"
global Result     "/rdcprojects/ps/ps01109/programs/jt/EJTX/apparel/Stata/Result"
global OutputLog  "/rdcprojects/ps/ps01109/programs/jt/EJTX/apparel/OutputLog"
*/

log using "$OutputLog/lfttd_imp_apparel_1996_2011.log", replace
//Extract the US apparel imports from 1996 to 2011
//Unify the variable set and variable names

forvalues y = 1996/2000{
use "$Data/lfttd/imp_comb`y'.dta" if substr(hs, 1, 2) == "61" | substr(hs, 1, 2) == "62", clear

keep ssn_flag country d_ent d_u d_p p_ent p_p p_u date_ex date_imp duty fp hs ///
  iso_ex manuf_id mot origqty1 origqty2 orig_swt qty_1 qty_1_dn related state swt value ein alpha 

rename  d_ent     district_entry
rename  d_u       district_unlading
rename  d_p       district_proc
rename  p_ent     port_entry
rename  p_p       port_proc
rename  p_u       port_unlading //Foreign ports
rename  date_ex   date_exp
rename  fp        foreign_port
rename  hs        hs10
rename  iso_ex    iso_exp
rename  manuf_id  id_exp
rename  mot       trans_mode
rename  qty_1_dn  unit
rename  value     value_imp

keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha port_unlading
order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
     /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp

destring hs10, replace force
gen hs2 = int(hs10/100000000)

save "$Output/lfttd_m_apparel_`y'.dta", replace

}

forvalues y = 2001/2005{
use "$Data/lfttd/imp_comb`y'.dta" if substr(hs, 1, 2) == "61" | substr(hs, 1, 2) == "62" , clear

keep ssn_flag country dist_ent dist_unl dist_prc port_ent port_prc port_unl doe date_imp duty ///
  frgnport hs iso_exp manuf_id mot origqty1 origqty2 orig_swt qty_1 qty1_dsg related state swt value ein alpha

rename  dist_ent  district_entry
rename  dist_unl  district_unlading
rename  dist_prc  district_proc
rename  port_ent  port_entry
rename  port_prc  port_proc
rename  port_unl  port_unlading
rename  doe       date_exp
rename  frgnport  foreign_port
rename  hs        hs10
rename  manuf_id  id_exp
rename  mot       trans_mode
rename  qty1_dsg  unit
rename  value     value_imp

keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha port_unlading
order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
      /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp

destring hs10, replace force
gen hs2 = int(hs10/100000000)

save "$Output/lfttd_m_apparel_`y'.dta", replace

}


forvalues y = 2006/2011{
use "$Data/lfttd/imp_comb`y'.dta" if substr(hs, 1, 2) == "61" | substr(hs, 1, 2) == "62" , clear

keep ssn_flag_imp country dist_ent dist_unl dist_prc port_ent port_prc port_unl doe date_imp duty ///
  frgnport hs iso_exp manuf_id mot origqty1 origqty2 orig_swt qty_1 qty1_dsg related state swt value ein alpha

rename  ssn_flag_imp ssn_flag
rename  dist_ent  district_entry
rename  dist_unl  district_unlading
rename  dist_prc  district_proc
rename  port_ent  port_entry
rename  port_prc  port_proc
rename  port_unl  port_unlading
rename  doe       date_exp
rename  frgnport  foreign_port
rename  hs        hs10
rename  manuf_id  id_exp
rename  mot       trans_mode
rename  qty1_dsg  unit
rename  value     value_imp

keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha port_unlading
order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
      /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp

destring hs10, replace force
gen hs2 = int(hs10/100000000)

save "$Output/lfttd_m_apparel_`y'.dta", replace

}


//Data Information:
//Transactional level
//hs2 = 61, 62
//Time: 1996-2011

//Variables:
//alpha ein state
//ssn_flag related
//date_exp date_imp
//hs10 value_imp swt
//id_exp (manuf_id)
//country iso_exp

log close
