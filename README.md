# SQL Learning & Projects

This repo is my collection of notes and hands-on practice while learning SQL (MySQL), plus two mini projects applying those skills to real datasets: a **Parks and Recreation** sample database and a **layoffs.csv** dataset from Kaggle.

## Setup

The `Beginner - Parks_and_Rec_Create_db.sql` file creates the `parks_and_recreation` database used throughout most of the topic files, with two main tables:

- `employee_demographics` — employee_id, first_name, last_name, age, gender, birth_date
- `employee_salary` — employee_id, first_name, last_name, occupation, salary, dept_id
- `parks_departments` — department_id, department_name (reference table)

Run this file first if you want to follow along with the topic scripts.

## Topics Covered

| File | Topic |
|---|---|
| `SELECT.sql` | Basic `SELECT`, arithmetic in queries, `DISTINCT` |
| `WHERE-COMPARISON-LIKE.sql` | Comparison operators, `AND`/`OR`/`NOT`, `LIKE` pattern matching with `%` and `_` |
| `GROUP-ORDERBY.sql` | `GROUP BY`, aggregate functions, `ORDER BY` |
| `Having-Where.sql` | Filtering before vs. after aggregation (`WHERE` vs `HAVING`) |
| `Limit-Aliasing.sql` | `LIMIT`, offsets, column aliasing with `AS` |
| `Joins.sql` | Inner/outer/self/cross joins, joining multiple tables |
| `Unions.sql` | `UNION` vs `UNION ALL`, combining result sets |
| `StringFunctions.sql` | `LENGTH`, `UPPER`/`LOWER`, `TRIM`, `LEFT`/`RIGHT`/`SUBSTRING`, `REPLACE`, `LOCATE`, `CONCAT` |
| `Case.sql` | `CASE` statements for conditional logic |
| `Subqueries.sql` | Subqueries in `WHERE`, `SELECT`, and `FROM` clauses |
| `CTE.sql` | Common Table Expressions, including multiple and renamed CTEs |
| `WindowFunctions.sql` | `OVER(PARTITION BY...)`, rolling totals, `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` |
| `TempTables.sql` | Creating and populating temporary tables |
| `StoredProcedures.sql` | Creating procedures, `DELIMITER`, parameters |
| `Triggers.sql` | `CREATE TRIGGER`, `AFTER INSERT` |
| `Events.sql` | `CREATE EVENT`, scheduled automation |
| `Comments.sql` | Single-line and block comment syntax |

## Projects

### 1. Data Cleaning (`DataCleaning.sql`)
Cleaning a raw `layoffs.csv` dataset (company, location, industry, layoffs, dates, funding stage, country) into an analysis-ready table, `layoffs_staging2`. Steps included:
- Removing duplicates using `ROW_NUMBER()` over a partition of all columns
- Standardizing text fields (trimming whitespace, merging inconsistent category names like `Crypto`/`CryptoCurrency`)
- Fixing inconsistent values (e.g. `United States.` → `United States`)
- Converting the date column from text to a proper `DATE` type with `STR_TO_DATE`
- Handling nulls and blanks, including backfilling industry values via a self-join
- Removing rows with no usable data

### 2. Exploratory Data Analysis (`ExploratoryDataAnalysis.sql`)
Analysis on the cleaned `layoffs_staging2` table to find patterns in the data, including:
- Companies and industries hit hardest by layoffs
- Countries most affected
- Layoffs by year and by month, including a **rolling total** using a CTE + window function
- Top 5 companies by layoffs per year using `DENSE_RANK()`

## Notes

These scripts are personal learning notes (comments throughout explain my own understanding of each concept) rather than a polished tutorial, so some entries include a "why this vs. that" comparison to help cement the concept — like the difference between `GROUP BY` and window functions, or `RANK()` vs `DENSE_RANK()`.
