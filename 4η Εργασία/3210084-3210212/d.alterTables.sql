ALTER TABLE hasGenre ADD CONSTRAINT pk_hasGenre PRIMARY KEY (genre_id,movie_id);

ALTER TABLE hasKeyword ADD CONSTRAINT pk_hasKeyword PRIMARY KEY (keyword_id,movie_id);

ALTER TABLE belongsTocollection ADD CONSTRAINT pk_belongsTocollection PRIMARY KEY (collection_id,movie_id);

ALTER TABLE hasProductioncompany ADD CONSTRAINT pk_hasProductioncompany PRIMARY KEY (pc_id,movie_id);

ALTER TABLE Ratings ADD CONSTRAINT pk_Ratings PRIMARY KEY (user_id,movie_id);
