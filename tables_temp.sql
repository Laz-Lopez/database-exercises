-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.





USE leavitt_1860;
ALTER TABLE employees_with_departments 
DROP dept_no, 
DROP emp_no, 
DROP birth_date, 
drop gender, 
drop hire_date, 
drop from_date, 
drop to_date;
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
SHOW CREATE TABLE employees_with_departments;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
ALTER TABLE employees_with_departments
drop first_name,
drop last_name;

-- What is another way you could have ended up with this same table?
SELECT full_name AS 'Full Name', dept_name AS 'Department'
FROM employees_with_departments
ORDER BY dept_name, full_name
LIMIT 20;


-- create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

CREATE temporary TABLE payment_copy AS
SELECT * , amount * 100 as amount_in_pennies from sakila.payment;
ALTER TABLE payment_copy DROP amount;
ALTER TABLE payment_copy CHANGE amount_in_pennies amount INT AFTER rental_id;

SELECT * from payment_copy
LIMIT 10;

DROP TABLE payment_copy;


-- Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

-- Hint Consider that the following code will produce the z score for current salaries.


CREATE temporary Table salary_avgs AS 
(
SELECT avg(salary) as avg_salary, stddev(salary) as sd_salary FROM employees.salaries WHERE to_date > now()
);
SELECT * FROM salary_avgs;

CREATE TEMPORARY TABLE departments_average_salary AS 
(
SELECT dept_name, avg(salary) as dept_salary_avg
FROM employees.salaries es
JOIN employees.dept_emp ede USING (emp_no)
JOIN employees.departments ed USING (dept_no)
WHERE ede.to_date > NOW() AND es.to_date > NOW()
GROUP BY dept_name
);


SELECT * FROM departments_average_salary;

ALTER TABLE departments_average_salary add overall_avg float(10,2);
ALTER TABLE departments_average_salary add overall_std float(10,2);
ALTER TABLE departments_average_salary add zscore float(10,2);

UPDATE departments_average_salary set overall_avg = (select avg_salary FROM salary_avgs);
UPDATE departments_average_salary set overall_std = (select sd_salary FROM salary_avgs);

UPDATE departments_average_salary set zscore = (dept_salary_avg - overall_avg) / overall_std;

SELECT * from departments_average_salary
ORDER BY zscore DESC;






