 /*
Spotify Top 10 Data Exploration 
 */


-- Selecting Data that we are going to be starting with -- 

SELECT * 
FROM PortfolioProject..top10



-- Looking at the total number of songs in the database --

SELECT count(*)
FROM PortfolioProject..top10



-- Looking at the total number of songs per genre -- 

SELECT count(*) as 'Total Pop Songs'
FROM PortfolioProject..top10
WHERE PortfolioProject..top10.[top genre] = 'pop'

SELECT count(*) as 'Total Hip Hop Songs'
FROM PortfolioProject..top10
WHERE PortfolioProject..top10.[top genre] = 'hip hop'

SELECT count(*) as 'Total Dance Pop Songs'
FROM PortfolioProject..top10
WHERE PortfolioProject..top10.[top genre] = 'dance pop'

SELECT count(*) as 'Total Electropop Songs'
FROM PortfolioProject..top10
WHERE PortfolioProject..top10.[top genre] = 'electropop'



-- Looking at the songs released by specific artists --

SELECT title, artist, year
FROM PortfolioProject..top10
WHERE artist = 'Eminem'

SELECT title, artist, year
FROM PortfolioProject..top10
WHERE artist = 'Rihanna'

SELECT title, artist, year
FROM PortfolioProject..top10
WHERE artist = 'Taylor Swift'



-- Looking at songs with a bpm higher than 170 -- 

SELECT title, artist, year, bpm
FROM PortfolioProject..top10
WHERE bpm > 170
order by bpm desc



-- Looking at total amount of songs per artitst --

SELECT count(*) as 'Songs From Justin Bieber'
FROM PortfolioProject..top10
WHERE artist = 'Justin Bieber'

SELECT count(*) as 'Songs From Bruno Mars'
FROM PortfolioProject..top10
WHERE artist = 'Bruno Mars'

SELECT count(*) as 'Songs From Lady Gaga'
FROM PortfolioProject..top10
WHERE artist = 'Lady Gaga'

SELECT count(*) as 'Songs From Adele'
FROM PortfolioProject..top10
WHERE artist = 'Adele'
