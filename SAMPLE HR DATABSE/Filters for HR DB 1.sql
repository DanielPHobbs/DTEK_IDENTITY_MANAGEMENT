#1
#Write a query in SQL to display the full name (first and last name), and salary for those employees who earn below 6000.

select e.FIRST_NAME  , e.LAST_NAME ,e.salary
from employees e 
where e.salary <6000;

#2
#Write a query in SQL to display the first and last_name, department number and salary for those employees who earn more than 8000.
select e.FIRST_NAME  , e.LAST_NAME ,e.department_id,e.salary
from employees e
where e.salary>8000;

#3
#Write a query in SQL to display the first and last name, and department number for all employees whose last name is “McEwen”.

select e.FIRST_NAME  , e.LAST_NAME ,e.department_id
from employees e
where e.last_name like '%McEwen%';

#4
#Write a query in SQL to display all the information for all employees without any department number

select *
from employees e 
where e.department_id is null;

#5
#Write a query in SQL to display all the information about the department Marketing.

select * from 
employees e , department d
where e.department_id =d.department_id
and d.DEPARTMENT_NAME = 'Marketing';

#6
#Write a query in SQL to display the full name (first and last), hire date, salary, and department number 
#for those employees whose last name does not containing the letter M and make the result set in ascending
#order by department number.


select e.FIRST_NAME  , e.LAST_NAME  , e.HIRE_DATE , e.salary , e.department_id
from employees e 
where e.last_name not like '%m%'
order by 4 asc;

#7
# Write a query in SQL to display all the information of employees whose salary is in the range of 8000 and 12000 and commission 
#is not null or department number is except the number 40, 120 and 70 and they have been hired before June 5th, 1987

select * from
employees e 
where e.salary between 8000 and 12000
and e.COMMISSION_PCT is not null
or e.department_id in (40,120,70)
and e.hire_date < '05/06/1987';

#8
#Write a query in SQL to display the full name (first and last name), and salary for all employees 
#who does not earn any commission.

select e.FIRST_NAME  , e.LAST_NAME , e.salary
from employee e
where e.commission_pct < 1;



#9
#Write a query in SQL to display the full name (first and last), the phone number and email separated 
#by hyphen, and salary, for those employees whose salary is within the range of 9000 and 17000. 
#The column headings assign with Full_Name, Contact_Details and Remuneration respectively.


select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name , e.EMAIL || '-' || e.PHONE_NUMBER as Contact_details , e.salary
from employees e 
where e.salary between 9000 and 17000;

#10
#Write a query in SQL to display the first and last name, and salary for those employees 
#whose first name is ending with the letter m.

select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name , e.salary
from employees e 
where e.first_name like '%m'

#11
#Write a query in SQL to display the full name (first and last) name, and salary, for all employees whose salary 
#is out of the range 7000 and 15000 and make the result set in ascending order by the full name.
select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name , e.salary
from employees e 
where e.salary not between  7000 and 15000
order by 1

#year-month-date
#12
#Write a query in SQL to display the full name (first and last), job id and date of hire for those employees 
#who was hired during March 5th, 1986 and July 5th, 1987.
select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name , e.JOB_ID, e.hire_date
from employees e
where   e.hire_date  BETWEEN '1986-03-05' AND '1987-07-05';  

#13
#Write a query in SQL to display the the full name (first and last name), and department number for those employees 
#who works either in department 70 or 90.

select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name , e.department_id
from employees e
where e.department_id in (70,80);


#14
#Write a query in SQL to display the full name (first and last name), salary, and manager number for those employees
#who is working under a manager. 

SELECT first_name ||' '||last_name AS Full_Name, salary, manager_id FROM employees WHERE manager_id IS NOT NULL;

#15
#Write a query in SQL to display all the information from Employees table for those employees 
#who was hired before June 21st, 1987.
select * from employees e
where e.hire_date < '1987-06-21'

#16
#Write a query in SQL to display the first and last name, email, salary and manager ID, for those employees whose 
#managers are hold the ID 120, 103 or 145.

select first_name ||' '||last_name AS Full_Name, email,salary, manager_id 
FROM employees 
where manager_id in (120,103,145);

#17
#Write a query in SQL to display all the information for all employees who have the letters D, S, or N in their first name 
#and also arrange the result in descending order by salary.

select *
from employees e 
where e.first_name like '%D%' or
e.first_name like '%S%' or
e.first_name like '%N%'
order by e.salary desc;


