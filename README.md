# Pewlett-Hackard-Analysis
Analysis of employee information using SQL.

## Challenge Overview
- Filtering with logic operators and replace the ninth-grade math and reading scores from Thomas High School with NaN.
- Recreate the district and school summary DataFrames.
- Recalculate the scores by grade, scores by school spending, scores by school size, and scores by school type.

# Documents required for the challenge:
- challenge_queries.sql 
    - Contains schema code and required tables
- EmployeeDB.png 
    - ERD that shows relationships between SQL tables
- Data/retirement_eligible_info.csv 
    - Data containing list of employees elegible for retirement with only their current (latest) title
- Data/title_retirement_count.csv
    - Data containing list that shows a vacancies count they can expect for each job title.
- Data/mentorship_elegibility_info.csv
    - Data containing list of employees elegible for the mentorship program.







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