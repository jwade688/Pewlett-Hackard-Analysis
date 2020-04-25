# Pewlett-Hackard-Analysis
Analysis of employee information using SQL.

## Challenge Overview
- Determine the total number of employees per title who will be retiring.
- Identify those employees who are eligible to participate in a mentorship program. 

# Documents required for the challenge:
- challenge_queries.sql 
    - Contains schema code and required tables
- EmployeeDB.png 
    - ERD that shows relationships between SQL tables
- Data/retirement_eligible_info.csv 
    - Data containing list of employees elegible for retirement with only their current (latest) title
- Data/title_retirement_count.csv
    - Data containing list that shows a vacancies count they can expect for each job title
- Data/mentorship_eligibility_info.csv
    - Data containing list of employees elegible for the mentorship program

# Technical analysis and conclusions:
Per the request of management, I set out to find the number of employees per title who will be retiring and a list of employees eligible for the mentorship program. 

The first step was to create an ERD to capture the relationship between Pewlett-Hackard's 6 different data sets (Departments, Employees, Titles, Deptartment Managers, Department Employees, and Salaries). To solve the problem, data would need to be combined from different sets. This relationship can be viewed visually in the EmployeeDB.png file. This visual relationship was used to create a SQL schema which can be viewed in the first half of the challenge_queries.sql file. This schema captured data titles, column titles, data types, primary keys, and foreign keys. The primary and foreign keys were used to connect the data relationships together so the sets could reference each other later. NOT NULL was used to tell SQL that no null fields will be allowed on import. 

Once all the data was organized and imported SQL code could be written to find the employees elegible for retirement and their titles. I first created a table with the employee's ID, name, title, when they started that title, and their salary. I joined the ID and names from the Employee data with the title name and date from the Title data and the salary from the Salary data. I also joined the Department Employee data to this set since dept_emp had the info of whether they are currently employed or not. I set conditionals to the elegibility of retirement from the module: born between 1951-1955, hired between 1985 and 1988, and currently employed. This table could not be used to count the number of employees per title because many employees had duplicates; they had multiple titles over their span of employement. I used PARTITION BY to remove duplicates and only pull their most recent (last) title. The original data request with duplicates was nested into the partition. I saved this table to the file Data/retirement_eligible_info.csv. Using this table, it was easy to count the number of employees (using their emp_no) and group the numbers by title. This data shows how many employees of each title are going to be retiring and can be viewed in the Data/title_retirement_count.csv file. 

The next part of the manager's request was getting the data of employees who are elegible for the mentorship program. Per the request, I combined the ID and names from the Employee Data and their title and the dates held for their title from the Titles data. I also needed to join the Department Employee data to determine whether they were currently employed or not. At first I tried to use the to_date from the Title data, but when selecting the date '9999-01-01' it removed each employees previous titles; that is why Department Employee data to_date was used. I then set the mentorship elegibility condition on the data: employee needs to be born after January 1, 1965 and before December 31, 1965 and be currently employed. This again created duplicate entries for each employee because of multiple titles. I again used the PARTITION BY to remove duplicates, same as the previous request. I ordered this data by employee number. This data can be viewed in the file Data/mentorship_eligibility_info.csv. 

My findings of retiring employee counts by title:

- Senior Engineer:	    13651
- Senior Staff:   	    12872
- Engineer:       	    2711
- Staff:          	    2022
- Technique Leader:	    1609
- Assistant Engineer:	251
- Manager:              2

I found that there are 1549 employees eligible for the mentorship program.

As for next steps, I would recommend finding the breakdown by title of the employees eligible for the mentorship program and see how they relate to the breakdown of retiring employee counts. It is limiting to have one lump sum of employees eligible and not knowing how they break down. Also I would recommend combining the breakdown by title with a breakdown by department since many of these titles work for different departments.