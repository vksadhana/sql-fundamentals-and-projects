-- String Functions

SELECT LENGTH('skyfall'); #7

SELECT * 
FROM employee_demographics
WHERE LENGTH(first_name) > 2;

SELECT first_name, LENGTH(first_name) #return the name and then the length
FROM employee_demographics
ORDER BY 2; #order by 2 meaning sort by the 2nd column's values.
#if order by 1 means sort the names in alphabetical value

SELECT UPPER('sky'); 
SELECT LOWER('SKY');
SELECT UPPER('sky') AS shout, LOWER('SKY') AS whisper;
#notes - sql is a relational language, so returns everything in virtual tables

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

-- Trim, left, right trim - getting rid of white spaces

SELECT TRIM('           SKY      '); #gets rid of leading and trailing
SELECT LTRIM('           SKY      '); #left trim
SELECT RTRIM('           SKY      '); #right trim

SELECT first_name, LEFT(first_name, 4), #first 3 characters
RIGHT(first_name, 4) #from right to left, #last 4 characters
FROM employee_demographics;
#this is not which index, just saying how many characters i want to grab 

#notes: sql string positions start at 1 not 0
-- substring
SELECT first_name, 
LEFT(first_name, 4), 
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2) AS middle, #start and then how many characters from there
SUBSTRING(birth_date, 6,2) AS month
FROM employee_demographics;

-- replace
SELECT first_name, REPLACE(first_name, 'n', 'z') #replaces all instances
FROM employee_demographics;

-- LOCATE
SELECT LOCATE('x','Alexander'); #the first instance - character position

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;

-- Concat multiple columns
SELECT first_name, last_name, 
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;