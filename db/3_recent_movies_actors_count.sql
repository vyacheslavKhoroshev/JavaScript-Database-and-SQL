SELECT 
    m.id,
    m.title,
    COUNT(DISTINCT c.actor_id) AS actors_count
FROM Movie m
LEFT JOIN Character c ON m.id = c.movie_id AND c.actor_id IS NOT NULL
WHERE m.release_date >= CURRENT_DATE - INTERVAL '15 years'
GROUP BY m.id, m.title
ORDER BY actors_count DESC, m.release_date DESC;