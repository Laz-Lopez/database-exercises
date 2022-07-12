USE employees;

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, hire_date, emp_no
FROM employees
JOIN salaries using (emp_no)
WHERE hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
)

and salaries.to_date > CURDATE()
;


-- Find all the titles ever held by all current employees with the first name Aamod.

SELECT g.first_name, g.last_name, titles.title
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'aamod'
    ) as g
JOIN titles ON g.emp_no = titles.emp_no
WHERE to_date > CURDATE();


-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

select count(*) as "No longer working" from employees
where emp_no not in (SELECT emp_no FROM salaries WHERE to_date > NOW());
-- 59900
-- Find all the current department managers that are female. List their names in a comment in your code.

SELECT g.first_name, g.last_name,g.gender, titles.title
FROM
    (
        SELECT *
        FROM employees
        WHERE gender = 'f'
    ) as g
JOIN titles ON g.emp_no = titles.emp_no
WHERE titles.title = 'manager'
and titles.to_date > CURDATE();

-- ISAMU, KARSTEN, LEON, Hilary
-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
Select first_name, last_name, emp_no, salaries.salary
FROM employees
JOIN salaries using (emp_no)
Where salary>
(SELECT round(avg(salary)) AS Average
FROM salaries)
AND salaries.to_date > CURDATE();




-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

SELECT STDDEV(salary)
from salaries
WHERE to_date > CURDATE();


select max(salary)
from salaries
where to_date > CURDATE()
;

SELECT
(
SELECT COUNT(*)
FROM salaries
WHERE salary > 
(
SELECT MAX(salary) 
FROM salaries 
WHERE to_date >= NOW()
)
 - 
(
SELECT STDDEV(salary) 
FROM salaries 
WHERE to_date >= NOW()
) 
AND to_date >= NOW()
)
/
(
SELECT COUNT(*)
FROM salaries
WHERE to_date >= NOW()
)
*100;



Select count(*)
from salaries 
where salary > 140910
and to_date > CURDATE();