#18
#Write a query in SQL to display the full name (first name and last name), hire date, commission percentage,
#email and telephone separated by '-', and salary for those employees who earn the salary above 11000 or 
#the seventh digit in their phone number equals 3 and make the result set in a descending order by the first name.

select e.first_name ||' '||e.last_name AS Full_Name, e.email || ' ' || e.PHONE_NUMBER ,e.salary
from employees e
where e.salary >11000
OR phone_number LIKE '______3%'  
order by e.first_name desc;                      

#19
#Write a query in SQL to display the first and last name, and department number for those employees who 
#holds a letter s as a 3rd character in their first name.

select e.first_name , e.last_name , e.department_id 
from employees e
where e.first_name like  '__s%';



#20
#Write a query in SQL to display the employee ID, first name, job id, and department number for those employees 
#who is working except the departments 50,30 and 80.

select e.employee_id , e.first_name , e.job_id , e.department_id
from employees e
where e.department_id not in (50,30,80);


#21
#Write a query in SQL to display the employee Id, first name, job id, and department number for those employees
#whose department number equals 30, 40 or 90.

select e.employee_id , e.first_name , e.job_id , e.department_id
from employees e 
where e.department_id in (30,40,90);

#22
#Write a query in SQL to display the ID for those employees who did two or more jobs in the past. 

select j.employee_id
from  job_history j
group by j.employee_id
having count(j.employee_id) >=2

#23
#Write a query in SQL to display job ID, number of employees, sum of salary, and 
#difference between highest salary and lowest salary for a job

select e.job_id , count(e.employee_id) , sum(e.salary) , (max(e.salary)-min(e.salary))
from employees e
group by e.job_id;

#24
#Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days

select e.job_id
from job_history e
where e.END_DATE - e.START_DATE >300
group  by e.job_id
having count(e.job_id)>1

#25
#Write a query in SQL to display the country ID and number of cities in that country we have.

select l.COUNTRY_ID , count(l.CITY )
from locations l
group by l.COUNTRY_ID

#26
#Write a query in SQL to display the manager ID and number of employees managed by the manager.

select e.manager_id , count(e.employee_id)
from employees e
group by e.manager_id;

#27
#Write a query in SQL to display the details of jobs in descending sequence on job title.

select * from jobs
order by JOB_TITLE desc;

#28
#Write a query in SQL to display the first and last name and date of joining of the 
#employees who is either Sales Representative or Sales Man.

select e.first_name , e.last_name , e.HIRE_DATE
from employees e
where JOB_ID IN ('SA_REP', 'SA_MAN');

#29
#Write a query in SQL to display the average salary of employees for each department who gets a commission percentage.

select avg(e.salary) 
from employees e
where e.COMMISSION_PCT >0

or
select avg(e.salary) , e.DEPARTMENT_ID
from employees e
where e.COMMISSION_PCT >0
group by e.DEPARTMENT_ID

#30
#Write a query in SQL to display those departments where any manager is managing 4 or more employees.

select distinct e.DEPARTMENT_ID
from employees e
group by e.department_id
having count(e.employee_id) >3;

#31
#Write a query in SQL to display those departments where more than ten employees work who got a commission percentage.

select e.department_id
from employees e
where
e.COMMISSION_PCT>0
group by e.department_id
having (e.employee_id)>10

#32
#Write a query in SQL to display the employee ID and the date on which he ended his previous job. 

select j.EMPLOYEE_ID , MAX(j.END_DATE)
from job_history j
group by j.employee_id;

#33
#Write a query in SQL to display the details of the employees who have no commission percentage and salary 
#within the range 7000 to 12000 and works in that department which number is 50.

select * from employees e 
where e.salary between 7000 and 12000
and e.department_id = 50

#34
#Write a query in SQL to display the job ID for those jobs which average salary is above 8000.

select e.job_id
from employees e 
group by e.job_id
having avg(e.salary)>8000;

#35
#Write a query in SQL to display job Title, the difference between minimum and maximum salaries for those 
#jobs which max salary within the range 12000 to 18000.

select j.JOB_TITLE , j.MAX_SALARY-j.MIN_SALARY
from jobs j
where j.MAX_SALARY between 12000 and 18000;

#36
#Write a query in SQL to display all those employees whose first name or last name starts with the letter D
select * from
employees e
where e.first_name like 'D%' or e.last_name like 'D%'

#37
#Write a query in SQL to display the details of jobs which minimum salary is greater than 9000

select * from jobs 
where MIN_SALARY >9000;

#38
#Write a query in SQL to display those employees who joined after 7th September, 1987.

select * from 
employees e 
where e.hire_date > '1987-11-7' 
