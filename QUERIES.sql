--DELETE FROM happiness;
--DELETE FROM alcohol_consumption;
--DELETE FROM antidepressant_consumption;

SELECT * FROM antidepressant_consumption;

SELECT * FROM happiness;

SELECT * FROM alcohol_consumption;

SELECT CASE WHEN country IN (SELECT country FROM alcohol_consumption) THEN 'Y' ELSE 'N' END AS IN_ALC_DATA,
CASE WHEN country IN (SELECT country FROM antidepressant_consumption) THEN 'Y' ELSE 'N' END AS IN_AND_DATA,
COUNT(*) AS COUNTS
FROM happiness
WHERE year = 2017
GROUP BY 1,2;

SELECT DISTINCT country FROM happiness ORDER BY 1;

SELECT DISTINCT country FROM happiness
WHERE country NOT IN (SELECT country FROM alcohol_consumption)
AND year = 2017;

SELECT DISTINCT country FROM alcohol_consumption
WHERE country NOT IN (SELECT country FROM happiness)
ORDER BY 1;


SELECT  t1.country, t1.happiness_rank, t1.happiness_score, t2.gender, t2.per_capita_consumption, t3.daily_dosage_per_1k
FROM happiness AS t1
INNER JOIN alcohol_consumption AS t2 ON t1.country = t2.country AND t2.year = 2018
INNER JOIN antidepressant_consumption AS t3 ON t1.country = t3.country
WHERE t1.year = 2016
ORDER BY 2;

SELECT country, happiness_rank, happiness_score, gdp_per_capita, 
family, life_expectancy, freedom, trust_government, generosity, dystopia_residual 
FROM happiness 
WHERE year = 2017 ORDER BY happiness_rank;


SELECT country, happiness_rank, happiness_score, gdp_per_capita, 
family, life_expectancy, freedom, trust_government, generosity, dystopia_residual 
FROM happiness 
WHERE year = 2017 ORDER BY happiness_rank


SELECT T1.country, T2.ranking, T1.gender, T1.per_capita_consumption
FROM (SELECT country, gender, AVG(per_capita_consumption) AS per_capita_consumption 
FROM alcohol_consumption GROUP BY country, gender ORDER BY 3 DESC, 1) AS T1
INNER JOIN (SELECT country, per_capita_consumption, 
ROW_NUMBER () OVER (ORDER BY per_capita_consumption DESC) AS ranking 
FROM (SELECT country, AVG(per_capita_consumption) AS per_capita_consumption 
FROM alcohol_consumption GROUP BY country ORDER BY 2 DESC) AS T3) AS T2
ON T1.country = T2.country ORDER BY 2;

SELECT country,daily_dosage_per_1k, year, notes 
FROM antidepressant_consumption ORDER BY daily_dosage_per_1k DESC

SELECT AVG(happiness_score) From happiness
