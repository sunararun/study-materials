/*1. From the following table, 
write a SQL query to find the managers. 
Return complete information about the managers.*/

SELECT 
    *
FROM
    interpra.employees AS mangr
WHERE
    mangr.emp_id IN (SELECT 
            emp.manager_id
        FROM
            interpra.employees AS emp);
/*
2. From the following table, 
write a SQL query to compute the experience of all the managers. 
Return employee ID, employee name, job name, joining date, and experience.
*/

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
            dept.job_name
        FROM
            interpra.employees AS dept
        WHERE
            dept.dep_id = 1001);

/*
17. From the following table, 
write a SQL query to list any job of department ID 1001 which are not found in department ID 2001.
 Return job name.
*/

SELECT 
    emp.job_name
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id = 1001
        AND emp.job_name NOT IN (SELECT 
            dept.job_name
        FROM
            interpra.employees AS dept
        WHERE
            dept.dep_id = 2001);
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
    emp.salary = (SELECT 
            MAX(emp1.salary)
        FROM
            interpra.employees AS emp1);
/*
23. From the following table, 
write a SQL query to find those employees who are senior employees as of year 1991. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp1
WHERE
    YEAR(emp1.hire_date) < 1991;

/*
24. From the following table, 
write a SQL query to find those employees who joined in 1991 in a designation 
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
            emp1.hire_date = (SELECT 
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
write a SQL query to find those employees of department 1001 
and whose salary is more than the average salary of employees in department 2001. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id = 1001
        AND emp.salary > ANY (SELECT 
            avg(emp1.salary)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 2001);

/*
29. From the following table, 
write a SQL query to find those departments where maximum number of employees work. 
Return department ID, department name, location and number of employees.
*/

SELECT 
    *
FROM
    interpra.department AS dept
WHERE
    dept.dep_id IN (SELECT 
            emp1.dep_id
        FROM
            interpra.employees AS emp1
        GROUP BY emp1.dep_id
        HAVING COUNT(*) = (SELECT 
                MAX(emp_count)
            FROM
                (SELECT 
                    COUNT(*) AS emp_count
                FROM
                    interpra.employees AS emp2
                GROUP BY emp2.dep_id) AS emp_max));
/*
32. From the following table, 
write a SQL query to find those employees who are working as a manager. 
Return employee name, job name, department name, and location.
*/

SELECT 
    mangr.emp_name,
    mangr.job_name,
    dept.dep_name,
    dept.dep_location
FROM
    interpra.employees AS mangr,
    interpra.department AS dept
WHERE
    dept.dep_id = mangr.dep_id
        AND mangr.emp_id IN (SELECT 
            emp.manager_id
        FROM
            interpra.employees AS emp);
/*
33. From the following table, 
write a SQL query to find those employees who receive the highest salary of each department. 
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
write a SQL query to find those employees whose salary 
is equal or more to the average of maximum and minimum salary. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary >= ANY (SELECT 
            (MAX(emp1.salary) + MIN(emp1.salary)) / 2
        FROM
            interpra.employees AS emp1);

/*
35. From the following table, 
write a  SQL query to find those managers whose salary is more than the average salary of his employees. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS mangr
WHERE
    mangr.salary > (SELECT 
            AVG(emp.salary)
        FROM
            interpra.employees AS emp
        WHERE
            mangr.emp_id = emp.manager_id);
/*
36. From the following table, 
write a SQL query to find those employees 
whose salary is less than the salary of his manager but more than the salary of any other manager. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary < ANY (SELECT 
            hisManagr.salary
        FROM
            interpra.employees AS hisManagr
        WHERE
            emp.manager_id = hisManagr.emp_id)
        AND emp.salary > ANY (SELECT 
            otrManagr.salary
        FROM
            interpra.employees AS otrManagr
        WHERE
            otrManagr.emp_id IN (SELECT 
                    man.manager_id
                FROM
                    interpra.employees AS man));

/*
37. From the following table, 
write a SQL query to compute department wise average salary of employees. 
Return employee name, average salary, department ID as "Current Salary".
*/

SELECT 
    emp.emp_name, emp.dep_id AS 'Current Salary', avg_sal
FROM
    interpra.employees AS emp,
    (SELECT 
        AVG(dept.salary) AS 'avg_sal', dept.dep_id
    FROM
        interpra.employees AS dept
    GROUP BY dept.dep_id) dept1
