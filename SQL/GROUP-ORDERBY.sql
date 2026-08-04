-- Group By (rows in the same value in the same columns) 
# you can run aggregate functions on those rows

#group by collapsese your rows into one row per group (one row per distinct gender value)

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender; #rolling up all values into one row, so we can run aggregate functions

#when you select an column and not an aggregated, it will not work. 
# if not using agg functions, the SELECT has to match group by

SELECT gender, AVG(age) AS AverageAge
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT gender, AVG(age) AS AverageAge, MAX(age), MIN(age), COUNT(age) # count, counts the rows within the age column when we group by gender, so 4 females
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

-- ORDER BY (sort the results in asc and desc)

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC; #asc default

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender , age DESC; #gender first priority and then age (desc only to age)

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender DESC, age DESC;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age, gender; #gender is so useless here because there are no duplicate values within age.

#IMPORTANT - you don't have to use the column names, you can use positions - however not recommended

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4; #gender and age, will cause issues if we add or remove columns

