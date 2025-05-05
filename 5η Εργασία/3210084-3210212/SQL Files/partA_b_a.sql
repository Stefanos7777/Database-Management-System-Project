SELECT name, character
FROM movie JOIN movie_cast ON movie_id = id
WHERE title = 'Armageddon';

-- Create an index on the 'title' column of the 'movie' table
CREATE INDEX idx_movie_title ON movie (title);

-- Create an index on the 'movie_id' column of the 'movie_cast' table
CREATE INDEX idx_movie_cast_movie_id ON movie_cast (movie_id);




