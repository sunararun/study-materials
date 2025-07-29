SELECT * FROM sqlpractise.employees;
/*1. From the following table, 
write a SQL query to find those employees who receive a higher salary than the employee with ID 163. 
Return first name, last name.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY > (SELECT 
            emp1.SALARY
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.EMPLOYEE_ID = 163);


/*2. From the following table, 
write a  SQL query to find out which employees have the same designation as the employee whose ID is 169. 
Return first name, last name, department ID and job ID.*/

SELECT 
    emp.FIRST_NAME, emp.LAST_NAME, emp.DEPARTMENT_ID, emp.JOB_ID
FROM
    sqlpractise.employees AS emp
WHERE
    emp.JOB_ID IN (SELECT 
            emp1.JOB_ID
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.EMPLOYEE_ID = 169);

/*3. From the following table, 
write a  SQL query to find those employees whose salary matches the lowest salary of any of the departments. 
Return first name, last name and department ID.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY = ANY (SELECT 
            MIN(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        GROUP BY emp1.DEPARTMENT_ID);
/* From the following table, 
write a  SQL query to find those employees who earn more than the average salary. 
Return employee ID, first name, last name.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY > (SELECT 
            AVG(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1);

/*5. From the following table, 
write a  SQL query to find those employees who report to that manager whose first name is ‘Payam’. 
Return first name, last name, employee ID and salary.*/

SELECT 
    emp.FIRST_NAME, emp.LAST_NAME, emp.EMPLOYEE_ID, emp.SALARY
FROM
    sqlpractise.employees AS emp
WHERE
    emp.MANAGER_ID IN (SELECT 
            emp1.EMPLOYEE_ID
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.FIRST_NAME = 'Payam');

/*6. From the following tables, 
write a  SQL query to find all those employees who work in the Finance department.
 Return department ID, name (first), job ID and department name.*/
 
SELECT 
    emp.DEPARTMENT_ID,
    emp.FIRST_NAME,
    emp.JOB_ID,
    dept.DEPARTMENT_NAME
FROM
    sqlpractise.employees AS emp,
    sqlpractise.department AS dept
WHERE
    emp.DEPARTMENT_ID = dept.DEPARTMENT_ID
        AND dept.DEPARTMENT_NAME = 'FINANCE';
/*7. From the following table, 
write a  SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. 
Return all fields.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY = 3000
        AND emp.MANAGER_ID = 121;

/*8. From the following table, 
write a  SQL query to find those employees whose ID matches any of the numbers 134, 159 and 183.
 Return all the fields.  */
 
 Select * from sqlpractise.employees as emp
 where emp.EMPLOYEE_ID in (134,159,183);

/*9. From the following table,
 write a  SQL query to find those employees whose salary is in the range of 1000, and 3000 (Begin and end values have included.).
 Return all the fields.*/
 
 Select * from sqlpractise.employees as emp
 where emp.SALARY between 1000 and 3000;

/*10. From the following table and
 write a  SQL query to find those employees whose salary falls within the range of the smallest salary and 2500. 
Return all the fields.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY BETWEEN (SELECT 
            MIN(emp1.salary)
        FROM
            sqlpractise.employees AS emp1) AND 2500;
/*11. From the following tables, 
write a  SQL query to find those employees who do not work in the departments where managers’ IDs are between 100 and 200 (Begin and end values are included.).
 Return all the fields of the employeess.*/
 
 SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.DEPARTMENT_ID IN (SELECT 
            emp1.DEPARTMENT_ID
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.MANAGER_ID BETWEEN 100 AND 200);

/*12. From the following table, 
write a  SQL query to find those employees who get second-highest salary. 
Return all the fields of the employees.*/
SELECT 
    *
FROM
    sqlpractise.employees AS emp3
