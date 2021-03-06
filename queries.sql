-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- DROP TABLE employees CASCADE; (this drops employees from all connected tables)

SELECT * FROM dept_emp;

-- Employees born between 1951-1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1951-01-01' AND '1955-12-31';

-- Employees born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Employees born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Employees born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Employees born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement elegibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create a new table of those elegible for retirement
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

-- Create a new table of those elegible for retirement including the emp_no
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables with aliases
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Create a new retirement table using JOINS
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Create a new retirement table using JOINS with aliases
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Create a new retirement table using JOINS with aliases and save it into current_emp
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by departemtn number and create a new table
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- NEW retirement employment table
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
WHERE (e.birth_date BETWEEN '1951-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- Manager retirement table
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);
	
-- Department Retirees table
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (de.emp_no = ce.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);

-- Retirement info in the Sales department
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (de.emp_no = ce.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');

-- Retirement info in the Sales and Development departments
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_development_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (de.emp_no = ce.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');




-- CLASS NOTES
SELECT * FROM salaries;

SELECT MIN(salary), MAX(salary), AVG(salary) 
FROM salaries;

SELECT gender, COUNT(1), MIN(hire_date) 
FROM employees 
GROUP BY gender;

SELECT last_name, COUNT(1), MIN(hire_date) 
FROM employees 
GROUP BY last_name;

SELECT last_name, gender, COUNT(1), MIN(hire_date) 
FROM employees 
GROUP BY last_name, gender
ORDER BY last_name;


-- Partition the data to show only the most recent title per employee.
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	t.title,
	t.from_date,
	t.to_date,
	s.salary
--INTO retiree_titles
FROM current_emp as ce
	INNER JOIN titles as t
		ON (ce.emp_no = t.emp_no)
	INNER JOIN salaries as s
		ON (ce.emp_no = s.emp_no);


SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary
--INTO retiring_titles_without_duplicates
FROM (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary, ROW_NUMBER() OVER
	(PARTITION BY (emp_no)
	 ORDER BY from_date DESC) rn
	 FROM retiree_titles
	 ) tmp WHERE rn = 1
ORDER BY (emp_no);





SELECT emp_no,
		first_name,
		last_name,
		title,
		from_date,
		salary
INTO title_info
FROM (SELECT emp_no,
	 		  first_name,
			  last_name,
			  title,
			  from_date,
			  salary, ROW_NUMBER() OVER
			  (PARTITION BY (emp_no)
	 		  ORDER BY from_date DESC) rn
	 		  FROM (SELECT ce.emp_no,
				   			ce.first_name,
				   			ce.last_name,
					   		t.title,
				   			t.from_date,
				  			s.salary
		   			FROM current_emp as ce
		   				INNER JOIN titles as t
							ON (ce.emp_no = t.emp_no)
						INNER JOIN salaries as s
							ON (ce.emp_no = s.emp_no)) as rt
	 		   ) tmp WHERE rn = 1
ORDER BY (emp_no);

SELECT title, 
		COUNT(emp_no) as number_retiring
FROM title_info
GROUP BY (title)
ORDER BY COUNT(emp_no);








