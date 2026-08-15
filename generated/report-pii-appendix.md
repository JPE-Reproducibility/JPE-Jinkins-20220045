## Appendix: Detailed PII Detection Results

*Generated on 2026-08-15 19:49:22*

This appendix lists all detected instances of potential personally identifiable information (PII) in the project files. Each entry shows the matched PII terms and, for data files, sample values to help verify whether the flagged content is indeed sensitive.

### Code Files

**/replication-package/code/Stata_LFTTD_code/00_do_apparel_shell.do**

- Line 55: country
  ```
  do "$Dofile/12_lfttd_aggregates_by_country.do"
  ```
- Line 59: lat
  ```
  do "$Dofile/14_lfttd_aggregates_by_related.do"
  ```
- Line 63: name
  ```
  // The original output has a copy in the folder "projects/data/busname2/ssl_apparel"
  ```
- Line 67: name
  ```
  do "$Dofile/16_ssl_cfn6_name_naics_wide_list.do"
  ```
- Line 76: country
  ```
  do "$Dofile/A1_1_lfttd_aggregates_topcountry_vs_others.do"
  ```
- Line 78: country
  ```
  do "$Dofile/A1_2_NoSeller_Top10Country_vs_Others.do"
  ```
- Line 82: name
  ```
  do "$Dofile/A3_lfttd_Top20ImportersName.do"
  ```

**/replication-package/code/Stata_LFTTD_code/00_do_apparel_shell_abbrev.do**

- Line 46: country
  ```
  do "$Dofile/12_lfttd_aggregates_by_country.do"
  ```
- Line 50: lat
  ```
  do "$Dofile/14_lfttd_aggregates_by_related.do"
  ```

**/replication-package/code/Stata_LFTTD_code/01_lfttd_imp_apparel_1996_2011.do**

- Line 17: name
  ```
  //Unify the variable set and variable names
  ```
- Line 22: country
  ```
  keep ssn_flag country d_ent d_u d_p p_ent p_p p_u date_ex date_imp duty fp hs ///
  ```
- Line 23: lat
  ```
  iso_ex manuf_id mot origqty1 origqty2 orig_swt qty_1 qty_1_dn related state swt value ein alpha
  ```
- Line 25: district, name
  ```
  rename  d_ent     district_entry
  ```
- Line 26: district, name
  ```
  rename  d_u       district_unlading
  ```
- Line 27: district, name
  ```
  rename  d_p       district_proc
  ```
- Line 28: name
  ```
  rename  p_ent     port_entry
  ```
- Line 29: name
  ```
  rename  p_p       port_proc
  ```
- Line 30: name
  ```
  rename  p_u       port_unlading //Foreign ports
  ```
- Line 31: name
  ```
  rename  date_ex   date_exp
  ```
- Line 32: name
  ```
  rename  fp        foreign_port
  ```
- Line 33: name
  ```
  rename  hs        hs10
  ```
- Line 34: name
  ```
  rename  iso_ex    iso_exp
  ```
- Line 35: name
  ```
  rename  manuf_id  id_exp
  ```
- Line 36: name
  ```
  rename  mot       trans_mode
  ```
- Line 37: name
  ```
  rename  qty_1_dn  unit
  ```
- Line 38: name
  ```
  rename  value     value_imp
  ```
- Line 40: country, lat
  ```
  keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha po
  ```
- Line 41: lat
  ```
  order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
  ```
- Line 42: country
  ```
  /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp
  ```
- Line 54: country
  ```
  keep ssn_flag country dist_ent dist_unl dist_prc port_ent port_prc port_unl doe date_imp duty ///
  ```
- Line 55: lat
  ```
  frgnport hs iso_exp manuf_id mot origqty1 origqty2 orig_swt qty_1 qty1_dsg related state swt value e
  ```
- Line 57: district, name
  ```
  rename  dist_ent  district_entry
  ```
- Line 58: district, name
  ```
  rename  dist_unl  district_unlading
  ```
- Line 59: district, name
  ```
  rename  dist_prc  district_proc
  ```
- Line 60: name
  ```
  rename  port_ent  port_entry
  ```
- Line 61: name
  ```
  rename  port_prc  port_proc
  ```
- Line 62: name
  ```
  rename  port_unl  port_unlading
  ```
- Line 63: name
  ```
  rename  doe       date_exp
  ```
- Line 64: name
  ```
  rename  frgnport  foreign_port
  ```
- Line 65: name
  ```
  rename  hs        hs10
  ```
- Line 66: name
  ```
  rename  manuf_id  id_exp
  ```
- Line 67: name
  ```
  rename  mot       trans_mode
  ```
- Line 68: name
  ```
  rename  qty1_dsg  unit
  ```
- Line 69: name
  ```
  rename  value     value_imp
  ```
- Line 71: country, lat
  ```
  keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha po
  ```
- Line 72: lat
  ```
  order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
  ```
- Line 73: country
  ```
  /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp
  ```
- Line 86: country
  ```
  keep ssn_flag_imp country dist_ent dist_unl dist_prc port_ent port_prc port_unl doe date_imp duty //
  ```
- Line 87: lat
  ```
  frgnport hs iso_exp manuf_id mot origqty1 origqty2 orig_swt qty_1 qty1_dsg related state swt value e
  ```
- Line 89: name
  ```
  rename  ssn_flag_imp ssn_flag
  ```
- Line 90: district, name
  ```
  rename  dist_ent  district_entry
  ```
- Line 91: district, name
  ```
  rename  dist_unl  district_unlading
  ```
- Line 92: district, name
  ```
  rename  dist_prc  district_proc
  ```
- Line 93: name
  ```
  rename  port_ent  port_entry
  ```
- Line 94: name
  ```
  rename  port_prc  port_proc
  ```
- Line 95: name
  ```
  rename  port_unl  port_unlading
  ```
- Line 96: name
  ```
  rename  doe       date_exp
  ```
- Line 97: name
  ```
  rename  frgnport  foreign_port
  ```
- Line 98: name
  ```
  rename  hs        hs10
  ```
- Line 99: name
  ```
  rename  manuf_id  id_exp
  ```
- Line 100: name
  ```
  rename  mot       trans_mode
  ```
- Line 101: name
  ```
  rename  qty1_dsg  unit
  ```
- Line 102: name
  ```
  rename  value     value_imp
  ```
- Line 104: country, lat
  ```
  keep ssn_flag country iso_exp date_exp date_imp hs10 id_exp value_imp related state swt ein alpha po
  ```
- Line 105: lat
  ```
  order /*importer*/ alpha ein state /*status*/ ssn_flag related /*time*/ date_exp date_imp ///
  ```
- Line 106: country
  ```
  /*transaction*/ hs10 value_imp swt /*exporter*/ id_exp /*country*/ country iso_exp
  ```
- Line 123: lat
  ```
  //ssn_flag related
  ```
- Line 127: country
  ```
  //country iso_exp
  ```

**/replication-package/code/Stata_LFTTD_code/02_lfttd_imp_apparel_alpha_id_exp.do**

- Line 10: block, lat, loc
  ```
  // The following block calculates importance of missing alpha obs. and creates a new dataset.
  ```
- Line 12: country
  ```
  // a dataset at buyer-seller-hs10-country-year level
  ```
- Line 26: country, lat
  ```
  keep alpha related hs10 value_imp id_exp country iso_exp hs2
  ```
- Line 27: country, lat
  ```
  collapse (sum) value_imp,by(alpha related hs10 id_exp country iso_exp hs2)
  ```
- Line 40: lat
  ```
  // The following code documents importance of obs. with missing exporter IDs and related party trade
  ```
- Line 47: country
  ```
  sort id_exp country
  ```
- Line 51: country
  ```
  replace missing_exp_id = 1 if id_exp == "" | country == ""
  ```
- Line 53: lat
  ```
  tabstat value_imp, stats(sum) by(related)
  ```
- Line 54: lat
  ```
  // drop if there is no exporter id and related trade
  ```
- Line 55: country, lat
  ```
  drop if id_exp == "" | country == "" | related =="Y"
  ```
- Line 58: country
  ```
  collapse (sum) value_imp,by(alpha id_exp country year)
  ```

**/replication-package/code/Stata_LFTTD_code/03_lfttd_dist_NumSeller_per_buyer.do**

- Line 6: lat
  ```
  Year by year, number of sellers for each buyer are calculated. These are saved in
  ```
- Line 41: name
  ```
  rename temp Freq
  ```
- Line 84: name
  ```
  rename temp Freq
  ```
- Line 87: lat
  ```
  // calculate # firms with at least x partners
  ```
