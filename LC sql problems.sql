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