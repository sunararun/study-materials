/*
From the following table, 
write a  SQL query to find those employees whose salary matches the lowest salary of any of the departments. 
Return first name, last name and department ID.
*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    emp.SALARY IN (SELECT 
            MIN(emp1.salary)
        FROM
            sqlpractise.employees AS emp1
        GROUP BY emp1.DEPARTMENT_ID);

/*
From the following table, 
write a  SQL query to find those employees who earn more than the average salary. 
Return employee ID, first name, last name.
*/

Select * from sqlpractise.employees as emp
where emp.SALARY >(

Select avg(emp1.SALARY) from sqlpractise.employees as emp1);

/*
12. From the following table, 
write a  SQL query to find those employees who get second-highest salary. 
Return all the fields of the employees.
*/

SELECT 
    *
FROM
    sqlpractise.employees AS emp
WHERE
    2 - 1 = (SELECT 
            COUNT(DISTINCT emp1.SALARY)
        FROM
            sqlpractise.employees AS emp1
        WHERE
            emp1.SALARY > emp.SALARY);
/*
20. From the following table, 
write a  SQL query to find those employees whose salaries are higher than the average for all departments. 
Return employee ID, first name, last name, job ID.
*/















