-- Unions, combine rows together, not columns (joins), from separate or same tables

#combine one select statement union and another select statement

SELECT age, gender
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary; 
#this is messy and you usually want to keep it the same sort of data when using union 


SELECT first_name, last_name
FROM employee_demographics
UNION # by default this is UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary; 
#returns all of the names in both table- but it's all unique

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary; 
#return everything - even duplicates

-- USECASE: 
SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;
#labeling - and has duplicates, multiple criteria