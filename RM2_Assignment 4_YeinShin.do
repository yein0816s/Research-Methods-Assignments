clear
cd "/Users/shin-yein/Documents/Stata"
log using "log231116.smcl", append

use "crime.dta", clear

*creating a balance table
global balanceopts "prehead(\begin{tabular}{l*{6}{c}}) postfoot(\end{tabular}) noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast) starlevels(* 0.1 ** 0.05 *** 0.01)"
estpost ttest severityofcrime monthsinjail recidivates, by(republicanjudge) unequal welch
esttab . using test.tex, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels("Control" "Treatment" "Difference") noobs $balanceopts mlabels(none) eqlabels(none) replace mgroups(none)

*first stage regression
reg monthsinjail republicanjudge severityofcrime
eststo regression_one 
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_one using RM2_Assignment4_YeinShin.rtf


*reduced form
reg recidivates republicanjudge severityofcrime

*IV regression
ssc install ivreg2
ivreg2 recidivates (monthsinjail=republicanjudge) severityofcrime
eststo regression_two 
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_two using RM2_Assignment4_IV_YeinShin.rtf
