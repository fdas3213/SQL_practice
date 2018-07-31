Q1.
-----------------
SELECT name 
FROM world
 WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

Q2.
-----------------
SELECT name
FROM world 
WHERE gdp/population > (SELECT gdp/population FROM world
           WHERE name = 'United Kingdom')
AND continent = 'Europe'

Q3.
-----------------
SELECT name, continent
FROM world
WHERE continent in (SELECT continent FROM world
              Where name = 'Argentina' OR name = 'Australia')
ORDER BY name

Q4.
----------------
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world 
                   WHERE name = 'Canada')
AND population < (SELECT population FROM world
                   WHERE name = 'Poland')
				   
Q5.
----------------
SELECT w.name, CONCAT(ROUND(w.population / g.population * 100),'%')
FROM world w
JOIN (SELECT population, continent 
      FROM world 
      WHERE name = 'Germany') g
ON w.continent = g.continent

----------------
SELECT name, CONCAT(ROUND(population / (SELECT population
									FROM world
									WHERE name = 'Germany') * 100), '%')
FROM world
WHERE continent = 'Europe'

Q6.
----------------
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp 
             FROM world
             WHERE continent = 'Europe' AND gdp > 0)

Q7.
----------------
SELECT w.continent, w.name, m.max_area
FROM world w
JOIN (SELECT MAX(area) AS max_area
      FROM world
      GROUP BY continent) m
ON w.area = m.max_area

Q8.
----------------
SELECT continent, a.name
FROM world a
WHERE a.name <= ALL(SELECT name
                    FROM world b
                    WHERE a.continent = b.continent)

Q9.
----------------
SELECT a.name, a.continent, a.population
FROM world a
JOIN (SELECT MAX(population) AS max_pop, continent
      FROM world
      GROUP BY continent) b
ON a.continent = b.continent
WHERE b.max_pop <= 25000000

Q10.
----------------
SELECT name,continent
FROM world a
WHERE population > ALL(SELECT population * 3
					FROM world b
					WHERE a.continent = b.continent and a.name != b.name)

