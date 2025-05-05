/* 1.Βρες τους τίτλους των ταινιών που η χαρακτηριστική τους ατάκα περιέχει την λέξη "love" και να εμφανιστεί μαζί η μέση βαθμολογία τους 
   και ο συνολικός αριθμός βαθμολογιών που έχουν λάβει.
   Output: 96 rows */

SELECT m.title, AVG(r.rating) AS avg_rating, COUNT(r.rating) AS num_ratings
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.tagline LIKE '%love%'
GROUP BY m.title;

/* 2.Εμφάνισε τους τίτλους των ταινιών και την ημερομηνία κυκλοφορίας τους για τις ταινίες που έχουν λάβει βαθμολογία από 3 έως 5. 
   Output: 25270 rows */

SELECT movie.title, movie.release_date
FROM movie
JOIN ratings ON movie.id = ratings.movie_id
WHERE ratings.rating BETWEEN 3 AND 5

/* 3.Εμφάνισε τον χαμηλότερο μέσο όρο αξιολόγησης για κάθε είδος ταινίας.
   Output: 9 rows */

SELECT g.name AS genre, MIN(r.rating) AS lowest_average_rating
FROM Genre g
JOIN hasGenre hg ON g.id = hg.genre_id
JOIN Movie m ON m.id = hg.movie_id
JOIN Ratings r ON m.id = r.movie_id
GROUP BY g.name

/* 4.Εμφάνισε τον τίτλο της ταινίας και τη μέγιστη βαθμολογία που έχει λάβει από τους χρήστες. 
    Output: 1501 rows */

SELECT m.title, MAX(r.rating) AS max_rating
FROM movie m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.title

/* 5.Εμφάνισε όλους τους τίτλους και τις λέξεις κλειδία κάθε ταινίας ταξινομημένους με αλφαβητική σειρά.
    Output: 58414 rows */

SELECT m.title, k.name
FROM movie m
LEFT OUTER JOIN hasKeyword hk ON m.id = hk.movie_id
LEFT OUTER JOIN keyword k ON hk.keyword_id = k.id
ORDER BY m.title ASC;

/* 6.Εμφάνισε τους τίτλους των ταινιών και τον αριθμό των λέξεων κλειδιών που έχουν συσχετιστεί με αυτές.
    Output: 1480 rows */

SELECT movie.title, COUNT(keyword.id)
FROM movie
JOIN keyword ON movie.id = keyword.id
GROUP BY movie.id, movie.title
ORDER BY COUNT( keyword.id) DESC

/* 7. Εμφάνισε τα ονόματα των ηθοποιών που έχουν παίξει σε ταινίες με αξιολόγηση μεγαλύτερη από 3.
    Output: 20169 rows */

SELECT DISTINCT movie_cast.name
FROM movie_cast
JOIN movie ON movie.id = movie_cast.movie_id
JOIN ratings ON ratings.movie_id = movie.id
WHERE ratings.rating > 3;

/* 8.Eμφάνισε τις 10 ταινίες με το υψηλότερο μέσο όρο αξιολόγησης.
    Output: 10 rows */

SELECT TOP 10 m.title, AVG(r.rating) AS avg_rating
FROM movie AS m
JOIN ratings AS r ON m.id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC

/* 9.Εμφάνισε τον τίτλο και τη βαθμολογία όλων των ταινιών που έχουν αξιολογηθεί.
    Output: 30162 rows */

SELECT movie.title, ratings.rating
FROM movie
JOIN ratings ON movie.id = ratings.movie_id

/* 10.Εμφάνισε τα 10 πιο δημοφιλή είδη ταινιών.
    Output: 9 rows */

SELECT TOP 10 g.name, AVG(m.popularity) as avg_popularity
FROM movie m
INNER JOIN hasGenre hg ON m.id = hg.movie_id
INNER JOIN genre g ON hg.genre_id = g.id
GROUP BY g.name
ORDER BY avg_popularity DESC

/* 11.Εμφάνισε τους τίτλους των ταινιών και τα ονόματα των ηθοποιών που έχουν συμμετάσχει σε αυτές, συμπεριλαμβανομένων και των ταινιών που δεν έχουν ηθοποιούς.
    Output: 160622 rows */

SELECT m.title, mc.name
FROM movie m
LEFT OUTER JOIN movie_cast mc ON m.id = mc.movie_id;

/* 12.Εμφάνισε όλους τους τίτλους των ταινιών και την βαθμολογία τους, συμπεριλαμβανομένων και των ταινίων που δεν εχουν αξιολογηθεί.
    Output: 38642 rows */

SELECT movie.title, ratings.rating AS rating
FROM movie
LEFT OUTER JOIN ratings ON movie.id = ratings.movie_id;

