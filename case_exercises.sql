
use employees;
SHOW TABLES;
DESCRIBE dept_emp;


-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.


SELECT concat(first_name, ' ', last_name) as 'Employee Name', de.dept_no, from_date, to_date,
IF (to_date > NOW(), TRUE, FALSE) AS is_current_employee
FROM employees 
JOIN dept_emp
USING(emp_no)
GROUP BY dept_no, last_name, first_name, to_date, from_date;


-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name, de.dept_no, from_date, to_date,
CASE
WHEN SUBSTRING(last_name, 1,1) BETWEEN 'A' AND 'H' THEN 'A-H'
WHEN SUBSTRING(last_name, 1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
WHEN SUBSTRING(last_name, 1,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
END AS Alpha_Group
FROM employees 
JOIN dept_emp 
USING(emp_no)
GROUP BY dept_no, last_name, first_name, to_date, from_date
ORDER BY last_name, first_name;
SELECT first_name, last_name, birth_date, 
CASE
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1930 AND 1939 THEN '1930s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1940 AND 1940 THEN '1940s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1950 AND 1959 THEN '1950s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1960 AND 1969 THEN '1960s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1970 AND 1979 THEN '1970s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1980 AND 1989 THEN '1980s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 1990 AND 1999 THEN '1990s'
WHEN SUBSTRING(birth_date, 1,4) BETWEEN 2000 AND 2009 THEN '2000s'
END AS 'Birth Decade'
FROM employees
GROUP BY last_name, first_name, birth_date
ORDER BY birth_date, last_name, first_name;
-- How many employees (current or previous) were born in each decade?
-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT CONCAT(first_name, ' ', last_name),
    CASE
        WHEN departments.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN departments.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN departments.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN departments.dept_name IN ('Finance', 'Human Resources') THEN 'Finanace & HR'
        ELSE departments.dept_name
    END AS dept_group, salary
FROM departments
JOIN dept_emp  USING (dept_no)
JOIN salaries USING (emp_no)
JOIN employees USING (emp_no)
WHERE salaries.to_date > NOW() AND dept_emp.to_date > NOW()
ORDER BY dept_name, salary;