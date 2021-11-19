#Write a query in SQL to display the first name, last name, department number, and department name for each employee.

select e.FIRST_NAME, e.LAST_NAME ,e.department_id , d.department_name 
from employees e , departments d
where e.department_id = d.department_id

#Write a query in SQL to display the first and last name, department, city, and state province for each employee

select e.FIRST_NAME, e.LAST_NAME , d.DEPARTMENT_NAME , l.CITY ,l.STATE_PROVINCE
from employees e , departments d ,locations l
where e.department_id =d.department_id
and d.LOCATION_ID = l.LOCATION_ID

#Write a query in SQL to display the first name, last name, salary, and job grade for all employees. 

select e.FIRST_NAME, e.LAST_NAME ,e.SALARY , j.GRADE_LEVEL
from employees e , job_grades j
where e.salary between j.LOWEST_SAL and j.HIGHEST_SAL

#Write a query in SQL to display the first name, last name, department number and department name, for all 
#employees for departments 80 or 40.

select e.FIRST_NAME, e.LAST_NAME  , e.department_id ,d.DEPARTMENT_NAME
fromm employees e ,  departments d
where e.department_id = d.department_id
and e.department_id in (80,40);

#Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name,
#department, city, and state province.

select e.FIRST_NAME, e.LAST_NAME , d.DEPARTMENT_NAME,l.CITY ,l.STATE_PROVINCE
from employees e , departments d , locations l
where e.department_id =d.department_id
and d.LOCATION_ID = l.LOCATION_ID 
and e.first_name like '%z%'

#Write a query in SQL to display all departments including those where does not have any employee.

select distinct d.DEPARTMENT_NAME
from departments d left join employees e
on d.department_id = e.department_id

#Write a query in SQL to display the first and last name and salary for those employees who earn less than 
#the employee earn whose number is 182

select e.FIRST_NAME, e.LAST_NAME, e.SALARY
from employees e 
where e.salary <(select e.salary from employees e where e.EMPLOYEE_ID =182);

#Write a query in SQL to display the first name of all employees including the first name of their manager.

select e.first_name , f.first_name 
from employees e inner join employees f 
on e.employee_id = f.MANAGER_ID

#Write a query in SQL to display the department name, city, and state province for each department. 

select d.DEPARTMENT_NAME , l.CITY ,l.STATE_PROVINCE
from departments d 
inner join locations l 
on d.location_id = l.location_id

#Write a query in SQL to display the first name, last name, department number and name, for all 
#employees who have or have not any department.

select e.FIRST_NAME, e.LAST_NAME ,d.DEPARTMENT_NAME , d.department_id
from employees e left outer join departments d
on e.department_id =d.department_id;

#Write a query in SQL to display the first name of all employees and the first name of their manager 
#including those who does not working under any manager.

select e.first_name , f.first_name 
from employees e left outer join employees f 
on e.employee_id = f.MANAGER_ID


#Write a query in SQL to display the first name, last name, and department number for those employees who works 
#in the same department as the employee who holds the last name as Taylor

select e.FIRST_NAME, e.LAST_NAME , d.department_id
from employees e , department d
where e.department_id =d.department_id
and e.department_id in (select e.department_id from employees e where e.LAST_NAME like '%Taylor%');

#Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, 
#and starting date for all the jobs which started on or after 1st January, 1993 
#and ending with on or before 31 August, 1997

select jh.JOB_ID ,d.DEPARTMENT_NAME , concat(e.FIRST_NAME, e.LAST_NAME)
from employees e , job_history jh
where e.employee_id = jh.employee_id
jh.START_DATE between 1993-01-01 and 1997-07-31;

or
select jh.JOB_ID ,d.DEPARTMENT_NAME , e.FIRST_NAME, e.LAST_NAME
from employees e , job_history jh , departments d
where e.employee_id = jh.employee_id
and e.employee_id =d.employee_id
and jh.START_DATE > '1993-01-01'
and jh.END_DATE < '1997-01-07';

#Write a query in SQL to display job title, full name (first and last name ) of employee, 
#and the difference between maximum salary for the job and salary of the employee.

