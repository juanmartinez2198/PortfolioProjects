 /*
Netflix Data Exploration
Skills Used: Case Statements, Wildcard Characters, Counts, Distinct Queries, Aggregate Functions
 */



-- Selecting all data to see what kind of information is stored in the database -- 

SELECT *
FROM dbo.netflix_titles
order by show_id



-- Looking at the amount of movies VS tv shows titles in the database --

SELECT count(*)
FROM dbo.netflix_titles
WHERE type = 'Movie'

SELECT count(*)
FROM dbo.netflix_titles
WHERE type = 'TV Show'



-- Looking at all the movies where an specific actor/actress was part of the cast -- 

SELECT title
FROM dbo.netflix_titles
WHERE cast LIKE 'Anne Hathaway%'

SELECT title
FROM dbo.netflix_titles
WHERE cast LIKE 'Kevin Hart%'



-- Looking at oldest and newest movies added to the database and their release year -- 

SELECT title, min(release_year) as 'Release Year Of Oldest Movie'
FROM dbo.netflix_titles
WHERE type = 'Movie'
group by title, release_year
order by release_year asc
limit 1;

SELECT title, max(release_year) as 'Release Year Of Newest Movie'
FROM dbo.netflix_titles
WHERE type = 'Movie'
group by title, release_year
order by release_year desc
limit 1;



-- Looking at the total amount of movies made by each country --

SELECT distinct country, count(country)
FROM dbo.netflix_titles
WHERE country IS NOT null
group by country
order by country



-- Looking at longest tv shows and movies added to the database -- 

SELECT title, dbo.netflix_titles.duration
FROM dbo.netflix_titles
WHERE type = 'Movie' and duration IS NOT null
order by duration

SELECT title, dbo.netflix_titles.duration
FROM dbo.netflix_titles
WHERE type = 'TV Show' and duration IS NOT null
order by duration desc



-- Looking at a Case Statement that filters Local Movies vs International Movies

SELECT title, Country,
CASE
    WHEN country = 'United States' THEN 'Local Movie'
    ELSE 'The movie is international'
END AS 'Where Is The Movie From'
FROM dbo.netflix_titles
WHERE Country IS NOT NULL;
