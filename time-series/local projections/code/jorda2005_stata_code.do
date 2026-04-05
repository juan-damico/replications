*=============================================================================
* Replication of Jordà (2005): Local Projections
* American Economic Review, 95(1), 161-182
*=============================================================================
*
* Author:  Juan Nicolas D'Amico
* Contact: juan.damico@forecastingeconomics.com
* Date:    2026
*
* Complete DO file with custom graphs can be acquired in the link below:
* https://jdeconomicstore.com/b/local-projections-jorda2005
*
* Description:
*   This script replicates Figure 1 of Jordà (2005) using
*   a VAR(12) benchmark and Local Projections in Stata. Covers structural
*   shock identification via Cholesky decomposition, LP impulse-response
*   functions, and comparison with VAR-based IRFs. The empirical application
*   follows Evans & Marshall (1998).
*
* Disclaimer:
*   This code has been independently developed by Juan D'Amico for educational
*   and research purposes. The original paper and its contents belong to the
*   respective authors. This replication is not affiliated with or endorsed by
*   Jordà or the American Economic Association.
*
*=============================================================================

clear all
set more off
set matsize 800

*=============================================================
* STEP 1: Estimate VAR(12) and plot IRFs with twoway
*=============================================================

use "evansmarshall.dta", clear
tsset t

var em p pcom ff nbrx m2, lags(1/12)

irf set var12_irfs, replace
irf create var12, step(24)

*=============================================================
* STEP 2: Extract the structural FF shock and plot it
*=============================================================

use "evansmarshall.dta", clear
tsset t

quietly var em p pcom ff nbrx m2, lags(1/12)

predict res_em,   residuals equation(em)
predict res_p,    residuals equation(p)
predict res_pcom, residuals equation(pcom)
predict res_ff,   residuals equation(ff)

* Purge ff residual of contemporaneous effect from em, p, pcom
quietly reg res_ff res_em res_p res_pcom
predict ff_shock, residuals

* Normalize to 1 s.d.
quietly summarize ff_shock
replace ff_shock = ff_shock / r(sd)
label variable ff_shock "Structural FF shock (Cholesky, 1 s.d.)"


*=============================================================
* STEP 3: Local Projections with locproj and twoway plots
*=============================================================

use "evansmarshall_with_shock.dta", clear
tsset t

* --- Estimate each LP and save IRF variables ---

locproj em, shock(ff_shock) ylags(2) slags(2) ///
    controls(l(1/2).p l(1/2).pcom l(1/2).ff l(1/2).nbrx l(1/2).m2) ///
    hor(0/24) met(newey) hopt(lag) zero saveirf irfname(lp_em) ///
    title("EM — LP response to FF shock")
	
	
// NOTE: Do this with all the variables. In this example I ued "em", do so for the rest of the variables as well.

