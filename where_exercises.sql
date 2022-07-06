USE employees;
DESCRIBE employees;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT *
	FROM employees
    WHERE first_name IN ('Irena', 'Vidya', 'Maya');
    -- 709 rows
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT *
	FROM employees
    WHERE first_name = 'Irena'
    or first_name ='Vidya'
    or first_name ='Maya';
    -- same 709
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT *
	FROM employees
    WHERE gender = 'M'
    and (first_name = 'Irena'
    or first_name ='Vidya'
    or first_name ='Maya');
    -- 441 rows
-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT *
	FROM employees
    WHERE last_name like'E%' ;
    -- 7330 rows
-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT *
	FROM employees
    WHERE last_name like'E%' 
    or last_name like '%E';
    -- 30723 
SELECT *
	FROM employees
    WHERE last_name like '%E'
     AND last_name NOT LIKE 'e%';
-- 23393
-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
 SELECT *
	FROM employees
    WHERE last_name like '%E';
-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
 SELECT *
	FROM employees
    WHERE hire_date BETWEEN '1989-12-31' and '2000-01-01';
    -- 135296
-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT *
	FROM employees
    WHERE birth_date like '%-12-25';
    -- 842
-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT *
	FROM employees
    WHERE birth_date like '%-12-25'
    and hire_date BETWEEN '1989-12-31' and '2000-01-01';
    -- 362
-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
 SELECT *
	FROM employees
    WHERE last_name like '%q%';
    -- 1873
-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
 SELECT *
	FROM employees
    WHERE last_name like '%q%'
    AND last_name NOT LIKE '%qu%';
    -- 547