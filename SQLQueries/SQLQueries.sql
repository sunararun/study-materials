/**1. From the following table, write a SQL query to find the managers.
 Return complete information about the managers**/
SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.emp_id IN (SELECT 
            manager.manager_id
        FROM
            interpra.employees AS manager);
 /**2. From the following table, 
 write a SQL query to compute the experience of all the managers. 
 Return employee ID, employee name, job name, joining date, and experience.**/
 
SELECT 
    emp.emp_id,
    emp.emp_name,
    emp.job_name,
    emp.hire_date,
    (DATEDIFF(NOW(), hire_date)) / 365 Experience
FROM
    interpra.employees AS emp
WHERE
    emp.emp_id IN (SELECT 
            manager.manager_id
        FROM
            interpra.employees AS manager);
 
/****** 3. From the following table, 
write a SQL query to find those employees who work as 'MANAGERS' and 'ANALYST' and working in ‘SYDNEY’ or ‘PERTH’ 
with an experience more than 5 years without receiving the commission. 
Sort the result-set in ascending order by department location. 
Return employee ID, employee name, salary, and department name.*****/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.job_name IN ('MANAGER' , 'ANALYST')
        AND emp.dep_id IN (SELECT 
            dept.dep_id
        FROM
            interpra.department AS dept
        WHERE
            dept.dep_location IN ('SYDNEY' , 'PERTH'))
        AND (DATEDIFF(NOW(), emp.hire_date)) / 365 > 5
        AND emp.commission = 0.00;
        /**From the following tables, 
write a SQL query to find those employees work at SYDNEY or working in the FINANCE department with an annual salary above 28000, 
but the monthly salary should not be 3000 or 2800 and who do not work as a MANAGER and whose ID contain a digit of '3' or '7' in 3rd position. 
Sort the result-set in ascending order by department ID and descending order by job name. 
Return employee ID, employee name, salary, department name, department location, department ID, and job name.**/
SELECT 
    emp.emp_id,
    emp.emp_name,
    emp.salary,
    emp.job_name,
    dept.dep_name,
    dept.dep_location,
    dept.dep_id
FROM
    interpra.employees AS emp,
    interpra.department AS dept
WHERE
    (dept.dep_location = 'SYDNEY'
        OR dept.dep_name = 'FINANCE')
        AND emp.emp_id IN (SELECT 
            emp1.emp_id
        FROM
            interpra.employees AS emp1
        WHERE
            (12 * emp1.salary) > 28000
                AND emp1.job_name != 'MANAGER')
        AND (emp.emp_id LIKE '__3%'
        OR emp.emp_id LIKE '__7%');
       
/****5. From the following table, write a SQL query to find the employees of grade 2 and 3.
Return all the information of employees and salary details.****/

SELECT 
    emp.*
FROM
    interpra.employees AS emp,
    interpra.salary_grade AS sal
WHERE
    emp.salary BETWEEN sal.min_sal AND sal.max_sal
        AND sal.grade IN (2 , 3)From the following table,
 write a SQL query to find those employees of grade 4 or 5 and who work as ANALYST or MANAGER. 
Return complete information about the employees.**/

Select emp.* from interpra.employees as emp, interpra.salary_grade as sal
where emp.salary between sal.min_sal and sal.max_sal
and  (sal.grade =4 or sal.grade = 5)
and ( emp.job_name = 'ANALYST' or  emp.job_name = 'MANAGER');

/**7. From the following table,
 write a SQL query to find those employees whose salary is more than the salary of JONAS. 
Return complete information about the employees.**/
SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.salary > (SELECT 
            emp1.salary
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.emp_name = 'JONAS');
/**8. From the following table,
 write a SQL query to find those employees who work as same designation of FRANK.
 Return complete information about the employees.****/
 
 SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.job_name IN (SELECT 
            emp1.job_name
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.emp_name = 'FRANK');
/****9. From the following table,
 write a SQL query to find those employees who are senior to ADELYN. 
Return complete information about the employees.**/

SELECT 
    *
FROM
    interpra.employees AS emp
WHERE
    emp.hire_date < (SELECT 
            emp1.hire_date
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.emp_name = 'ADELYN');
/***10. From the following table,
 write a SQL query to find those employees of department ID 2001 
 and whose designation is same as of the designation of department ID 1001. 
Return complete information about the employees.******/

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

