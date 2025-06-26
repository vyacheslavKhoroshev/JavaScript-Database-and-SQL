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
    ) as director,
    json_build_object(
        'id', pf.id,
        'file_name', pf.file_name,
        'mime_type', pf.mime_type,
        'public_url', pf.public_url
    ) as director_photo,
    (
        SELECT json_agg(
            json_build_object(
                'id', actor.id,
                'first_name', actor.first_name,
                'last_name', actor.last_name,
                'photo', json_build_object(
                    'id', actor_photo.id,
                    'file_name', actor_photo.file_name,
                    'mime_type', actor_photo.mime_type,
                    'public_url', actor_photo.public_url
                )
            )
        )
        FROM Character c
        JOIN Person actor ON c.actor_id = actor.id
        LEFT JOIN PersonPhoto pp ON actor.id = pp.person_id AND pp.is_primary = TRUE
        LEFT JOIN File actor_photo ON pp.file_id = actor_photo.id
        WHERE c.movie_id = m.id AND c.actor_id IS NOT NULL
    ) as actors,
    (
        SELECT json_agg(
            json_build_object(
                'id', g.id,
                'name', g.name
            )
        )
        FROM MovieGenre mg
        JOIN Genre g ON mg.genre_id = g.id
        WHERE mg.movie_id = m.id
    ) as genres
FROM Movie m
LEFT JOIN File f ON m.poster_file_id = f.id
LEFT JOIN Person p ON m.director_id = p.id
LEFT JOIN PersonPhoto pp ON p.id = pp.person_id AND pp.is_primary = TRUE
LEFT JOIN File pf ON pp.file_id = pf.id
WHERE m.id = 1; 