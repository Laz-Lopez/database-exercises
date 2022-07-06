USE albums_db;
SELECT * from albums;

-- Explore the structure of the albums table.

-- a. How many rows are in the albums table?
-- 31
-- b. How many unique artist names are in the albums table?
SELECT  DISTINCT artist
FROM albums;
-- 23
-- c. What is the primary key for the albums table?
Describe albums;
-- id
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
-- 1967
-- 2011
-- Write queries to find the following information:

-- a. The name of all albums by Pink Floyd
SELECT * 
FROM albums 
WHERE artist = 'pink floyd';

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT 
	release_date AS Year_Released,
    artist AS BAND_NAME,
    name AS ALBUM_NAME
    FROM albums
    WHERE name = "Sgt. Pepper's Lonely Hearts Club band";

-- c. The genre for the album Nevermind
SELECT 
	genre
    FROM albums
    WHERE name = 'nevermind';
    
-- d. Which albums were released in the 1990s
SELECT
	name 
    FROM albums
    WHERE release_date between 1989 and 2000;

-- e. Which albums had less than 20 million certified sales
SELECT
	name
    FROM albums
    WHERE sales < 20;
-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT 
	name
    FROM albums
    WHERE genre = 'Rock';
-- becasue we didnt use containt or sounds like or is like 