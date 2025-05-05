SELECT movie_id, AVG(rating) AS average_rating
FROM Ratings
GROUP BY movie_id
HAVING AVG(rating) > 4;

CREATE INDEX idx_ratings_movie_id_rating ON Ratings (movie_id, rating);
