-- Common Table Expressions, subquery block that will reference the main query
-- Kind of like standardized functions

#unique thing about CTE is that you have to use it right after
WITH CTE_Example AS
(
	SELECT gender, AVG(salary) as avg_sal, MAX(salary) as max_sal, MIN(salary) as min_sal, COUNT(salary) as count_sal
	FROM employee_demographics as d
	JOIN employee_salary as s
		ON d.employee_id = s.employee_id
	GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
; #average of both male and female

#notes - advanced calculation, but also supports readability (professional), you can do this with subquery as well

-- Additional Functionality 
# how to get around the immediately usability - temp tables

-- Multipl CTEs
WITH CTE_Example AS
(
	SELECT employee_id, gender, birth_date
	FROM employee_demographics as d
	WHERE birth_date > '1985-01-01'
), 
CTE_Example2 AS (
	SELECT employee_id, salary 
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_Example as c1
JOIN CTE_Example2 as c2 ON
c1.employee_id = c2.employee_id
;

WITH CTE_Example (Gender, Average_Salary, Max_Salary, Min_Salary, Count_Salary) AS
(
	SELECT gender, AVG(salary) as avg_sal, MAX(salary) as max_sal, MIN(salary) as min_sal, COUNT(salary) as count_sal
	FROM employee_demographics as d
	JOIN employee_salary as s
		ON d.employee_id = s.employee_id
	GROUP BY gender
)
SELECT *
FROM CTE_Example
;
#renaming the columns, default column names
