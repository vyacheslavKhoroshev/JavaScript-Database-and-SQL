SELECT 
    u.id,
    u.username,
    ARRAY_AGG(fm.movie_id) FILTER (WHERE fm.movie_id IS NOT NULL) AS favorite_movie_ids
FROM Users u
LEFT JOIN FavoriteMovie fm ON u.id = fm.user_id
GROUP BY u.id, u.username
ORDER BY u.id;