/***11. From the following table, 
write a SQL query to find those employees whose salary is the same as the salary of FRANK or SANDRINE. 
Sort the result-set in descending order by salary. 
Return complete information about the employees.****/

Select * from interpra.employees as emp
where emp.salary in 
(Select emp2.salary from interpra.employees as emp2
where (emp2.emp_name = 'FRANK' or emp2.emp_name = 'SANDRINE') 
and emp.emp_id != emp2.emp_id);

/****12. From the following table, 
write a SQL query to find those employees whose designation are the same as the designation of MARKER or salary is more than the salary of ADELYN. 
Return complete information about the employees.*****/

Select * from interpra.employees as emp
where emp.job_name in (
Select emp1.job_name from interpra.employees as emp1
where emp1.emp_name = 'MARKER')
or emp.salary> (
Select emp2.salary from interpra.employees as emp2
where emp2.emp_name = 'ADELYN');

/****13. From the following table,
 write a SQL query to find those employees whose salary is more than the total remuneration (salary + commission) of the designation SALESMAN. 
Return complete information about the employees.*****/

Select * from interpra.employees as emp
where emp.salary> (
Select max(emp1.commission+emp1.salary) from interpra.employees as emp1
where emp1.job_name = 'SALESMAN');

/*****14. From the following table, 
write a SQL query to find those employees who are senior to BLAZE and working at PERTH or BRISBANE. 
Return complete information about the employees.****/

Select * from interpra.employees as emp
where emp.hire_date<(
Select emp1.hire_date from interpra.employees as emp1
where emp1.emp_name = 'BLAZE' )
and emp.dep_id in (

select dept.dep_id from interpra.department as dept
where(dept.dep_location = 'PERTH' or dept.dep_location = 'BRISBANE'));

/*****15. From the following tables,
 write a SQL query to find those employees of grade 3 and 4 and work in the department of FINANCE or AUDIT 
 and whose salary is more than the salary of ADELYN
 and experience is more than FRANK. 
Return complete information about the employees.*****/

Select * from interpra.employees as emp, interpra.salary_grade as sal
where emp.salary between sal.min_sal and sal.max_sal 
and sal.grade in (3,4)
and emp.dep_id in (
Select dept.dep_id from interpra.department as dept
where dept.dep_name in ( 'FINANCE' ,  'AUDIT'))
and emp.salary >
(Select emp1.salary from interpra.employees as emp1
where emp1.emp_name = 'ADELYN');

SELECT *
FROM interpra.employees e
WHERE e.dep_id IN
    (SELECT d.dep_id
     FROM interpra.department d
     WHERE d.dep_name IN ('FINANCE',
                          'AUDIT') )
  AND e.salary >
    (SELECT salary
     FROM interpra.employees
     WHERE emp_name = 'ADELYN')
  AND e.hire_date <
    (SELECT hire_date
     FROM interpra.employees
     WHERE emp_name = 'FRANK')
  AND e.emp_id IN
    (SELECT e.emp_id
     FROM interpra.employees e,
          interpra.salary_grade s
     WHERE e.salary BETWEEN s.min_sal AND s.max_sal
       AND s.grade IN (3,
                       4) )
ORDER BY e.hire_date ASC;

/***16. From the following table, 
write a SQL query to find those employees whose designation is same as the designation of SANDRINE or ADELYN. 
Return complete information about the employees. ****/

Select *  from interpra.employees as emp
where emp.job_name in (
Select emp1.job_name from interpra.employees as emp1
where (emp1.emp_name = 'SANDRINE' or emp1.emp_name = 'ADELYN'));

