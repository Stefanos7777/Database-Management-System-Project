ALTER TABLE movie ADD CONSTRAINT pk_movie PRIMARY KEY (id);

ALTER TABLE genre ADD CONSTRAINT pk_genre PRIMARY KEY (id);

ALTER TABLE productioncompany ADD CONSTRAINT pk_productioncompany PRIMARY KEY (id);

ALTER TABLE collection ADD CONSTRAINT pk_collection PRIMARY KEY (id);

ALTER TABLE movie_cast ADD CONSTRAINT pk_movie_cast PRIMARY KEY (cid);

ALTER TABLE movie_crew ADD CONSTRAINT pk_movie_crew PRIMARY KEY (cid);

ALTER TABLE keyword ADD CONSTRAINT pk_keyword PRIMARY KEY (id);


ALTER TABLE belongsTocollection ADD CONSTRAINT fk_belongsTocollection_movie FOREIGN KEY (movie_id) REFERENCES movie(id);
ALTER TABLE belongsTocollection ADD CONSTRAINT fk_belongsTocollection_collection FOREIGN KEY (collection_id) REFERENCES collection(id);

ALTER TABLE hasGenre ADD CONSTRAINT fk_hasGenre_movie FOREIGN KEY (movie_id) REFERENCES movie(id);
ALTER TABLE hasGenre ADD CONSTRAINT fk_hasGenre_genre FOREIGN KEY (genre_id) REFERENCES genre(id);

ALTER TABLE hasProductioncompany ADD CONSTRAINT fk_hasProductioncompany_movie FOREIGN KEY (movie_id) REFERENCES movie(id);
ALTER TABLE hasProductionCompany ADD CONSTRAINT fk_hasProductionCompany_productioncompany FOREIGN KEY (pc_id) REFERENCES productioncompany(id);

ALTER TABLE Ratings ADD CONSTRAINT fk_Ratings_movie FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE movie_cast ADD CONSTRAINT fk_movie_cast_movie FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE movie_crew ADD CONSTRAINT fk_movie_crew_movie FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE hasKeyword ADD CONSTRAINT fk_hasKeyword_movie FOREIGN KEY (movie_id) REFERENCES movie(id);
ALTER TABLE hasKeyword ADD CONSTRAINT fk_hasKeyword_keyword FOREIGN KEY (keyword_id) REFERENCES keyword(id);