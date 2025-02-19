// Load the dataset
use "D:\FYP\sata\stata data\plist.dta"

// Sort and check if hhcode and idc are uniquely identifying
sort hhcode idc
isid hhcode idc

// Education sheet merging 1 to 1
merge 1:1 hhcode idc using "D:\FYP\sata\stata data\secc1.dta"
drop _merge

// Gender Dummy: if Female, it takes value 1; otherwise 0
gen female = 0
replace female = 1 if sb1q4 == 2

// Literacy Dummy: if can read, takes value 1; otherwise 0
gen read_lit = 0
replace read_lit = 1 if sc1q1a == 1

// Save the dataset as "table1" to preserve it before further modifications
save "D:\FYP\sata\stata data\table1.dta", replace


// Importing migration table to remove duplicates
use "D:\FYP\sata\stata data\secb2.dta", clear

// Removing duplicates from migration table
duplicates drop hhcode idc, force


//merge with tabel1
merge 1:1 hhcode idc using "D:\FYP\sata\stata data\table1.dta"
drop _merge


//update table1
save "D:\FYP\sata\stata data\table1.dta", replace

// generate new binary variable
gen migration= 0
replace migration =1 if sb2q01 == 2


// merging income table
merge 1:1 hhcode idc using "D:\FYP\sata\stata data\sece.dta"

//generating variable for total annual income
egen total_income = rowtotal(seaq10 seaq15 seaq17 seaq19 seaq21)
drop _merge

//merge housing structure table
merge m:1 hhcode using "D:\FYP\sata\stata data\secf1.dta"
drop _merge

//merge health data
merge 1:1 hhcode idc using "D:\FYP\sata\stata data\secd.dta"
drop _merge


