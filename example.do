cd "C:\Users\hhs\Dropbox\GitHub\colorcor"
clear
qui: bcuse fringe
timer clear
timer on 1
label var annearn "Annual earnings"
colorcor annearn hrearn exper  age depends married tenure educ nrtheast nrthcen south male white union office annhrs
timer off 1
timer list 1