/**17. From the following table, 
write a SQL query to list any job of department ID 1001 which are not found in department ID 2001.
 Return job name.**/
 
 Select * from interpra.employees as emp
 where emp.dep_id = 1001 and emp.job_name not in (
 
 Select dept.job_name from interpra.employees as dept where dept.dep_id = 2001);
 /*****18. From the following table,
 write a SQL query to find the highest paid employee.
 Return complete information about the employees.*****/
 
 Select * from interpra.employees as emp
 where emp.salary =(
 Select max(emp1.salary) from interpra.employees as emp1);
 
 /***19. From the following table,
 write a SQL query to find the highest paid employees in the department MARKETING. 
 Return complete information about the employees.**/
 
 Select * from interpra.employees as empSal
 where empSal.salary =(
 Select max( emp.salary) from interpra.employees as emp, interpra.department as dept
 where emp.dep_id = dept.dep_id
 and dept.dep_name = 'MARKETING');
 
 /****20. From the following tables, 
 write a SQL query to find the employees of grade 3 who joined recently and location at PERTH.
 Return employee ID, employee name, job name, hire date, and salary. 
 ***/
 
 Select * from interpra.employees as emp
 where emp.dep_id in (Select dept.dep_id from interpra.department as dept where dept.dep_location = 'PERTH')
 and emp.hire_date in (
 Select max(emp1.hire_date) from interpra.employees as emp1, interpra.salary_grade as sg
 where emp1.salary between sg.min_sal and sg.max_sal
 and sg.grade = 3);
 
 /******21. From the following table, 
 write a SQL query to find those employees who are senior to recently hired employee and work under KAYLING. 
 Return complete information about the employees.**/
 
 Select * from interpra.employees as emp
 where emp.hire_date <(
 
 Select max(emp.hire_date) from interpra.employees as emp 
 where emp.manager_id in
 (Select emp1.emp_id from interpra.employees as emp1
 where emp1.emp_name = 'KAYLING'));
 
 /**22. From the following tables, 
 write a  SQL query to find those employees of grade 3 to 5 and location at SYDNEY.
 The employees are not in PRESIDENT designated and salary is more than the highest paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING. 
 Return complete information about the employees.***/
 
 Select * from interpra.employees as emp, interpra.salary_grade as sg
 where emp.job_name!='RRESID'
 and emp.salary between sg.min_sal and sg.max_sal
 and sg.grade in (3,4,5)
 and emp.dep_id in (
 select dept.dep_id from interpra.department as dept
 where dept.dep_location = 'SYDNEY')
  
 and emp.salary>(
 
 Select max(emp2.salary) from interpra.employees as emp2, interpra.department as dept
 where dept.dep_location = 'PERTH'
 and emp2.dep_id = dept.dep_id);
 
 Select * from interpra.employees as emp4
 where emp4.job_name in ('MANAGER' , 'SALESMAN')
 and emp4.manager_id not in(
 Select emp1.emp_id from interpra.employees as emp1
 where emp1.emp_name ='KAYLING');
 
 /**25. From the following table, 
 write a SQL query to find the most senior employee of grade 4 or 5, work under KAYLING.
 Return complete information about the employees.***/
 
 Select * from interpra.employees as emp 
 where emp.hire_date in(
 Select min(emp2.hire_date) from interpra.employees as emp2, interpra.salary_grade as sg
 where emp2.salary between sg.min_sal and sg.max_sal
 and sg.grade in (4,5))
 and emp.manager_id in (Select emp1.emp_id from interpra.employees as emp1 where emp1.emp_name ='KAYLING');
 
 /****26. From the following table, write a SQL query to compute the total salary of the designation MANAGER.
 Return total salary.***/
 Select sum(emp.salary) from interpra.employees as emp
 where emp.job_name = 'MANAGER';
 /****27. From the following table,
 write a SQL query to compute the total salary of employees of grade 3.
 Return total salary.****/
 
 Select sum(emp.salary) from interpra.employees as emp, interpra.salary_grade as sg
 where emp.salary between sg.min_sal and sg.max_sal
 and sg.grade = 3;
 
 /***28. From the following table, 
 write a SQL query to find those employees of department 1001 and whose salary is more than the average salary of employees in department 2001.
 Return complete information about the employees.****/
 
 Select * from interpra.employees as emp
 where emp.dep_id = 1001 and emp.salary> (
 Select avg(emp1.salary) from interpra.employees as emp1
 where emp1.dep_id =2001);
 /*29. From the following table, write a SQL query to find those departments where maximum number of employees work. 
 Return department ID, department name, location and number of employees.*/

/****30. From the following table, write a SQL query to find those employees whose manager is JONAS. 
Return complete information about the employees.*****/

