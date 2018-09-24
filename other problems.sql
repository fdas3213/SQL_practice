
Q1. 
-------------------
SELECT date, COUNT(DISTINCT ssession_id)/COUNT(user_id) AS avg_number_session_per_user
FROM A 
GROUP BY date

Q2. ?
-------------------
SELECT time_spent, COUNT(DISTINCT user_id) AS number_of_user 
FROM  A JOIN B 
ON A.session_id = b.session_id
GROUP BY time_spent

Q597.
-------------------
SELECT COALESCE(ROUND(COUNT(DISTINCT requester_id, accepter_id)/
			COUNT(DISTINCT sender_id, send_to_id), 2), 0) AS accept_rate
FROM friend_request, request_accepted
			
Q602.
------------------
SELECT id1 AS id, COUNT() AS num_friendss
FROM (SELECT requester_id AS id1, accepter_id AS id id2 FROM request_accepted 
			UNION
			SELECT accepter_id AS id1, requester_id AS id id2 FROM request_accepted) tmp
GROUP BY id1
ORDER BY COUNT()
LIMIT 1


Q578.
------------------
SELECT tmp.question_id AS survey_log
FROM	(SELECT question_id, CASE WHEN action = 'answer' THEN 1 ELSE 0 END AS answer 
			FROM q_table) tmp
GROUP BY tmp.question_id
ORDER BY SUM(tmp.answer) DESC
LIMIT 1