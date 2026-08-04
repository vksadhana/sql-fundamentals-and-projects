-- LIMIT & Aliasing 

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3;

#top 3 oldest people

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1; #start at position 3 and go one row after it
#this gets the 3 oldest person

-- ALIASING, most part - change the name of the columns

SELECT gender, AVG(age) AS avg_age #aliasing keyword as, and name of the column
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40;

SELECT gender, AVG(age) avg_age #you can also get rid of as and its interpretted
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40;