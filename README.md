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

# Analysis and conclusions:
Per the request of management, I set out to find the number of employees per title who will be retiring and a list of employees eligible for the mentorship program. 

The first step was to create an ERD to capture the relationship between Pewlett-Hackard's 6 different data sets (Departments, Employees, Titles, Deptartment Managers, Department Employees, and Salaries). To solve the problem, data would need to be combined from different sets. This relationship can be viewed visually in the EmployeeDB.png file. This visual relationship was used to create a SQL schema which can be viewed in the first half of the challenge_queries.sql file. This schema captured data titles, column titles, data types, primary keys, and foreign keys. The primary and foreign keys were used to connect the data relationships together so the sets could be reference each other later. NOT NULL was used to tell SQL that no null fields will be allowed on import. 

Once all the data was organized and imported code could be writted to find the employees elegible for retirement and their titles. I first created a table with the employee's ID, name, title, when they started that title, and their salary. I joined the ID and names from the Employee data with the title name and date from the Title data and the salary from the Salary data. I also joined the Department Employee data to this set since this set had the info of whether they are currently employed or not. I set conditionals to the elegibility of retirement from the module: born between 1951-1955, hired between 1985 and 1988, and currently employed. This table could not be used to count the number of employees per title because many employees had multiple titles over their span of employement. I used PARTITION BY to remove duplicates and only pull their most recent (last) title. The originaly data request with duplicates was nested into the partition. I saved this table to the file Data/retirement_eligible_info.csv. Using this table, it was easy to count the number of employees (using their emp_no) and group the numbers by title. This data shows how many employees of each title are going to be retireing and can be viewed in the Data/title_retirement_count.csv file. 

The next part of the manager's request was getting the data of employees who are elegible for the mentorship program. Per the request, I combined the ID and names from the Employee Data and their title and the dates held for their title from the Titles Data. I also needed to join the Department Employee data to determine whether they were currently employed or not. At first I tried to use the to_date from the Title data, but when selecting the date '9999-01-01' it removed all previous titles; that is why Department Employee data to_date was used. I then set the mentorship elegibility condition on the data: employee needs to be born after January 1, 1965 and before December 31, 1965 and be currently employed. I ordered this data by employee number. This data can be viewed in the file Data/mentorship_eligibility_info.csv. 

I found that there are 1549 employees eligible for the mentorship program and my findings of retiring employee counts by title:

Senior Engineer:	13651
Senior Staff:   	12872
Engineer:       	2711
Staff:          	2022
Technique Leader:	1609
Assistant Engineer:	251
Manager	2:          2

As for next steps, I would recommend finding the breakdown by title of the employees eligible for the mentorship program and see how they relate to the break down of retiring employee counts. It is limiting to have one lump sum of employees eligible and not knowing how they break down. Also I would recommend combining the breakdown by title with a breakdown by department since many of these titles work for different departments.

In your final paragraph, share the results of your analysis and discuss the data that you’ve generated. Have you identified any limitations to the analysis? What next steps would you recommend?





# School_District_Analysis
School analysis using Anaconda

## Challenge Overview
- Filtering with logic operators and replace the ninth-grade math and reading scores from Thomas High School with NaN.
- Recreate the district and school summary DataFrames.
- Recalculate the scores by grade, scores by school spending, scores by school size, and scores by school type.

# District summary analysis:
- With the test scores replaced for math and reading for the Thomas HS 9th graders:
    - The average math score decreased .1
    - The average reading score did not change when rounded to the 10th
    - The % passing math decreased 1%
    - The % passing reading decreased 1%
    - The % Overall passing decreased 1%
- Implications: When applied to the entirety of the dataset, removing these students did not have a huge affect.

# Per school summary analysis:
- With the test scores replaced, this is how Thomas HS was impacted:
    - The average math score decreased .067
    - The reading score increased .02
    - The % passing math decreased 26%
    - The % passing reading decreased 28%
    - The % Overall passing decreased 26%
- Implications: removing the Thomas HS scores dramatically decreased the passing percentages. This is because the passing percentages were calculated using the total student population. Since the 9th graders were included in this calculation, the data is skewed. I would recommend recalculating the passing percentages using the total population minus the 9th graders.

# High and low performing schools analysis:
- Without the Thomas HS 9th graders, the % Overall passing decreased 26%. This severly impacted their ranking compared to other schools. They moved from the 2nd to 8th ranked school because of this. Again, I believe this calculation is skewing the data and I would recommend recalculating the passing percentages using the total population minus the 9th graders. When calculated this way, they remain the 2nd ranked school.

# Math and Reading Scores by Grade summary analysis:
- By replacing the Thomas HS 9th grader's math and reading scores with NaN, there was no data to recalculate their average. In the summaries, the correlating scores appear as NaN.

# Scores by School Spending summary analysis:
- Thomas HS fell in the $630 - $644 spending per student range. With the test scores replaced for math and reading:
    - The average math and reading scores did not change.
    - The average % passing math decreased 5%
    - The average % passing reading decreased 5%
    - The average % Overall passing decreased 4%
- The decrease in % passing can be attributed to the calculation using the total population instead of the total population minus the 9th graders.

# Scores by School Size summary analysis:
- Thomas HS fell in the Medium (1000-2000) student population range. With the test scores replaced for math and reading:
    - The average math and reading scores did not change.
    - The average % passing math decreased 6%
    - The average % passing reading decreased 6%
    - The average % Overall passing decreased 6%
- The decrease in % passing can be attributed to the calculation using the total population instead of the total population minus the 9th graders.

# Scores by School Type summary analysis:
- Thomas HS is a Charter school. With the test scores replaced for math and reading:
    - The average math and reading scores did not change.
    - The average % passing math decreased 4%
    - The average % passing reading decreased 4%
    - The average % Overall passing decreased 3%
- The decrease in % passing can be attributed to the calculation using the total population instead of the total population minus the 9th graders.