Q1.
-------------------
SELECT id, title
 FROM movie
 WHERE yr=1962
  
Q2.
-------------------
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane'

Q3.
-------------------
SELECT id, title, yr
FROM movie
WHERE  title LIKE 'Star Trek%'
ORDER BY yr

Q4.
-------------------
SELECT id
FROM actor
WHERE name = 'Glenn Close'

Q5.
-------------------
SELECT id 
FROM movie
WHERE title = 'Casablanca'

Q6.
-------------------
SELECT name
FROM actor JOIN (SELECT actorid FROM casting 
								JOIN movie ON casting.movieid = movie.id
								WHERE movie.title = 'Alien') C
ON actor.id = C.actorid

Q7.
-------------------
SELECT title 
FROM movie JOIN (SELECT movieid FROM casting
									JOIN actor ON casting.actorid = actor.id
									WHERE actor.name = 'Harrison Ford' AND casting.ord != 1) I
ON movie.id = I.movieid


Q8.
-------------------
SELECT movie.title, actor.name 
FROM casting JOIN movie 
ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962 AND casting.ord = 1