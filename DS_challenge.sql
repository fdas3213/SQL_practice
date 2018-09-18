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