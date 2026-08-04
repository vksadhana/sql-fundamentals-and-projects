-- Project 1: Data Cleaning
/* 
- Fixing issues in Raw Data so the data is more useful and in an usable format
- create a database
- import a dataset: layoffs.csv
- clean the data
*/

# 1. Create a new Schema (Database)
# 2. Right Click on Tables in Schema and Import Table From Wizard

SELECT * 
FROM layoffs; 

/* 
Notes About the Dataset: 
- company that did the layoff
- location that company is located in 
- the industry
- total number of people laid off
- percentage of people laid off from the total company
- the date
- what stage in their career (post ipo - contract ends, series b (missing revenue), series c (reduction), etc
- country of the company
- funds raise in millions
*/

# Goals 
-- 1. Remove Duplicates if there are any
-- 2. Standardize the Data
-- 3. Null Values or Blank Values (if we can populate that or not)
-- 4. Remove Any Columns or Rows that are not necessary (when to do this and not. Ex. massive datasets, remove uncessary columns if there are no ETL process required for it)
	-- will be a problem if you are importing data from somewhere and removed columns from the raw data
    -- real world: you should create staging or an alternative one

# create a copy of the raw data
CREATE TABLE layoffs_staging
LIKE layoffs;

#insert values from the raw to this new table
INSERT layoffs_staging
SELECT * 
FROM layoffs; 

#remove duplicates - we can create a CTE or subquery

#we will have to filter over all columns to detect duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1; # if there is ever a duplicate it would be greater than 1, because row_num assigns the same rank to duplicates

/*Notes: 
Companies with reported duplicates: Casper, Cazoo, Hibob, Wildlife Studios, Yahoo
- Casper: 3 rows, there is one duplicate on date 9/14/2021, we only want to remove one of them
- Cazoo: 3 rows, there is one duplicate on 6/7/2022, we only want to remove one of them 
- Hibob: 2 rows, duplicate on a row - so we want to delete one and keep the other one
- Wildlife Studios: 2 rows, duplicate on a row - so we want to delete one and keep the other one
- Yahoo: 2 rows, duplicate on a row - so we want to delete one and keep the other one
*/

# Select statement use to evaluate each company to see if they are really duplicates
SELECT *
FROM layoffs_staging
WHERE company = 'Yahoo'; #tried Casper, Cazoo, Hibob, Wildlife Studios, Yahoo
#remove one of them - not both, we need to identify the row number

-- HOW TO REMOVE DUPLICATES 

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1; 

DELETE
FROM layoffs_staging2
WHERE row_num > 1; 

-- STANDARDIZING DATA

SELECT company, TRIM(company)
FROM layoffs_staging2; 

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1; 
#there is a blank one, and null one, Crypto, CryptoCurrency and Crypto Currency (confident in merging)

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'; 

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'; 

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL; 

SELECT *
FROM layoffs_staging2
WHERE industry = ''; 

SELECT DISTINCT(location)
FROM layoffs_staging2
ORDER BY 1; # DÃ¼sseldorf, FlorianÃ³polis, MalmÃ¶

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1; #United States and United States. 

SELECT *
FROM layoffs_staging2
WHERE country = 'United States.'; 

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%'; 

/* 
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) - this will fix it too
FROM layoffs_staging2;
*/

# time series visualization needs date to be integer, currently date is text

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS std_date
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y'); # there are some nulls

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; #only do this on staging tables only

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

#if total_laid_off and percentage is null - it is pretty useless

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
	# AND t1.location = t2.location #different usecases
WHERE t1.industry IS NULL OR t1.industry = ''
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''; 

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


SELECT * FROM layoffs_staging2
WHERE company LIKE 'Bally%'; #edgecase

SELECT COUNT(*) FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL; # these might not be useful if we have no info on these - however, do we delete it?

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;