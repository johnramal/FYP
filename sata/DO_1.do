use "D:\PSLM_2019\stata data\plist.dta"

//to sort and check if hhcode and idc are uniqely identifier//
sort hhcode idc
isid hhcode idc

//Education sheet merging 1 to 1//
merge 1:1 hhcode idc using "D:\PSLM_2019\stata data\secc1.dta"

//Gender Dummy if Female it takes value 1 otherwise 0//
gen female=0
replace female=1 if sb1q4==2

gen read_lit = 0
replace read_lit=1 if sc1q1a==1

//importing migration table to remove duplicates//
use "D:\PSLM_2019\stata data\secb2.dta", clear

//removing duplicates from migration table//
duplicates drop hhcode idc, force

