SELECT person_id
FROM Person
GROUP BY person_id
HAVING COUNT(DISTINCT name) > 1 OR COUNT(DISTINCT gender) > 1;

UPDATE movie_cast
SET person_id = (SELECT MIN(person_id)
                 FROM Person
                 WHERE Person.person_id = movie_cast.person_id)
WHERE person_id IN (SELECT person_id
                    FROM Person
                    GROUP BY person_id
                    HAVING COUNT(DISTINCT name) > 1 OR COUNT(DISTINCT gender) > 1);

UPDATE movie_crew
SET person_id = (SELECT MIN(person_id)
                 FROM Person
                 WHERE Person.person_id = movie_crew.person_id)
WHERE person_id IN (SELECT person_id
                    FROM Person
                    GROUP BY person_id
                    HAVING COUNT(DISTINCT name) > 1 OR COUNT(DISTINCT gender) > 1);