Select * from interpra.employees as emp
where emp.manager_id =(
Select emp1.emp_id from interpra.employees as emp1
where emp1.emp_name = 'JONAS');

/*******31. From the following table,
 write a SQL query to find those employees who are not working in the department MARKETING. 
Return complete information about the employees.
****/

Select * from interpra.employees as emp
where emp.dep_id not in (
Select dept.dep_id from interpra.department as dept
where dept.dep_name = 'MARKETING');

/******32. From the following table, 
write a SQL query to find those employees who are working as a manager. 
Return employee name, job name, department name, and location.****/

Select * from interpra.employees as emp, interpra.department as dept
where emp.emp_id in(

select emp1.manager_id from interpra.employees as emp1)
and emp.dep_id = dept.dep_id;
/***33. From the following table, 
write a SQL query to find those employees who receive the highest salary of each department. 
Return employee name and department ID.*/

Select emp.dep_id, emp.emp_name from interpra.employees as emp
where emp.salary =(
Select max(emp1.salary) from interpra.employees as emp1
where emp.dep_id = emp1.dep_id);
/*******34. From the following table,
 write a SQL query to find those employees whose salary is equal or more to the average of maximum and minimum salary.
 Return complete information about the employees.******/
 
 Select * from interpra.employees as emp
 where emp.salary >(
 Select (max(emp1.salary) + min(emp1.salary))/2 from interpra.employees as emp1);

 /******35. From the following table, 
 write a  SQL query to find those managers whose salary is more than the average salary of his employees. 
 Return complete information about the employees.*******/
 
Select * from interpra.employees as m
where m.emp_id in (
Select emp1.manager_id from interpra.employees as emp1)
and m.salary >
(Select avg(emp.salary) from interpra.employees as emp
where m.emp_id = emp.manager_id);

/******36. From the following table,
 write a SQL query to find those employees whose salary is less than the salary of his manager but more than the salary of any other manager. 
Return complete information about the employees.*****/

SELECT 
    *
FROM
    interpra.employees AS emp,
    interpra.employees AS m
WHERE
    emp.manager_id = m.emp_id
        AND emp.salary < m.salary
        AND emp.salary > ANY (SELECT 
            emp1.salary
        FROM
            interpra.employees AS emp1
        WHERE
            emp1.emp_id IN (SELECT 
                    manager.manager_id
                FROM
                    interpra.employees AS manager));
/*****37. From the following table, write a SQL query to compute department wise average salary of employees.
 Return employee name, average salary, department ID as "Current Salary".****/

SELECT 
    e.emp_name, d.avgsal, e.dep_id AS 'Current Salary'
FROM
    interpra.employees e,
    (SELECT 
        AVG(salary) avgsal, dep_id
    FROM
        interpra.employees
    GROUP BY dep_id) d
WHERE
    e.dep_id = d.dep_id;

/**38. From the following table, write a  SQL query to find five lowest paid workers. 
Return complete information about the employees.***/
 
 SELECT *
FROM interpra. employees e
WHERE 5>
    (SELECT count(*)
     FROM interpra.employees
     WHERE e.salary >salary);
 
 /*******39. From the following table, write a SQL query to find those managers who are not working under the PRESIDENT.
 Return complete information about the employees.****/
 
 Select * from interpra.employees as emp
 where emp.emp_id in (Select m.manager_id from interpra.employees as m )
 and emp.manager_id NOT IN (Select emp1.emp_id from interpra.employees as emp1 where emp1.job_name = 'PRESID');
 
 
 SELECT *
FROM interpra.employees
WHERE emp_id IN
    (SELECT manager_id
     FROM interpra.employees)
  AND manager_id NOT IN
    (SELECT emp_id
     FROM interpra.employees
     WHERE job_name = 'PRESID');
     
 /***41. From the following tables, 
 write a SQL query to find those departments where the highest number of employees works. 
 Return department name.****/
 
