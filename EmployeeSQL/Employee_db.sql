CREATE VIEW employee_view AS
SELECT emp_no AS "Employee Number",
		last_name AS "Last Name",
		first_name AS "First Name",
		birth_date AS "Birth Date",
		hire_date AS "Hire Date",
		(SELECT sex FROM sex WHERE sex_id=employees.sex) AS "Gender",
		(SELECT salary FROM salaries WHERE emp_no=employees.emp_no) AS "Salary",
		(SELECT title FROM titles WHERE title_id=employees.emp_title_id) AS "Title"
FROM employees;


CREATE VIEW emp_dept_view AS
SELECT emp_no AS "Employee Number",
		(SELECT "Last Name" FROM employee_view WHERE "Employee Number"=dept_emp.emp_no),
		(SELECT "First Name" FROM employee_view WHERE "Employee Number"=dept_emp.emp_no),
		(SELECT dept_name FROM departments WHERE dept_no=dept_emp.dept_no) AS "Department Name"
FROM dept_emp;



-- 1. List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.
SELECT "Employee Number", "Last Name", "First Name", "Gender", "Salary" 
FROM employee_view;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT "First Name", "Last Name", "Hire Date" 
FROM employee_view 
WHERE EXTRACT(YEAR FROM "Hire Date")=1986;


-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT dept_no AS "Department Number",
		(SELECT dept_name FROM departments WHERE dept_no=dept_manager.dept_no) AS "Department Name",
		emp_no AS "Employee Number",
		(SELECT "Last Name" FROM employee_view WHERE "Employee Number"=dept_manager.emp_no),
		(SELECT "First Name" FROM employee_view WHERE "Employee Number"=dept_manager.emp_no)
FROM dept_manager;


-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT * FROM emp_dept_view;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT "Last Name", "First Name", "Gender"
FROM employee_view
WHERE "First Name"='Hercules' AND "Last Name" LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * FROM emp_dept_view
WHERE "Department Name"='Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM emp_dept_view
WHERE "Department Name" IN ('Sales', 'Development');


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT "Last Name", COUNT("Last Name") AS "Count"
FROM employee_view
GROUP BY "Last Name"
ORDER BY "Count" DESC;


SELECT * FROM employee_view WHERE "Employee Number"=499942;
