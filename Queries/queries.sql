-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Save query to a new table 'retirement_info' using SELECT INTO
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
      dm.emp_no,
      dm.from_date,
      dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
       de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de ON ri.emp_no = de.emp_no;

-- Use Left Join for retirement_info and dept_emp tables
-- and create a new table (current_emp) 
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO cur_emp_dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;s

SELECT * FROM salaries
ORDER BY to_date DESC;


-- Join 3 tables (using inner join) 
-- listing current employees to retire their name, gender salary 
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31') 
	 AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
-- List department retirees
-- join 3 tables together by linking them through 'dept_emp' table
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM retirement_info;

--- Listing retiring employee info for sales department 
SELECT ri.emp_no,
		ri.first_name,
		ri.last_name,
		d.dept_name
INTO retirement_sales_info
FROM retirement_info AS ri
INNER JOIN dept_emp AS de 
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_no = 'd007');

--- Listing retiring employee info for sales and development department 
SELECT ri.emp_no,
		ri.first_name,
		ri.last_name,
		d.dept_name
		INTO retirement_sales_develop_info
FROM retirement_info AS ri
INNER JOIN dept_emp AS de 
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_no IN ('d007','d005');


