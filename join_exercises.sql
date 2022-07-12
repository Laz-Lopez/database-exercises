USE join_example_db;

SHOW tables;

DESCRIBE roles;

DESCRIBE users;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT users.name AS user_name, users.email AS emails, roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id;


SELECT users.name as user_name, roles.name as role_name
FROM roles
LEFT JOIN users ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id ;

SELECT users.name AS user_name, roles.name, COUNT(*) AS role_name
FROM users
JOIN roles ON users.role_id = roles.id
GROUP BY roles_name;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.



-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
USE employees;
SHOW tables;
Describe dept_manager;
Describe departments;
Describe dept_emp;
Describe employees;
Describe titles;
Describe salaries;

SELECT CONCAT(employees.first_name, '  ',employees.last_name) AS Manager_name, departments.dept_name AS Department_NAME
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no= departments.dept_no
WHERE dept_manager.to_date like '9999-%-%';

-- Find the name of all departments currently managed by women.

SELECT CONCAT(employees.first_name, ' ',employees.last_name) AS Manager_name, departments.dept_name AS Department_NAME
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no= departments.dept_no
WHERE dept_manager.to_date like '9999-%-%'
AND employees.gender like 'f';

-- Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title AS Title, Count(*) 
From titles
JOIN dept_emp on titles.emp_no=dept_emp.emp_no
WHERE dept_emp.to_date > now()
AND titles.to_date > NOW()
AND dept_emp.dept_no like 'd009'
Group by TITLE;


-- Find the current salary of all current managers.

SELECT CONCAT(employees.first_name, '  ',employees.last_name) AS Manager_name, departments.dept_name AS Department_NAME, salaries.salary AS 'Salary'
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no= departments.dept_no
JOIN salaries ON employees.emp_no=salaries.emp_no
WHERE dept_manager.to_date > now()
AND salaries.to_date >= NOW();


-- Find the number of current employees in each department.
SELECT  departments.dept_no AS Dept_Number ,departments.dept_name AS Dept_Name, count(*) AS Num_Employees
FROM departments
Join dept_emp
USING (dept_no)
WHERE dept_emp.to_date > now()
Group by dept_no
Order by dept_no ASC;

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_name AS 'Dept', AVG(salaries.salary) AS 'Average_Salary'
FROM departments
JOIN dept_emp 
USING (dept_no)
JOIN salaries
USING(emp_no)
WHERE dept_emp.to_date > NOW()
AND salaries.to_date >= NOW()
Group by dept_name
ORDER BY AVG(salaries.salary) DESC LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
Where departments.dept_name like 'Marketing'
AND dept_emp.to_date > NOW()
AND salaries.to_date >= NOW()
Order by Salary DESC
Limit 1;
-- Which current department manager has the highest salary?
SELECT CONCAT(employees.first_name, '  ',employees.last_name) AS Manager_name, departments.dept_name AS Department_NAME, salaries.salary AS 'Salary'
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no= departments.dept_no
JOIN salaries ON employees.emp_no=salaries.emp_no
WHERE dept_manager.to_date > now()
AND salaries.to_date >= NOW()
Order by salary desc
Limit 1;

-- Determine the average salary for each department. Use all salary information and round your results.

SELECT  departments.dept_name AS Department_NAME, round(avg(salary)) 
FROM salaries
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_emp.to_date > now()
ANd salaries.to_date >= NOW()
group by departments.dept_name;

SELECT CONCAT(employees.first_name, '  ',employees.last_name) AS Employee_name, departments.dept_name, 






