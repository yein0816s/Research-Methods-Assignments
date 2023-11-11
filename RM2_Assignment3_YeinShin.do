clear
cd "/Users/shin-yein/Documents/Stata"
log using "log231110.smcl", append

use "sports-and-education.dta", clear

*creating a balance table
global balanceopts "prehead(\begin{tabular}{l*{6}{c}}) postfoot(\end{tabular}) noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast) starlevels(* 0.1 ** 0.05 *** 0.01)"

estpost ttest academicquality athleticquality nearbigmarket, by(ranked2017) unequal welch

esttab . using test.tex, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels("Control" "Treatment" "Difference") noobs $balanceopts mlabels(none) eqlabels(none) replace mgroups(none)

*building a propensity score model
logit ranked2017 academicquality athleticquality nearbigmarket
predict propensity_score,pr

eststo logit_regression 

global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab logit_regression using RM2_Assignment3_logit_YS.rtf


*drawing a histogram
twoway histogram propensity_score, start(0) width(0.01) bc(red%30) freq || histogram propensity_score if ranked2017==0, start(0) width(0.01) bc(blue%30) freq legend(order(1 "Treatment (Ranked)" 2 "Control (Unranked)"))

*blocking based on propensity score
sort propensity_score
gen block = floor(_n/10)

*analyzing the treatment effect of being ranked on alumni donations
reg alumnidonations2018 ranked2017 academicquality athleticquality nearbigmarket i.block

eststo regression 

global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression using RM2_Assignment3_YS.rtf
