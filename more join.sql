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
------------------
SELECT name
FROM actor JOIN (SELECT actorid FROM casting 
								JOIN movie ON casting.movieid = movie.id
								WHERE movie.title = 'Alien') C
ON actor.id = C.actorid

Q8.
-------------------
SELECT title 
FROM movie JOIN (SELECT movieid FROM casting
									JOIN actor ON casting.actorid = actor.id
									WHERE actor.name = 'Harrison Ford') I
ON movie.id = I.movieid


Q9.
--------------------
SELECT title 
FROM movie JOIN (SELECT movieid FROM casting
									JOIN actor ON casting.actorid = actor.id
									WHERE actor.name = 'Harrison Ford' AND casting.ord != 1) I
ON movie.id = I.movieid


Q10.
-------------------
SELECT movie.title, actor.name 
FROM casting JOIN movie 
ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962 AND casting.ord = 1

Q11.
-------------------
SELECT movie.yr, COUNT(DISTINCT movie.id) AS num_of_movie_year
FROM casting JOIN movie
ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name =  'John Travolta'
GROUP BY movie.yr
HAVING num_of_movie_year > 2


-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
Q12.
------------------
SELECT movie.title, actor.name
FROM movie JOIN casting
ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN
	(SELECT casting.movieid 
	FROM casting JOIN actor
	ON casting.actorid = actor.id
	WHERE actor.name = 'Julie Andrews') AND casting.ord = 1 

-- another answer(slightly modified)
SELECT title, name
FROM movie JOIN casting 
ON (movie.id = casting.movieid AND casting.ord = 1)
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN
	(SELECT movieid
	 FROM casting 
	 WHERE actorid IN 
	 	(SELECT id 
	 		FROM actor
	 		WHERE name = 'Julie Andrews'))
	
-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
Q13.
-----------------
SELECT actor.name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 30


-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
Q14.
----------------
SELECT movie.title, COUNT(casting.actorid) AS num_of_actors
FROM movie JOIN casting
ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY num_of_actors DESC, movie.title


-- List all the people who have worked with 'Art Garfunkel'.
Q15.
-------------------
SELECT actor.name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE casting.movieid IN 
		(SELECT movie.id
		FROM movie JOIN casting
		ON movie.id = casting.movieid
		JOIN actor ON actor.id = casting.actorid
		WHERE actor.name = 'Art Garfunkel') AND actor.name != 'Art Garfunkel'
		
-- added another correct query
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name