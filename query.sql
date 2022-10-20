SELECT * FROM netflix.credits;

SELECT * FROM netflix.titles;

#query number of show and movie
SELECT type,count(*) FROM netflix.titles GROUP BY type;

#what country produce the most
SELECT production_countries, count(*) FROM netflix.titles GROUP BY production_countries;

#how many movie is comedy genre
SELECT count(*) comedy_genre_count FROM netflix.titles WHERE genres LIKE "%comedy%";

#what movies have the the most actors
SELECT t.title, count(c.person_id) total_actors FROM netflix.titles t
JOIN netflix.credits c ON t.id = c.id
WHERE c.role = "ACTOR"
GROUP BY t.title
ORDER BY total_actors DESC;

#the max movie run time by year
SELECT release_year, MAX(avg_runtime.average) longest_avg_runtime FROM
	(SELECT release_year, AVG(runtime) average FROM netflix.titles WHERE type = "movie") AS avg_runtime
GROUP BY release_year;

#create view for director_view
CREATE VIEW netflix.director_view AS(
SELECT c.name, t.title, t.type, t.description, t.release_year, t.age_certification, t.runtime, t.genres, t.production_countries
FROM netflix.titles t
JOIN netflix.credits c ON t.id = c.id
WHERE c.role = "director");

SELECT * FROM netflix.director_view;

#select the show and movie that have  imdb score more than average
SELECT * FROM netflix.titles
WHERE imdb_score > (SELECT AVG(imdb_score) FROM netflix.titles);

