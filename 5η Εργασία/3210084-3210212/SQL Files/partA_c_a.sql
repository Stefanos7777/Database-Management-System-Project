SELECT movie_id, AVG(rating) AS average_rating
FROM Ratings
GROUP BY movie_id
HAVING AVG(rating) > 4;