WHERE
    emp.dep_id = dept1.dep_id;
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
            emp.salary > emp1.salary);


/*
40. From the following table, 
write a SQL query to find those departments where the number of employees 
is equal to the number of characters in the department name. 
Return complete information about the department.
*/

SELECT 
    *
FROM
    interpra.department AS dept
WHERE
    LENGTH(dept.dep_name) = (SELECT 
            COUNT(*)
        FROM
            interpra.employees AS emp
        WHERE
            dept.dep_id = emp.dep_id);
/*
41. From the following tables, 
write a SQL query to find those departments where the highest number of employees works.
 Return department name.
*/

SELECT 
    dept.dep_name
FROM
    interpra.department AS dept
WHERE
    dept.dep_id IN (SELECT 
            emp.dep_id
        FROM
            interpra.employees AS emp
        GROUP BY emp.dep_id
        HAVING COUNT(*) IN (SELECT 
                MAX(emp_count)
            FROM
                (SELECT 
                    COUNT(*) AS emp_count
                FROM
                    interpra.employees AS emp1
                GROUP BY emp1.dep_id) aliasEmp));
/*
42. From the following table, 
write a SQL query to find those employees who joined in the company on the same date.
 Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.hire_date IN (SELECT 
            emp1.hire_date
        FROM
            interpra.employees AS emp1
        WHERE
            emp.emp_id != emp1.emp_id);
/*
43. From the following table, 
write a SQL query to find those departments where more than average number of employees works.
 Return department name.
*/

SELECT 
    dept.dep_name
FROM
    interpra.department AS dept
WHERE
    dept.dep_id IN (SELECT 
            emp.dep_id
        FROM
            interpra.employees AS emp
        GROUP BY emp.dep_id
        HAVING COUNT(*) > ANY (SELECT 
                AVG(avg_emp)
            FROM
                (SELECT 
                    COUNT(*) AS avg_emp
                FROM
                    interpra.employees AS emp1
                GROUP BY emp1.dep_id) empAvg));
/*
44. From the following table, 
write a SQL query to find those managers who handle maximum number of employees. 
Return managers name, number of employees.
*/

SELECT 
    mangr.emp_name, emp_count
FROM
    interpra.employees AS mangr,
    (SELECT 
        MAX(max_emp) AS emp_count
    FROM
        (SELECT 
        COUNT(*) AS max_emp
    FROM
        interpra.employees AS emp1
    GROUP BY emp1.manager_id) emp_max) emp_count1
WHERE
    mangr.emp_id IN (SELECT 
            emp.manager_id
        FROM
            interpra.employees AS emp
        GROUP BY emp.manager_id
        HAVING COUNT(*) IN (SELECT 
                MAX(max_emp)
            FROM
                (SELECT 
                    COUNT(*) AS max_emp
                FROM
                    interpra.employees AS emp1
                GROUP BY emp1.manager_id) emp_max));

/*
45. From the following table, 
write a SQL query to find those managers who receive less salary then the employees work under them.
 Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS manger
WHERE
    manger.salary < ANY (SELECT 
            emp.salary
        FROM
            interpra.employees AS emp
        WHERE
            emp.manager_id = manger.emp_id);

/*
48. From the following table, 
write a  SQL query to list the name of the employees for their manager JONAS
 and the name of the manager of JONAS.

*/

SELECT 
    emp.emp_name AS 'Under JONAS',
    jonasManager.emp_name AS 'Jonas as Manager',
    (SELECT 
            manager.emp_name
        FROM
            interpra.employees AS manager
        WHERE
            jonasManager.manager_id = manager.emp_id) AS 'jonas_manager'
FROM
    interpra.employees AS emp,
    interpra.employees AS jonasManager
WHERE
    emp.manager_id = jonasManager.emp_id
        AND jonasManager.emp_name = 'JONAS';

