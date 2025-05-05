CREATE TRIGGER Update_AVG_Rating
ON Ratings
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted) -- Έλεγχος για εισαγμένες γραμμές
    BEGIN
        UPDATE Movie
        SET AVG_Rating = (
            SELECT AVG(rating)
            FROM Ratings
            WHERE Ratings.movie_id = Movie.id
        )
        WHERE Movie.id IN (SELECT movie_id FROM inserted);
    END
    ELSE IF EXISTS (SELECT * FROM deleted) -- Έλεγχος για διαγραμμένες γραμμές
    BEGIN
        UPDATE Movie
        SET AVG_Rating = (
            SELECT AVG(rating)
            FROM Ratings
            WHERE Ratings.movie_id = Movie.id
        )
        WHERE Movie.id IN (SELECT movie_id FROM deleted);
    END
END;
