Q1. 
----------------
SELECT SUM(population)
FROM world

Q2.
---------------
SELECT DISTINCT continent
FROM world

Q3.
--------------
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'

Q4.
-------------
SELECT COUNT(DISTINCT name)
FROM world
WHERE area >= 1000000

Q5.
-------------
SELECT SUM(popu lation)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

Q6.
--------------
SELECT continent, COUNT(name)
FROM world
GROUP BY continent

Q7.
--------------
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent

Q8.
--------------
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000


###Aggregate quiz using nobel table

Q1. 
----------------
SELECT COUNT(winner) FROM nobel

Q2.
---------------
SELECT subject
FROM nobel
GROUP BY subject

Q3.
--------------
SELECT COUNT(winner)
FROM nobel
WHERE subject = 'Physics'
GROUP BY subject

Q4.
-------------
SELECT subject, COUNT(winner)
FROM nobel
GROUP BY subject

Q5.
-------------
SELECT subject, MIN(yr)
FROM nobel
GROUP BY subject

Q6.
--------------
SELECT subject, COUNT(yr)
FROM nobel
WHERE yr = 2000
GROUP BY subject

Q7.
--------------
SELECT subject, COUNT(DISTINCT winner)
FROM nobel
GROUP BY subject

Q8.
--------------
SELECT subject, COUNT(DISTINCT yr)
FROM nobel
GROUP BY subject

Q9.
--------------
SELECT yr
FROM nobel
WHERE subject = 'Physics'
GROUP BY yr
HAVING COUNT(winner) = 3

Q10.
---------------
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(winner) > 1

Q11.
---------------
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject) > 1

Q12.
---------------
SELECT yr, subject
FROM nobel
GROUP BY yr, subject
HAVING yr >= 2000 AND COUNT(winner) = 3