WHERE
    emp3.SALARY = (SELECT 
            MAX(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.SALARY < (SELECT 
                    MAX(emp2.SALARY)
                FROM
                    sqlpractise.employees AS emp2));
/*20. From the following table, 
write a  SQL query to find those employees whose salaries are higher than the average for all departments. 
Return employee ID, first name, last name, job ID.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY > ANY (SELECT 
            AVG(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        GROUP BY emp1.DEPARTMENT_ID);
/*22. From the following table,
 write a  SQL query to calculate total salary of the departments where at least one employee works.
 Return department ID, total salary.*/
 
SELECT 
    dept.DEPARTMENT_ID, total_salary
FROM
    sqlpractise.department AS dept,
    (SELECT 
        emp.DEPARTMENT_ID, SUM(emp.SALARY) AS total_salary
    FROM
        sqlpractise.employees AS emp
    GROUP BY emp.DEPARTMENT_ID) emp_tbl
WHERE
    emp_tbl.DEPARTMENT_ID = dept.DEPARTMENT_ID;

/*24. 
Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column
 with a title HIGH and LOW respectively for those employees whose salary is more than 
 and less than the average salary of all employees.*/
 
-- Selecting specific columns (employee_id, first_name, last_name, salary, SalaryStatus) from the 'employees' table
SELECT  employee_id,  first_name, last_name, salary,  

  -- Using the CASE statement to create a new column 'SalaryStatus' based on the comparison of 'salary' with the average salary in the 'employees' table
  CASE WHEN salary >= (SELECT AVG(salary) FROM employees) THEN 'HIGH'  
       ELSE 'LOW'  
  END AS SalaryStatus 

-- From the 'employees' table
FROM employees;

/*26. From the following table, 
write a SQL query to find all those departments where at least one employee is employed.
 Return department name.*/
 
 SELECT 
    dept.DEPARTMENT_NAME
FROM
    sqlpractise.department AS dept
WHERE
    dept.DEPARTMENT_ID IN (SELECT DISTINCT
            (emp.DEPARTMENT_ID)
        FROM
            sqlpractise.employees AS emp);

/*31. From the following tables, 
write a SQL query to find those employees whose salaries exceed 50% of their department's total salary bill. 
Return first name, last name.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY > (SELECT 
            SUM(emp1.SALARY) * 0.5
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp.DEPARTMENT_ID = emp1.DEPARTMENT_ID);
/*32. From the following tables, write a SQL query to find those employees who are managers. 
Return all the fields of employees table.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.EMPLOYEE_ID IN (SELECT 
            emp1.MANAGER_ID
        FROM
            sqlpractise.employees AS emp1);
		
/*33. From the following table,
 write a SQL query to find those employees who manage a department. 
Return all the fields of employees table.*/
SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.EMPLOYEE_ID IN (SELECT 
            dept.MANAGER_ID
        FROM
            sqlpractise.department AS dept);

/*36. From the following table,
 write a SQL query to find those employees who earn more than the average salary. 
 Sort the result-set in descending order by salary. 
Return first name, last name, salary, and department ID.*/

SELECT 
    emp.FIRST_NAME, emp.LAST_NAME,emp.SALARY, emp.DEPARTMENT_ID
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY > (SELECT 
            AVG(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1)
ORDER BY emp.SALARY DESC;

/*50. From the following table,
 write a SQL query to find those managers who supervise four or more employees. 
Return manager name, department ID.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.EMPLOYEE_ID IN (SELECT 
            emp1.MANAGER_ID
        FROM
            sqlpractise.employees AS emp1
        GROUP BY emp1.MANAGER_ID
        HAVING COUNT(*) >= 4);
/*52. From the following table, 
write a SQL query to find those employees who earn the second-lowest salary of all the employees.
 Return all the fields of employees.*/
 
 SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY IN (SELECT 
            MAX(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.SALARY < (SELECT 
                    MAX(emp2.SALARY)
                FROM
                    sqlpractise.employees AS emp2));
/*54. From the following table,
 write a SQL query to find those employees who earn the highest salary in a department. 
Return department ID, employee name, and salary.*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY = (SELECT 
            MAX(emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp.DEPARTMENT_ID = emp1.DEPARTMENT_ID);
















































