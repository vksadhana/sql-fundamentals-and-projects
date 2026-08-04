-- Window Functions - kind of like group by except they don't roll up into one row
# you can look at a partition, row number, and rank and dense rank

#let's take salary and compare with gender
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id
GROUP BY gender;

#now with window function
SELECT d.first_name, d.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;
#this is better than grouping by first_name, last_name, gender and taking average because that would return
#groupped value of the first and last name that was average - here the salary has no affected on the grouping
# it returns the same average for that specific gender they belong to

SELECT d.first_name, d.last_name, gender, SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;
    
SELECT d.first_name, d.last_name, gender, SUM(salary) OVER(PARTITION BY gender ORDER BY d.employee_id) AS Rolling_Total
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;
#rolling total - keeps adding up till the last gender

-- ROW NUMBER

SELECT d.employee_id, d.first_name, d.last_name, gender, salary,
ROW_NUMBER() OVER() #row number is just like aggregate function
#adds 1 - 11 for all employees
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;

SELECT d.employee_id, d.first_name, d.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender) #row number is just like aggregate function
# 1 - smth for females and restarts for male
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;

#ordering by higher salary
SELECT d.employee_id, d.first_name, d.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) #row number is just like aggregate function
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;

#ordering by higher salary
SELECT d.employee_id, d.first_name, d.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num, 
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;
#row num won't have duplicates, rank is going to have duplicates based on order by - assigns the same number
# the next number is not going to be 55 and then 6, it goes to 7 (positionally)

SELECT d.employee_id, d.first_name, d.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num, 
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_ra
FROM employee_demographics as d
JOIN employee_salary as s
	ON d.employee_id = s.employee_id;
#just different when it gets to duplicates - will duplicate but next number is numerically 6 not going to 7
