INSERT INTO Country (name) VALUES 
('USA'), 
('UK'), 
('France'), 
('Canada'), 
('New Zealand'), 
('Germany'), 
('Australia');

INSERT INTO File (id, file_name, mime_type, file_key, public_url) VALUES
(1, 'john_avatar.jpg', 'image/jpeg', 'avatars/john_avatar.jpg', 'https://s3.example.com/avatars/john_avatar.jpg'),
(2, 'alice_avatar.jpg', 'image/jpeg', 'avatars/alice_avatar.jpg', 'https://s3.example.com/avatars/alice_avatar.jpg'),
(3, 'inception_poster.jpg', 'image/jpeg', 'posters/inception.jpg', 'https://s3.example.com/posters/inception.jpg'),
(4, 'beauty_poster.jpg', 'image/jpeg', 'posters/beauty.jpg', 'https://s3.example.com/posters/beauty.jpg'),
(5, 'lotr_poster.jpg', 'image/jpeg', 'posters/lotr.jpg', 'https://s3.example.com/posters/lotr.jpg'),
(6, 'matrix_poster.jpg', 'image/jpeg', 'posters/matrix.jpg', 'https://s3.example.com/posters/matrix.jpg'),
(7, 'leo_photo.jpg', 'image/jpeg', 'photos/leo.jpg', 'https://s3.example.com/photos/leo.jpg'),
(8, 'emma_photo.jpg', 'image/jpeg', 'photos/emma.jpg', 'https://s3.example.com/photos/emma.jpg'),
(9, 'peter_photo.jpg', 'image/jpeg', 'photos/peter.jpg', 'https://s3.example.com/photos/peter.jpg'),
(10, 'keanu_photo.jpg', 'image/jpeg', 'photos/keanu.jpg', 'https://s3.example.com/photos/keanu.jpg'),
(11, 'natalie_photo.jpg', 'image/jpeg', 'photos/natalie.jpg', 'https://s3.example.com/photos/natalie.jpg');

INSERT INTO Genre (name) VALUES 
('Action'), 
('Drama'), 
('Comedy'),
('Fantasy'),
('Sci-Fi'),
('Thriller');

INSERT INTO Users (username, first_name, last_name, email, password, avatar_file_id) VALUES
('jdoe', 'John', 'Doe', 'john@example.com', 'hashedpassword1', 1),
('asmith', 'Alice', 'Smith', 'alice@example.com', 'hashedpassword2', 2);

INSERT INTO Person (first_name, last_name, biography, date_of_birth, gender, country_id, primary_photo_id) VALUES
('Christopher', 'Nolan', 'British-American filmmaker known for complex storytelling.', '1970-07-30', 'male', 2, 7),
('Leonardo', 'DiCaprio', 'American actor and environmental activist.', '1974-11-11', 'male', 1, 7),
('Emma', 'Watson', 'British actress, activist, known for Harry Potter.', '1990-04-15', 'female', 2, 8),
('Peter', 'Jackson', 'New Zealand director, known for Lord of the Rings.', '1961-10-31', 'male', 5, 9),
('Keanu', 'Reeves', 'Canadian actor known for action movies.', '1964-09-02', 'male', 4, 10),
('Natalie', 'Portman', 'Israeli-American actress known for diverse roles.', '1981-06-09', 'female', 1, 11);

INSERT INTO Movie (title, description, budget, release_date, duration, director_id, country_id, poster_file_id) VALUES
('Inception', 'A skilled thief is given a chance at redemption if he can successfully perform an inception — planting an idea into a target''s subconscious.', 160000000, '2010-07-16', 148, 1, 1, 3),
('Beauty and the Beast', 'A romantic fantasy musical about a young woman and a cursed prince.', 255000000, '2017-03-17', 129, NULL, 2, 4),
('The Lord of the Rings: The Fellowship of the Ring', 'A hobbit sets out to destroy an ancient ring of power.', 93000000, '2001-12-19', 178, 4, 5, 5),
('The Matrix', 'A hacker discovers the nature of his reality and his role in the war against its controllers.', 63000000, '1999-03-31', 136, NULL, 4, 6);

INSERT INTO PersonPhoto (person_id, file_id, is_primary) VALUES
(2, 7, TRUE),
(3, 8, TRUE),
(4, 9, TRUE),
(5, 10, TRUE),
(6, 11, TRUE);


INSERT INTO MovieGenre (movie_id, genre_id) VALUES
(1, 1), (1, 2), (1, 5), -- Inception: Action, Drama, Sci-Fi
(2, 2), (2, 3), (2, 4), -- Beauty: Drama, Comedy, Fantasy
(3, 1), (3, 2), (3, 4), -- LOTR: Action, Drama, Fantasy
(4, 1), (4, 5), (4, 6); -- Matrix: Action, Sci-Fi, Thriller

INSERT INTO Character (name, description, role, movie_id, actor_id) VALUES
('Dom Cobb', 'A skilled extractor, haunted by his past.', 'leading', 1, 2),
('Belle', 'A young woman with a love for books.', 'leading', 2, 3),
('Frodo Baggins', 'A hobbit tasked with carrying the One Ring.', 'leading', 3, NULL),
('Gandalf', 'A wise wizard guiding the Fellowship.', 'supporting', 3, NULL),
('Neo', 'The One, destined to free humanity.', 'leading', 4, 5),
('Trinity', 'A skilled hacker and fighter.', 'supporting', 4, NULL);

INSERT INTO FavoriteMovie (user_id, movie_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4);
