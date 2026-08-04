-- WHERE CLAUSE & Operators
#note - for mysql, there must be a space between "--" and the comment, or else it will be an error.

/*Notes: 
- these rules do differ across database systems -

single quotes vs. double quotes 
- ' ' are for string/date literals - actual data values you are comparing against
- " " are for identifiers - table names, column names, aliases - but only when you need to escape 
something like a reserved word, a space, or a mixed caues you want preserved like SELECt "Order Date" FROM "Order"
^ for postgresql, oracle, or sql server
mysql single or double works for strings, and then ` ` backticks for identifiers
SQL server - brackets also works for identifiers 

also - case for MySQL, "Male and 'Male' - work the same way by default (stick with single quotes)

why male and Male does not matter - COLLATION, rule set that governs how a database compares and sorts text
- most are case-insenestive (mysql, sql server), postgresql is the odd one out - it is sensitive ( you need to wrap with ILIKE or wrap in LOWER()

*/
SELECT * 
FROM parks_and_recreation.employee_salary
WHERE first_name = "Leslie"; # = is the comparison operator

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary > 50000; #only greater than 50,000, exactly will be removed

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000; 

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary < 50000; 

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary <= 50000; 

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE gender = 'Female';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE gender != 'Female';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'; #this is the default date format, which is year, month, and date

-- LOGIAL OPERATORS (AND OR NOT)

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01' AND gender = 'Male'; 

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01' OR gender = 'Male'; 

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01' OR NOT gender = 'Male'; 

# pemdas applies to logical operators as well

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55; 

-- LIKE Statement (looking for patterns)
# where statement is looking for an exact match

-- % (anything) _ (specific value) 
SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A%'; #%a% or %an

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A__';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A___%';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '1989%';