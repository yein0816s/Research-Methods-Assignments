clear
cd "/Users/shin-yein/Documents/Stata"
log using "log_RM2_Assignment2.smcl", append

*** PART1
use "RM2_Assignment1.dta", clear

* Label your variables
label variable candidateid "Candidate ID"
label variable calledback "Called Back"
label variable recruiteriswhite "Recruiter is White"
label variable recruiterismale "Recruiter is Male"
label variable malecandidate "Male Candidate"
label variable eliteschoolcandidate "Elite School Candidate"
label variable bigcompanycandidate "Big Company Candidate"

* Run regression (with and without)
reg calledback eliteschoolcandidate malecandidate

* Store regression
eststo regression_one 

global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_one using Assignment2_PART1_YeinShin.rtf

*** PART2

clear
cd "/Users/shin-yein/Documents/Stata"

import delimited "/Users/shin-yein/Downloads/vaping-ban-panel.csv"

** (1) using xtreg

xtset stateid year
gen post=(year>=2021)
gen vp=vapingban*post

*Q2
regress lunghospitalizations i.vapingban##i.post
eststo regression_1
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_1 using Assignment2_PART2-Q2_YeinShin.rtf

**
xtreg lunghospitalizations i.vapingban##c.year if year < 2021
margins vapingban, dydx(year)

*Q4
xi: xtreg lunghospitalizations vp i.stateid i.year,fe
eststo regression_2
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_2 using Assignment2_PART2-Q41_YeinShin.rtf

testparm i.stateid

** (2) using didregress

clear
cd "/Users/shin-yein/Documents/Stata"

import delimited "/Users/shin-yein/Downloads/vaping-ban-panel.csv"


*Q4
didregress (lunghospitalizations) (vapingban), group(stateid) time(year)
eststo regression_one 
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_one using Assignment2_PART2-Q42_YeinShin.rtf

*Q3
estat trendplots

*Q2
estat ptrends
eststo regression_two
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_one using Assignment2_PART2-Q22_YeinShin.rtf



