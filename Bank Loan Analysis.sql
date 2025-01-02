create database Bank_loan_analysis;

select count(*) from finance_1;
select * from finance_1 limit 39717;
select count(*) from finance2;
select * from finance2 limit 39717;

#KPI 1 Year wise loan amount 
select year(issue_D) as Year, sum(loan_amnt) as Loan_Amount
from finance_1
group by Year
order by Year;

#KPI 2 Grade and Sub Grade wise Revol_Bal
select grade as Grade, sub_grade as Sub_Grade, sum(revol_bal) as Revol_Bal
from finance_1 inner join finance2
on(finance_1.id = finance2.id)
group by grade, sub_grade
order by grade, sub_grade;

#KPI 3 Total Payment for verified status Vs Total Payment for Non Verified Status
select verification_status as Verification_Status, concat("$",format(round(sum(total_pymnt)/1000000,2),2)," ","M") as Total_Payment 
from finance_1 inner join finance2
on(finance_1.id = finance2.id)
group by verification_status;

#KPI 4 State wise loan status 
select addr_state as State, loan_status as Loan_Status
from finance_1 
group by addr_state, loan_status
Order by addr_state;

#KPI 5 Month wise loan status 
select monthname(finance2.last_pymnt_d) pay_month, count(finance_1.loan_status) as loan_status
from finance_1 join finance2 
on(finance_1.id = finance2.id)
group by pay_month
order by loan_status;

#KPI 6 Home Ownership Vs last payment date stats
select home_ownership as Home_Ownership, last_pymnt_d as Last_Payment_Date,
concat("$",format(round(sum(last_pymnt_amnt)/10000,2),2)," ","K") as Last_Payment_Amount
from finance_1 inner join finance2
on(finance_1.id = finance2.id)
group by home_ownership, last_pymnt_d
order by last_pymnt_d desc, home_ownership desc;