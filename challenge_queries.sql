-- Create table schema for PH-EmployeeDB
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


-- CHALLENGE CODE TO CREATE 3 NEW TABLES.

-- Create a table with those elegible for retirement with only their current (latest) title.
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary
INTO retirement_eligible_info
FROM (SELECT emp_no,
	 	first_name,
		last_name,
		title,
		from_date,
		salary, 
	  	-- Partition data to get only the employee's current title.
	  	ROW_NUMBER() OVER
		(PARTITION BY (emp_no)
	 	ORDER BY from_date DESC) rn
	 	-- Get employee information who are elegible for retirement.
	  	FROM (SELECT e.emp_no,
				   	e.first_name,
				   	e.last_name,
					t.title,
				    t.from_date,
				  	s.salary
		   	   FROM employees as e
		   			INNER JOIN titles as t
						ON (e.emp_no = t.emp_no)
					INNER JOIN salaries as s
						ON (e.emp_no = s.emp_no)
					INNER JOIN dept_emp as de
						ON (e.emp_no = de.emp_no)
				WHERE (birth_date BETWEEN '1951-01-01' AND '1955-12-31')
	   				   AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	   				   AND de.to_date = ('9999-01-01')) as rt
	 	) tmp WHERE rn = 1
ORDER BY (emp_no);


-- Create a table that shows a vacancies count they can expect for each job title.
SELECT title, 
	COUNT(emp_no) as "retirement eligible count"
INTO title_retirement_count
FROM retirement_eligible_info
GROUP BY (title)
ORDER BY COUNT(emp_no) DESC;


-- Create a table of employees elegible for the mentorship program.
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
--INTO mentorship_elegibility_info
FROM employees as e
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	   AND (de.to_date = '9999-01-01')
ORDER BY (e.emp_no);






