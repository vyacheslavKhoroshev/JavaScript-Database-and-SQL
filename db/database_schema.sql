
CREATE TYPE gender_enum AS ENUM ('male', 'female', 'other');
CREATE TYPE role_enum AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 2. File table (no dependencies)
CREATE TABLE File (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    file_key VARCHAR(255) NOT NULL UNIQUE,
    public_url VARCHAR(500) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_file_id INT REFERENCES File(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender gender_enum,
    country_id INT REFERENCES Country(id) ON DELETE SET NULL,
    primary_photo_id INT REFERENCES File(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    budget DECIMAL(15,2),
    release_date DATE,
    duration SMALLINT, 
    director_id INT REFERENCES Person(id) ON DELETE SET NULL,
    country_id INT REFERENCES Country(id) ON DELETE SET NULL,
    poster_file_id INT REFERENCES File(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE PersonPhoto (
    id SERIAL PRIMARY KEY,
    person_id INT NOT NULL REFERENCES Person(id) ON DELETE CASCADE,
    file_id INT NOT NULL REFERENCES File(id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX unique_primary_photo_per_person
ON PersonPhoto (person_id)
WHERE is_primary = TRUE;

CREATE TABLE MovieGenre (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL REFERENCES Movie(id) ON DELETE CASCADE,
    genre_id INT NOT NULL REFERENCES Genre(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE(movie_id, genre_id)
);

CREATE TABLE Character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role role_enum NOT NULL,
    movie_id INT NOT NULL REFERENCES Movie(id) ON DELETE CASCADE,
    actor_id INT REFERENCES Person(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE FavoriteMovie (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    movie_id INT NOT NULL REFERENCES Movie(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, movie_id)
);

CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_person_name ON Person(first_name, last_name);
CREATE INDEX idx_person_country ON Person(country_id);
CREATE INDEX idx_movie_title ON Movie(title);
CREATE INDEX idx_movie_release_date ON Movie(release_date);
CREATE INDEX idx_movie_director ON Movie(director_id);
CREATE INDEX idx_movie_country ON Movie(country_id);
CREATE INDEX idx_character_movie ON Character(movie_id);
CREATE INDEX idx_character_actor ON Character(actor_id);
CREATE INDEX idx_favorite_movie_user ON FavoriteMovie(user_id);
CREATE INDEX idx_favorite_movie_movie ON FavoriteMovie(movie_id);
CREATE INDEX idx_movie_genre_movie ON MovieGenre(movie_id);
CREATE INDEX idx_movie_genre_genre ON MovieGenre(genre_id);
CREATE INDEX idx_person_photo_person ON PersonPhoto(person_id);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_country_updated_at BEFORE UPDATE ON Country FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_file_updated_at BEFORE UPDATE ON File FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_genre_updated_at BEFORE UPDATE ON Genre FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON Users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_person_updated_at BEFORE UPDATE ON Person FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_movie_updated_at BEFORE UPDATE ON Movie FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_person_photo_updated_at BEFORE UPDATE ON PersonPhoto FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_movie_genre_updated_at BEFORE UPDATE ON MovieGenre FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_character_updated_at BEFORE UPDATE ON Character FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_favorite_movie_updated_at BEFORE UPDATE ON FavoriteMovie FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE Users IS 'Stores user account information with authentication data';
COMMENT ON TABLE File IS 'Stores metadata for files stored in external services (S3)';
COMMENT ON TABLE Country IS 'Stores countries for origin information';
COMMENT ON TABLE Person IS 'Stores information about people (actors, directors)';
COMMENT ON TABLE PersonPhoto IS 'Links people to their photos with primary photo designation';
COMMENT ON TABLE Genre IS 'Stores movie genres';
COMMENT ON TABLE Movie IS 'Stores movie information with director and country';
COMMENT ON TABLE MovieGenre IS 'Junction table linking movies to genres';
COMMENT ON TABLE Character IS 'Stores movie characters with optional actor assignments';
COMMENT ON TABLE FavoriteMovie IS 'Stores user favorite movie preferences';
