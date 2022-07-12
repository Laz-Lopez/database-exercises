
USE leavitt_1860;
ALTER TABLE employees_with_departments 
DROP dept_no, 
DROP emp_no, 
DROP birth_date, 
drop gender, 
drop hire_date, 
drop from_date, 
drop to_date;

SHOW CREATE TABLE employees_with_departments;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
ALTER TABLE employees_with_departments
drop first_name,
drop last_name;


SELECT full_name AS 'Full Name', dept_name AS 'Department'
FROM employees_with_departments
ORDER BY dept_name, full_name
LIMIT 20;


CREATE temporary TABLE payment_copy AS
SELECT * , amount * 100 as amount_in_pennies from sakila.payment;
ALTER TABLE payment_copy DROP amount;
ALTER TABLE payment_copy CHANGE amount_in_pennies amount INT AFTER rental_id;

SELECT * from payment_copy
LIMIT 10;

DROP TABLE payment_copy;




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






