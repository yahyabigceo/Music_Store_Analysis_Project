/*Q1: Write query to return the email, first name, last name, & Genre
of all Rock Music listeners. Return your list ordered alphabetically
by email starting with A*/
SELECT DISTINCT C.EMAIL,C.FIRST_NAME,C.LAST_NAME
FROM CUSTOMER AS C
JOIN INVOICE AS I ON C.CUSTOMER_ID=I.CUSTOMER_ID
JOIN INVOICE_LINE AS IL ON I.INVOICE_ID=IL.INVOICE_ID
WHERE TRACK_ID IN(
	SELECT TRACK_ID FROM TRACK AS T
	JOIN GENRE AS G ON T.GENRE_ID=G.GENRE_ID
	WHERE G.NAME='Rock')
ORDER BY EMAIL ASC
--ALTERNATE WAY OF SOLIVNG Q1
SELECT DISTINCT 
    C.EMAIL, 
    C.FIRST_NAME, 
    C.LAST_NAME, 
    G.NAME AS GENRE
FROM CUSTOMER AS C
JOIN INVOICE AS I ON C.CUSTOMER_ID = I.CUSTOMER_ID
JOIN INVOICE_LINE AS IL ON I.INVOICE_ID = IL.INVOICE_ID
JOIN TRACK AS T ON IL.TRACK_ID = T.TRACK_ID
JOIN GENRE AS G ON T.GENRE_ID = G.GENRE_ID
WHERE G.NAME = 'Rock'
ORDER BY C.EMAIL ASC;

/*Q2: Let's invite the artists who have written the most rock music in
our dataset. Write a query that returns the Artist name and total
track count of the top 10 rock bands*/
SELECT * FROM TRACK AS T
SELECT ART.ARTIST_ID,ART.NAME,COUNT(ART.ARTIST_ID) AS NUMBER_OF_SONGS
FROM TRACK AS T
JOIN ALBUM AS A ON A.ALBUM_ID=T.ALBUM_ID
JOIN ARTIST AS ART ON ART.ARTIST_ID=A.ARTIST_ID
JOIN GENRE AS G ON G.GENRE_ID=T.GENRE_ID
WHERE G.NAME='Rock'
GROUP BY ART.ARTIST_ID
ORDER BY NUMBER_OF_SONGS DESC
LIMIT 10

/*Q3: Return all the track names that have a song length longer than
the average song length. Return the Name and Milliseconds for
each track. Order by the song length with the longest songs listed
first.*/
SELECT T.NAME,T.MILLISECONDS
FROM TRACK AS T
WHERE T.MILLISECONDS>(SELECT AVG(T.MILLISECONDS) FROM TRACK AS T)
ORDER BY T.MILLISECONDS DESC


