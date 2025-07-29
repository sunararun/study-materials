/*
1. From the following table, 
write a SQL query to find the managers. 
Return complete information about the managers.
*/
SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.emp_id IN (SELECT 
            mngr.manager_id
        FROM
            interpra.employees AS mngr);



/*
10. From the following table, 
write a SQL query to find those employees of department ID 2001 
and whose designation is same as of the designation of department ID 1001. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id = 2001
        AND emp.job_name IN (SELECT 
            emp1.job_name
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 1001);


/*
17. From the following table, 
write a SQL query to list any job of department ID 1001 
which are not found in department ID 2001. 
Return job name.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id = 1001
        AND emp.job_name NOT IN (SELECT 
            emp1.job_name
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 2001);


/*
18. From the following table, 
write a SQL query to find the highest paid employee. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary IN (SELECT 
            MAX(emp1.salary)
        FROM
            interpra.employees AS emp1);


/*
23. From the following table, 
write a SQL query to find those employees 
who are senior employees as of year 1991. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.hire_date IN (SELECT 
            MIN(emp1.hire_date)
        FROM
            interpra.employees AS emp1
        WHERE
            YEAR(emp1.hire_date) = 1991);

/*
24. From the following table, 
write a SQL query to find those employees 
who joined in 1991 in a designation 
same as the most senior person of the year 1991. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    YEAR(emp.hire_date) = 1991
        AND emp.job_name IN (SELECT 
            emp1.job_name
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.hire_date IN (SELECT 
                    MIN(emp2.hire_date)
                FROM
                    interpra.employees AS emp2
                WHERE
                    YEAR(emp2.hire_date) = 1991));



/*
26. From the following table, 
write a SQL query to compute the total salary of the designation MANAGER. 
Return total salary.
*/

SELECT 
    SUM(emp.salary)
FROM
    interpra.employees AS emp
WHERE
    emp.job_name = 'MANAGER';


/*
28. From the following table, 
write a SQL query to find those employees of department 1001 and 
whose salary is more than the average salary of employees in department 2001. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id = 1001
        AND emp.salary > (SELECT 
            AVG(emp1.salary)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 2001);

/*
29. From the following table, 
write a SQL query to find those departments 
where maximum number of employees work. 
Return department ID, department name, location and number of employees.
*/

SELECT 
    dept.dep_id, dept.dep_name, dept.dep_location, COUNT(*)
FROM
    interpra.employees AS emp,
    interpra.department AS dept
WHERE
    dept.dep_id = emp.dep_id
GROUP BY emp.dep_id
HAVING COUNT(*) IN (SELECT 
        MAX(emp_count)
    FROM
        (SELECT 
            COUNT(*) AS emp_count
        FROM
            interpra.employees AS emp1
        GROUP BY emp1.dep_id) empCount);


/*
33. From the following table, 
write a SQL query to find those employees 
who receive the highest salary of each department. 
Return employee name and department ID.
*/

SELECT 
    emp.emp_name, emp.dep_id
FROM
    interpra.employees AS emp
WHERE
    emp.salary IN (SELECT 
            MAX(emp1.salary)
        FROM
            interpra.employees AS emp1
        GROUP BY emp1.dep_id);


/*
34. From the following table, 
write a SQL query to find those employees 
whose salary is equal or more to the average of maximum and minimum salary. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary >= ANY (SELECT 
            (MIN(emp1.salary) + MAX(emp1.salary)) / 2
        FROM
            interpra.employees AS emp1);

/*
35. From the following table, 
write a SQL query to find those managers 
whose salary is more than the average salary of his employees. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS mngr
WHERE
    mngr.salary > ANY (SELECT 
            AVG(emp.salary)
        FROM
            interpra.employees AS emp
        WHERE
            emp.manager_id = mngr.emp_id);


/*
36. From the following table, 
write a SQL query to find those employees 
whose salary is less than the salary of his manager 
but more than the salary of any other manager. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary < ANY (SELECT 
            hisMngr.salary
        FROM
            interpra.employees AS hisMngr
        WHERE
            emp.manager_id = hisMngr.emp_id)
        AND emp.salary > ANY (SELECT 
            otrMngr.salary
        FROM
            interpra.employees AS otrMngr
        WHERE
            otrMngr.emp_id IN (SELECT 
                    emp1.manager_id
                FROM
                    interpra.employees AS emp1));



/*
37. From the following table, 
write a SQL query to compute department wise average salary of employees. 
Return employee name, average salary, department ID as "Current Salary".
*/

