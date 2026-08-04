-- JOINS, two or more tables with column data (no need to have same name)

# Inner Join - default, returns rows that are the same in both tables in both columns
SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT * 
FROM parks_and_recreation.employee_salary;

SELECT * 
FROM parks_and_recreation.employee_demographics
INNER JOIN parks_and_recreation.employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
    # this will result in an error because it's ambiguous employee_id = employee_id
;

# selecting the columns
SELECT employee_demographics.employee_id, employee_demographics.first_name, employee_demographics.last_name, employee_demographics.age, employee_demographics.gender, employee_salary.dept_id, employee_salary.occupation, employee_salary.salary, employee_demographics.birth_date
FROM parks_and_recreation.employee_demographics
INNER JOIN parks_and_recreation.employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
    # this will result in an error because it's ambiguous employee_id = employee_id
;

# NOTE - you do not use alias for all, you only have to use it for the names that are in both tables to separately identify them.

-- Aliasing 
SELECT * FROM employee_demographics AS d
INNER JOIN employee_salary AS s
	ON d.employee_id = s.employee_id; 

-- OUTER JOINS (LEFT OUTER JOIN = LEFT JOIN, RIGHT OUTER JOIN = RIGHT JOIN), either table only

#left join, will take all columns in left even if there is no match and return all matches from the right table, opp for right join

SELECT * FROM employee_demographics AS d
LEFT JOIN employee_salary AS s
	ON d.employee_id = s.employee_id; 


SELECT * FROM employee_demographics AS d
RIGHT JOIN employee_salary AS s
	ON d.employee_id = s.employee_id; 

-- SELF JOIN, tie the table to itself, usecase: 
#secret santa, assign ids

SELECT * 
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id; 
#have to specifiy the table because they are the same

#simplify the output

SELECT 
    emp1.employee_id AS emp_santa,
    emp1.first_name  AS first_name_santa, 
    emp1.last_name   AS last_name_santa, 
    emp2.employee_id AS emp_recipient,
    emp2.first_name  AS first_name_recipient, 
    emp2.last_name   AS last_name_recipient
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id; #this is a comparison not adding
#2 = 2, true, keeps the true on

-- joining multiple tables together

SELECT *
FROM employee_demographics AS d
INNER JOIN employee_salary AS s
	ON d.employee_id = s.employee_id; 
    
SELECT * 
FROM parks_departments; #department id and department name, reference table - no duplicates

SELECT * 
FROM employee_demographics;

# return age (demographics) + occupation (salary), department name (departments)

SELECT age, occupation, department_name
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id
JOIN parks_departments as p
	ON s.dept_id = p.department_id
;

-- CROSS JOIN, simplest conceptually
# takes every row from Table A and pairs it with every row from Table begin
# no matching or on condition. just the complete combination of both tables 
# cartesian product

SELECT *
FROM employee_salary
CROSS JOIN parks_departments;

#another way to write it
SELECT *
FROM employee_salary, parks_departments;

#usecase  - a size or color product, filling missing vals