select  d.dep_name,count(e.emp_name) as counts from interpra.employees e,interpra.department d where d.dep_id=e.dep_id
group by d.dep_name
order by counts desc limit 1;
 
 /****42. From the following table, 
 write a SQL query to find those employees who joined in the company on the same date.
 Return complete information about the employees.*****/
 
 Select * from interpra.employees as emp1
 where emp1.hire_date in 
 (Select emp2.hire_date from interpra.employees as emp2
 where emp1.emp_id<>emp2.emp_id);
 
 /****43. From the following table,
 write a SQL query to find those departments where more than average number of employees works.
 Return department name.*****/
 
 /****select  d.dep_name,avg(e.emp_id) as counts from interpra.employees e,interpra.department d where d.dep_id=e.dep_id
group by d.dep_name
-- order by counts desc limit 1; ***/
  
  SELECT 
    dept.dep_name
FROM
    interpra.employees AS emp,
    interpra.department AS dept
WHERE
    emp.dep_id = dept.dep_id
GROUP BY dept.dep_name
HAVING COUNT(*) > (SELECT 
        AVG(mycount)
    FROM
        (SELECT 
            COUNT(*) mycount
        FROM
            interpra.employees AS emp3
        GROUP BY emp3.dep_id) AS emp1);

/***44. From the following table, 
write a SQL query to find those managers who handle maximum number of employees. 
Return managers name, number of employees.****/

SELECT 
    mana.emp_name, COUNT(*)
FROM
    interpra.employees AS emp,
    interpra.employees AS mana
WHERE
    emp.manager_id = mana.emp_id
GROUP BY mana.emp_name
HAVING COUNT(*) = (SELECT 
        MAX(maxCount)
    FROM
        (SELECT 
            COUNT(*) AS maxCount
        FROM
            interpra.employees AS emp
        GROUP BY emp.manager_id) AS manager);
/********45. From the following table, 
write a SQL query to find those managers who receive less salary then the employees work under them.
 Return complete information about the employees.****/ 
 
 Select DISTINCT m.emp_name,
                m.salary from interpra.employees as emp, interpra.employees as m
 where emp.manager_id = m.emp_id
 and emp.salary>m.salary;
 
 SELECT DISTINCT m.emp_name,
                m.salary
FROM interpra.employees w,
    interpra. employees m
WHERE w.manager_id = m.emp_id
  AND w.salary>m.salary;
 
 /**********46. From the following table,
 write a SQL query to find those employees who are sub-ordinates of BLAZE.
 Return complete information about the employees.******/
 
 Select * from interpra.employees as emp
 where emp.manager_id in (
 Select emp1.emp_id from interpra.employees as emp1
 where emp1.emp_name = 'BLAZE');
 
 /********47. From the following table, write a SQL query to find those employees who work as managers.
 Return complete information about the employees. 
 Use co-related subquery.********/
 
 Select * from interpra.employees as emp
 where emp.emp_id in (
 Select manager.manager_id from interpra.employees as manager);
 
 /*******. From the following table, 
 write a SQL query to list the name of the employees for their manager JONAS 
 and the name of the manager of JONAS.******/
 
 Select emp.emp_name, mJ.emp_name as "manager_Jonas", manager.emp_name as "Jonas Manager"
 from interpra.employees as emp, interpra.employees as mJ, interpra.employees as manager
 where emp.manager_id = mJ.emp_id
 and mJ.emp_name = 'JONAS'
 and mJ.manager_id = manager.emp_id;
 
 /****49. From the following table, 
 write a SQL query to find those employees who receive minimum salary for a designation.
 Sort the result-set in ascending order by salary. 
 Return complete information about the employees.***/
 
 Select * from employees as emp
 where emp.salary in (
Select Min(emp.salary) from interpra.employees as emp
group by emp.job_name)
order by emp.salary asc;