select j.JOB_TITLE ,e.FIRST_NAME, e.LAST_NAME , (jj.max_sal - e.SALARY ) as Diff
from jobs j, employees e , (select JOB_ID ,MAX_SALARY as max_sal  from jobs ) jj
where e.JOB_ID = j.JOB_ID
and e.JOB_ID = jj.JOB_ID

#Write a query in SQL to display the name of the department, average salary and number of 
#employees working in that department who got commission.

select d.DEPARTMENT_NAME , avg(e.SALARY) , count (e.DEPARTMENT_ID)
from employees e , departments d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.department_name
having e.COMMISSION_PCT >0;

#Write a query in SQL to display the full name (first and last name ) of employee, and job title 
#of those employees who is working in the department which ID 80 and deserve a commission percentage.
select e.FIRST_NAME, e.LAST_NAME , j.JOB_TITLE 
from employees e , jobs j
where 
e.JOB_ID = j.JOB_ID
and e.DEPARTMENT_ID =80
and e.COMMISSION_PCT >0


#Write a query in SQL to display the name of the country, city, and the departments which are running there

select c.COUNTRY_NAME , l.CITY , d.department_name
from countries c ,locations l , departments d
where c.COUNTRY_ID = l.COUNTRY_ID
and d.location_id = l.location_id;

#Write a query in SQL to display the details of jobs which was done by any of the employees who is presently
#earning a salary on and above 12000

select e.FIRST_NAME, e.LAST_NAME , jh.JOB_ID 
from employees e , job_history jh
where e.JOB_ID = jh.JOB_ID 
and e.salary >= 12000

#Write a query in SQL to display the country name, city, and number of those departments where 
#at leaste 2 employees are working.

select c.COUNTRY_NAME , l.CITY , count (d.department_id)
from countries c ,locations l , departments d 
where c.COUNTRY_ID = l.COUNTRY_ID
and d.location_id = l.location_id
and department_id IN 
(SELECT department_id 
FROM employees 
GROUP BY department_id 
HAVING COUNT(department_id)>=2)
group by c.COUNTRY_NAME , l.CITY ;

#Write a query in SQL to display the department name, full name (first and last name) of manager, and their city

SELECT department_name, first_name || ' ' || last_name AS name_of_manager, city 
FROM departments D 
JOIN employees E 
ON (D.manager_id=E.employee_id) 
JOIN locations L USING (location_id);

#Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.
select employee_id ,  job_title, end_date-start_date DAYS 
from job_history , jobs
where job_history.job_id = jobs.job_id
and job_history.department_id=80;


#24
#Write a query in SQL to display the full name (first and last name), and salary of those employees who 
#working in any department located in London

select first_name || ' ' || last_name , salary 
from departments , locations , employees
where 
departments.LOCATION_ID = locations.LOCATION_ID
and employees.DEPARTMENT_ID  = departments.DEPARTMENT_ID
and locations.CITY = 'London'

#25
#Write a query in SQL to display full name(first and last name), job title, starting and 
#ending date of last jobs for those employees with worked without a commission percentage

select e.first_name || ' ' || e.last_name ,j.JOB_TITLE  , h.START_DATE , h.END_DATE
from employees e , jobs j , job_history h
where e.job_id = j.job_id
and j.job_id = h.job_id
and e.EMPLOYEE_ID = h.EMPLOYEE_ID
and e.COMMISSION_PCT is not null ;

#26
#Write a query in SQL to display the department name and number of employees in each of the department

select d.DEPARTMENT_NAME , count(e.EMPLOYEE_ID )
from departments d , employees e
d.DEPARTMENT_ID =e.DEPARTMENT_ID
group by d.department_name;

or
select d.DEPARTMENT_NAME , count(* )
from departments d , employees e
where e.DEPARTMENT_ID =d.DEPARTMENT_ID
and e.MANAGER_ID =d.MANAGER_ID
group by d.department_name order by 1;

#27
#Write a query in SQL to display the full name (firt and last name ) of employee with ID 
#and name of the country presently where (s)he is working.

select e.first_name || ' ' || e.last_name , e.employee_id , c.COUNTRY_NAME
from employees e , countries c , locations l , departments d
where c.COUNTRY_ID = l.COUNTRY_ID
and e.DEPARTMENT_ID = d.DEPARTMENT_ID
and d.LOCATION_ID =l.LOCATION_ID;