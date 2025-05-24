SELECT * FROM ARTISTS

SELECT * FROM ALBUMS

SELECT * FROM SONGS

			
					--PART-A

--1. Retrieve a unique genre of songs. 

SELECT DISTINCT GENRE FROM SONGS

--2. Find top 2 albums released before 2010. 

SELECT TOP 2 * FROM ALBUMS
WHERE RELEASE_YEAR < 2010

--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 

INSERT INTO SONGS VALUES(1245,'ZAROOR',2.55,'FEEL GOOD',1005)

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’ 

UPDATE SONGS
SET GENRE = 'HAPPY'
WHERE GENRE = 'ZAROOR'

--5. Delete an Artist ‘Ed Sheeran’ 

DELETE FROM ARTISTS
WHERE ARTIST_NAME = 'ED SHEERAN'

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)] 

ALTER TABLE SONGS
ADD RATINGS DECIMAL(3,2)

--7. Retrieve songs whose title starts with 'S'.

SELECT * FROM SONGS
WHERE SONG_TITLE LIKE 'S%'

--8. Retrieve all songs whose title contains 'Everybody'. 

SELECT * FROM SONGS
WHERE SONG_TITLE LIKE '%EVERYBODY%'

--9. Display Artist Name in Uppercase.

SELECT UPPER(ARTIST_NAME) FROM ARTISTS

--10. Find the Square Root of the Duration of a Song ‘Good Luck’ 

SELECT SQRT(DURATION) FROM SONGS
WHERE SONG_TITLE = 'GOOD LUCK'

--11. Find Current Date. 

SELECT GETDATE()

--12. Find the number of albums for each artist. 

SELECT COUNT(ALBUMS.ALBUM_ID),ARTISTS.ARTIST_NAME 
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID = ALBUMS.ARTIST_ID
GROUP BY ARTISTS.ARTIST_NAME

--13. Retrieve the Album_id which has more than 5 songs in it. 

SELECT ALBUMS.ALBUM_ID,COUNT(SONGS.SONG_ID)
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID = SONGS.ALBUM_ID
GROUP BY ALBUMS.ALBUM_ID
HAVING COUNT(SONGS.SONG_ID) > 5

--14. Retrieve all songs from the album 'Album1'. (using Subquery) 

SELECT SONG_TITLE FROM SONGS
WHERE ALBUM_ID IN (SELECT ALBUM_ID FROM ALBUMS
				   WHERE ALBUM_TITLE = 'ALBUM1')

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery) 

SELECT ALBUM_TITLE FROM ALBUMS
WHERE ARTIST_ID IN (SELECT ARTIST_ID FROM ARTISTS
				    WHERE ARTIST_NAME = 'APARSHAKTI KHURANA')

--16. Retrieve all the song titles with its album title.

SELECT SONGS.SONG_TITLE,ALBUMS.ALBUM_TITLE
FROM SONGS JOIN ALBUMS
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID

--17. Find all the songs which are released in 2020.

SELECT SONGS.SONG_TITLE 
FROM SONGS JOIN ALBUMS
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID
WHERE ALBUMS.RELEASE_YEAR = 2020

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105. 

CREATE VIEW FAVORITE_SONGS
AS
SELECT * FROM SONGS
WHERE SONG_ID > 100 AND SONG_ID < 106

SELECT * FROM FAVORITE_SONGS

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.

UPDATE FAVORITE_SONGS
SET SONG_TITLE = 'JANNAT'
WHERE SONG_ID = 101

--20. Find all artists who have released an album in 2020.

SELECT ARTISTS.ARTIST_NAME
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID = ALBUMS.ARTIST_ID
WHERE ALBUMS.RELEASE_YEAR = 2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.

SELECT SONGS.SONG_TITLE 
FROM SONGS JOIN ALBUMS
ON SONGS.ALBUM_ID = ALBUMS.ALBUM_ID
JOIN ARTISTS
ON ALBUMS.ARTIST_ID = ARTISTS.ARTIST_ID
WHERE ARTISTS.ARTIST_NAME = 'SHREYA GHOSHAL'



					--Part – B
					
--22. Retrieve all song titles by artists who have more than one album. 

SELECT S.SONG_TITLE
FROM SONGS S INNER JOIN ALBUMS AL
ON S.ALBUM_ID = AL.ALBUM_ID
INNER JOIN ARTISTS A
ON A.ARTIST_ID = AL.ARTIST_ID
WHERE A.ARTIST_ID IN (SELECT ARTIST_ID FROM ALBUMS
					  GROUP BY ARTIST_ID
					  HAVING COUNT(ALBUM_ID) > 1)

--23. Retrieve all albums along with the total number of songs. 

SELECT A.ALBUM_TITLE ,COUNT(S.SONG_ID)
FROM ALBUMS A INNER JOIN SONGS S
ON A.ALBUM_ID = S.ALBUM_ID
GROUP BY A.ALBUM_TITLE

--24. Retrieve all songs and release year and sort them by release year. 

SELECT A.RELEASE_YEAR ,S.SONG_TITLE
FROM ALBUMS A INNER JOIN SONGS S
ON A.ALBUM_ID = S.ALBUM_ID
GROUP BY A.RELEASE_YEAR,S.SONG_TITLE

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs. 

SELECT COUNT(SONG_ID),GENRE FROM SONGS
GROUP BY GENRE
HAVING COUNT(SONG_ID) > 2

--26. List all artists who have albums that contain more than 3 songs. 

SELECT A.ARTIST_NAME , COUNT(S.SONG_ID) 
FROM ARTISTS A INNER JOIN ALBUMS AL
ON A.ARTIST_ID = AL.ARTIST_ID
INNER JOIN SONGS S
ON AL.ALBUM_ID = S.ALBUM_ID
GROUP BY A.ARTIST_NAME , AL.ALBUM_ID
HAVING COUNT(S.SONG_ID) > 3