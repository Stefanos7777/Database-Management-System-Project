-- 1. Αριθμός ταινιών ανά έτος (year, movies_per_year) για ταινίες με συνολικό budget μεγαλύτερο από 1,000,000
SELECT YEAR(release_date) AS year, COUNT(*) AS movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY YEAR(release_date)

-- 2. Αριθμός ταινιών ανά είδος (genre, movies_per_genre) για ταινίες που έχουν συνολικό budget μεγαλύτερο από 1,000,000 ή διάρκεια μεγαλύτερη από 2 ώρες
SELECT g.name AS genre, COUNT(*) AS movies_per_genre
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE m.budget > 1000000 OR m.runtime > 120
GROUP BY g.name

-- 3. Αριθμός ταινιών ανά είδος και ανά έτος (genre, year, movies_per_gy)
SELECT g.name AS genre, YEAR(m.release_date) AS year, COUNT(*) AS movies_per_gy
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
GROUP BY g.name, YEAR(m.release_date)

-- 4. Για τον αγαπημένο σας ηθοποιό, το σύνολο των εσόδων (revenue) για τις ταινίες στις οποίες έχει συμμετάσχει ανά έτος (year, revenues_per_year)
SELECT YEAR(m.release_date) AS year, SUM(m.revenue) AS revenues_per_year
FROM movie m
JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Bruce Willis'
GROUP BY YEAR(m.release_date)

-- 5. Το υψηλότερο budget ταινίας ανά έτος (year, max_budget), όταν το budget αυτό δεν είναι μηδενικό
SELECT YEAR(release_date) AS year, MAX(budget) AS max_budget
FROM movie
WHERE budget > 0
GROUP BY YEAR(release_date)

-- 6. Τις συλλογές του πίνακα Collection που αναφέρονται σε τριλογίες, δηλαδή η συλλογή έχει ακριβώς 3 ταινίες (trilogy_name)
SELECT c.name AS trilogy_name
FROM collection c
JOIN belongsTocollection bc ON c.id = bc.collection_id
GROUP BY c.name
HAVING COUNT(*) = 3

-- 7. Για κάθε χρήστη του πίνακα Ratings, να επιστραφούν η μέση βαθμολογία του χρήστη και ο αριθμός των βαθμολογιών του (avg_rating, rating_count)
SELECT user_id, AVG(rating) AS avg_rating, COUNT(*) AS rating_count
FROM ratings
GROUP BY user_id

-- 8. Οι 10 ταινίες με το υψηλότερο budget (movie_title, budget)
SELECT TOP 10 title AS movie_title, budget
FROM movie
WHERE budget > 0
ORDER BY budget DESC

-- 9. Χρησιμοποιώντας το ερώτημα 5, βρείτε με εμφώλευση την ταινία (ταινίες) 
--    με το μεγαλύτερο budget ανά χρονιά (year, movies_with_max_budget), έχοντας ταξινόμηση ως προς το έτος και το όνομα της ταινίας
SELECT m.release_date, m.title AS movies_with_max_budget
FROM movie m
JOIN (
    SELECT YEAR(release_date) AS year, MAX(budget) AS max_budget
    FROM movie
    WHERE budget > 0
    GROUP BY YEAR(release_date)
) b ON YEAR(m.release_date) = b.year AND m.budget = b.max_budget
ORDER BY m.release_date, m.title

-- 10. Προσδιορίστε το ερώτημα το οποίο θα χρησιμοποιηθεί για να φτιάξουμε ένα view (όψη)
--     με το όνομα Popular_Movie_Pairs που περιέχει όλα τα ζεύγη ταινιών και την δημοφιλία τους. 
CREATE VIEW Popular_Movie_Pairs AS
SELECT m1.id AS movie1_id, m1.title AS movie1_title, m2.id AS movie2_id, m2.title AS movie2_title, COUNT(DISTINCT r1.user_id) AS popularity
FROM movie m1
JOIN movie m2 ON m1.id < m2.id
JOIN ratings r1 ON r1.movie_id = m1.id
JOIN ratings r2 ON r2.movie_id = m2.id
WHERE r1.rating >= 4 AND r2.rating >= 4
GROUP BY m1.id, m1.title, m2.id, m2.title
HAVING COUNT(DISTINCT r1.user_id) > 10;


