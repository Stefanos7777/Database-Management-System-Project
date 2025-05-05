UPDATE Movie
SET AVG_Rating = (
    SELECT AVG(rating)
    FROM Ratings
    WHERE Ratings.movie_id = Movie.id
)
WHERE EXISTS (
    SELECT 1
    FROM Ratings
    WHERE Ratings.movie_id = Movie.id
);
