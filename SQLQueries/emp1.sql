/*****1. From the following table,
 write a  SQL query to find the managers. Return complete information about the managers.***/
 
 Select * from interpra.employees as emp
 where emp.emp_id in (
 Select emp1.manager_id from interpra.employees as emp1);
 
 /****3. From the following table,
 write a SQL query to find those employees who work as 'MANAGERS' and 'ANALYST' and working in ‘SYDNEY’ or ‘PERTH’ with an experience more than 5 years without receiving the commission. 
 Sort the result-set in ascending order by department location. Return employee ID, employee name, salary, and department name.**/
 
 SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp_id IN (SELECT 
            emp1.emp_id
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.job_name IN ('MANAGER' , 'ANALYST'))
        AND emp.dep_id IN (SELECT 
            dept.dep_id
        FROM
            interpra.department AS dept
        WHERE
            dept.dep_location IN ('SYDNEY' , 'PERTH'))
        AND emp.commission = 0.00
        AND emp.hire_date IN (SELECT 
            emp3.hire_date
        FROM
            interpra.employees AS emp3
        WHERE
            FLOOR(DATEDIFF(CURDATE(),
                            STR_TO_DATE(emp3.hire_date, '%Y-%m-%d')) / 365) > 32);
 
 
 /********4. From the following tables, 
 write a SQL query to find those employees work at SYDNEY or working in the FINANCE department with an annual salary above 28000, 
 but the monthly salary should not be 3000 or 2800 and who do not work as a MANAGER and whose ID contain a digit of '3' or '7' in 3rd position. 
 Sort the result-set in ascending order by department ID and descending order by job name.
 Return employee ID, employee name, salary, department name, department location, department ID, and job name.********/ 
 
 Select * from interpra.employees as emp, interpra.department as dept
 where emp.dep_id = dept.dep_id
 and (dept.dep_location = 'SYDNEY' or dept.dep_name ='FINANCE')
 and emp.emp_id in (
 Select emp1.emp_id from interpra.employees as emp1
 where (emp1.salary*12)>28000
  and emp1.salary not in (3000,2800))
  and emp.job_name != 'MANAGER'
  and (emp.emp_id like '__3%' or emp.emp_id like '__7%');
 
 /******5. From the following table, 
 write a SQL query to find the employees of grade 2 and 3.
 Return all the information of employees and salary details.****/
 
 Select * from interpra.employees as emp , interpra.salary_grade as sg
 where emp.salary between sg.min_sal and sg.max_sal
 and sg.grade in (2,3);
 /***6. From the following table, 
 write a SQL query to find those employees of grade 4 or 5 and who work as ANALYST or MANAGER. 
 Return complete information about the employees.**/
 Select * from interpra.employees as emp, interpra.salary_grade as sg
 where (emp.job_name = 'ANALYST' or emp.job_name='MANAGER')
 and emp.salary between sg.min_sal and sg.max_sal
 and (sg.grade =4 or sg.grade = 5);
 
 /******7. From the following table, 
 write a SQL query to find those employees whose salary is more than the salary of JONAS. 
 Return complete information about the employees.******/
 
 Select * from interpra.employees as emp
 where emp.salary >
 (select emp1.salary from interpra.employees as emp1
 where emp1.emp_name = 'JONAS');
 
 /*******8. From the following table, 
 write a SQL query to find those employees who work as same designation of FRANK. 
 Return complete information about the employees.*****/
 
 Select * from interpra.employees as emp
 where emp.job_name in 
 (Select emp1.job_name from interpra.employees as emp1
 where emp1.emp_name = 'FRANK');
 
 /****9. From the following table,
 write a SQL query to find those employees who are senior to ADELYN. 
 Return complete information about the employees.******/
 
 
 Select * from interpra.employees as emp
 where emp.hire_date <
 (Select emp1.hire_date from interpra.employees as emp1
 where emp1.emp_name = 'ADELYN' );
 
 
 
 
 
 
 
 
 