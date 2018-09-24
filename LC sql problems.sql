P175
-------------------
SELECT p.FirstName, p.LastName, a.City, a.State
FROM Person p LEFT JOIN Address a
ON p.PersonId = a.PersonId

P176
-------------------
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary)
							FROM Employee)
							
P178
-------------------
SELECT Score, dense_rank() OVER (ORDER BY Score DESC) AS Rank
FROM Scores

Sol 2.-----------------
SELECT Score, (SELECT COUNT(DISTINCT Score) FROM Scores WHERE Score >= s.Score) AS Rank
FROM Scores s
ORDER BY s.Score DESC

P180
--------------------
SELECT DISTINCT a.Num AS ConsecutiveNums
FROM Logs a, Logs b, Logs c
WHERE a.Id = b.Id-1 AND b.Id = c.Id-1 AND a.Num = b.Num AND b.Num = c.Num

P181
--------------------
SELECT e1.Name AS Employee
FROM Employee e1 JOIN Employee e2
ON e1.ManagerId = e2.Id
WHERE e1.Salary > e2.Salary

P182
--------------------
SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(Id) > 1

P183
--------------------
SELECT c.Name AS Customers
FROM Customers c LEFT JOIN Orders o
ON c.Id = o.CustomerId
WHERE o.CustomerId IS NULL

P184
--------------------
SELECT t1.dep AS Department, e1.Name AS Employee, t1.max_salary AS Salary
FROM 
		(SELECT d.Name AS dep, D.Id AS dep_id, MAX(Salary) AS max_salary
		FROM Employee e JOIN Department d
		ON e.DepartmentId = d.Id 
		GROUP BY d.Name) t1 
JOIN Employee e1 ON t1.dep_id = e1.DepartmentId AND t1.max_salary = e1.Salary


P185
------------------
SELECT Department, person AS Employee, Salary AS Salary
FROM
    (SELECT e.Name AS person, Salary, d.Name AS Department, DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS dep_rank
    FROM Employee e JOIN Department d
    ON e.DepartmentId = d.Id) tmp
WHERE dep_rank = 1 or dep_rank = 2 or dep_rank = 3

P197
------------------
SELECT w1.Id
FROM Weather w1  JOIN Weather w2 
ON DATEDIFF(w1.RecordDate, w2.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature


P262
-----------------
SELECT tmp.Request_at AS Day ,  ROUND(SUM(tmp.cancel)/(0.0 +COUNT(tmp.Client_id)), 2)  AS 'Cancellation Rate'
FROM (SELECT *, CASE WHEN t.Status = 'completed' THEN 0 ELSE 1 END AS cancel 
			FROM Trips t JOIN Users u
			ON t.Client_Id = u.Users_id
			WHERE u.Banned = 'No' AND t.Request_at >= '2013-10-01' AND t.Request_at <= '2013-10-03') tmp
GROUP BY tmp.Request_at


P595
-----------------
SELECT name, population, area
FROM World
WHERE population > 25000000 OR area > 3000000


P601
-----------------
SELECT a.id, a.date, a.people
FROM stadium a, stadium b, stadium c
WHERE DATEDIFF(a.date, b.date) = 1 AND DATEDIFF(b.date,c.date) = 1 AND a.people >= 100 AND b.people >= 100 AND c.people >=100


P626
-----------------
SELECT id, CASE WHEN id%2=0 THEN (SELECT student FROM seat WHERE id=s.id-1)
	        WHEN id%2!= 0 AND id<(SELECT COUNT(*) FROM seat) THEN (SELECT student FROM seat WHERE id=s.id+1)
		ELSE student END AS student
FROM seat s