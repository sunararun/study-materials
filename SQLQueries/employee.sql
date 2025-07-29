/*****1. From the following tables, 
write a SQL query to find the first name, last name, department number,
 and department name for each employee.***/
 
SELECT emp.FIRST_NAME, emp.LAST_NAME, dept.DEPARTMENT_ID, dept.DEPARTMENT_NAME FROM sqlpractise.employees as emp
inner join sqlpractise.department as dept
on emp.DEPARTMENT_ID = dept.DEPARTMENT_ID;
/*******2. From the following tables, 
write a SQL query to find the first name, last name, department, city, 
and state province for each employee.*******/

Select emp.FIRST_NAME,emp.LAST_NAME,dept.DEPARTMENT_NAME, loc.CITY, loc.STATE_PROVINCE from sqlpractise.employees as emp
inner join sqlpractise.department as dept
on  emp.DEPARTMENT_ID= dept.DEPARTMENT_ID
inner join sqlpractise.locations as loc
on dept.LOCATION_ID = loc.LOCATION_ID;
/*******3. From the following table,
 write a SQL query to find the first name, last name, salary, 
 and job grade for all employees.*****/
 
 Select emp.FIRST_NAME, emp.LAST_NAME, emp.SALARY, jg.GRADE_LEVEL from sqlpractise.employees as emp
 inner join sqlpractise.job_grade as jg
 on emp.SALARY between jg.LOWEST_SAL and jg.HIGHEST_SAL;
 
 /******4. From the following tables,
 write a SQL query to find all those employees who work in department ID 80 or 40. 
 Return first name, last name, department number and department name.****/
 
 Select emp.FIRST_NAME,emp.LAST_NAME, dept.DEPARTMENT_ID, dept.DEPARTMENT_NAME from sqlpractise.employees as emp
 inner join sqlpractise.department as dept
 on emp.DEPARTMENT_ID = dept.DEPARTMENT_ID
 and dept.DEPARTMENT_ID in (80,40);
 /********6. From the following tables, write a SQL query to find all departments, including those without employees. 
 Return first name, last name, department ID, department name.****/
 
 Select emp.FIRST_NAME,emp.LAST_NAME,dept.DEPARTMENT_ID, dept.DEPARTMENT_NAME from sqlpractise.employees as emp
 left join sqlpractise.department as dept
 on emp.DEPARTMENT_ID = dept.DEPARTMENT_ID;
 
 /*******7. From the following table, write a SQL query to find the employees who earn less than the employee of ID 182. 
 Return first name, last name and salary.******/
 
 Select emp.FIRST_NAME,emp.LAST_NAME, emp.SALARY from sqlpractise.employees as emp
 inner join sqlpractise.employees as emp1
 on emp.SALARY<emp1.SALARY
 and emp1.EMPLOYEE_ID = 182;
 
 /***8. From the following table, write a SQL query to find the employees and their managers. 
 Return the first name of the employee and manager.******/
 
 Select emp.FIRST_NAME as emp_name, manager.FIRST_NAME as manager from sqlpractise.employees as emp
 inner join sqlpractise.employees as manager
 on emp.MANAGER_ID = manager.EMPLOYEE_ID;
 
 /**9. From the following tables,
 write a SQL query to display the department name, city, and state province for each department.****/
 
 Select dept.DEPARTMENT_NAME, loc.CITY,loc.STATE_PROVINCE from sqlpractise.department as dept
 inner join sqlpractise.locations as loc
 on dept.LOCATION_ID = loc.LOCATION_ID;
 
 /******14. From the following tables, write a SQL query to calculate the difference between the maximum salary of the job and the employee's salary. 
 Return job title, employee name, and salary difference.*****/
 
 Select jb.JOB_TITLE,emp.FIRST_NAME, (jb.MAX_SALARY-emp.SALARY) as salary_difference from sqlpractise.employees as emp
 join sqlpractise.jobs as jb
 on emp.JOB_ID = jb.JOB_ID;
 
 /*******15. From the following table,
 write a SQL query to calculate the average salary, the number of employees receiving commissions in that department.
 Return department name, average salary and number of employees.*****/
 
 Select avg(emp.salary),count(*) from interpra.employees as emp
 where emp.dep_id in 
 (Select emp1.dep_id from interpra.employees as emp1
 where emp1.commission !=0.00);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 