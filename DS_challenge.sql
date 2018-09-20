P2
--------------------------
SELECT SUM(CASE WHEN m.user_id IS NOT NULL AND w.user_id IS NULL THEN 1 ELSE 0 END)/COUNT(*)*100 AS mobile_percent,
SUM(CASE WHEN w.user_id IS NOT NULL AND m.user_id IS NULL THEN 1 ELSE 0 END)/COUNT(*)*100 AS web_percent,
SUM(CASE WHEN w.user_id IS NOT NULL AND m.user_id IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*)*100 AS both_percent
FROM 
(SELECT DISTINCT user_id FROM data_mobile) m 
OUTER JOIN 
(SELECT DISTINCT user_id FROM data_web) w
ON m.user_id = w.user_id


P3
-------------------------
SELECT user_id, date
FROM (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY date) AS tenth_date 
	FROM data) d
WHERE tenth_date = 10 


P4 a.
-----------------------
SELECT user_id, SUM(transaction_amount) as total
FROM (SELECT * FROM data_march 
			UNION ALL
			SELECT * FROM data_april) data
GROUP BY user_id
ORDER BY user_id

P4 b.
---------------------
SELECT user_id, date, SUM(total_amount) OVER (PARTITION BY user_id ORDER BY date) AS cumsum
FROM (SELECT user_id, date, SUM(transaction_amount) as total_amount
			FROM data_march
			GROUP BY user_id, date
			UNION ALL
			SELECT user_id,date,SUM(transaction_amount) as total_amount
			 FROM data_april
			 GROUP BY user_id, date) data
ORDER BY user_id, date


P6 a.
--------------------
SELECT country, user_count
	(SELECT *, ROW_NUMBER() OVER(ORDER BY user_count) AS count_up,
				ROW_NUMBER() OVER (ORDER BY user_count DESC) AS count_down
				FROM 
			(SELECT country, COUNT(DISTINCT user_id) as user_count
			FROM data
			GROUP BY country) a 
		) tmp
WHERE count_up = 1 or count_down = 1

P6 b.
---------------------
SELECT user_id, country, created_at
	(SELECT *
		  ROW_NUMBER() OVER(PARTITION BY country ORDER BY created_at DESC) AS country_time_desc,
	  	ROW_NUMBER() OVER(PARTITION BY country ORDER BY created_at) AS country_time_asc
	FROM data) tmp
WHERE country_time_desc = 1 or country_time_asc = 1
