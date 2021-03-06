Q1.
-------------------
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
Q2.
-------------------
SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012

Q3.
-------------------
SELECT player, goal.teamid,stadium, game.mdate
  FROM game JOIN goal ON (id=matchid)
WHERE goal.teamid = 'GER'

Q4.
-------------------
SELECT game.team1, game.team2, goal.player
FROM game JOIN goal
ON game.id = goal.matchid
WHERE goal.player LIKE 'Mario%'

Q5.
-------------------
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam
ON teamid = id
 WHERE gtime<=10
 
Q6.
-------------------
SELECT game.mdate, eteam.teamname
FROM game JOIN eteam
ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

Q7.
-------------------
SELECT goal.player
FROM goal JOIN game 
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw'


Q8.
-------------------
SELECT DISTINCT goal.player
FROM goal JOIN game
ON goal.matchid = game.id
WHERE (game.team1 = 'GER' AND goal.teamid != game.team1) OR (game.team2 = 'GER' AND goal.teamid != game.team2)


Q9.
-------------------
SELECT eteam.teamname, COUNT(goal.gtime)
FROM eteam JOIN goal
ON eteam.id = goal.teamid
GROUP BY eteam.teamname


Q10.
-------------------
SELECT game.stadium, COUNT(goal.gtime)
FROM game JOIN goal
ON game.id = goal.matchid
GROUP BY game.stadium

Q11.
-------------------
SELECT goal.matchid, MIN(game.date), COUNT(goal.gtime)
FROM game JOIN goal
ON game.id = goal.matchid
WHERE game.team1 = 'POL' OR game.team2 = 'POL'
GROUP BY goal.matchid

Q12.
-------------------
SELECT goal.matchid, MIN(game.mdate), COUNT(goal.player)
FROM game JOIN goal
ON game.id = goal.matchid
GROUP BY goal.teamid, goal.matchid
HAVING goal.teamid = 'GER'


SELECT matchid, mdate, COUNT(*) AS num_goals
FROM game JOIN goal
ON game.id = goal.matchid
WHERE (team1 = 'GER' AND teamid = 'GER') OR (team2 = 'GER' AND teamid = 'GER')
GROUP BY 1,2

Q13.
-------------------
-- using a left join here because maybe there is one match that has no goals, so that there is no record in the 'goal' table
SELECT MIN(game.mdate), MIN(game.team1), SUM(CASE WHEN goal.teamid = game.team1 THEN 1 Else 0 END) AS score1, MIN(game.team2), 
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS score2 
FROM game LEFT JOIN goal ON (game.id = goal.matchid)
GROUP BY game.id
ORDER BY game.mdate, goal.matchid, game.team1, game.team2