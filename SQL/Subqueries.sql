-- Subqueriees - query within a query

# first - in a where clause, and then select and from clause

# we want to find employees that work in the parks and rec department, we can combine both tables with dept_id
# but we can also use subqueries

SELECT * 
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id FROM employee_salary # we cannot return two columns like employee_id, dept_id
    WHERE dept_id = 1
);

#all the salary, we want to compare it to the average salary for everyone
SELECT first_name, salary, (SELECT AVG(salary) FROM employee_salary)
FROM employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender; 

SELECT AVG(max_age) #backticks are referencing the column
FROM 
	(SELECT gender, AVG(age) AS avg_age, MAX(age) AS max_age, MIN(age) AS min_age, COUNT(age)
	FROM employee_demographics GROUP BY gender) AS agg_table #must have an alias table name
    #SQL needs a way to refer to that result set as a table, 
    #and unlike a real table, a subquery doesn't come with a name built in.
;