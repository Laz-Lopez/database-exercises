USE employees;
describe employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
-- 7 rows
SELECT DISTINCT title
FROM titles;
-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
-- 
SELECT DISTINCT last_name
from employees
where last_name like 'E%'
AND last_name like '%E';

SELECT last_name 
FROM employees
WHERE last_name like 'e%e'
GROUP BY last_name;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
-- 
SELECT concat(first_name,'  ',last_name) AS unique_combinations
FROM employees
WHERE last_name like 'e%e'
GROUP BY last_name, first_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- 
SELECT DISTINCT last_name 
FROM employees
WHERE last_name like '%q%' 
AND last_name NOT LIKE '%qu%';

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
-- 
SELECT last_name, COUNT(*) AS how_many
FROM employees
WHERE last_name like '%q%' 
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
HAVING how_many;
-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(Gender) 
	FROM employees
    WHERE first_name = 'Irena'
    or first_name ='Vidya'
    or first_name ='Maya'
    GROUP BY first_name, gender
;
    
-- Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT CONCAT(SUBSTR(LOWER(first_name), 1, 1),
SUBSTR(LOWER(last_name), 1, 4), "_", 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 3, 2))
AS username, COUNT(*)
FROM employees
group by username;
-- Bonus: More practice with aggregate functions:
-- 
-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
-- Determine how many different salaries each employee has had. This includes both historic and current.
-- Find the maximum salary for each employee.
-- Find the minimum salary for each employee.
-- Find the standard deviation of salaries for each employee.
-- Now find the max salary for each employee where that max salary is greater than $150,000.
-- Find the average salary for each employee where that average salary is between $80k and $90k.