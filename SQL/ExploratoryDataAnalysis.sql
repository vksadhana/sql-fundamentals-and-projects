-- Exploratory Data Analysis

SELECT * 
FROM layoffs_staging2;

#we are looking at total_laid off and percentage_laid off (however, percentage_laid off is not useful b/c we don't 
#have a total number of employees to gain any insight from.

SELECT MAX(total_laid_off)
FROM layoffs_staging2; #12000, a company laid off this much in one go (or one day) 

SELECT MAX(percentage_laid_off)
FROM layoffs_staging2; #1, as in 100% of the company was laid off

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC; #company with the most people laid off

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; #company with a lot of funds

SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

#date range - begining of 2020 to end of 2023, so covid can be a factor
SELECT MIN(`date`), MAX(`date`) 
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC; #consumer got hit the most

#which country got hit the most
SELECT country, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC; #us got hit the most, and then india

#which date had the most layoffs
SELECT YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC; #2020 - 2023, 2020 had the most, but 2023 only 3 months of data and it has a lot of layoffs

#stage of the company
SELECT stage, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

#progression of layoffs, rolling sum 

#rolling total of the month - so 01, is jan of 2020 - 2023
SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY `MONTH` ASC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, 
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

#break down by year`

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), COMPANY_YEAR_Rank AS
(SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
WHERE years is NOT NULL
)
SELECT * 
FROM Company_Year_Rank
WHERE ranking <= 5;