/*
49. From the following table, 
write a SQL query to find those employees who receive minimum salary for a designation.
 Sort the result-set in ascending order by salary. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary IN (SELECT 
            MIN(emp1.salary)
        FROM
            interpra.employees AS emp1
        GROUP BY emp1.job_name)
ORDER BY emp.salary ASC;

/*
50. From the following table, 
write a SQL query to find those employees who receive maximum salary for a designation. 
Sort the result-set in descending order by salary. 
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
            interpra.employees AS emp1
        GROUP BY emp1.job_name)
ORDER BY emp.salary DESC;

/*
51. From the following table, 
write a SQL query to find recently hired employees of every department. 
Sort the result-set in descending order by hire date. 
Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.hire_date IN (SELECT 
            MAX(emp1.hire_date)
        FROM
            interpra.employees AS emp1
        WHERE
            emp.dep_id = emp1.dep_id);
/*
52. From the following table, 
write a SQL query to find those employees who receive a salary higher 
than the average salary of their department. 
Sort the result-set in ascending order by department ID. 
Return employee name, salary, and department ID.


*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary > ANY (SELECT 
            AVG(emp1.salary)
        FROM
            interpra.employees AS emp1
        WHERE
            emp.dep_id = emp1.dep_id)
ORDER BY emp.dep_id ASC;

/*53. From the following table, 
write a SQL query to find those employees who earn a commission and receive maximum salary. 
Return complete information about the employees.*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary = (SELECT 
            MAX(emp1.salary)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.commission != 0.00);

/*
/*54. From the following table, 
write a SQL query to find those employees who do not work in the department 1001 
but work in the same designation and salary as the employees in department 3001.
 Return employee name, job name and salary.
 */

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.dep_id != 1001
        AND emp.salary = ANY (SELECT 
            emp1.salary
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 3001)
        AND emp.job_name = ANY (SELECT 
            emp2.job_name
        FROM
            interpra.employees AS emp2
        WHERE
            emp2.dep_id = 3001);

/*
55. From the following table, 
write a SQL query to find those employees who get a commission percent 
and works as a SALESMAN and earn maximum net salary.
Return department ID, name, designation, salary, and net salary (salary+ commission).
*/

SELECT 
    emp.dep_id, emp.emp_name, emp.job_name, emp.salary, (emp.salary + emp.commission) as "net salary"
FROM
    interpra.employees AS emp
WHERE
    emp.commission != 0.00
        AND (emp.salary + emp.commission) = (SELECT 
            MAX(emp1.salary + emp1.commission)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.job_name = 'SALESMAN');

/*
56. From the following table, 
write a SQL query to find those employees who gets a commission 
and earn the second highest net salary (salary + commission). 
Return department id, employee name, designation, salary, and net salary.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    2 - 1 = (SELECT 
            COUNT(DISTINCT (emp1.salary + emp1.commission))
        FROM
            interpra.employees emp1
        WHERE
            (emp.salary + emp.commission) > (emp1.salary + emp1.commission)
                AND emp1.commission != 0.00
                AND emp.commission != 0.00);
/*
57. From the following table, 
write a SQL query to find those departments where the average salary is less than the averages for all departments. 
Return department ID, average salary.
*/

SELECT 
    emp.dep_id, AVG(emp.salary)
FROM
    interpra.employees AS emp
GROUP BY emp.dep_id
HAVING AVG(emp.salary) < (SELECT 
        AVG(emp1.salary)
    FROM
        interpra.employees AS emp1);

/*
58. From the following tables, 
write a SQL query to find the unique department of the employees. 
Return complete information about the department.
*/

SELECT 
    *
FROM
    interpra.department AS dept
WHERE
    dept.dep_id IN (SELECT 
            emp.dep_id
        FROM
            interpra.employees AS emp
        WHERE
            dept.dep_id = emp.dep_id);
/*
67. From the following tables, 
write a SQL query to find those employees whose salary is same as any one of the employee.
 Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary = ANY (SELECT 
            emp1.salary
        FROM
            interpra.employees AS emp1
        WHERE
            emp.emp_id != emp1.emp_id);

/*
69. From the following table, 
write a SQL query to find the recently hired employees of department 3001.
 Return complete information about the employees.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.hire_date IN (SELECT 
            MAX(emp1.hire_date)
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.dep_id = 3001);

/*
72. From the following table,
 write a  SQL query to find those employees whose net pay are higher than 
 or equal to the salary of any other employee in the company. 
Return employee name, salary, and commission.
*/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    (emp.commission + emp.salary) > ANY (SELECT 
            emp1.salary
        FROM
            interpra.employees AS emp1
        WHERE
            emp.emp_id != emp1.emp_id);

/*
75. From the following table, 
write a SQL query to count the number of employees who work as a manager.
 Return number of employees.
*/


SELECT 
    COUNT(*)
FROM
    interpra.employees AS mangr
WHERE
    mangr.emp_id IN (SELECT 
            emp.manager_id
        FROM
            interpra.employees AS emp);





