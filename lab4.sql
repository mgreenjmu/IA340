`--4.1 
/* no because of the 1 to M relationship and we still have VA records */
--4.2 
/* no because 80 is not a valid fips */
--4.3
/* just fine */ 
--4.5
/* yes, perfect */
--4.6 
SELECT n.name, i.income, i.year
FROM income i
JOIN name n ON i.fips = n.fips
WHERE i.year = (SELECT MAX(year) FROM income)
ORDER BY i.income DESC
LIMIT 1;

--4.7 
WITH VirginiaPop AS (
    SELECT year, pop
    FROM population
    JOIN name ON population.fips = name.fips
    WHERE name.name = 'Virginia'
    ORDER BY year DESC
    LIMIT 2
)
SELECT 
    year AS Year,
    pop AS Population,
    LAG(pop) OVER (ORDER BY year) AS Previous_Population,
    (pop - LAG(pop) OVER (ORDER BY year)) / LAG(pop) OVER (ORDER BY year) * 100 AS Growth_Rate_Percent
FROM VirginiaPop
ORDER BY year DESC
LIMIT 1;
/* did not work */
--4.7 
/* 
Prompt: Write an SQL query to calculate the population growth rate in Virginia (VA) over the past five years. 
Did I modify the query? Yes. The original prompt suggested calculating for just two years (recent year and previous year). 
I modified the query to handle multiple consecutive years (5 years) and calculated the growth for each year.


SELECT
    p1.year AS year_end,
    p2.year AS year_start,
    p1.pop AS population_end,
    p2.pop AS population_start,
    ((p1.pop - p2.pop) / p2.pop::float * 100.0) AS growth_rate_percent
FROM
    population p1
JOIN
    population p2 ON p1.fips = p2.fips AND p1.year = p2.year + 1
JOIN
    name n ON p1.fips = n.fips
WHERE
    n.name = 'Virginia'
ORDER BY
    p1.year DESC
LIMIT 5;

--4.8.
/* ChatGPT generally provides highly accurate and helpful responses for well-formed prompts.
However, it may not always consider edge cases or specific details in the database schema unless explicitly mentioned.
In this case, I modified the prompt to return multiple years (not just one year) and adjusted it for accuracy. */
