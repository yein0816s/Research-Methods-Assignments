

ssc install estout

* Read in data: 
insheet using assignment1-research-methods.csv, comma names clear

* Label your variables
label variable candidateid "Candidate ID"
label variable calledback "Called Back"
label variable recruiteriswhite "Recruiter is White"
label variable recruiterismale "Recruiter is Male"
label variable malecandidate "Male Candidate"
label variable eliteschoolcandidate "Elite School Candidate"
label variable bigcompanycandidate "Big Company Candidate"

* Run regression: 
reg calledback eliteschoolcandidate

* Store regression
eststo regression_one 

global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"
esttab regression_one using Assignment1_YeinShin.rtf
