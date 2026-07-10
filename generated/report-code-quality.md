## Code Quality

### Stata

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (02_lfttd_imp_apparel_alpha_id_exp.do, line 46)
  → keep if hs2 == 61 | hs2 == 62

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_lfttd_dist_NumSeller_per_buyer.do, line 62)
  → keep if x_`depv'NoSeller != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_lfttd_dist_NumSeller_per_buyer.do, line 73)
  → keep if x_`depv'NoSeller != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (04_lfttd_dist_NumBuyer_per_seller.do, line 60)
  → keep if x_`depv'NoBuyer !=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (04_lfttd_dist_NumBuyer_per_seller.do, line 71)
  → keep if x_`depv'NoBuyer !=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (05_lfttd_NumSellerBuyer_transition_matrix.do, line 32)
  → drop if year == 2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (05_lfttd_NumSellerBuyer_transition_matrix.do, line 89)
  → drop if year == 2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (07_lfttd_duration.do, line 92)
  → drop if duration == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (07_lfttd_duration.do, line 158)
  → drop if lnvalue_imp > lnvalue_imp95 | lnvalue_imp < lnvalue_imp5

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 63)
  → keep if rank < = 10

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 88)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 90)
  → keep if top_country == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 122)
  → keep if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 159)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 162)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 164)
  → keep if top_country == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 235)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 240)
  → drop if missing_id_exp == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 244)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (12_lfttd_aggregates_by_country.do, line 246)
  → keep if top_country == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (13_lfttd_aggregates.do, line 44)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (13_lfttd_aggregates.do, line 104)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (13_lfttd_aggregates.do, line 150)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (13_lfttd_aggregates.do, line 156)
  → drop if missing_id_exp == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (14_lfttd_aggregates_by_related.do, line 44)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (14_lfttd_aggregates_by_related.do, line 94)
  → drop if missing_alpha == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (14_lfttd_aggregates_by_related.do, line 99)
  → drop if missing_id_exp == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A10_lfttd_tenure_of_BuyerSeller.do, line 30)
  → drop if alpha_id == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A10_lfttd_tenure_of_BuyerSeller.do, line 31)
  → drop if id_exp_id == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 45)
  → keep if NoSeller <=5

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 69)
  → keep if `dur'_end == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 83)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 85)
  → keep if match_age <= 10

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 102)
  → drop if year == 2012

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 107)
  → drop if start_yr == 1996

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 133)
  → drop if year == 2012

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 138)
  → drop if start_yr == 1996

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (A7_lfttd_imp_apparel_statistics.do, line 156)
  → keep if yr_in_market <= 10

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 55)
  → drop if Year > 2018

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 67)
  → drop if rank > 10

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 69)
  → drop if T == 0 & Country == "China"

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 100)
  → drop if m_w == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 107)
  → drop if rank > `rankcap'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (event_study.do, line 127)
  → drop if Year == 2025

### Unknown

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (main.m, line 11)
  → % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (main.m, line 11)
  → % workingFolder = '/Users/yx43/Dropbox/Networks project/matlab code';

