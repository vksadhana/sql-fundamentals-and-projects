-- HAVING & WHERE

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
#WHERE AVG(age) > 40 cannot use WHERE here, when filtering avg hasn't happened cuz avg happens after group
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation like '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000; #only works aggregated functions after the group by runs