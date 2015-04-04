cap program drop colorcor
program colorcor
/* This program creates a colored cor. matrix */
/* Created by hhsievertsen/April 2015.*/

syntax varlist [if] [in], [Nonsig(string)]
* create tempfile instead of preserve
tempfile temp1
qui: save "`temp1'"
/* keep only variables needed*/
marksample  touse
qui: keep if `touse'
keep `varlist'
/* Set locals */
	* identifier for square
	local q=1
	* number of variables
	local N: word count `varlist' 
	* number of variables minus 1
	local N1=`N'-1
	* x and y label placement
	local xlabels_i=0.5
	local ylabels_i=`N'-0.5
	* tokenize variables
	tokenize `varlist'
/* Loop through variables and calculate correlations using reg command, improve! This is way too time consuming*/
forval j=1/`N1'{
* Create labels for axes
	loc lab: var l ``j''
	if "`lab'"==""{
	loc lab="``j''"
	}
	local xlabel=`"`xlabel'"'+`" `xlabels_i' "`lab'" "'
	local xlabels_i=`xlabels_i'+1
	local ylabel=`" `ylabels_i' "`lab'" "'+`"`ylabel'"'
	local ylabels_i=`ylabels_i'-1
* This is a bit messy, it regs all combinations of variables
	local start=`j'+1
	forval i=`start'/`N'{
	qui: reg  ``j'' ``i''
	local rho=abs(e(r2)^.5)
	* Determine sign and thereby color
		if _b[``i'']<0{
		 local col="red*`rho'"
		}
		else {
		 local col="green*`rho'"
		}
	local outline="fcolor(`col')"
	* If sig option is enabled, non significant (for now just 5% level) are colored according to option
		if "`nonsig'"!="" & (2 * ttail(e(df_r), abs(_b[``i'']/_se[``i''])))>0.05{
			local outline="fcolor(`nonsig')"
		}
* Adds to graph string for twoway graph. 
	local graph="`graph'"+"	(rarea up low x if correlate_id==`q',fcolor(`col')  lwidth(none) lcolor(`col') `outline'  xaxis(2)) "
* Add correlation coefficient
*local lines="text"+"	(rarea up low x if correlate_id==`q',fcolor(`col')  lwidth(none) lcolor(`col') `outline'  xaxis(2)) "
* Increment counter
	local q=`q'+1
	}
}
* Add labels for last variable
	loc lab: var l ``N''
	if "`lab'"==""{
		loc lab="``N''"
		}
	local xlabel=`"`xlabel'"'+`" `xlabels_i' "`lab'" "'
	local xlabel=`"`xlabel'"'+`" `xlabels_i' " " "'
	local ylabel=`" `ylabels_i' "`lab'" "'+`"`ylabel'"'
	local ylabel=`"`ylabels_i' " " "'+`"`ylabel'"'
* Creat dataset for plotting
clear
	qui: set obs `N1'
	* upper y val for rectangle
	qui: gen up=_n
	* lower y val  for rectangle
	qui: gen low=up-1
	* expand dataset such taht there is an obs per correlation coef.
	qui: expand `N1'-low
	* Create x values
	qui:  bys up: gen x=_n-1
	gsort x -up
	* Gen identifier for each rectangle
	qui: gen correlate_id=_n
	* Duplicate dataset so that we can expand dataset
	qui: expand 2, gen (add)
	qui: replace x=x+add

* Create twoway graph
twoway  (rarea up low x if correlate_id==0.5,xaxis(1))  `graph', ///
	    ylabel(`ylabel',noticks nogrid  angle(horizontal) labsize(small)) xlabel(`xlabel',labsize(small) noticks axis(2) angle(vertical)) legend(off) graphregion(fcolor(white) lcolor(white)) xscale(off axis(1)) ///
	   plotregion(fcolor(white) lcolor(white)) xtitle("") ytitle("") xtitle("",axis(2))  yscale(noline)   xscale(noline axis(2)) 

* Reload original data
use `temp1',clear
end


