DELETE FROM happiness;
DELETE FROM alcohol_consumption;
DELETE FROM antidepressant_consumption;

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
INNER JOIN alcohol_consumption AS t2 ON t1.country = t2.country AND t2.year = 2017
INNER JOIN antidepressant_consumption AS t3 ON t1.country = t3.country
WHERE t1.year = 2017
ORDER BY 2;
