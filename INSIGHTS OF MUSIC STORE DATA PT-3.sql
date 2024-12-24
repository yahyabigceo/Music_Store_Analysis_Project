/*Q1: Find how much amount spent by each customers on artists? Write a query to return customer name,
artist name and total spent*/
WITH BEST_SELLING_ARTIST AS (
	SELECT ARTIST.ARTIST_ID AS ARTIST_ID,ARTIST.NAME AS ARTIST_NAME,
	SUM(INVOICE_LINE.UNIT_PRICE*INVOICE_LINE.QUANTITY) AS TOTAL_SALES
	FROM INVOICE_LINE
	JOIN TRACK ON INVOICE_LINE.TRACK_ID=TRACK.TRACK_ID
	JOIN ALBUM ON TRACK.ALBUM_ID=ALBUM.ALBUM_ID
	JOIN ARTIST ON ALBUM.ARTIST_ID=ARTIST.ARTIST_ID
	GROUP BY ARTIST.ARTIST_ID
	ORDER BY TOTAL_SALES DESC
	LIMIT 1
)
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.FIRST_NAME,CUSTOMER.LAST_NAME,BEST_SELLING_ARTIST.ARTIST_NAME,	
SUM(INVOICE_LINE.UNIT_PRICE*INVOICE_LINE.QUANTITY) AS AMOUNT_SPENT
FROM INVOICE
JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID=INVOICE.CUSTOMER_ID
JOIN INVOICE_LINE ON INVOICE_LINE.INVOICE_ID=INVOICE.INVOICE_ID
JOIN TRACK ON TRACK.TRACK_ID=INVOICE_LINE.TRACK_ID
JOIN ALBUM ON ALBUM.ALBUM_ID=TRACK.ALBUM_ID
JOIN BEST_SELLING_ARTIST ON BEST_SELLING_ARTIST.ARTIST_ID=ALBUM.ARTIST_ID
GROUP BY CUSTOMER.CUSTOMER_ID,CUSTOMER.FIRST_NAME,CUSTOMER.LAST_NAME,BEST_SELLING_ARTIST.ARTIST_NAME
ORDER BY AMOUNT_SPENT DESC

/*Q2: We want to find out the most popular music Genre for each country.
(We determine the most popular genre as the genre with the highest amount.*/
WITH popular_genre AS(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id,
    ROW_NUMBER() OVER (PARTITION BY customer.country ORDER BY COUNT (invoice_line.quantity) DESC) AS RowNo
    FROM invoice_line
    JOIN invoice ON invoice. invoice_id = invoice_line.invoice_id
    JOIN customer ON customer.customer_id = invoice.customer_id
    JOIN track ON track.track_id = invoice_line.track_id
    JOIN genre ON genre.genre_id = track.genre_id
    GROUP BY 2,3,4
    ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1

/*Q3: Write a query that determines the customer that has spent the most on music for each country.
Write a query that returns the country along with the top customer and how much they spent.
For countries where the top amount spent is shared, provide all customers who spent this amount*/
WITH Customter_with_country AS (
          SELECT customer.customer_id, first_name, last_name, billing_country, SUM (total) AS total_spending,
          ROW_NUMBER() OVER (PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo
          FROM invoice
          JOIN customer ON customer.customer_id = invoice.customer_id
          GROUP BY 1,2,3,4
          ORDER BY 4 ASC, 5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1 