SELECT 
    emp.emp_name,
    AVG(emp.salary),
    emp.dep_id AS 'Current Salary'
FROM
    interpra.employees AS emp,
    interpra.department AS dept
WHERE
    emp.dep_id = dept.dep_id
GROUP BY emp.dep_id , emp.emp_name;



/*
38. From the following table, 
write a SQL query to find five lowest paid workers. 
Return complete information about the employees.
*/
SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    5 > (SELECT 
            COUNT(*)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.salary > emp.salary);



/*
40. From the following table, 
write a SQL query to find those departments 
where the number of employees is equal to the 
number of characters in the department name. 
Return complete information about the department.
*/

Select * from interpra.department as dept
where length(dept.dep_name) in 
(Select count(*) from interpra.employees as emp
group by emp.dep_id);


/*
41. From the following tables, 
write a SQL query to find those departments 
where the highest number of employees works. 
Return department name.
*/



/*
42. From the following table, 
write a SQL query to find those employees 
who joined in the company on the same date. 
Return complete information about the employees.
*/





/*
43. From the following table, 
write a SQL query to find those departments 
where more than average number of employees works. 
Return department name.
*/



/*
44. From the following table, 
write a SQL query to find those managers 
who handle maximum number of employees. 
Return managers name, number of employees.
*/



/*
45. From the following table, 
write a SQL query to find those managers 
who receive less salary then the employees work under them. 
Return complete information about the employees.
*/




/*
49. From the following table, 
write a SQL query to find those employees 
who receive minimum salary for a designation. 
Sort the result-set in ascending order by salary. 
Return complete information about the employees.
*/




/*
50. From the following table, 
write a SQL query to find those employees 
who receive maximum salary for a designation. 
Sort the result-set in descending order by salary. 
Return complete information about the employees.
*/




/*
51. From the following table, 
write a SQL query to find recently hired employees of every department. 
Sort the result-set in descending order by hire date. 
Return complete information about the employees.
*/





/*
52. From the following table,
write a SQL query to find those employees 
who receive a salary higher than 
the average salary of their department. 
Sort the result-set in ascending order by department ID. 
Return employee name, salary, and department ID.
*/






/*
53. From the following table, 
write a SQL query to find those employees 
who earn a commission and receive maximum salary. 
Return complete information about the employees.
*/





/*
54. From the following table, 
write a SQL query to find those employees 
who do not work in the department 1001 
but work in the same designation and 
salary as the employees in department 3001. 
Return employee name, job name and salary.
*/




/*
55. From the following table, 
write a SQL query to find those employees 
who get a commission percent and 
works as a SALESMAN and 
earn maximum net salary. 
Return department ID, name, designation, salary, and net salary (salary+ commission).
*/




/*
56. From the following table, 
write a SQL query to find those employees 
who gets a commission and 
earn the second highest net salary (salary + commission). 
Return department id, employee name, designation, salary, and net salary.
*/




/*
57. From the following table, 
write a SQL query to find those departments 
where the average salary is less than the averages for all departments. 
Return department ID, average salary.
*/




/*
67. From the following tables, 
write a SQL query to find those employees 
whose salary is same as any one of the employee. 
Return complete information about the employees.
*/






/*
72. From the following table, 
write a SQL query to find those employees 
whose net pay are higher than or equal to the salary of any other employee in the company. 
Return employee name, salary, and commission.
*/




/*
73. From the following table, 
write a SQL query to find those employees 
whose salaries are greater than the salaries of their managers. 
Return complete information about the employees.
*/




/*
75. From the following table, 
write a SQL query to count the number of employees who work as a manager. 
Return number of employees.
*/


/*
To compute the average salary for each department, you can use the following SQL query:
*/

/*
76. From the following table, 
write a SQL query to find those departments 
where no employee works. 
Return department ID.
*/