- Line 106: lat
  ```
  title("Relation between log(# buyers with at least x sellers) and log(# sellers), year = `y'")
  ```
- Line 146: name
  ```
  rename temp Freq
  ```
- Line 189: name
  ```
  rename temp Freq
  ```
- Line 232: name
  ```
  rename temp Freq
  ```

**/replication-package/code/Stata_LFTTD_code/04_lfttd_dist_NumBuyer_per_seller.do**

- Line 6: lat
  ```
  Year by year, number of buyers for each seller are calculated. These are saved in
  ```
- Line 32: country
  ```
  collapse (count) NoBuyer = value_imp,by(id_exp country)
  ```
- Line 40: name
  ```
  rename temp Freq
  ```
- Line 82: name
  ```
  rename temp Freq
  ```
- Line 85: lat
  ```
  // calculate # firms with at least x partners
  ```
- Line 104: lat
  ```
  title("Relation between log(# sellers with at least x buyers) and log(# buyers), year = `y'")
  ```
- Line 125: country
  ```
  collapse (count) NoBuyer = value_imp,by(id_exp country)
  ```
- Line 142: name
  ```
  rename temp Freq
  ```
- Line 167: country
  ```
  collapse (count) NoBuyer = value_imp,by(id_exp country)
  ```
- Line 184: name
  ```
  rename temp Freq
  ```
- Line 208: country
  ```
  collapse (count) NoBuyer = value_imp,by(id_exp country)
  ```
- Line 225: name
  ```
  rename temp Freq
  ```
- Line 250: country
  ```
  collapse (count) NoBuyer = value_imp,by(id_exp country)
  ```
- Line 264: name
  ```
  rename temp Freq
  ```

**/replication-package/code/Stata_LFTTD_code/05_lfttd_NumSellerBuyer_transition_matrix.do**

- Line 55: name
  ```
  // rename variables
  ```
- Line 57: name
  ```
  rename temp_shr`i' NoSeller_gr_shr_f`i'
  ```
- Line 58: name
  ```
  rename temp`i' NoSeller_gr_f`i'
  ```
- Line 80: country
  ```
  // exporter id - redefined - assume id_exp and country uniquely define an exporter
  ```
- Line 81: country
  ```
  egen id_exp_new = group(id_exp country)
  ```
- Line 108: name
  ```
  // rename variables
  ```
- Line 110: name
  ```
  rename temp_shr`i' NoBuyer_gr_shr_f`i'
  ```
- Line 111: name
  ```
  rename temp`i' NoBuyer_gr_f`i'
  ```

**/replication-package/code/Stata_LFTTD_code/07_lfttd_duration.do**

- Line 5: lat
  ```
  This code calculates the duration of each business relationship. Two defintions of
  ```
- Line 11: lat
  ```
  Distributions of durations are graphed (duration_hist`dur'.xlsx) and related to sales
  ```
- Line 23: lat
  ```
  **** Calculate Duration		   ****
  ```
- Line 29: country
  ```
  egen pair_id_origin = group(alpha id_exp country)
  ```
- Line 40: lat
  ```
  // get another definition of pair_id -- if business is suspended (either permanent or temporary), st
  ```
- Line 41: country
  ```
  sort alpha id_exp country year dur1
  ```
- Line 44: country
  ```
  sort alpha id_exp country year dur1
  ```
- Line 53: country
  ```
  egen pair_id_origin = group(alpha id_exp country)
  ```
- Line 82: country
  ```
  collapse (mean) value_imp, by(pair_id id_exp country alpha year_start year_end)
  ```
- Line 83: lat
  ```
  gen duration  = year_end - year_start + 1 if year_end != 2011 // if the relation has not end at 2011
  ```
- Line 110: lat
  ```
  label var lnvalue_imp "log (average trade volume during the relation)"
  ```
- Line 113: country
  ```
  egen export_id = group(id_exp country)
  ```
- Line 118: lat, lon
  ```
  // by controlling importers' effect; the more important relation is, the longer the duration
  ```
- Line 121: lat, lon
  ```
  // by controlling exporters' effect; the more important relation is, the longer the duration
  ```
- Line 127: lat, lon
  ```
  // by controlling importers' effect; the more important relation is, the longer the duration
  ```
- Line 130: lat, lon
  ```
  // by controlling exporters' effect; the more important relation is, the longer the duration
  ```
- Line 136: lat, lon
  ```
  // by controlling importers' effect; the more important relation is, the longer the duration
  ```
- Line 139: lat, lon
  ```
  // by controlling exporters' effect; the more important relation is, the longer the duration
  ```
- Line 144: lat
  ```
  title("Relation between duration and trade volume") ///
  ```

**/replication-package/code/Stata_LFTTD_code/12_lfttd_aggregates_by_country.do**

- Line 22: country
  ```
  collapse (sum) value_imp,by(country)
  ```
- Line 42: lat
  ```
  , ytitle("Cummulative Import value share") ///
  ```
- Line 46: lat
  ```
  graph export "$Result/cummulative_import_shr.eps",as(eps) replace
  ```
- Line 50: country
  ```
  **** choose ten most important country of origin in 2011
  ```
- Line 57: country
  ```
  collapse (sum) value_imp,by(country)
  ```
- Line 64: country
  ```
  gen top_country = 1
  ```
- Line 67: country
  ```
  keep country top_country value_shr rank
  ```
- Line 68: country
  ```
  save "$OutputTemp/Top_Country_List_`yr'.dta",replace
  ```
- Line 73: country
  ```
  **** Trade Volume Aggregates by Country of origin     ****
  ```
- Line 75: country
  ```
  **** Trade Volume Aggregates of top 10 country list
  ```
- Line 90: country
  ```
  keep if top_country == 1
  ```
- Line 92: country
  ```
  collapse (sum) value_imp,by(missing_alpha country)
  ```
- Line 94: country
  ```
  save "$OutputTemp/Value_imp_by_missing_alpha_country_`y'.dta", replace
  ```
- Line 98: country
  ```
  use "$OutputTemp/Value_imp_by_missing_alpha_country_1996.dta", clear
  ```
- Line 103: country
  ```
  export excel "$Result/Value_imp_by_missing_alpha_country_1996_2011.xlsx",replace firstrow(variables)
  ```
- Line 104: country
  ```
  save "$Output/Value_imp_by_missing_alpha_country_1996_2011.dta",replace
  ```
- Line 109: country
  ```
  // graph Value_imp_by_missing_alpha_country_1996_2011
  ```
- Line 110: country
  ```
  use "$Output/Value_imp_by_missing_alpha_country_1996_2011.dta",clear
  ```
- Line 111: country
  ```
  gen country_eng = ""
  ```
- Line 112: country
  ```
  replace country_eng = "China" if country == "5700"
  ```
- Line 113: country
  ```
  replace country_eng = "Indonesia" if country == "5600"
  ```
- Line 114: country
  ```
  replace country_eng = "Cambobia" if country == "5550"
  ```
- Line 115: country
  ```
  replace country_eng = "Vietnam" if country == "5520"
  ```
- Line 116: country
  ```
  replace country_eng = "Bangladesh" if country == "5380"
  ```
- Line 117: country
  ```
  replace country_eng = "Pakistan" if country == "5350"
  ```
- Line 118: country
  ```
  replace country_eng = "India" if country == "5330"
  ```
- Line 119: country
  ```
  replace country_eng = "Honduras" if country == "2150"
  ```
- Line 120: country
  ```
  replace country_eng = "El Salvador" if country == "2110"
  ```
- Line 121: country
  ```
  replace country_eng = "Mexico" if country == "2010"
  ```
- Line 125: country
  ```
  twoway line import_value year if country == "2010" ///
  ```
- Line 126: country
  ```
  || line import_value year if country == "2110" ///
  ```
- Line 127: country
  ```
  || line import_value year if country == "2150" ///
  ```
- Line 128: country
  ```
  || line import_value year if country == "5330" ///
  ```
- Line 129: country
  ```
  || line import_value year if country == "5350" ///
  ```
- Line 130: country
  ```
  || line import_value year if country == "5380" ///
  ```
- Line 131: country
  ```
  || line import_value year if country == "5520" ///
  ```
- Line 132: country
  ```
  || line import_value year if country == "5550" ///
  ```
- Line 133: country
  ```
  || line import_value year if country == "5600" ///
  ```
- Line 134: country
  ```
  || line import_value year if country == "5700" ///
  ```
- Line 141: country
  ```
  graph export "$Result/Value_imp_by_missing_alpha_country_1996_2011.eps",as(eps) replace
  ```
- Line 145: country
  ```
  **** Total number of buyers by Country of origin    ****
  ```
- Line 148: country
  ```
  **** Total number of buyers of top 10 country list
  ```
- Line 164: country
  ```
  keep if top_country == 1
  ```
- Line 166: country
  ```
  collapse (sum) value_imp,by(alpha country)
  ```
- Line 167: country
  ```
  collapse (count) NoBuyer = value_imp,by(country)
  ```
- Line 169: country
  ```
  save "$OutputTemp/NoBuyer_by_country_`y'.dta", replace
  ```
- Line 172: country
  ```
  use "$OutputTemp/NoBuyer_by_country_1996.dta", clear
  ```
- Line 183: country
  ```
  keep year NoBuyer_r country
  ```
- Line 184: country
  ```
  export excel "$Result/NoBuyer_by_country_1996_2011.xlsx",replace firstrow(varlabels)
  ```
- Line 185: country
  ```
  save "$Output/NoBuyer_by_country_1996_2011.dta",replace
  ```
- Line 188: country
  ```
  // graph "$Output/NoBuyer_by_country_1996_2011
  ```
- Line 189: country
  ```
  use "$Output/NoBuyer_by_country_1996_2011.dta",replace
  ```
- Line 190: country
  ```
  gen country_eng = ""
  ```
- Line 191: country
  ```
  replace country_eng = "China" if country == "5700"
  ```
- Line 192: country
  ```
  replace country_eng = "Indonesia" if country == "5600"
  ```
- Line 193: country
  ```
  replace country_eng = "Cambobia" if country == "5550"
  ```
- Line 194: country
  ```
  replace country_eng = "Vietnam" if country == "5520"
  ```
- Line 195: country
  ```
  replace country_eng = "Bangladesh" if country == "5380"
  ```
- Line 196: country
  ```
  replace country_eng = "Pakistan" if country == "5350"
  ```
- Line 197: country
  ```
  replace country_eng = "India" if country == "5330"
  ```
- Line 198: country
  ```
  replace country_eng = "Honduras" if country == "2150"
  ```
- Line 199: country
  ```
  replace country_eng = "El Salvador" if country == "2110"
  ```
- Line 200: country
  ```
  replace country_eng = "Mexico" if country == "2010"
  ```
- Line 203: country
  ```
  twoway line NoBuyer_r year if country == "2010" ///
  ```
- Line 204: country
  ```
  || line NoBuyer_r year if country == "2110" ///
  ```
- Line 205: country
  ```
  || line NoBuyer_r year if country == "2150" ///
  ```
- Line 206: country
  ```
  || line NoBuyer_r year if country == "5330" ///
  ```
- Line 207: country
  ```
  || line NoBuyer_r year if country == "5350" ///
  ```
- Line 208: country
  ```
  || line NoBuyer_r year if country == "5380" ///
  ```
- Line 209: country
  ```
  || line NoBuyer_r year if country == "5520" ///
  ```
- Line 210: country
  ```
  || line NoBuyer_r year if country == "5550" ///
  ```
- Line 211: country
  ```
  || line NoBuyer_r year if country == "5600" ///
  ```
- Line 212: country
  ```
  || line NoBuyer_r year if country == "5700" ///
  ```
- Line 219: country
  ```
  graph export "$Result/NoBuyer_by_country_1996_2011.eps",as(eps) replace
  ```
- Line 223: country
  ```
  **** Total number of Sellers by Country of origin    ****
  ```
- Line 226: country
  ```
  **** By Country of origin: Top 10 countries
  ```
- Line 239: country
  ```
  replace missing_id_exp = 1 if id_exp == "" | country == ""
  ```
- Line 242: country
  ```
  egen export_id = group(id_exp country)
  ```
- Line 246: country
  ```
  keep if top_country == 1
  ```
- Line 248: country
  ```
  collapse (sum) value_imp,by(export_id country)
  ```
- Line 249: country
  ```
  collapse (count) NoSeller = value_imp,by(country)
  ```
- Line 251: country
  ```
  save "$OutputTemp/NoSeller_by_country_`y'.dta", replace
  ```
- Line 254: country
  ```
  use "$OutputTemp/NoSeller_by_country_1996.dta", clear
  ```
- Line 265: country
  ```
  keep year NoSeller_r country
  ```
- Line 266: country
  ```
  export excel "$Result/NoSeller_by_country_1996_2011.xlsx",replace firstrow(varlabels)
  ```
- Line 267: country
  ```
  save "$Output/NoSeller_by_country_1996_2011.dta",replace
  ```
- Line 270: country
  ```
  // graph "$Output/NoSeller_by_country_1996_2011
  ```
- Line 271: country
  ```
  use "$Output/NoSeller_by_country_1996_2011.dta",replace
  ```
- Line 272: country
  ```
  gen country_eng = ""
  ```
- Line 273: country
  ```
  replace country_eng = "China" if country == "5700"
  ```
- Line 274: country
  ```
  replace country_eng = "Indonesia" if country == "5600"
  ```
- Line 275: country
  ```
  replace country_eng = "Cambobia" if country == "5550"
  ```
- Line 276: country
  ```
  replace country_eng = "Vietnam" if country == "5520"
  ```
- Line 277: country
  ```
  replace country_eng = "Bangladesh" if country == "5380"
  ```
- Line 278: country
  ```
  replace country_eng = "Pakistan" if country == "5350"
  ```
- Line 279: country
  ```
  replace country_eng = "India" if country == "5330"
  ```
- Line 280: country
  ```
  replace country_eng = "Honduras" if country == "2150"
  ```
- Line 281: country
  ```
  replace country_eng = "El Salvador" if country == "2110"
  ```
- Line 282: country
  ```
  replace country_eng = "Mexico" if country == "2010"
  ```
- Line 285: country
  ```
  twoway line NoSeller_r year if country == "2010" ///
  ```
- Line 286: country
  ```
  || line NoSeller_r year if country == "2110" ///
  ```
- Line 287: country
  ```
  || line NoSeller_r year if country == "2150" ///
  ```
- Line 288: country
  ```
  || line NoSeller_r year if country == "5330" ///
  ```
- Line 289: country
  ```
  || line NoSeller_r year if country == "5350" ///
  ```
- Line 290: country
  ```
  || line NoSeller_r year if country == "5380" ///
  ```
- Line 291: country
  ```
  || line NoSeller_r year if country == "5520" ///
  ```
- Line 292: country
  ```
  || line NoSeller_r year if country == "5550" ///
  ```
- Line 293: country
  ```
  || line NoSeller_r year if country == "5600" ///
  ```
- Line 294: country
  ```
  || line NoSeller_r year if country == "5700" ///
  ```
- Line 301: country
  ```
  graph export "$Result/NoSeller_by_country_1996_2011.eps",as(eps) replace
  ```

**/replication-package/code/Stata_LFTTD_code/13_lfttd_aggregates.do**

- Line 11: lat
  ```
  **** Trade Volume Aggregates by missing alpha and related/nonrelated trade       ****
  ```
- Line 22: lat
  ```
  collapse (sum) value_imp,by(missing_alpha relate)
  ```
- Line 24: lat
  ```
  save "$OutputTemp/Value_imp_by_missing_alpha_related_`y'.dta", replace
  ```
- Line 28: lat
  ```
  use "$OutputTemp/Value_imp_by_missing_alpha_related_1996.dta", clear
  ```
- Line 33: lat
  ```
  export excel "$Result/Value_imp_by_missing_alpha_related_1996_2011.xlsx",replace firstrow(variables)
  ```
- Line 34: lat
  ```
  save "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",replace
  ```
- Line 48: country
  ```
  replace missing_id_exp = 1 if id_exp == "" | country == ""
  ```
- Line 64: lat
  ```
  // graph "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta" -- missing nonmissing
  ```
- Line 65: lat
  ```
  use "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",clear
  ```
- Line 73: lat
  ```
  graph export "$Result/Value_imp_by_missing_alpha_related_1996_2011_missing_alpha.eps",as(eps) replac
  ```
- Line 154: country
  ```
  replace missing_id_exp = 1 if id_exp == "" | country == ""
  ```
- Line 157: country
  ```
  egen export_id = group(id_exp country)
  ```

**/replication-package/code/Stata_LFTTD_code/14_lfttd_aggregates_by_related.do**

- Line 12: lat
  ```
  **** Trade Volume Aggregates of related/nonrelated trade       ****
  ```
- Line 17: lat
  ```
  // graph "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta" -- related nonralated
  ```
- Line 18: lat
  ```
  use "$Output/Value_imp_by_missing_alpha_related_1996_2011.dta",clear
  ```
- Line 21: lat
  ```
  twoway line import_value year if related == "Y" ///
  ```
- Line 22: lat
  ```
  || line import_value year if related == "N" ///
  ```
- Line 23: lat
  ```
  || line import_value year if related == "" ///
  ```
- Line 24: lat
  ```
  , legend(col(3) lab(1 "Related") lab(2 "Non-related") lab(3 "Missing")) ///
  ```
- Line 27: lat
  ```
  graph export "$Result/Value_imp_by_missing_alpha_related_1996_2011_related_nonralated.eps",as(eps) r
  ```
- Line 33: lat
  ```
  **** related/nonrelated trade
  ```
- Line 35: lat
  ```
  **** By Related/Nonrelated party trade
  ```
- Line 46: lat
  ```
  collapse (sum) value_imp,by(alpha relate)
  ```
- Line 47: lat
  ```
  collapse (count) NoBuyer = value_imp,by(relate)
  ```
- Line 49: lat
  ```
  save "$OutputTemp/NoBuyer_by_related_`y'.dta", replace
  ```
- Line 52: lat
  ```
  use "$OutputTemp/NoBuyer_by_related_1996.dta", clear
  ```
- Line 63: lat
  ```
  keep year NoBuyer_r relate
  ```
- Line 64: lat
  ```
  export excel "$Result/NoBuyer_by_related_1996_2011.xlsx",replace firstrow(varlabels)
  ```
- Line 65: lat
  ```
  save "$Output/NoBuyer_by_related_1996_2011.dta",replace
  ```
- Line 68: lat
  ```
  // graph "$Output/No`x'_by_related_1996_2011.dta"
  ```
- Line 69: lat
  ```
  use "$Output/NoBuyer_by_related_1996_2011.dta",clear
  ```
- Line 73: lat
  ```
  twoway line NoBuyer_r year if related == "Y"  ///
  ```
- Line 74: lat
  ```
  || line NoBuyer_r year if related == "N" ///
  ```
- Line 75: lat
  ```
  , legend(col(3) lab(1 "Related") lab(2 "Non-related")) ///
  ```
- Line 78: lat
  ```
  graph export "$Result/NoBuyer_by_related_1996_2011.eps",as(eps) replace
  ```
- Line 83: lat
  ```
  **** related/nonrelated trade
  ```
- Line 85: lat
  ```
  **** By Related/Nonrelated party trade
  ```
- Line 98: country
  ```
  replace missing_id_exp = 1 if id_exp == "" | country == ""
  ```
- Line 101: country
  ```
  egen export_id = group(id_exp country)
  ```
- Line 102: lat
  ```
  collapse (sum) value_imp,by(export_id relate)
  ```
- Line 103: lat
  ```
  collapse (count) NoSeller = value_imp,by(relate)
  ```
- Line 105: lat
  ```
  save "$OutputTemp/NoSeller_by_related_`y'.dta", replace
  ```
- Line 108: lat
  ```
  use "$OutputTemp/NoSeller_by_related_1996.dta", clear
  ```
- Line 113: lat
  ```
  replace relate = "missing" if relate == ""
  ```
- Line 120: lat
  ```
  keep year NoSeller_r relate
  ```
- Line 121: lat
  ```
  export excel "$Result/NoSeller_by_related_1996_2011.xlsx",replace firstrow(varlabels)
  ```
- Line 122: lat
  ```
  save "$Output/NoSeller_by_related_1996_2011.dta",replace
  ```
- Line 125: lat
  ```
  // graph "$Output/NoSeller_by_related_1996_2011.dta"
  ```
- Line 126: lat
  ```
  use "$Output/NoSeller_by_related_1996_2011.dta",clear
  ```
- Line 130: lat
  ```
  twoway line NoSeller_r year if related == "Y"  ///
  ```
- Line 131: lat
  ```
  || line NoSeller_r year if related == "N" ///
  ```
- Line 132: lat
  ```
  , legend(col(3) lab(1 "Related") lab(2 "Non-related")) ///
  ```
- Line 135: lat
  ```
  graph export "$Result/NoSeller_by_related_1996_2011.eps",as(eps) replace
  ```

**/replication-package/code/Stata_LFTTD_code/A10_lfttd_tenure_of_BuyerSeller.do**

- Line 9: lat
  ```
  This code calculates the tenure of buyers/sellers. Two defintions of
  ```
- Line 29: country
  ```
  egen id_exp_id = group(id_exp country)
  ```
- Line 59: lat
  ```
  // get another definition of alpha_id -- if business is suspended (either permanent or temporary), s
  ```
- Line 125: lat
  ```
  // get another definition of id_exp_id-- if business is suspended (either permanent or temporary), s
  ```

**/replication-package/code/Stata_LFTTD_code/A7_lfttd_imp_apparel_statistics.do**

- Line 24: country
  ```
  egen seller = group(id_exp country)
  ```
- Line 52: loc
  ```
  local dur dur1
  ```
- Line 60: name
  ```
  rename `dur' match_age
  ```
- Line 63: loc
  ```
  local dur dur1
  ```
- Line 74: name
  ```
  rename `dur'_max match_age
  ```
- Line 75: name
  ```
  rename value_imp avg_value
  ```
- Line 76: name
  ```
  rename lnvalue_imp avg_lnvalue
  ```
- Line 77: name
  ```
  rename sd_value_imp sd_value
  ```
- Line 78: name
  ```
  rename sd_lnvalue_imp sd_lnvalue
  ```
- Line 95: country
  ```
  egen seller = group(id_exp country)
  ```
- Line 126: country
  ```
  egen seller = group(id_exp country)
  ```

**/replication-package/code/Stata_figure11b_event_study/event_study.do**

- Line 16: loc
  ```
  local root `"`0'"'
  ```
- Line 18: loc
  ```
  local root "`c(pwd)'"
  ```
- Line 21: loc
  ```
  local data_dir `"`root'/data/US_ITC_figure11b_event_study"'
  ```
- Line 22: loc
  ```
  local out_dir  `"`root'/output/figures/paper"'
  ```
- Line 39: country
  ```
  duplicates drop Country HTSNumber, force
  ```
- Line 47: name
  ```
  rename _w w_entropy
  ```
- Line 49: country
  ```
  keep Country HTSNumber T w*
  ```
- Line 57: country
  ```
  collapse (sum) m_val, by(Country)
  ```
- Line 66: country
  ```
  tab Country if _m != 3
  ```
- Line 69: country
  ```
  drop if T == 0 & Country == "China"
  ```
- Line 71: country
  ```
  collapse (sum) m_val (sum) m_q1 (mean) m_p, by(Country rank HTSNumber Year T hs8)
  ```
- Line 72: name
  ```
  rename m_p ref_m_p
  ```
- Line 81: country
  ```
  egen id = group(Country HTSNumber)
  ```
- Line 93: loc
  ```
  local tmax = r(max)
  ```
- Line 102: loc
  ```
  local y = "val"
  ```
- Line 103: loc
  ```
  local w = "entropy"
  ```
- Line 104: loc
  ```
  local rankcap = 5
  ```
- Line 109: country
  ```
  reghdfe lm_`y' et_* [pw=w_entropy], a(id ht) cluster(hs8 Country)
  ```
- Line 114: loc
  ```
  local tmax = r(max)
  ```
- Line 129: loc
  ```
  local ylab "-100(20)0"
  ```
- Line 130: loc
  ```
  local v "Log Value"
  ```
- Line 131: loc
  ```
  local xlab "2017(1)2024"
  ```

**/replication-package/code/matlab/AAR/baseline_moments/compute_lifecycle_profile.m**

- Line 7: lat
  ```
  %     • Cumulative life-cycle growth measured relative to the first year 
  ```
- Line 55: lat
  ```
  simulate_sellers_with_hazard(j, u(:, j), thetas, param_fix, param, TT, revenue_per_type(j));
  ```
- Line 109: lat
  ```
  % Cumulative growth relative to the first export year (age-one value is zero)
  ```
- Line 165: lat
  ```
  function [cnt_traj, mean_traj, std_traj, stats, sales_by_age] = simulate_sellers_with_hazard(stype, 
  ```
- Line 166: lat
  ```
  %SIMULATE_SELLERS_WITH_HAZARD Seller-side simulation with exporter-level hazard stats.
  ```
- Line 256: lat
  ```
  %   (`ages`) at the sequence of simulated jump times returned by the EJTX
  ```
- Line 298: lat
  ```
  risk_counts = accumulate_risk(risk_counts, spell_start_age, last_age, max_interval);
  ```
- Line 320: lat
  ```
  risk_counts = accumulate_risk(risk_counts, spell_start_age, last_age, max_interval);
  ```
- Line 328: lat
  ```
  %ACCUMULATE_RISK Adds survival exposure for a spell of given end-of-period age.
  ```

**/replication-package/code/matlab/AAR/baseline_moments/compute_size_exit_rates.m**

- Line 62: city
  ```
  capacity = upper_edge - (lower_edge + mass_in_bin);
  ```
- Line 63: city
  ```
  if capacity <= 1e-14
  ```
- Line 74: city, loc
  ```
  allocate = min(mass_i, capacity);
  ```
- Line 75: loc
  ```
  bin_mass(current_bin) = bin_mass(current_bin) + allocate;
  ```
- Line 76: loc
  ```
  bin_exit_num(current_bin) = bin_exit_num(current_bin) + allocate * exit_i;
  ```
- Line 77: loc
  ```
  bin_sales_num(current_bin) = bin_sales_num(current_bin) + allocate * sales_i;
  ```
- Line 78: loc
  ```
  mass_i = mass_i - allocate;
  ```
- Line 79: loc
  ```
  mass_in_bin = mass_in_bin + allocate;
  ```

**/replication-package/code/matlab/AAR/baseline_moments/compute_within_firm_growth_ratio.m**

- Line 7: lon
  ```
  %   observations at both horizons, along with the underlying sample of
  ```

**/replication-package/code/matlab/AAR/baseline_moments/expected_match_revenue.m**

- Line 4: lat
  ```
  %   consistent with the legacy baseline simulation code.
  ```
- Line 11: loc
  ```
  % Preallocate containers that mirror eval_s.m
  ```

**/replication-package/code/matlab/AAR/baseline_moments/generate_baseline_moments.m**

- Line 7: name
  ```
  this_dir = fileparts(mfilename('fullpath'));
  ```
- Line 18: lat
  ```
  baseline_sim_dir = fullfile(root_dir, 'other_code', 'baseline simulation');
  ```
- Line 20: lat
  ```
  baseline_sim_dir = fullfile(legacy_dir, 'other_code', 'baseline simulation');
  ```
- Line 169: name
  ```
  'VariableNames', {'age', 'hazard', 'exposure', 'exit_count'});
  ```

**/replication-package/code/matlab/AAR/comparison/scripts/generate_comparison_outputs.m**

- Line 2: son
  ```
  %GENERATE_COMPARISON_OUTPUTS Create tables comparing AAR model and EJTX targets.
  ```
- Line 4: name
  ```
  project_root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
  ```
- Line 29: son
  ```
  comparison_tbl = table(labels, data_vec, model_vec, diff_vec, ...
  ```
- Line 30: name
  ```
  'VariableNames', {'moment', 'ejtx_data', 'aar_model', 'model_minus_data'});
  ```
- Line 31: son
  ```
  output_table_path = fullfile(project_root, 'comparison', 'tables', 'moment_comparison.csv');
  ```
- Line 32: son
  ```
  writetable(comparison_tbl, output_table_path);
  ```
- Line 34: name
  ```
  param_names = {'f_bar', 'delta_f', 'xi_H', 'rho_xi'}';
  ```
- Line 37: name
  ```
  param_tbl = table(param_names, param_values, 'VariableNames', {'parameter', 'estimate'});
  ```
- Line 38: son
  ```
  output_param_path = fullfile(project_root, 'comparison', 'tables', 'parameter_estimates.csv');
  ```
- Line 41: son
  ```
  % Policy-shock comparison (EJTX Section 7.1 calibration mapped into AAR).
  ```
- Line 44: son
  ```
  output_policy_path = fullfile(project_root, 'comparison', 'tables', 'policy_shock_comparison.csv');
  ```
- Line 46: son
  ```
  output_policy_benchmark_path = fullfile(project_root, 'comparison', 'tables', 'policy_shock_benchmar
  ```
- Line 49: son
  ```
  fprintf('Comparison outputs written to %s\n', fullfile(project_root, 'comparison'));
  ```

**/replication-package/code/matlab/AAR/counterfactuals/policy_shock/run_policy_shock_counterfactual.m**

- Line 14: name
  ```
  this_dir = fileparts(mfilename('fullpath'));
  ```
- Line 46: name
  ```
  metric_names = metrics_pre.names(:);
  ```
- Line 52: name
  ```
  ejtx_policy_pct(strcmp(metric_names, 'measure active low-productivity suppliers')) = 29.3;
  ```
- Line 53: name
  ```
  ejtx_policy_pct(strcmp(metric_names, 'measure active high-productivity suppliers')) = 19.3;
  ```
- Line 55: name
  ```
  result_tbl = table(metric_names, pre_vec, post_vec, pct_change, ejtx_policy_pct, ...
  ```
- Line 56: name
  ```
  'VariableNames', {'metric', 'pre_policy', 'post_policy', 'pct_change', 'ejtx_policy_pct_change'});
  ```
- Line 58: name
  ```
  benchmark_tbl = build_policy_benchmark_table(pre_vec, post_vec, metric_names);
  ```
- Line 64: name
  ```
  'VariableNames', { ...
  ```
- Line 73: name
  ```
  for k = 1:numel(metric_names)
  ```
- Line 75: name
  ```
  metric_names{k}, pre_vec(k), post_vec(k), pct_change(k));
  ```
- Line 79: name
  ```
  results.metric_names = metric_names;
  ```
- Line 105: name
  ```
  metrics.names = {
  ```
- Line 195: name
  ```
  idx_low = strcmp(metric_names, 'measure active low-productivity suppliers');
  ```
- Line 196: name
  ```
  idx_high = strcmp(metric_names, 'measure active high-productivity suppliers');
  ```
- Line 197: name
  ```
  idx_total = strcmp(metric_names, 'measure active exporters');
  ```
- Line 198: name
  ```
  idx_share = strcmp(metric_names, 'share high-productivity among active exporters');
  ```
- Line 199: name
  ```
  idx_welfare = strcmp(metric_names, 'consumer welfare level (1/P)');
  ```
- Line 213: name
  ```
  'VariableNames', {'metric', 'ejtx_policy_pct_change', 'aar_policy_pct_change'});
  ```

**/replication-package/code/matlab/AAR/estimation/compute_empirical_moments.m**

- Line 2: lat
  ```
  %COMPUTE_EMPIRICAL_MOMENTS Map baseline simulation statistics into AAR targets.
  ```

**/replication-package/code/matlab/AAR/estimation/data_moments_baseline.m**

- Line 8: name
  ```
  this_dir = fileparts(mfilename('fullpath'));
  ```

**/replication-package/code/matlab/AAR/estimation/default_config.m**

- Line 7: name
  ```
  this_dir = fileparts(mfilename('fullpath'));
  ```
- Line 12: city
  ```
  cfg.sigma       = 3.25;    % Intermediate elasticity (geometric mean of EJTX elasticities)
  ```
- Line 26: lat
  ```
  cfg.life_cycle_horizon  = 10;  % number of life-cycle points simulated for diagnostics
  ```

**/replication-package/code/matlab/AAR/estimation/estimate_parameters.m**

- Line 13: name
  ```
  clamp = @(name, value) min(max(value, cfg.bounds.(name)(1)), cfg.bounds.(name)(2));
  ```
- Line 144: name
  ```
  fields = fieldnames(cfg.bounds);
  ```
- Line 147: name
  ```
  name = fields{k};
  ```
- Line 148: name
  ```
  bnd = cfg.bounds.(name);
  ```
- Line 149: name
  ```
  theta.(name) = bnd(1) + (bnd(2) - bnd(1)) * rand();
  ```
- Line 191: name
  ```
  fields = fieldnames(cfg.bounds);
  ```
- Line 193: name
  ```
  name = fields{k};
  ```
- Line 194: name
  ```
  theta.(name) = min(max(theta.(name), cfg.bounds.(name)(1)), cfg.bounds.(name)(2));
  ```
- Line 213: name
  ```
  names = {'f_bar', 'delta_f', 'xi_H', 'rho_xi'};
  ```
- Line 215: name
  ```
  for k = 1:numel(names)
  ```
- Line 216: name
  ```
  bnd = cfg.bounds.(names{k});
  ```
- Line 217: name
  ```
  theta.(names{k}) = min(max(p(k), bnd(1)), bnd(2));
  ```

**/replication-package/code/matlab/AAR/estimation/model_moments.m**

- Line 216: loc
  ```
  idx_next = local_state_index(type_s, xi_next);
  ```
- Line 225: loc
  ```
  %LOCAL_STATE_INDEX Map (type, ξ) to the 4-element exporter state ordering
  ```
- Line 243: lon
  ```
  % no longer enter the MSM objective for the streamlined configuration.
  ```

**/replication-package/code/matlab/AAR/estimation/run_estimation.m**

- Line 4: lat
  ```
  %  moment vector, and (iii) uses Method of Simulated Moments to estimate
  ```
- Line 18: name
  ```
  this_dir = fileparts(mfilename('fullpath'));
  ```
- Line 81: son
  ```
  % EJTX benchmark objects used in the referee comparison paragraph.
  ```
- Line 84: son
  ```
  fprintf('\nComparison against EJTX benchmark\n');
  ```

**/replication-package/code/matlab/AAR/estimation/solve_model.m**

- Line 103: block, loc
  ```
  % degeneracy that arises when applying a global eigenvector to the block
  ```
- Line 179: lat
  ```
  % Exporter masses (used by diagnostics and life-cycle calculations)
  ```
- Line 378: block, loc
  ```
  %   Permanent productivity types imply that each block evolves independently;
  ```

**/replication-package/code/matlab/audit_report_values.m**

- Line 7: name
  ```
  rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath
  ```
- Line 101: name
  ```
  tmpParent = tempname;
  ```
- Line 141: name
  ```
  if isfolder(pathName)
  ```
- Line 142: name
  ```
  rmdir(pathName, 's');
  ```

**/replication-package/code/matlab/audit_tariff_transition.m**

- Line 6: name
  ```
  rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath
  ```
- Line 10: name
  ```
  rootDir = char(java.io.File(fullfile(fileparts(mfilename('fullpath')), '..', '..')).getCanonicalPath
  ```
- Line 56: name
  ```
  T = table(metrics, values, notes, 'VariableNames', {'metric','value','notes'});
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/Epsilon_CDF_values.m**

- Line 1: lon
  ```
  function [CDF_eps_x,expect_cond_eps_x] =  Epsilon_CDF_values(x,sigma_eps)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/TSS_mutationgaussian.m**

- Line 3: child
  ```
  %   MUTATIONCHILDREN = MUTATIONGAUSSIAN(PARENTS,OPTIONS,GENOMELENGTH,...
  ```
- Line 4: lat
  ```
  %   FITNESSFCN,STATE,THISSCORE,THISPOPULATION,SCALE,SHRINK) Creates the
  ```
- Line 44: lat
  ```
  if(strcmpi(options.PopulationType,'doubleVector'))
  ```
- Line 64: child
  ```
  mutationChildren = zeros(length(parents),GenomeLength);
  ```
- Line 66: lat
  ```
  parent = thisPopulation(parents(i),:);
  ```
- Line 67: child
  ```
  mutationChildren(i,:) = parent  + scale .* randn(1,length(parent));
  ```
- Line 69: lat
  ```
  elseif(strcmpi(options.PopulationType,'bitString'))
  ```
- Line 72: child, lat
  ```
  mutationChildren = mutationuniform(parents ,options, GenomeLength,FitnessFcn,state, thisScore,thisPo
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/calculate_epsilon_star.m**

- Line 10: loc, lon
  ```
  % Preallocate matrix for epsilon* values
  ```
- Line 12: lon
  ```
  epsilon_star_matrix = zeros(rows, cols);
  ```
- Line 14: lon
  ```
  % Define the equation to solve for epsilon*
  ```
- Line 15: lon
  ```
  epsilon_star_equation = @(epsilon, pi_ij) (1 - beta) * (pi_ij * epsilon - F) + ...
  ```
- Line 17: lon
  ```
  (expected_value_epsilon_greater(epsilon, sigma) - epsilon) * ...
  ```
- Line 18: lon
  ```
  (1 - logncdf(epsilon, 0, sigma)) / ...
  ```
- Line 21: lon
  ```
  % Solve for epsilon* for each pi_ij in the matrix
  ```
- Line 26: lon, son
  ```
  epsilon_initial = sigma; % A reasonable starting point
  ```
- Line 27: lon
  ```
  if epsilon_star_equation(1e-6, pi_ij) > 0
  ```
- Line 28: lon
  ```
  epsilon_star_matrix(i, j) = 1e-6;
  ```
- Line 31: lon
  ```
  epsilon_star_matrix(i, j) = fminbnd(@(epsilon) abs(epsilon_star_equation(epsilon, pi_ij)), 1e-6, exp
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/comparison_plots.m**

- Line 4: degree, son
  ```
  %% Degree comparison
  ```
- Line 17: lat
  ```
  %% Relative ratio
  ```
- Line 20: degree, son
  ```
  % Plot the degree comparison and the transition matrix of the buyer. scatter plot with Y-axis for th
  ```
- Line 24: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 27: degree
  ```
  title('sellers per buyer degree distribution'); % Add title
  ```
- Line 31: degree, son
  ```
  % Plot the degree comparison and the transition matrix of the seller. scatter plot with Y-axis for t
  ```
- Line 35: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 38: degree
  ```
  title('buyers per seller degree distribution'); % Add title
  ```
- Line 45: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 54: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 63: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 72: degree
  ```
  plot([0 1], [0 1], 'k--'); % Add a 45 degree line
  ```
- Line 78: lat
  ```
  %% Simulate firm life cycle
  ```
- Line 80: lat
  ```
  %% Compare simulation with data
  ```
- Line 104: lat
  ```
  ylabel('culmulative increase of business connections');
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 60: lat
  ```
  % cumulative probabilities of partner counts
  ```
- Line 96: lat
  ```
  %normalize for continuing relationships
  ```
- Line 113: lat
  ```
  %normalize for continuing relationships
  ```
- Line 121: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 133: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 134: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 235: network
  ```
  %below should divide by number of network connections, not number of firms
  ```
- Line 263: block, loc
  ```
  % consolidate blocks of covariance matrix for current moments
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/define_parameters.m**

- Line 32: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/define_payoffs.m**

- Line 120: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/main_no_gamma.m**

- Line 2: lat
  ```
  %This code solves the model once and experiment w/the calculation of model moments
  ```
- Line 20: name
  ```
  % filename = 'se_results_no_M_target.mat';
  ```
- Line 22: name
  ```
  % filePath = fullfile(workingFolder, subdirectory, filename);
  ```
- Line 25: network
  ```
  % %true parameters, search cost/network buyer/network seller/
  ```
- Line 30: network
  ```
  % x0(3) = x0(1); %set seller network is now seller cost)
  ```
- Line 59: lat
  ```
  % generate initial population around initial parameter vector
  ```
- Line 63: lat
  ```
  disp(['Population size ' num2str(PS)])
  ```
- Line 77: lat
  ```
  % initial population
  ```
- Line 78: lat
  ```
  population = X0;
  ```
- Line 79: lat
  ```
  population(1,:) = theta;
  ```
- Line 101: lat
  ```
  thisPopulation) ...
  ```
- Line 103: lat
  ```
  state,thisScore,thisPopulation,scale,shrink,t,R,GN);
  ```
- Line 106: lat
  ```
  'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
  ```
- Line 111: lat
  ```
  [x,fval_ga,exitflag,output,population] = ...
  ```
- Line 119: name
  ```
  FileName = ['Output/' 'Optimization','_',datestr(now,'yyyy_mmdd_HHMM'),...
  ```
- Line 121: lat, name
  ```
  save(FileName,'x','fval_ga','population')
  ```
- Line 125: minute
  ```
  ' minutes'])
  ```
- Line 128: second
  ```
  ' seconds'])
  ```
- Line 129: lat
  ```
  pop_range_t = [min(population',[],2) max(population',[],2)];
  ```
- Line 132: lat
  ```
  disp(['Average (max minus min) population range as percentage of initial range: ' num2str(pop_range0
  ```
- Line 134: lat
  ```
  disp(['Percentage of initial bounds that are violated by at least one parameter vector in the curren
  ```
- Line 146: loc
  ```
  disp('Starting local search (patternsearch)...');
  ```
- Line 149: loc
  ```
  [x_local,fval_local] = patternsearch(@(X) objective(X,param_indx,param_state,param_fix),...
  ```
- Line 151: loc
  ```
  fprintf('Patternsearch completed. Objective = %.5f\n',fval_local);
  ```
- Line 152: loc
  ```
  if fval_local < best_value
  ```
- Line 153: loc
  ```
  best_value = fval_local;
  ```
- Line 154: loc
  ```
  best_solution = x_local(:);
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/match_death_reg_MP.m**

- Line 31: loc
  ```
  % Preallocate array for the "loss probability"
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/mom_function.m**

- Line 23: lon
  ```
  [thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match,profit_m
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/objective.m**

- Line 18: lon
  ```
  [thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match,profit_m
  ```
- Line 21: son
  ```
  % load data moments (need them here for comparison plots
  ```
- Line 57: network
  ```
  fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 62: city
  ```
  fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
  ```
- Line 71: city
  ```
  fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
  ```
- Line 106: son
  ```
  % comparison_plots(...)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/plot_fit.m**

- Line 39: lat
  ```
  title('Targeted and simulated moments')
  ```
- Line 60: degree
  ```
  title('suppliers per buyer degree distribution')
  ```
- Line 69: degree
  ```
  title('buyers per supplier degree distribution')
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/report_match_shock_stats.m**

- Line 5: lon
  ```
  %   shock exceeds epsilon* (positive phi), and (iii) always accepted.  Also
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_b.m**

- Line 19: lat
  ```
  % simulate the path for each buyer in stationary equilibrium
  ```
- Line 44: birth
  ```
  %birth rate
  ```
- Line 60: lat
  ```
  % cumulate events (add1, add2, drop1, drop2, reset)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_b_no_interdep.m**

- Line 13: lat
  ```
  % simulate the path for each buyer in stationary equilibrium
  ```
- Line 38: birth
  ```
  %birth rate
  ```
- Line 54: lat
  ```
  % cumulate events (add1, add2, drop1, drop2, reset)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/sim_s.m**

- Line 2: lat
  ```
  %% Simulation of number of buyers for each seller type
  ```
- Line 23: lat
  ```
  N_simS = round((1-w2_x)*N_sim*Ns);  % JT: # type-1 seller simulations
  ```
- Line 25: lat
  ```
  N_simS = round(w2_x*N_sim*Ns);      % JT: # type-2 seller simulations
  ```
- Line 46: birth
  ```
  %birth rate
  ```
- Line 72: lat
  ```
  %drop burn-in simulations
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/solve_eps_cutoff.m**

- Line 25: lon
  ```
  [CDF_a, E_a] = Epsilon_CDF_values(a, sigma_eps);
  ```
- Line 26: lon
  ```
  fa = function_epsilon_solve(a, profit_temp, E_a, CDF_a, rho, delta, deltaB, deltaS, lambda, F, sbarg
  ```
- Line 28: lon
  ```
  %[CDF_b, E_b] = Epsilon_CDF_values(b, sigma_eps);
  ```
- Line 29: lon
  ```
  %fb = function_epsilon_solve(b, profit_temp, E_b, CDF_b, rho, delta, deltaB, deltaS, lambda, F, sbar
  ```
- Line 42: lon
  ```
  [CDF_c, E_c] = Epsilon_CDF_values(c, sigma_eps);
  ```
- Line 43: lon
  ```
  fc = function_epsilon_solve(c, profit_temp, E_c, CDF_c, rho, delta, deltaB, deltaS, lambda, F, sbarg
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/solve_model_no_gamma.m**

- Line 1: lon
  ```
  function [thetas,thetab,Ap,U1,U2,V,mMb,msb,u1,u2,Qbx,epsilon_cutoffs_matrix,phi,uncond_surplus_match
  ```
- Line 30: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 76: lat
  ```
  % sales to be used later
  ```
- Line 107: lon
  ```
  % epsilon_cutoffs_matrix = 1/2 * (F./profit_matrix + sqrt(determinant));
  ```
- Line 108: lon
  ```
  % epsilon_cutoffs_matrix(determinant <= 0 | epsilon_cutoffs_matrix <= pareto_scale) = pareto_scale +
  ```
- Line 111: lon
  ```
  expected_value_epsilon_greater = @(epsilon, sigma) exp(sigma^2 / 2) .* ...
  ```
- Line 112: lon
  ```
  normcdf((sigma.^2 - log(epsilon)) ./ sigma) ./ (1 - logncdf(epsilon, 0, sigma));
  ```
- Line 115: lat, lon
  ```
  %epsilon_cutoffs_matrix = calculate_epsilon_star(sigma, sbarg, F, lambda, profit_matrix, rho, delta,
  ```
- Line 116: lon
  ```
  %epsilon_cutoffs_matrix = ones(size(epsilon_cutoffs_matrix)); %shut down cutoff
  ```
- Line 121: lon
  ```
  % scatter(log(profit_matrix(:,1)),epsilon_cutoffs_matrix(:,1),'r')
  ```
- Line 123: lon
  ```
  % scatter(log(profit_matrix(:,2)),epsilon_cutoffs_matrix(:,2),'b')
  ```
- Line 129: lon
  ```
  % saveas(fig,"results/epsilon_scatter.png","png")
  ```
- Line 132: lon
  ```
  % phi_ij = F(epsilon_ij) where F is the Pareto CDF
  ```
- Line 133: lon
  ```
  %phi = logncdf(epsilon_cutoffs_matrix,0,sigma);
  ```
- Line 156: lon
  ```
  %cond_surplus_match =  (profit_matrix .* expected_value_epsilon_greater(epsilon_cutoffs_matrix,sigma
  ```
- Line 187: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 195: lat, lon
  ```
  epsilon_cutoffs_matrix = calculate_epsilon_star(sigma, sbarg, F, lambda, profit_matrix_scaled, rho, 
  ```
- Line 196: lon
  ```
  %[epsilon_cutoffs_matrix] = solve_eps_cutoff(rho, delta, delta_B, delta_S, lambda, F, sigma, sbarg, 
  ```
- Line 198: lon
  ```
  phi = logncdf(epsilon_cutoffs_matrix,0,sigma);
  ```
- Line 200: lon
  ```
  cond_surplus_match =  (profit_matrix_scaled .* expected_value_epsilon_greater(epsilon_cutoffs_matrix
  ```
- Line 209: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 217: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 236: network
  ```
  netB=(s1+s2+1).^gamB; % network effect (denom.) in search cost function
  ```
- Line 265: lat
  ```
  %% calculate seller's search for new matches
  ```
- Line 284: lat
  ```
  %disp('top 50% buyer types cumulative visibility')
  ```
- Line 295: lat
  ```
  % Calculate total mass for each seller type
  ```
- Line 322: lat
  ```
  %average flow profit calculation (for interpretation of fixed costs F)
  ```
- Line 346: lat
  ```
  % Compute cumulative sum of weights, find where it crosses 0.5:
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/std_errors.m**

- Line 5: lat
  ```
  % % 3. Calculate AGS sensitivity matrix
  ```
- Line 38: lat
  ```
  disp('Missing values in the moment vector: std error calculations doomed');
  ```
- Line 75: name
  ```
  % param_names = {'cb0 ','cs0 ','gamB','gamS','w2_x','sbarg'}';
  ```
- Line 76: name
  ```
  param_names = {'cb0','cs0','w2_x','c2','var ln(mu)','Ms/Mb','subs elas','match_scale','F'}';
  ```
- Line 80: name
  ```
  se_table = table(param_names,param_vec,stderr,z_ratio)
  ```
- Line 84: lat
  ```
  %% 3. calculate AGS sensitivity matrix (needs checking)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/MP model/calibration_no_gamma_s/x2param.m**

- Line 9: network
  ```
  %network effects
  ```
- Line 23: lat
  ```
  % Relative number of agents
  ```
- Line 26: city
  ```
  % cross store elasticity of substitution
  ```
- Line 44: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 45: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 51: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 60: lat
  ```
  % cumulative probabilities of partner counts
  ```
- Line 96: lat
  ```
  %normalize for continuing relationships
  ```
- Line 113: lat
  ```
  %normalize for continuing relationships
  ```
- Line 121: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 133: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 134: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 240: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/define_parameters.m**

- Line 32: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/define_payoffs.m**

- Line 112: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/main.m**

- Line 1: lat
  ```
  % This code solves the model once and experiments with the calculation of model moments
  ```
- Line 9: network
  ```
  workingFolder = 'D:\Dropbox\Networks project\matlab code';
  ```
- Line 11: network
  ```
  % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';
  ```
- Line 14: name
  ```
  filename = 'se_results_no_M_target.mat';
  ```
- Line 17: name
  ```
  filePath = fullfile(workingFolder, subdirectory, filename);
  ```
- Line 51: degree, son
  ```
  %% Degree comparison
  ```
- Line 63: lat
  ```
  %% Relative ratio
  ```
- Line 70: lat
  ```
  %% Simulate firm life cycle
  ```
- Line 73: lat
  ```
  %% Compare simulation with data
  ```
- Line 101: lat
  ```
  ylabel('culmulative increase of business connections');
  ```
- Line 105: loc, location
  ```
  legend('data: buyer', 'model: buyer', 'data: seller', 'model: seller type1', 'model: seller type2','
  ```
- Line 107: name
  ```
  % Define the folder and filename
  ```
- Line 109: name
  ```
  filename = fullfile(folder, 'life_cycle.png');
  ```
- Line 112: name
  ```
  saveas(gcf, filename);
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/objective.m**

- Line 41: network
  ```
  fprintf(' Buyer network parameter      = %.5f\n', coefvec(5));
  ```
- Line 42: network
  ```
  fprintf(' Seller network parameter     = %.5f\n', coefvec(6));
  ```
- Line 47: city
  ```
  fprintf(' Cross-store elasticity       = %.5f\n', coefvec(12));
  ```
- Line 53: city
  ```
  fprintf(' Cross-product elasticity     = %.5f\n', param_fix{7});
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/plot_fit.m**

- Line 32: lat
  ```
  title('Targetted and simulated moments')
  ```
- Line 53: degree
  ```
  title('sellers per buyer degree distribution')
  ```
- Line 62: degree
  ```
  title('buyers per seller degree distribution')
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/sim_b.m**

- Line 10: lat
  ```
  % simulate the path for each buyer in stationary equilibrium
  ```
- Line 35: birth
  ```
  %birth rate
  ```
- Line 51: lat
  ```
  % cumulate events (add1, add2, drop1, drop2, reset)
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/sim_s.m**

- Line 2: lat
  ```
  %% Simulation of number of buyers for each seller type
  ```
- Line 17: lat
  ```
  N_simS = round((1-w2_x)*N_sim*Ns);  % JT: # type-1 seller simulations
  ```
- Line 19: lat
  ```
  N_simS = round(w2_x*N_sim*Ns);      % JT: # type-2 seller simulations
  ```
- Line 40: birth
  ```
  %birth rate
  ```
- Line 66: lat
  ```
  %drop burn-in simulations
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/solve_model.m**

- Line 32: city
  ```
  % Cross-store elasticity of substitution
  ```
- Line 49: lat
  ```
  %% Total Surplus and State-specific Calculations
  ```
- Line 160: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 167: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 176: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 202: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/solve_model_old.m**

- Line 33: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 71: lat
  ```
  % JT: will buyer effect be added later?
  ```
- Line 179: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 186: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 196: lat
  ```
  % JT: adjust flow payoffs for price deflator, edied by DX to take out bargaining weights
  ```
- Line 222: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/baseline simulation/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 35: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 36: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 42: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 80: lat
  ```
  %normalize for continuing relationships
  ```
- Line 98: lat
  ```
  %normalize for continuing relationships
  ```
- Line 131: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 143: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 144: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 249: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/define_parameters.m**

- Line 32: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/define_payoffs.m**

- Line 120: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/main.m**

- Line 1: lat
  ```
  % This code solves the model once and experiments with the calculation of model moments
  ```
- Line 9: network
  ```
  workingFolder = 'D:\Dropbox\Networks project\matlab code';
  ```
- Line 11: network
  ```
  % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';
  ```
- Line 14: name
  ```
  filename = 'se_results_no_M_target.mat';
  ```
- Line 17: name
  ```
  filePath = fullfile(workingFolder, subdirectory, filename);
  ```
- Line 61: name
  ```
  % Define the folder and filename
  ```
- Line 73: second
  ```
  % Plot the second line with the right y-axis
  ```
- Line 82: loc, location
  ```
  legend('profit share','avg. number of suppliers','Location','northwest');
  ```
- Line 84: name
  ```
  filename = fullfile(folder, 'buyer_profit_share.png');
  ```
- Line 87: name
  ```
  saveas(gcf, filename);
  ```
- Line 117: second
  ```
  % Plot the second line with the right y-axis
  ```
- Line 126: loc, location
  ```
  legend('search cost as share of buyer profit','Location','southwest');
  ```
- Line 128: name
  ```
  filename = fullfile(folder, 'buyer_search_cost_share.png');
  ```
- Line 131: name
  ```
  saveas(gcf, filename);
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/solve_model.m**

- Line 32: city
  ```
  % Cross-store elasticity of substitution
  ```
- Line 49: lat
  ```
  %% Total Surplus and State-specific Calculations
  ```
- Line 160: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 167: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 176: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 202: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/steady state summary/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 35: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 36: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 42: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table.tex**

- Line 30: lat, second
  ```
  \item [a] *Baseline figures reflect several normalizations. First, measures of active buyers and sup
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/counterfactual_table_2026.tex**

- Line 30: lat, second
  ```
  \item [a] *Baseline figures reflect several normalizations. First, measures of active buyers and sup
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 80: lat
  ```
  %normalize for continuing relationships
  ```
- Line 98: lat
  ```
  %normalize for continuing relationships
  ```
- Line 131: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 143: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 144: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 249: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/define_parameters.m**

- Line 32: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/define_payoffs.m**

- Line 120: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/objective.m**

- Line 27: network
  ```
  fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 28: network
  ```
  fprintf(' seller network parameter     = %.5f\n',coefvec(6));
  ```
- Line 33: city
  ```
  fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
  ```
- Line 39: city
  ```
  fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/plot_fit.m**

- Line 32: lat
  ```
  title('Targetted and simulated moments')
  ```
- Line 53: degree
  ```
  title('sellers per buyer degree distribution')
  ```
- Line 62: degree
  ```
  title('buyers per seller degree distribution')
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_dynamics.m**

- Line 125: lat
  ```
  % expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_model.m**

- Line 30: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 66: lat
  ```
  % sales to be used later
  ```
- Line 166: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 173: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 182: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 208: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/solve_ss.m**

- Line 30: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 167: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 174: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 183: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 209: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/summary_ss.m**

- Line 151: lat
  ```
  %% Generate Latex table
  ```
- Line 153: lat
  ```
  % MATLAB Code: Generate LaTeX Table for Counterfactual Results
  ```
- Line 191: lat
  ```
  % Write LaTeX table header
  ```
- Line 216: lat, second
  ```
  fprintf(fileID, '\\item [a] *Baseline figures reflect several normalizations. First, measures of act
  ```
- Line 223: lat
  ```
  disp('LaTeX table written to counterfactual_table.tex');
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/transition_dynamics.m**

- Line 12: name
  ```
  filename = 'se_results_no_M_target.mat';
  ```
- Line 15: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 17: name
  ```
  filePath = fullfile(matlabRoot, 'baseline_no_NsNb_target', 'results', filename);
  ```
- Line 113: son
  ```
  %% Summarize steady state comparisons
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/transition dynamics/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 35: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 36: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 42: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 80: lat
  ```
  %normalize for continuing relationships
  ```
- Line 98: lat
  ```
  %normalize for continuing relationships
  ```
- Line 131: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 143: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 144: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 249: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/define_parameters.m**

- Line 32: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/define_payoffs.m**

- Line 123: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/main.m**

- Line 9: name
  ```
  filename = 'se_results_no_M_target.mat';
  ```
- Line 11: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 13: name
  ```
  filePath = fullfile(matlabRoot, 'baseline_no_NsNb_target', 'results', filename);
  ```
- Line 16: network
  ```
  %true parameters, search cost/network buyer/network seller/
  ```
- Line 119: lon
  ```
  %disp('trade volume response in long run SS')
  ```
- Line 150: lat
  ```
  %% Generate Latex table
  ```
- Line 152: lat
  ```
  % MATLAB Code: Generate LaTeX Table for Counterfactual Results
  ```
- Line 174: lat
  ```
  % Write LaTeX table header
  ```
- Line 196: lat, second
  ```
  % fprintf(fileID, '\\item [a] *Baseline figures reflect several normalizations. First, measures of a
  ```
- Line 203: lat
  ```
  disp('LaTeX table written to counterfactual_tariff_table.tex');
  ```
- Line 270: lon
  ```
  %% Summarize welfare and profit along transitional path
  ```
- Line 315: lat
  ```
  % ylabel('relative change: treatment vs control')
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/objective.m**

- Line 27: network
  ```
  fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 28: network
  ```
  fprintf(' seller network parameter     = %.5f\n',coefvec(6));
  ```
- Line 33: city
  ```
  fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
  ```
- Line 39: city
  ```
  fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/plot_fit.m**

- Line 32: lat
  ```
  title('Targetted and simulated moments')
  ```
- Line 53: degree
  ```
  title('sellers per buyer degree distribution')
  ```
- Line 62: degree
  ```
  title('buyers per seller degree distribution')
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_model.m**

- Line 30: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 67: lat
  ```
  % sales to be used later
  ```
- Line 168: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 175: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 184: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 210: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_model_tariff.m**

- Line 34: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 73: lat
  ```
  % sales to be used later
  ```
- Line 174: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 181: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 190: lat
  ```
  % JT: adjust flow payoffs for price deflator and bargaining weights
  ```
- Line 216: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/solve_tariff_dynamics.m**

- Line 34: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 131: lat
  ```
  % expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_counterfactuals_July_2024/trump tariff/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 39: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 40: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 46: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/TSS_mutationgaussian.m**

- Line 3: child
  ```
  %   MUTATIONCHILDREN = MUTATIONGAUSSIAN(PARENTS,OPTIONS,GENOMELENGTH,...
  ```
- Line 4: lat
  ```
  %   FITNESSFCN,STATE,THISSCORE,THISPOPULATION,SCALE,SHRINK) Creates the
  ```
- Line 44: lat
  ```
  if(strcmpi(options.PopulationType,'doubleVector'))
  ```
- Line 64: child
  ```
  mutationChildren = zeros(length(parents),GenomeLength);
  ```
- Line 66: lat
  ```
  parent = thisPopulation(parents(i),:);
  ```
- Line 67: child
  ```
  mutationChildren(i,:) = parent  + scale .* randn(1,length(parent));
  ```
- Line 69: lat
  ```
  elseif(strcmpi(options.PopulationType,'bitString'))
  ```
- Line 72: child, lat
  ```
  mutationChildren = mutationuniform(parents ,options, GenomeLength,FitnessFcn,state, thisScore,thisPo
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/data_moments_baseline.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 60: lat
  ```
  % cumulative probabilities of partner counts
  ```
- Line 96: lat
  ```
  %normalize for continuing relationships
  ```
- Line 113: lat
  ```
  %normalize for continuing relationships
  ```
- Line 121: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 133: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 134: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 244: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/define_parameters.m**

- Line 54: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/define_payoffs.m**

- Line 120: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/objective.m**

- Line 22: son
  ```
  %for comparison to mechanical model
  ```
- Line 32: network
  ```
  fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 33: network
  ```
  fprintf(' seller network parameter     = %.5f\n',coefvec(6));
  ```
- Line 38: city
  ```
  fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
  ```
- Line 44: city
  ```
  fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
  ```
- Line 46: son
  ```
  fprintf('\r\n MECH MODEL COMPARISON OBJECTIVE FUNCTION = %.5f\n',out_mech);
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/plot_fit.m**

- Line 36: lat
  ```
  title('Targetted and simulated moments')
  ```
- Line 57: degree
  ```
  title('sellers per buyer degree distribution')
  ```
- Line 66: degree
  ```
  title('buyers per seller degree distribution')
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/sim_moments_baseline.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/solve_model.m**

- Line 33: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 71: lat
  ```
  % JT: will buyer effect be added later?
  ```
- Line 179: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 186: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 195: lat
  ```
  % JT: adjust flow payoffs for price deflator, edied by DX to take out bargaining weights
  ```
- Line 221: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/start_estimation_ga.m**

- Line 44: lat
  ```
  % generate initial population around initial parameter vector
  ```
- Line 48: lat
  ```
  disp(['Population size ' num2str(PS)])
  ```
- Line 61: lat
  ```
  % initial population
  ```
- Line 62: lat
  ```
  population = X0;
  ```
- Line 63: lat
  ```
  population(1,:) = theta;
  ```
- Line 79: lat
  ```
  thisPopulation) ...
  ```
- Line 81: lat
  ```
  state,thisScore,thisPopulation,scale,shrink,t,R,GN);
  ```
- Line 84: lat
  ```
  'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
  ```
- Line 89: lat
  ```
  [x,fval_ga,exitflag,output,population] = ...
  ```
- Line 92: name
  ```
  FileName = ['Output/' 'Optimization','_',datestr(now,'yyyy_mmdd_HHMM'),...
  ```
- Line 94: lat, name
  ```
  save(FileName,'x','fval_ga','population')
  ```
- Line 98: minute
  ```
  ' minutes'])
  ```
- Line 101: second
  ```
  ' seconds'])
  ```
- Line 102: lat
  ```
  pop_range_t = [min(population',[],2) max(population',[],2)];
  ```
- Line 105: lat
  ```
  disp(['Average (max minus min) population range as percentage of initial range: ' num2str(pop_range0
  ```
- Line 107: lat
  ```
  disp(['Percentage of initial bounds that are violated by at least one parameter vector in the curren
  ```
- Line 113: name
  ```
  FileName = ['results/' 'all_objects_',datestr(now,'yyyy_mmdd_HHMM')];
  ```
- Line 114: name
  ```
  save(FileName)
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/std_errors.m**

- Line 5: lat
  ```
  % % 3. Calculate AGS sensitivity matrix
  ```
- Line 34: lat
  ```
  disp('Missing values in the moment vector: std error calculations doomed');
  ```
- Line 64: name
  ```
  % param_names = {'cb0 ','cs0 ','gamB','gamS','w2_x','sbarg'}';
  ```
- Line 65: name
  ```
  param_names = {'cb0 and cs0','gamB','gamS','w2_x','Delta','var ln(mu)','Ms/Mb','eta'}';
  ```
- Line 70: name
  ```
  se_table = table(param_names,param_vec,stderr,z_ratio)
  ```
- Line 74: lat
  ```
  %% 3. calculate AGS sensitivity matrix (needs checking)
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/baseline_no_NsNb_target/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 35: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 36: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 42: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/generate_standard_errors_at_saved_parameters.m**

- Line 6: lat
  ```
  % each model's std_errors.m script in an isolated temporary copy of the model
  ```
- Line 10: loc
  ```
  ensureLocalDir(fileparts(logFile));
  ```
- Line 145: name
  ```
  tmpParent = tempname;
  ```
- Line 147: lname, name
  ```
  [~, modelName] = fileparts(srcDir);
  ```
- Line 148: lname, name
  ```
  tmpDir = fullfile(tmpParent, modelName);
  ```
- Line 159: lat
  ```
  pattern = [regexptranslate('escape', label) '\s*=\s*([-+0-9.eE]+)'];
  ```
- Line 169: loc
  ```
  ensureLocalDir(fileparts(dst));
  ```
- Line 175: name
  ```
  T = cell2table(rows, 'VariableNames', {'model', 'parameter_index', ...
  ```
- Line 187: name
  ```
  if ~isfolder(pathName)
  ```
- Line 188: name
  ```
  mkdir(pathName);
  ```
- Line 193: name
  ```
  if isfolder(pathName)
  ```
- Line 194: name
  ```
  removePathTree(pathName);
  ```
- Line 195: name
  ```
  rmdir(pathName, 's');
  ```
- Line 201: name
  ```
  canonicalRoot = char(java.io.File(pathName).getCanonicalPath());
  ```

**/replication-package/code/matlab/generate_table_figure_source_map.m**

- Line 13: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 24: name
  ```
  tmpDir = tempname;
  ```
- Line 60: lat
  ```
  'Figure 7', 'Figure', 'Model structure', 'Manuscript schematic only; no output file generated by MAT
  ```
- Line 63: lat
  ```
  'Figure 10', 'Figure', 'Buyers and Suppliers Accumulation of Connections', 'output/figures/paper/fig
  ```
- Line 67: census
  ```
  'Table 1', 'Table', 'Year-to-year transition rates: buyers per supplier', 'output/tables/paper/table
  ```
- Line 68: census
  ```
  'Table 2', 'Table', 'Year-to-year transition rates: suppliers per buyer', 'output/tables/paper/table
  ```
- Line 69: census
  ```
  'Table 3', 'Table', 'Firm distributions by partner counts, 2011', 'output/tables/paper/table_03_firm
  ```
- Line 78: son
  ```
  'Table 12', 'Table', 'MSM results (EJTX moments vs. our AAR model)', 'output/tables/paper/table_12_a
  ```
- Line 106: lat
  ```
  % LibreOffice can make tiny platform-dependent width/height changes.
  ```
- Line 109: name
  ```
  layoutDir = tempname;
  ```
- Line 112: zip
  ```
  unzip(xlsxFile, layoutDir);
  ```
- Line 142: zip
  ```
  cmd = sprintf('cd %s && zip -qr %s .', shell_quote(layoutDir), shell_quote(xlsxFile));
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/TSS_mutationgaussian.m**

- Line 3: child
  ```
  %   MUTATIONCHILDREN = MUTATIONGAUSSIAN(PARENTS,OPTIONS,GENOMELENGTH,...
  ```
- Line 4: lat
  ```
  %   FITNESSFCN,STATE,THISSCORE,THISPOPULATION,SCALE,SHRINK) Creates the
  ```
- Line 44: lat
  ```
  if(strcmpi(options.PopulationType,'doubleVector'))
  ```
- Line 64: child
  ```
  mutationChildren = zeros(length(parents),GenomeLength);
  ```
- Line 66: lat
  ```
  parent = thisPopulation(parents(i),:);
  ```
- Line 67: child
  ```
  mutationChildren(i,:) = parent  + scale .* randn(1,length(parent));
  ```
- Line 69: lat
  ```
  elseif(strcmpi(options.PopulationType,'bitString'))
  ```
- Line 72: child, lat
  ```
  mutationChildren = mutationuniform(parents ,options, GenomeLength,FitnessFcn,state, thisScore,thisPo
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/data_moments_hetero.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 60: lat
  ```
  % cumulative probabilities of partner counts
  ```
- Line 96: lat
  ```
  %normalize for continuing relationships
  ```
- Line 113: lat
  ```
  %normalize for continuing relationships
  ```
- Line 121: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 133: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 134: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 235: network
  ```
  %below should divide by number of network connections, not number of firms
  ```
- Line 263: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/define_parameters.m**

- Line 54: lat
  ```
  %% Parameters for simulation size and burin-in
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/define_payoffs.m**

- Line 120: lat
  ```
  %% Calculate the total cost reimbursement
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/eval_s.m**

- Line 4: lat
  ```
  %calculate the expected value of a new relationship
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/objective.m**

- Line 30: network
  ```
  fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 31: network
  ```
  fprintf(' seller network parameter     = %.5f\n',coefvec(6));
  ```
- Line 36: city
  ```
  fprintf(' cross-store elasticity       = %.5f\n',coefvec(12));
  ```
- Line 44: city
  ```
  fprintf(' cross-product elasticity     = %.5f\n',param_fix{7});
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/plot_fit.m**

- Line 34: lat
  ```
  title('Targetted and simulated moments')
  ```
- Line 55: degree
  ```
  title('sellers per buyer degree distribution')
  ```
- Line 64: degree
  ```
  title('buyers per seller degree distribution')
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/search_newbuyer.m**

- Line 21: network
  ```
  netS=(nbuy+1).^gamS; % JT: network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/sim_moments_hetero.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 212: lat
  ```
  % %% Simulate firm life cycle
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/solve_model.m**

- Line 42: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 80: lat
  ```
  % JT: will buyer effect be added later?
  ```
- Line 188: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 195: lat
  ```
  %% Start the loop for calculating buyer value function
  ```
- Line 204: lat
  ```
  % JT: adjust flow payoffs for price deflator, edied by DX to take out bargaining weights
  ```
- Line 230: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/start_estimation_ga.m**

- Line 50: lat
  ```
  % generate initial population around initial parameter vector%cost_exp = 2;
  ```
- Line 55: lat
  ```
  disp(['Population size ' num2str(PS)])
  ```
- Line 70: lat
  ```
  % initial population
  ```
- Line 71: lat
  ```
  population = X0;
  ```
- Line 72: lat
  ```
  population(1,:) = theta;
  ```
- Line 88: lat
  ```
  thisPopulation) ...
  ```
- Line 90: lat
  ```
  state,thisScore,thisPopulation,scale,shrink,t,R,GN);
  ```
- Line 93: lat
  ```
  'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
  ```
- Line 98: lat
  ```
  [x,fval_ga,exitflag,output,population] = ...
  ```
- Line 101: name
  ```
  FileName = ['Output/' 'Optimization','_',datestr(now,'yyyy_mmdd_HHMM'),...
  ```
- Line 103: lat, name
  ```
  save(FileName,'x','fval_ga','population')
  ```
- Line 107: minute
  ```
  ' minutes'])
  ```
- Line 110: second
  ```
  ' seconds'])
  ```
- Line 111: lat
  ```
  pop_range_t = [min(population',[],2) max(population',[],2)];
  ```
- Line 114: lat
  ```
  disp(['Average (max minus min) population range as percentage of initial range: ' num2str(pop_range0
  ```
- Line 116: lat
  ```
  disp(['Percentage of initial bounds that are violated by at least one parameter vector in the curren
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/std_errors.m**

- Line 5: lat
  ```
  % % 3. Calculate AGS sensitivity matrix
  ```
- Line 35: lat
  ```
  disp('Missing values in the moment vector: std error calculations doomed');
  ```
- Line 65: name
  ```
  % param_names = {'cb0 ','cs0 ','gamB','gamS','w2_x','sbarg'}';
  ```
- Line 66: name
  ```
  param_names = {'cb0 and cs0','gamB','gamS','w2_x','Delta','var ln(mu)','Ms','eta','match_death hazar
  ```
- Line 71: name
  ```
  se_table = table(param_names,param_vec,stderr,z_ratio)
  ```
- Line 75: lat
  ```
  %% 3. calculate AGS sensitivity matrix (needs checking)
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/val_b.m**

- Line 27: network
  ```
  netB=(ns+1).^gamB; % network effect (denom.) in search cost function
  ```

**/replication-package/code/matlab/heterogeneous_death_haz/sellers_only/x2param.m**

- Line 7: network
  ```
  %network effects
  ```
- Line 20: lat
  ```
  % Relative number of agents
  ```
- Line 23: city
  ```
  % cross store elasticity of substitution
  ```
- Line 40: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 41: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 47: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/mechanical_model/data_moments_mechanical.m**

- Line 2: lat
  ```
  % Calculate Moments and Objective Function
  ```
- Line 4: degree
  ```
  %%1. Buyer/Seller Degree Dist.
  ```
- Line 60: lat
  ```
  % cumulative probabilities of partner counts
  ```
- Line 96: lat
  ```
  %normalize for continuing relationships
  ```
- Line 113: lat
  ```
  %normalize for continuing relationships
  ```
- Line 121: census
  ```
  % (Based on 2007 and 2012 Census data for retail apparel sector)
  ```
- Line 133: lat
  ```
  cdf_TS = cumsum(data_TS,2); % cumulative buyers per seller transitions
  ```
- Line 134: lat
  ```
  cdf_TB = cumsum(data_TB,2); % cumulative sellers per buyer transitions
  ```
- Line 239: block, loc
  ```
  % consolidate blocks of covariance matrix
  ```

**/replication-package/code/matlab/mechanical_model/define_lindex.m**

- Line 22: block, loc
  ```
  % (s1+1,s2) is a block diagonal matrix
  ```

**/replication-package/code/matlab/mechanical_model/define_parameters.m**

- Line 7: lat
  ```
  % Ns= 8.48; % relative seller to buyer ratio (used to be 1)
  ```
- Line 18: lon
  ```
  % kap=1/(1+(1-gam)/(1-alp));  % JT: no longer used
  ```
- Line 56: lat
  ```
  % simulation size and burin-in
  ```

**/replication-package/code/matlab/mechanical_model/define_payoffs.m**

- Line 69: lat
  ```
  %% Calculate the total cost reimbursement (added by JT)
  ```

**/replication-package/code/matlab/mechanical_model/load_best_mechanical_estimate.m**

- Line 25: name
  ```
  tok = regexp(opt_files(i).name,'Run(\d+)of(\d+)\.mat$','tokens','once');
  ```
- Line 30: name
  ```
  c = regexp(opt_files(i).name,'(Optimization_[0-9_]+)_Run\d+of\d+\.mat$','tokens','once');
  ```
- Line 40: lat
  ```
  [~,ix_latest] = max([opt_files(cand_idx).datenum]);
  ```
- Line 41: lat
  ```
  campaign_use = campaign(cand_idx(ix_latest));
  ```
- Line 46: name
  ```
  S = load(fullfile(opt_files(use_idx(i)).folder,opt_files(use_idx(i)).name));
  ```
- Line 50: name
  ```
  best_file = opt_files(use_idx(i)).name;
  ```

**/replication-package/code/matlab/mechanical_model/mechanical_counterfactual_main.m**

- Line 4: son
  ```
  % computes the policy-shock-only comparison table used in the appendix.
  ```
- Line 58: lat
  ```
  xT(7) = si_in(34); %number of sellers relative to buyers
  ```
- Line 92: lat
  ```
  % 2) Apply those same relative scale factors to the mechanical model's own
  ```
- Line 155: son
  ```
  %% Summarize steady state comparisons
  ```

**/replication-package/code/matlab/mechanical_model/objective_mechanical.m**

- Line 10: lat
  ```
  x(7) = si_in(34); %number of sellers relative to buyers
  ```
- Line 21: lat
  ```
  % Generate simulated moments for experiments (not needed for estimation)
  ```
- Line 23: lat
  ```
  % simulate profits and transfers (not needed for estimation)n
  ```
- Line 35: lat
  ```
  %% welfare calculation
  ```
- Line 49: network
  ```
  %    fprintf(' buyer network parameter      = %.5f\n',coefvec(5));
  ```
- Line 50: network
  ```
  %    fprintf(' seller network parameter     = %.5f\n',coefvec(6));
  ```
- Line 67: lat
  ```
  fprintf(' Relative number of sellers        = %.5f\n',x(7));
  ```

**/replication-package/code/matlab/mechanical_model/sim_moments_mechanical.m**

- Line 45: city
  ```
  % cross-store elasticity of substitution
  ```
- Line 51: degree
  ```
  %% 1. Degree distributions
  ```
- Line 77: lat
  ```
  %%%calculate transition based on number of sellers
  ```
- Line 87: lat
  ```
  %calculate sum of unconditional prob
  ```
- Line 100: lat
  ```
  %calculate sum of unconditional prob
  ```

**/replication-package/code/matlab/mechanical_model/solve_model_mechanical.m**

- Line 49: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 56: lat
  ```
  %% Start the loop for calculating transition probabilities
  ```
- Line 71: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/mechanical_model/solve_model_mechanical_cf.m**

- Line 64: lat
  ```
  else % JT: use relative search intensities of 2 buyer types if iter > 1
  ```
- Line 71: lat
  ```
  %% Start the loop for calculating transition probabilities
  ```
- Line 86: lat
  ```
  %% calculate seller's search for new matches
  ```

**/replication-package/code/matlab/mechanical_model/start_mechanical.m**

- Line 54: lat
  ```
  x(7) = si_in(34); %number of sellers relative to buyers
  ```
- Line 61: degree
  ```
  [Degree_dist_table,Transmat_table,NS_NB_table] =...
  ```
- Line 66: lat
  ```
  %This first part is all to get the initial population paramter vectors
  ```
- Line 67: lat
  ```
  theta = [si.buyer;si.seller;x(4);x(7)]; %last two are fraction of high skill w2_x and relative numbe
  ```
- Line 70: lat
  ```
  disp(['Population size ' num2str(PS)])
  ```
- Line 75: lat
  ```
  bounds(end,:) = [0.01,100]; %bounds for relative number of sellers to buyers
  ```
- Line 87: lat
  ```
  population = X0;
  ```
- Line 110: lat
  ```
  %    thisPopulation) ...
  ```
- Line 112: lat
  ```
  %    state,thisScore,thisPopulation,scale,shrink,t,R,GN);
  ```
- Line 114: lat
  ```
  %violate bounds constraints (see here:
  ```
- Line 119: lat
  ```
  'Generations',GN,'PopulationSize',PS,'InitialPopulation',population,'Display','iter',...
  ```
- Line 125: lat
  ```
  [si_in,fval_ga,exitflag,output,population,SCORES]= ga(@(si_in) objective_mechanical(si_in,x,param_in
  ```
- Line 127: name, network
  ```
  %    FileName = ['D:\Dropbox\Networks project\matlab code\model calibration Dec 2019\Estimation\Rest
  ```
- Line 128: name
  ```
  FileName = fullfile('results', ...
  ```
- Line 131: lat, name
  ```
  save(FileName,'si_in','fval_ga','population')
  ```
- Line 136: minute
  ```
  ' minutes'])
  ```
- Line 139: second
  ```
  ' seconds'])
  ```
- Line 140: lat
  ```
  pop_range_t = [min(population',[],2) max(population',[],2)];
  ```
- Line 143: lat
  ```
  disp(['Average (max minus min) population range as percentage of initial range: ' num2str(pop_range0
  ```
- Line 145: lat
  ```
  disp(['Percentage of initial bounds that are violated by at least one parameter vector in the curren
  ```
- Line 158: degree
  ```
  [Degree_dist_table,Transmat_table,NS_NB_table] =...
  ```
- Line 161: name
  ```
  FileName2 = fullfile('results', ...
  ```
- Line 163: name
  ```
  save(FileName2,'si','param_vec','x')
  ```
- Line 220: degree
  ```
  scatter([Degree_dist_table.data_moms1],[Degree_dist_table.sim_moms1],'b')
  ```
- Line 229: degree
  ```
  scatter([Degree_dist_table.data_moms2],[Degree_dist_table.sim_moms2],'b')
  ```

**/replication-package/code/matlab/mechanical_model/summary_mechanical_policy_shock.m**

- Line 4: lat, lon
  ```
  % Writes a standalone LaTeX table with policy-shock-only percent changes.
  ```
- Line 93: lat
  ```
  %% === Read and Parse the Source LaTeX File ===
  ```
- Line 166: son
  ```
  %% === Define the Labels for the Policy Shock Comparison ===
  ```
- Line 174: second
  ```
  %% === Compute the "Actual" Percentage Change (Second Experiment Only) ===
  ```
- Line 192: second
  ```
  % Final value after second experiment:
  ```
- Line 195: lat, second
  ```
  % Percentage effect of second experiment, relative to the new baseline:
  ```
- Line 214: lat
  ```
  %% === Generate LaTeX Table Comparing Actual vs. Mechanical Policy Shocks ===
  ```
- Line 236: lat
  ```
  disp(['LaTeX table written to ', outputFile]);
  ```

**/replication-package/code/matlab/mechanical_model/tables_mechanical.m**

- Line 2: degree
  ```
  function [Degree_dist_table,Transmat_table,NS_NB_table ] = ...
  ```
- Line 34: network
  ```
  fprintf(' buyer network parameter      = %.4f\n',coefvec(5));
  ```
- Line 35: network
  ```
  fprintf(' seller network parameter     = %.4f\n',coefvec(6));
  ```
- Line 46: name
  ```
  param_names3 = [];
  ```
- Line 47: name
  ```
  param_names4 = [];
  ```
- Line 65: name
  ```
  param_names3 = [param_names3,strcat('TransTB_',string(i),'_',string(j))];
  ```
- Line 66: name
  ```
  param_names4 = [param_names4,strcat('TransTS_',string(i),'_',string(j))];
  ```
- Line 69: name
  ```
  param_names3 = param_names3';
  ```
- Line 70: name
  ```
  param_names4 =  param_names4';
  ```
- Line 72: name
  ```
  param_names1 = {'cdf_SPB1 ','cdf_SPB2 ','cdf_SPB3 ','cdf_SPB4 ','cdf_SPB5 ','cdf_SPB10 ','cdf_SPB15 
  ```
- Line 73: name
  ```
  param_names2 = {'cdf_BPS1 ','cdf_BPS2 ','cdf_BPS3 ','cdf_BPS4 ','cdf_BPS5 ','cdf_BPS10 ','cdf_BPS15 
  ```
- Line 74: name
  ```
  param_names5 = {'concen1 ','concen2 ','concen3 ','concen4 '}';
  ```
- Line 75: name
  ```
  param_names6 = {'active sellers per buyer '};
  ```
- Line 80: name
  ```
  NN2 = length(param_names3);
  ```
- Line 97: name
  ```
  SPB_table     = table(param_names1,data_moms1,sim_moms1);
  ```
- Line 98: name
  ```
  BPS_table     = table(param_names2,data_moms2,sim_moms2);
  ```
- Line 99: name
  ```
  TransTB_table = table(param_names3,data_moms3,sim_moms3);
  ```
- Line 100: name
  ```
  TransTS_table = table(param_names4,data_moms4,sim_moms4);
  ```
- Line 101: name
  ```
  % Concen_table  = table(param_names5,data_moms5,sim_moms5);
  ```
- Line 102: name
  ```
  NS_NB_table   = table(param_names6,data_active_SPB ,sim_active_SPB );
  ```
- Line 106: lat
  ```
  % fprintf('\r\n  COMPARE DATA-BASED AND SIMULATED MOMENTS ');
  ```
- Line 107: degree
  ```
  Degree_dist_table   = [SPB_table,BPS_table];
  ```

**/replication-package/code/matlab/mechanical_model/x2param.m**

- Line 6: network
  ```
  %network effects
  ```
- Line 18: lat
  ```
  % Relative number of agents
  ```
- Line 21: city
  ```
  % cross store elasticity of substitution
  ```
- Line 33: network
  ```
  param{5} = gamB;     % JT: buyer network effect
  ```
- Line 34: network
  ```
  param{6} = gamS;     % JT: seller network effect
  ```
- Line 40: city
  ```
  param{12} = gam;    % cross store elasticity of substitution
  ```

**/replication-package/code/matlab/run_all_replication.m**

- Line 7: lon
  ```
  %   run_all_replication('full')   % attempt long estimation workflows
  ```
- Line 19: name
  ```
  scriptDir = fileparts(mfilename('fullpath'));
  ```
- Line 47: lon
  ```
  write_standalone_model_tables(rootDir, outputDir);
  ```
- Line 63: census
  ```
  censusFigSrc = fullfile(rootDir, 'data', 'Census_LFTTD--disclosed_statistics_and_graphs', ...
  ```
- Line 65: census
  ```
  copyRequired(fullfile(censusFigSrc, 'NoSeller_1996_2011.eps'), ...
  ```
- Line 67: census, country
  ```
  copyRequired(fullfile(censusFigSrc, 'NoSeller_by_country_1996_2011.eps'), ...
  ```
- Line 68: country
  ```
  fullfile(figOut, 'figure_03_suppliers_by_country.eps'));
  ```
- Line 69: census, lat
  ```
  copyRequired(fullfile(censusFigSrc, 'NoBuyer_by_related_1996_2011.eps'), ...
  ```
- Line 70: lat
  ```
  fullfile(figOut, 'figure_06_buyers_related_arm_length.eps'));
  ```
- Line 73: census
  ```
  stats = fullfile(rootDir, 'data', 'Census_LFTTD--disclosed_statistics_and_graphs', 'CES_disclosed_fi
  ```
- Line 183: son
  ```
  fprintf('Generating AAR appendix/comparison outputs...\n');
  ```
- Line 185: son
  ```
  if isfile(fullfile(aarDir, 'comparison', 'scripts', 'generate_comparison_outputs.m'))
  ```
- Line 188: son
  ```
  cd(fullfile(aarDir, 'comparison', 'scripts'));
  ```
- Line 189: son
  ```
  generate_comparison_outputs;
  ```
- Line 191: son
  ```
  fprintf('AAR comparison rebuild failed: %s\n', err.message);
  ```
- Line 196: son
  ```
  copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'parameter_estimates.csv'), ...
  ```
- Line 198: son
  ```
  copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'moment_comparison.csv'), ...
  ```
- Line 199: son
  ```
  fullfile(tabOut, 'table_12_aar_moment_comparison.csv'));
  ```
- Line 200: son
  ```
  copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'policy_shock_benchmark_comparison.csv'), ...
  ```
- Line 201: son
  ```
  fullfile(tabOut, 'table_13_aar_policy_shock_benchmark_comparison.csv'));
  ```
- Line 202: son
  ```
  copyIfExists(fullfile(aarDir, 'comparison', 'tables', 'policy_shock_comparison.csv'), ...
  ```
- Line 203: son
  ```
  fullfile(tabOut, 'table_13_aar_policy_shock_comparison.csv'));
  ```
- Line 214: lon
  ```
  fprintf('Writing standalone model parameter/moment tables...\n');
  ```
- Line 237: name
  ```
  'VariableNames', {'row', 'paper_reported_estimate', 'paper_reported_std_error', ...
  ```
- Line 265: name
  ```
  'VariableNames', {'row', 'baseline_paper_reported', 'baseline_generated', ...
  ```
- Line 269: son
  ```
  writeTableCsv(T10, fullfile(tabOut, 'table_10_heterogeneous_death_hazard_comparison.csv'));
  ```
- Line 275: name
  ```
  'VariableNames', {'row', 'data', 'model_based_estimate'});
  ```
- Line 291: city
  ```
  'Within-store elasticity', NaN, NaN, match.param_vec(7), match.stderr(7), nodisp.param_vec(7), nodis
  ```
- Line 292: city
  ```
  'Cross-store elasticity', base.param_vec(8), base.stderr(8), NaN, NaN, NaN, NaN, 'MP cross-store ela
  ```
- Line 299: name
  ```
  T9 = cell2table(rows, 'VariableNames', {'row', 'baseline_estimate', ...
  ```
- Line 305: lat
  ```
  latexRows = {
  ```
- Line 314: city
  ```
  'Within-store elasticity', NaN, NaN, 1.8771, 0.0034, 1.8687, 0.0035;
  ```
- Line 315: city
  ```
  'Cross-store elasticity', 2.432, 0.141, NaN, NaN, NaN, NaN;
  ```
- Line 322: lat, name
  ```
  L9 = cell2table(latexRows, 'VariableNames', {'row', 'baseline_latex', ...
  ```
- Line 323: lat
  ```
  'baseline_latex_std_error', 'match_shock_latex', ...
  ```
- Line 324: lat
  ```
  'match_shock_latex_std_error', 'no_dispersion_latex', ...
  ```
- Line 325: lat
  ```
  'no_dispersion_latex_std_error'});
  ```
- Line 326: lat, son
  ```
  writeTableCsv(L9, fullfile(tabOut, 'table_09_mp_model_latex_comparison.csv'));
  ```
- Line 390: name
  ```
  stepName = steps{i, 1};
  ```
- Line 393: name
  ```
  fprintf('  Test checking %s...\n', stepName);
  ```
- Line 394: name
  ```
  fprintf(fid, '===== %s =====\n', stepName);
  ```
- Line 397: name
  ```
  fprintf(fid, '%s\nPASS: %s\n\n', txt, stepName);
  ```
- Line 398: name
  ```
  fprintf('  PASS: %s\n', stepName);
  ```
- Line 400: name
  ```
  fprintf(fid, 'FAIL: %s\n%s\n\n', stepName, getReport(err, 'extended', 'hyperlinks', 'off'));
  ```
- Line 401: name
  ```
  fprintf('  FAIL: %s -- %s\n', stepName, err.message);
  ```
- Line 402: name
  ```
  failed{end+1} = stepName; %#ok<AGROW>
  ```
- Line 565: loc, location
  ```
  legend('profit share', 'avg. number of suppliers', 'Location', 'northwest');
  ```
- Line 582: loc, location
  ```
  legend('search cost as share of buyer profit', 'Location', 'southwest');
  ```
- Line 712: name
  ```
  tmpParent = tempname;
  ```
- Line 733: lon
  ```
  [thetas, thetab, Ap, U1, U2, V, mMb, msb, u1, u2, Qbx, epsilon_cutoffs_matrix, ...
  ```
- Line 764: name
  ```
  cmd = sprintf('matlab -batch "cd(''%s''); %s"', escapeQuotes(scriptDir), scriptName);
  ```
- Line 767: name
  ```
  error('MATLAB generator failed with status %d: %s', status, scriptName);
  ```
- Line 773: lat
  ```
  relDoFile = relativePath(rootDir, doFile);
  ```
- Line 809: name
  ```
  fileName = char(java.io.File(fileName).getCanonicalPath());
  ```
- Line 811: name
  ```
  if startsWith(fileName, prefix)
  ```
- Line 812: name
  ```
  rel = fileName(numel(prefix)+1:end);
  ```
- Line 814: name
  ```
  rel = fileName;
  ```
- Line 834: name
  ```
  T = readtable(src, 'Sheet', 'Previous Version', 'ReadVariableNames', false);
  ```
- Line 846: loc, location
  ```
  legend('Domestic consumption', 'Imports', 'Location', 'northwest');
  ```
- Line 869: loc, location
  ```
  legend(countries, 'Location', 'eastoutside', 'Interpreter', 'none');
  ```
- Line 872: country
  ```
  saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_04_import_value_by_country.eps'), 'epsc'
  ```
- Line 883: lat
  ```
  srcDir = fullfile(rootDir, 'code', 'matlab', 'baseline_counterfactuals_July_2024', 'baseline simulat
  ```
- Line 919: lat
  ```
  ylabel('cumulative increase of business connections');
  ```
- Line 921: loc, location
  ```
  'model: seller type1', 'model: seller type2', 'Location', 'northwest');
  ```
- Line 926: lat
  ```
  saveas(fig, fullfile(outputDir, 'figures', 'paper', 'figure_10_buyers_suppliers_connection_accumulat
  ```
- Line 1050: name
  ```
  if isfolder(pathName)
  ```
- Line 1051: name
  ```
  rmdir(pathName, 's');
  ```
- Line 1066: name
  ```
  copyfile(fullfile(files(i).folder, files(i).name), fullfile(dstDir, files(i).name));
  ```
- Line 1085: name
  ```
  if ~isfile(fileName)
  ```
- Line 1086: name
  ```
  error('Required replication source file is missing: %s', fileName);
  ```
- Line 1091: name
  ```
  if ~isfolder(pathName)
  ```
- Line 1092: name
  ```
  mkdir(pathName);
  ```

**/replication-package/docs/EJTX_2026_replication.tex**

- Line 1: gps
  ```
  \documentclass[12pt]{article} \usepackage{amsmath,amssymb,amsthm,geometry,graphicx,setspace,algorith
  ```
- Line 14: lon
  ```
  \usepackage{longtable} % table spanning multiple page
  ```
- Line 16: name
  ```
  \usepackage[usenames, dvipsnames]{color} % tex to a given permanent productivity shock. Since both t
  ```
- Line 34: url
  ```
  \usepackage{url}
  ```
- Line 52: url
  ```
  ,urlcolor=black
  ```
- Line 64: census
  ```
  This research was performed at a Federal Statistical Research Data Center under FSRDC Project number
  ```
- Line 65: name
  ```
  %EndAName
  ```
- Line 66: school
  ```
  $^{a}$Penn State, $^{b}$NBER, $^{c}$Copenhagen Business School, $^{d}$%
  ```
- Line 77: name
  ```
  %EndAName
  ```
- Line 93: lat, network
  ```
  International trade is built on relationships. To access foreign markets, firms must form partnershi
  ```
- Line 96: lat
  ```
  domestic consumers. Heterogeneous suppliers and buyers search for each other, taking stock of their 
  ```
- Line 101: lat, second, son
  ```
  In a second experiment, we simulate a decrease in search costs on both sides of the wholesale market
  ```
- Line 103: lat, loc, location, lon
  ```
  Finally, in our third experiment, we simulate the short-run impact and longer-term effects of Trump'
  ```
- Line 105: lat, network
  ```
  Beyond serving as a quantitative laboratory, our structural framework recovers key latent objects th
  ```
- Line 109: lat
  ```
  \subsection{Relation to the literature}
  ```
- Line 110: lat
  ```
  Our paper relates to a wide variety of earlier contributions. First, it connects to papers on firm-l
  ```
- Line 113: lat
  ```
  Because our model predicts firms' dynamic matching patterns, it also connects to the literature that
  ```
- Line 116: network
  ```
  A third relevant literature focuses on transnational firm-to-firm trading patterns and the question 
  ```
- Line 118: lat, lon
  ```
  Finally, since our firms deal in clothing, our paper relates to a substantial literature on global a
  ```
- Line 124: second
  ```
  categories of consumer goods, so we can approximate their payoffs with a simple functional form. Sec
  ```
- Line 125: lat
  ```
  Accordingly, we choose an industry in which domestic suppliers play a relatively minor role. Finally
  ```
- Line 126: network
  ```
  merchandise having emerged abroad and with the phaseout of quantitative restrictions on imports. The
  ```
- Line 128: network
  ```
  Before describing the details of our model, we review some aggregate patterns in U.S. apparel trade 
  ```
- Line 133: network
  ```
  } Other dynamic network features have received less attention, particularly those concerning match c
  ```
- Line 137: census, lon
  ```
  Our quantitative analysis is based largely on the customs records contained in the U.S. Census Burea
  ```
- Line 141: address, name
  ```
  when we began our paper.\medskip} Among other variables, each record includes a ten-digit Harmonized
  ```
- Line 144: address, lat, name
  ```
  The name and address of a given exporter may be recorded differently for different shipments, and th
  ```
- Line 175: country
  ```
  \captionof{figure}{Number of suppliers by country, 1996-2011$^{b}$}
  ```
- Line 176: country
  ```
  \label{fig:NoSeller_by_country_1996_2011}
  ```
- Line 180: country
  ```
  \captionof{figure}{Value of imports by country, 1996-2011$^{c}$}
  ```
- Line 181: country
  ```
  \label{fig:value_imp_by_missing_alpha_country_1996_2011}
  ```
- Line 195: country, lat
  ```
  exporting to the United States has steadily grown. Figure \ref{fig:Noseller_1996_2011} shows the num
  ```
- Line 206: lat
  ```
  wholesalers (including branded importers), and general merchandise retailers.\footnote{\citet{plunke
  ```
- Line 224: lat
  ```
  Gulati Group also does some clothing manufacturing, and Hanes owns some manufacturing facilities. Al
  ```
- Line 227: census
  ```
  brick-and-mortar stores.\footnote{Census classifies \emph{establishments} according to their main ac
  ```
- Line 234: house, son
  ```
  between firms with in-house sourcing departments and firms that use sourcing firms. Accordingly, we 
  ```
- Line 238: lat
  ```
  {fig:NoBuyer_by_related_1996_2011}) reflects this lack of vertical integration. Moreover, arm's-leng
  ```
- Line 243: lat
  ```
  \caption{Number of buyers, related party versus arm's length trade$^a$}
  ```
- Line 244: lat
  ```
  \label{fig:NoBuyer_by_related_1996_2011}
  ```
- Line 252: second
  ```
  Second, it doesn't appear that apparel importers rely heavily on sourcing firms to match with foreig
  ```
- Line 259: loc
  ```
  which includes many representatives of apparel manufacturers located in
  ```
- Line 289: network
  ```
  \subsubsection{Network dynamics}
  ```
- Line 290: network
  ```
  \label{subsec:network_dynamics}
  ```
- Line 295: lon
  ```
  In some cases retailers procure new production runs via long-standing
  ```
- Line 296: lat, lon
  ```
  relationships with manufacturers \citep{CahalMacchiavelloNogueras2020}, but most buyer-supplier part
  ```
- Line 300: lon, son
  ```
  We estimate this hazard by regressing the log of the fraction of matches surviving $t$ years on $t$.
  ```
- Line 302: lat
  ```
  % A large amount of this relationship turnover is associated with product
  ```
- Line 389: degree
  ```
  \subsubsection{Degree distributions}
  ```
- Line 422: lat
  ```
  Table \ref{tab:within buyer shares} reports average log imports per supplier among buyers with a sin
  ```
- Line 471: network
  ```
  maintaining a network of business connections is high, regardless of whether a firm uses its own sou
  ```
- Line 486: child
  ```
  fall short in terms of shop floor safety, child labor standards, and
  ```
- Line 488: social
  ```
  In a 2016 survey of U.S. apparel importers, \quotes{33 percent rated `unmet social
  ```
- Line 496: phone
  ```
  This observation is based on a telephone interview with the president of the
  ```
- Line 509: lat
  ```
  fluid creation and destruction of business relationships between heterogeneous importers and exporte
  ```
- Line 512: network
  ```
  \section{A model of buyer-supplier networks}
  ```
- Line 524: lat, second
  ```
  The representative consumer cannot save, and goods are non-durable, so she simply maximizes her flow
  ```
- Line 559: city, son
  ```
  When buyer $y$ and supplier $x$ collaborate to offer a product in the retail market, they jointly in
  ```
- Line 575: lon
  ```
  The same result, along with some intuition, can be found in
  ```
- Line 619: lat
  ```
  where $n^{B}(\mathbf{s}) =\sum_{j=1}^{J}s_{j}$ and $n^{S}(\mathbf{b}) =\sum_{i=1}^{I}b_{i}.$ This fu
  ```
- Line 622: lat, second, son
  ```
  Once formed, relationships eventually terminate for one of two exogenous reasons.\footnote{In Append
  ```
- Line 633: lon
  ```
  \mathbf{\upsilon}_{j}^{S}\left[V_{i}^{B}(\mathbf{s}+\mathbf{1}_{j})-V_{i}^{B}(%
  ```
- Line 640: lon
  ```
  where $\mathbf{1}_{j}$ is a $J \times 1$ vector with $j^{th}$ element $1$ and $0$'s elsewhere, $\mat
  ```
- Line 648: lat, lon
  ```
  The logic of  equation (\ref{HJB_buyer}) is straightforward. The buyer reaps its flow payoff, net of
  ```
- Line 657: lon
  ```
  V_{j}^{S}=\sum_{i}\sum_{\mathbf{s}\in \mathbb{S}}\upsilon _{i}^{B}(\mathbf{s})V_{ji}^{S}(\mathbf{s})
  ```
- Line 662: lon
  ```
  (\rho + \delta +  \delta^B + \delta^S) V_{ji}^{S}(\mathbf{s}) &=&\tau _{ji}(\mathbf{s})+\sigma _{i}^
  ```
- Line 668: lat
  ```
  Intuitively, a business relationship with a type-$i$ buyer who has $%
  ```
- Line 669: lat, lon
  ```
  \mathbf{s}$ suppliers will terminate with exogenous hazard $(\delta + \delta^B + \delta^S)$, become 
  ```
- Line 670: lat
  ```
  % Given our random search assumption, the \textit{ex ante} expected value of a new business relation
  ```
- Line 672: lon
  ```
  % V_{j}^{S}=\sum_{i}\sum_{\mathbf{s}\in \mathbb{S}}\upsilon _{i}^{B}(\mathbf{s})V_{ji}^{S}(\mathbf{s
  ```
- Line 688: son
  ```
  Although our model characterizes a many-to-many matching equilibrium, the bargaining game that deter
  ```
- Line 695: lon
  ```
  \textbf{No commitment:} Buyers and their suppliers cannot commit to long-term transfer schedules. Th
  ```
- Line 698: lat
  ```
  \textbf{Bilateral bargaining:} Buyers use delegates to bargain on their behalf---one for each connec
  ```
- Line 706: lat
  ```
  \textbf{Passive beliefs: }When a delegate or a supplier receives an out-of-equilibrium offer or an u
  ```
- Line 714: lat
  ```
  Together, these assumptions simplify the multilateral dynamic bargaining problem to a Nash-like prob
  ```
- Line 716: lat, social
  ```
  Further details concerning the role of these assumptions appear in Appendix \ref{app:bargaining}. He
  ```
- Line 726: lat
  ```
  Consider buyers first. And, for the moment, take the matching hazard per unit of search $\theta^B$ a
  ```
- Line 731: lon
  ```
  -\mathbf{1}_{j})\theta ^{B}\upsilon_{j}^{S}M_{i}^{B}(\mathbf{s}-\mathbf{1}_{j})+\tilde{\delta} (s_{j
  ```
- Line 735: lon
  ```
  This group gains a member whenever any of the $M_{i}^{B}(\mathbf{s}-\mathbf{1}_{j})$ buyers in state
  ```
- Line 779: lon
  ```
  It remains to develop expressions for the matching hazard per unit search measures, $\theta^B$ and $
  ```
- Line 819: lon
  ```
  \upsilon _{i}^{B}(\mathbf{s})=\frac{H_{i}^{B}(\mathbf{s})}{H^{B}},$
  ```
- Line 820: lon
  ```
  and the share of matches involving suppliers of type $j$ is $\upsilon_{j}^{S} = \frac{\sum_{n^S} H_{
  ```
- Line 841: city
  ```
  We set $\alpha=4.35$ to match the elasticity of substitution across apparel varieties estimated by \
  ```
- Line 845: lat, son
  ```
  To estimate the remaining parameters we proceed in two stages. First, since it is possible to identi
  ```
- Line 855: lat, second
  ```
  {tab:buyers_per_seller_transitions} and \ref{tab:sellers_per_buyer_transitions}, including diagonals
  ```
- Line 874: lat
  ```
  Next, the estimated ratio of potential suppliers to potential buyers is $M^{S}=4.20$. Since there ar
  ```
- Line 876: lat
  ```
  Finally, our $\omega$ estimate implies that only 3 percent of the potential exporter population is `
  ```
- Line 908: lat, second
  ```
  The lower left panel of Figure \ref{fig:baseline_fit} summarizes the model's ability to generate the
  ```
- Line 917: lat
  ```
  There is one targeted data moment that does not appear in Figure \ref{fig:baseline_fit}: the ratio o
  ```
- Line 921: lat
  ```
  Using our estimated parameters, we now characterize the quantitative features of our baseline model.
  ```
- Line 945: lat
  ```
  \caption{Simulated Buyer Profit and Search Cost Heterogeneity}
  ```
- Line 951: lat
  ```
  On the supplier side, total search costs constitute 0.064 of total expenditure, representing $45$ pe
  ```
- Line 961: lat
  ```
  \caption{Buyers and Suppliers Accumulation of Connections$^*$ }
  ```
- Line 976: country, lat, second
  ```
  Our experiments concerning market developments are motivated by three patterns in Figures \ref{fig:c
  ```
- Line 986: lat
  ```
  Now consider the changes in key equilibrium outcomes when search costs fall (column 2).  Consumer we
  ```
- Line 990: lat
  ```
  % \footnote{We treat this increase as an unexpected shock to the initial equilibrium in $2004$. Whil
  ```
- Line 998: lat
  ```
  We next use our model to simulate the effects of Trump's Section 301 tariffs on the U.S. apparel mar
  ```
- Line 1002: network
  ```
  These initial impacts manifest exclusively in intensive margin adjustments to the profits and revenu
  ```
- Line 1010: lon
  ```
  A more novel prediction of this paper concerns the speed of adjustment following the shock. Along th
  ```
- Line 1016: lat, name
  ```
  where $\tilde{c}(\mathbf{s}) = \left[\sum_{k}s_k(\mathbf{s}) \left((1+t_k)\tilde{c}_k\right)^{1-\alp
  ```
- Line 1019: second
  ```
  {\label{fn:IMP} In our model, payments to type-$j$ exporters have two components: compensation for v
  ```
- Line 1029: lon
  ```
  + \varepsilon_{jgt},
  ```
- Line 1033: lat, loc, location
  ```
  Figure \ref{fig:val_entropy_year_no2025_full} reports these coefficient estimates (red circles) toge
  ```
- Line 1070: lat
  ```
  We develop a dynamic model of international buyer-supplier matching in which agents on both sides of
  ```
- Line 1072: lat
  ```
  We find, first, that the aggregate costs of forming business relationships
  ```
- Line 1077: second
  ```
  Second, buyers and suppliers adjust their search intensity over their life
  ```
- Line 1078: lon, son
  ```
  cycles, both because their market visibility changes and because buyers face diminishing returns to 
  ```
- Line 1082: lat, lon, son
  ```
  Finally, our simulations suggest that Trump's 2018 tariffs on Chinese apparel imports reduced consum
  ```
- Line 1086: name
  ```
  %\bibliographystyle{aaai-named}
  ```
- Line 1106: son
  ```
  Following \citet{AtkesonBurstein2008} and \citet{HottmanReddingWeinstein2015}, this section establis
  ```
- Line 1127: lat
  ```
  and since negotiated prices are bilaterally efficient (see Section \ref{app:bargaining} below), they
  ```
- Line 1177: lat, lon
  ```
  To summarize the static game, we adopt some of the notation of dFG. Let $J$ be the set of suppliers 
  ```
- Line 1180: lon
  ```
  In the approximate notation of dFG, the flow payoffs in this equilibrium are $ \Upsilon^B(K) \equiv 
  ```
- Line 1198: lon
  ```
  \textbf{No commitment:} A buyer and her suppliers cannot commit to long-term transfer schedules. The
  ```
- Line 1210: lat
  ```
  \textbf{Passive beliefs: }When a delegate or a supplier receives an offer of $p_{x}(K)\neq \hat{p}_{
  ```
- Line 1216: lat
  ```
  Together, these assumptions simplify the multilateral bargaining problem to a Nash-like problem in w
  ```
- Line 1224: lat
  ```
  To demonstrate the role of Assumptions \ref{ass_bargain_1}-\ref{ass_bargain_4} in establishing equat
  ```
- Line 1226: lat
  ```
  \subsubsubsection{\textbf{Bilateral efficiency:}}
  ```
- Line 1227: lat
  ```
  \label{sec:bilat_effic}
  ```
- Line 1228: lat
  ```
  The following Lemma establishes that the solution to our bargaining game is bilaterally efficient:
  ```
- Line 1233: network
  ```
  Suppose agents hold passive beliefs and expect the equilibrium network state
  ```
- Line 1236: lat
  ```
  }_{x}(\hat{K})$ that is bilaterally efficient. That is, taking the outcomes
  ```
- Line 1244: lat
  ```
  \label{bilat_effic}
  ```
- Line 1250: lat
  ```
  Consider the bilateral bargaining session involving supplier $x$. If the buyer's delegate is chosen 
  ```
- Line 1270: network
  ```
  Here supplier $x$ believes that if the buyer's delegate rejects an out-of-equilibrium offer, she wil
  ```
- Line 1287: lat
  ```
  We next show that, when agents bargain at each point in time over the current flow surplus, the outc
  ```
- Line 1290: network
  ```
  As $\sigma \rightarrow 1,$ there exists a perfect Bayesian equilibrium with equilibrium network stat
  ```
- Line 1297: lat
  ```
  $ be bilaterally efficient, with
  ```
- Line 1307: lat, network
  ```
  Also, for the bilateral game involving supplier $x$, let $\hat{R}_{x}^{b}(\hat{K})$ be the equilibri
  ```
- Line 1310: lat
  ```
  By Lemma \ref{lemma1}, the bilaterally efficient prices will be chosen in each bilateral game under 
  ```
- Line 1315: lon
  ```
  (Although $\hat{\tau}_{x}(\hat{K}\backslash x)=0,$ we carry it along for
  ```
- Line 1331: lat
  ```
  These relationships are sufficient to determine the equilibrium flow payoffs for the case when the b
  ```
- Line 1401: lat
  ```
  \hat{K})\rightarrow \pi ^{B}(\hat{K}).$ Accordingly, as the probability of an exogenous breakdown in
  ```
- Line 1418: loc, location
  ```
  The fair allocation property therefore holds in the limit as $\sigma
  ```
- Line 1420: loc, location
  ```
  dFG note that if each party is equally likely to move first, the fair allocation property also obtai
  ```
- Line 1498: lat
  ```
  to restate the relationship creation terms in (\ref{eq:diffHJB_buyer}):
  ```
- Line 1510: lat, second
  ```
  Second, restate the relationship destruction terms in (\ref{eq:diffHJB_buyer}%
  ```
- Line 1631: lat
  ```
  The calculation above can be repeated for each type $i$ of buyers, so we can obtain $\vec{\sigma}^B_
  ```
- Line 1649: lat
  ```
  \item supplier exits the export market or relationship terminated: $\tilde{\delta}$ to state $(0,0)$
  ```
- Line 1701: lon
  ```
  Neither uniqueness nor existence is guaranteed for the dynamic equilibrium. However, at the candidat
  ```
- Line 1746: block, loc
  ```
  construction of the associated block-diagonal weighting matrix, component by
  ```
- Line 1757: lat
  ```
  have $j$ partners in period $t+1.$ They are sample analogs to the population
  ```
- Line 1791: lat
  ```
  Next, restate each row of $\mathbf{\Pi }^{BPS}$ in terms of cumulative
  ```
- Line 1813: lat
  ```
  Suppose we wish to calculate the covariance between two sample-based
  ```
- Line 1814: lat
  ```
  cumulative probabilities, $\hat{F}_{q}=\hat{F}(x_{q})$\textbf{\ }and\textbf{\
  ```
- Line 1815: lat
  ```
  }$\hat{F}_{m}=\hat{F}(x_{m}).$ These are calculated at chosen cutoffs $x_{m}$
  ```
- Line 1905: son
  ```
  However, for two reasons, we exclude some elements of $\mathbf{\hat{\Pi}}%
  ```
- Line 1908: second
  ```
  information and $\Psi ^{BPS}$ is singular. Second, $\mathbf{\hat{\Pi}}^{BPS}$
  ```
- Line 1952: block, lat, loc
  ```
  ^{BPS}$ are not correlated across rows, the block-diagonal covariance matrix
  ```
- Line 1966: lat
  ```
  Replacing population transition probabilities $\mathbf{\Pi }^{BPS}$ with
  ```
- Line 1972: degree
  ```
  \subsection{Degree distributions}
  ```
- Line 1974: degree
  ```
  In addition to elements of the transition matrices, we target the degree
  ```
- Line 1976: degree, lat
  ```
  The degree distributions in Table \ref{tab:client_dists} are related to the
  ```
- Line 1981: lat
  ```
  attempt to account for the correlation between our transition matrix moments
  ```
- Line 1982: degree
  ```
  and degree distribution moments in our weighting matrix.} These are
  ```
- Line 1984: degree
  ```
  and buyer degree distributions, respectively. As with the transition
  ```
- Line 1986: degree
  ```
  limit our exposition to the buyers per supplier degree distribution.
  ```
- Line 1988: lat
  ```
  Define the cumulative cutoffs of the cumulative distribution of firms to be $%
  ```
- Line 2013: lat
  ```
  cumulative probabilities that underlie them with their sample analogs.
  ```
- Line 2030: lat, son
  ```
  The baseline model characterizes firms' search efforts as optimal forward-looking behavior, given th
  ```
- Line 2046: lon
  ```
  is between a type-$i$ buyer and a type-$j$ supplier is $\upsilon_{i}^{B}\upsilon_{j}^{S}$
  ```
- Line 2050: lon
  ```
  \upsilon_{i}^{B}=\frac{\sigma_{i}^{B}n_{i}^{B}}{{\displaystyle \sum_{i'}}\sigma_{i'}^{B}n_{i^{\prime
  ```
- Line 2066: lat
  ```
  All relationships end with exogenous hazard $\delta$, and buyers and suppliers die with exogenous ha
  ```
- Line 2068: lon
  ```
  \dot{M}_{i}^{B}(\mathbf{s}) & =\sum_{j}\left[\sigma_{i}^{B}\theta^{B}\upsilon_{j}^{S}M_{i}^{B}(\math
  ```
- Line 2099: degree
  ```
  \subsubsubsection{Degree distributions}
  ```
- Line 2105: lat
  ```
  in the behavioral version of the model.  With this solution in hand, we can calculate
  ```
- Line 2117: degree
  ```
  These expressions directly imply the degree distributions for each
  ```
- Line 2141: lat
  ```
  These hazards can be fed through an intensity matrix to calculate
  ```
- Line 2142: degree
  ```
  analogs to observed transition rates and degree distributions for
  ```
- Line 2147: lat
  ```
  of connections.  These transitions also help identify the relative fraction of the two supplier type
  ```
- Line 2161: second
  ```
  We cannot directly compare the fit metric of the mechanical model with that of the baseline.  First,
  ```
- Line 2190: lat, son
  ```
  One limitation of our benchmark formulation is that it does not allow for match-specific fixed costs
  ```
- Line 2192: city
  ```
  It is possible to add these features to the model, but to keep it computationally tractable we need 
  ```
- Line 2193: lat
  ```
  We must also shut down visibility effects on both sides of the market; otherwise, each match-specifi
  ```
- Line 2199: city
  ```
  To keep this model tractable, we make two simplifying assumptions. First, we impose that the elastic
  ```
- Line 2205: second
  ```
  Second, we shut down visibility effects on both sides of the market ($\gamma^B=\gamma^S=0$). Without
  ```
- Line 2209: lon
  ```
  To incorporate match-specific shocks and fixed costs, we follow \citet{MortensenPissarides1994}. Let
  ```
- Line 2211: lon
  ```
  With these additional model features, the flow value to a type-$i$ buyer of a  match with a type-$j$
  ```
- Line 2213: lon
  ```
  (\rho + \delta + \delta^B + \delta^S)V_{ji}^B(\varepsilon) & = \pi_{ij}^T \varepsilon - \tau_{ji}(\v
  ```
- Line 2216: lon
  ```
  where  $\tau_{ji}(\varepsilon)$ is the portion of the flow match surplus the buyer transfers to the 
  ```
- Line 2218: lon
  ```
  (\rho + \delta + \delta^B + \delta^S)V_{ji}^S(\varepsilon) & = \tau_{ji}(\varepsilon) - F  + \lambda
  ```
- Line 2226: lon
  ```
  & \max_{\tau_{ij}(\varepsilon)} \left[V_{ji}^S(\varepsilon) - 0 \right] \left[ V_{ji}^B(\varepsilon)
  ```
- Line 2230: lon
  ```
  V_{ji}^S(\varepsilon)  = & V_{ji}^B(\varepsilon)
  ```
- Line 2235: lon
  ```
  \tau_{ji}(\varepsilon) = \frac{\pi_{ij}^T \varepsilon + F}{2}
  ```
- Line 2244: lon
  ```
  0 = (\pi_{ij}^T\varepsilon_{ij}^\ast -F) & +  \lambda \int_{\varepsilon_{ij}^\ast}^{\infty} \frac{\p
  ```
- Line 2247: lon
  ```
  Given $G(x)$, this equation implicitly determines $\varepsilon^{\ast}$. For example, if the shock is
  ```
- Line 2249: lon
  ```
  0  = (\pi_{ij}^T\varepsilon_{ij}^\ast -F) & + \lambda \pi_{ij}^T \frac{ \left(\mathbb{E}[\varepsilon
  ```
- Line 2251: lon
  ```
  where $\Phi()$ is the standard normal distribution function, and the conditional expectation of $\va
  ```
- Line 2253: lon
  ```
  \mathbb{E}[\varepsilon | \varepsilon > \varepsilon_{ij}^\ast] = e^{\frac{\sigma^2}{2}} \frac{\Phi\le
  ```
- Line 2262: lon
  ```
  \nonumber (\rho + \delta + \delta^B + \delta^S) S_{ij}(\varepsilon) =  \pi_{ij}^T \varepsilon - F + 
  ```
- Line 2265: lon
  ```
  \[\nonumber (\rho + \delta + \delta^B + \delta^S + \lambda) S_{ij}(\varepsilon) = \pi_{ij}^T \vareps
  ```
- Line 2267: lon
  ```
  Taking conditional expectations over $  \varepsilon_{ij} > \varepsilon_{ij}^\ast$, defining $\phi_{i
  ```
- Line 2269: lon
  ```
  \mathbb{E}\left[S_{ij} (\varepsilon)|\varepsilon>\varepsilon_{ij}^\ast\right] = \frac{1}{(\rho + \de
  ```
- Line 2271: lon
  ```
  implying $\mathbb{E}\left[S_{ij}(\varepsilon)\right] =
  ```
- Line 2272: lon
  ```
  \frac{1 - \phi_{ij} }{(\rho + \delta + \delta^B + \delta^S + \lambda \phi_{ij}) } \cdot \left(\pi_{i
  ```
- Line 2279: lon
  ```
  \frac{d \kappa^B(\sigma_i^B)}{d \sigma_i^B} &= \theta^B \frac{1}{2}\sum_{j=1}^{J} \upsilon_j^S  \mat
  ```
- Line 2282: lon
  ```
  \frac{d \kappa^S(\sigma_j^S)}{d \sigma_j^S} &= \theta^S \frac{1}{2}\sum_{i=1}^{I} \upsilon_i^B  \mat
  ```
- Line 2285: lat
  ```
  These first-order conditions imply policy functions for $\sigma_j^S$ and $\sigma_i^B$ that vary only
  ```
- Line 2298: lon
  ```
  H^S = \sum_{j=1}^{J} \sigma_j^S \upsilon_j^S N^S
  ```
- Line 2336: lat
  ```
  Unlike the baseline model, supplier transitions depend on the type(s) of the buyer they are matched 
  ```
- Line 2340: second
  ```
  The first term is the exogenous match death hazard, and the second is the endogenous death hazard.  
  ```
- Line 2375: city
  ```
  Within-store elasticity & calibrated & 1.8771 & 1.8687 \\
  ```
- Line 2377: city
  ```
  Cross-store elasticity & 2.432 & same as within & same as within \\
  ```
- Line 2393: son
  ```
  The overall fit of the match shock model is slightly worse compared with the baseline model (11,522.
  ```
- Line 2419: lon
  ```
  \mathbf{\upsilon }_{j}^{S}\left[ V_{i}^{B}(\mathbf{s}+\mathbf{1}_{j})-V_{i}^{B}(%
  ```
- Line 2425: lon
  ```
  element $1$ and $0$'s elsewhere and $\mathbf{\upsilon }_{j}^{S}=\sum_{\ \mathbf{b}\in \mathbb{B}}\up
  ```
- Line 2430: lon
  ```
  \sigma _{i}^{B}}=\theta ^{B}\sum_{j=1}^{J}\upsilon^S_j\left[ V_{i}^{B}(\mathbf{s}%
  ```
- Line 2436: lon
  ```
  \mathbf{s})\theta ^{B}\sum_{k=1}^{J}\upsilon _{k}^{S}\left[ V_{ji}^{S}(%
  ```
- Line 2441: lat
  ```
  As search is random, the expected value of a supplier's next relationship is:
  ```
- Line 2443: lon
  ```
  V_{j}^{S}=\sum_{i}\sum_{\mathbf{s}\in \mathbb{S}}\upsilon _{i}^{B}(\mathbf{s}%
  ```
- Line 2458: lon
  ```
  -\mathbf{1}_{j})\theta ^{B}\upsilon _{j}^{S}M_{i}^{B}(\mathbf{s}-\mathbf{1}_{j})+(\delta_j + \delta^
  ```
- Line 2473: lon
  ```
  -\mathbf{1}_{k})\theta ^{S}\upsilon _{k}^{B}M_{k}^{S}(\mathbf{b}-\mathbf{1}_{k})+\left(\delta_j + \d
  ```
- Line 2484: lat
  ```
  Aggregate mass of buyers and suppliers, search effort, and matching hazard calculations are as in th
  ```
- Line 2490: lon
  ```
  \begin{equation}D_{ijt+1} = \beta_{N_B} \ln N^B_{it}+ \beta_{N_S}\ln N^S_{jt}+\tau_t+\epsilon_{ijt}.
  ```
- Line 2515: son
  ```
  \caption{Comparison of Heterogeneous Death Hazard Model with Baseline*}
  ```
- Line 2582: lon
  ```
  f(h) = \bar f + \mathbf{1}\{h = 0\} \Delta f + \varepsilon,
  ```
- Line 2583: lon
  ```
  \qquad \varepsilon \sim \mathcal{N}(0,1),
  ```
- Line 2615: lat
  ```
  \paragraph{Simulated targets}
  ```
- Line 2616: lat
  ```
  As we do not have data on the relevant population of foreign firms, we cannot directly observe their
  ```
- Line 2651: lat
  ```
  % To compare foreign market participation costs across models, we calculate the supplier non-variabl
  ```
- Line 2656: lon
  ```
  It is instructive to compare the fixed costs we estimate with those reported by \citet{AlessandriaAr
  ```
- Line 2682: lat
  ```
  The results are summarized in Table \ref{tab:policy_shock}. The supplier-entry margins are direction
  ```

**/replication-package/output/tables/paper/table_06_market_developments_counterfactual.tex**

- Line 30: lat, second
  ```
  \item [a] *Baseline figures reflect several normalizations. First, measures of active buyers and sup
  ```

