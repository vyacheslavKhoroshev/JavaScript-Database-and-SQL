SELECT 
    p.id,
    p.first_name,
    p.last_name,
    SUM(m.budget) AS total_movies_budget
FROM Person p
JOIN Character c ON p.id = c.actor_id
JOIN Movie m ON c.movie_id = m.id
GROUP BY p.id, p.first_name, p.last_name
ORDER BY total_movies_budget DESC;