/*****50. From the following table, 
write a SQL query to find those employees who receive maximum salary for a designation. 
Sort the result-set in descending order by salary.
 Return complete information about the employees.*****/
 
 Select * from interpra.employees as emp
 where emp.salary in (
 Select max(sal.salary) from interpra.employees as sal
 group by sal.job_name)
 order by emp.salary asc;
 
 /*****51. From the following table, 
 write a SQL query to find recently hired employees of every department. Sort the result-set in descending order by hire date. 
 Return complete information about the employees.****/
 
 Select * from interpra.employees as emp
 where emp.hire_date in (
 Select max(hdate.hire_date) from interpra.employees as hdate
 where emp.dep_id = hdate.dep_id)
 order by emp.hire_date desc;
 
 /****52. From the following table, 
 write a SQL query to find those employees who receive a salary higher than the average salary of their department.
 Sort the result-set in ascending order by department ID. 
 Return employee name, salary, and department ID.****/
 
 Select emp.emp_name, emp.salary, emp.dep_id from interpra.employees as emp
 where emp.salary >(
 Select avg(dept.salary) from interpra.employees as dept
 where emp.dep_id = dept.dep_id)
 order by emp.dep_id asc;
 /***53. From the following table, 
 write a SQL query to find those employees who earn a commission and receive maximum salary. 
 Return complete information about the employees.******/
 
 Select * from interpra.employees as emp
 where emp.salary in (Select max(emp1.salary) from interpra.employees as emp1  where emp1.commission<>0.00);
 /*****54. From the following table,
 write a SQL query to find those employees who do not work in the department 1001 
 but work in the same designation and salary as the employees in department 3001. 
 Return employee name, job name and salary.*****/
 Select * from interpra.employees as emp
 where (emp.salary, emp.job_name) in (
 
 Select emp.salary,emp.job_name from interpra.employees as emp
 where emp.dep_id = 3001)
 and emp.dep_id <>1001;
 /**55. From the following table, 
 write a SQL query to find those employees who get a commission percent and works as a SALESMAN and earn maximum net salary.
 Return department ID, name, designation, salary, and net salary (salary+ commission).**/
 
 Select * from interpra.employees as emp
 where emp.salary in (
 Select (emp1.salary+emp1.commission) as "net salary" from interpra.employees as emp1
 where emp.job_name ='SALESMAN');
/********57. From the following table, 
write a SQL query to find those departments 
where the average salary is less than the averages for all departments. 
Return department ID, average salary.********/

Select emp.dep_id, avg(emp.salary) from interpra.employees as emp
group by emp.dep_id
Having avg(emp.salary) < (Select avg(dept.salary) from interpra.employees as dept);

/*** 58. From the following tables, write a SQL query to find the unique department of the employees.
Return complete information about the employees.***/

Select  Distinct dept.dep_name, dept.dep_id, dept.dep_location from interpra.employees as emp, interpra.department as dept
where emp.dep_id = dept.dep_id;
/****59. From the following tables, write a SQL query to list the details of the employees working at PERTH**/

Select * from interpra.employees as emp, interpra.department as dept
where emp.dep_id = dept.dep_id
and dept.dep_location ='PERTH';
/****60. From the following tables, 
rite a  SQL query to list the employees of grade 2 or 3 and
 the department where he or she works, is located in the city PERTH.
 Return complete information about the employees**/
Select * from interpra.employees as emp, interpra.department as dept , interpra.salary_grade as sg
where emp.dep_id = dept.dep_id
and dept.dep_location ='PERTH'
and emp.salary between sg.min_sal and sg.max_sal
and sg.grade in (2,3);
/******61. From the following table,
 write a SQL query to find those employees whose designation is same as the designation of ADELYN or 
 the salary is more than the salary of WADE. 
Return complete information about the employees.****/

Select * from interpra.employees as emp
where emp.job_name in (
Select emp1.job_name from interpra.employees as emp1
where emp1.emp_name = 'ADELYN')
or emp.salary>(
Select emp2.salary from interpra.employees as emp2
where emp2.emp_name = 'WADE');
 
 /**63. From the following table, 
 write a SQL query to find those managers who are senior to KAYLING 
 and who are junior to SANDRINE.
 Return complete information about the employees.**/
 
 Select * from interpra.employees as mana
 where mana.emp_id in (
  Select emp.manager_id from interpra.employees as emp
  where emp.hire_date<(
 Select emp1.hire_date from interpra.employees as emp1
where emp1.emp_name = 'KAYLING')
 And emp.hire_date >(
Select emp2.hire_date from interpra.employees as emp2
where emp2.emp_name = 'SANDRINE'))
AND mana.manager_id <>0;

/****75. From the following table, write a SQL query to count the number of employees who work as a manager.
 Return number of employees.******/
 
 
 SELECT count(*)
FROM interpra.employees
WHERE emp_id IN
    (SELECT manager_id
     FROM interpra.employees);






