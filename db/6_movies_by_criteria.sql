SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'public_url', f.public_url
    ) as poster,
    json_build_object(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) as director
FROM Movie m
LEFT JOIN File f ON m.poster_file_id = f.id
LEFT JOIN Person p ON m.director_id = p.id
WHERE m.country_id = 1
    AND m.release_date >= '2000-01-01'
    AND m.duration > 135 
    AND EXISTS (
        SELECT 1 FROM MovieGenre mg
        JOIN Genre g ON mg.genre_id = g.id
        WHERE mg.movie_id = m.id
        AND g.name IN ('Action', 'Drama')
    )
ORDER BY m.release_date DESC; 