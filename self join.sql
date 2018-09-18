Q1.
-- How many stops are in the database.
SELECT COUNT(DISTINCT stop)
FROM route

Q2.
-- Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

Q3.
-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT stops.id, stops.name
FROM stops INNER JOIN route
ON stops.id = route.stop
WHERE route.num = '4' AND route.company = 'LRT'

Q4.
-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
-- Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes
SELECT company, num, COUNT(*) AS stop_num
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING stop_num =2


Q5.
-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. 
-- Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = 149


Q6.
-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. 
-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
-- If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'London Road'


Q7.
-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.id = 115 AND stopb.id = 137
 GROUP BY a.num, a.company


Q8.
-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'


Q9.
-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, 
-- offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' 

Q10.
-- Find the routes involving two buses that can go from Craiglockhart to Sighthill.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
SELECT DISTINCT S.num, S.company, stops.name, E.num, E.company
FROM
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Craiglockhart')
)S
  JOIN
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Sighthill')
)E
ON (S.stop = E.stop)
JOIN stops ON(stops.id = S.stop)






