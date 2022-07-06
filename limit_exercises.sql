USE employees;
DESCRIBE employees;

SELECT DISTINCT title FROM titles;


--  List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name
FROM employees
limit 10
;
-- 
-- Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
SELECT *
	FROM employees
    WHERE birth_date like '%-12-25'
    and hire_date BETWEEN '1989-12-31' and '2000-01-01'
    ORDER BY hire_date
    limit 5;
-- 'Alselm','Cappello','1990-01-01'
-- 'Utz','Mandell','1990-01-03'
-- 'Bouchung','Schreiter','1990-01-04'
-- 'Baocai','Kushner','1990-01-05'
-- 'Petter','Stroustrup','1990-01-10'

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
SELECT *
	FROM employees
    WHERE birth_date like '%-12-25'
    and hire_date BETWEEN '1989-12-31' and '2000-01-01'
    ORDER BY hire_date
    limit 5
    OFFSET 50;
-- 'Christophe','Baca','1990-08-11'
-- 'Moie','Birsak','1990-08-11'
-- 'Chikako','Ibel','1990-08-12'
-- 'Shounak','Jansen','1990-08-13'
-- 'Zhigen','Boissier','1990-08-18'

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- limit sets the page size(quantity) where the offset determins which page you start