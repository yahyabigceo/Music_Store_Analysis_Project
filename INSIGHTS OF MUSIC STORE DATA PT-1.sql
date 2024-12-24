--Q1: WHO IS THE SENIOR MOST EMPLOYEE BASED ON THE JOB TITLE?
SELECT * FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1

-- Q2:WHICH COUNTIRES HAVE THE MOST INVOICES?
SELECT * FROM INVOICE
SELECT COUNT(*) AS C,BILLING_COUNTRY
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY C DESC
LIMIT 1

--Q3:WHAT ARE THE TOP 3 VALUES OF TOTAL INVOICE
SELECT * FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3

/*Q4: Which city has the best customers? We would like to throw a
promotional Music Festival in the city we made the most money. Write a
query that returns one city that has the highest sum of invoice totals.
Return both the city name & sum of all invoice totals*/
SELECT * FROM INVOICE
SELECT BILLING_CITY,SUM(TOTAL) AS INVOICE_TOTAL
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY INVOICE_TOTAL DESC

/*Q5: Who is the best customer? The customer who has spent the most
money will be declared the best customer. Write a query that returns
the person who has spent the most money.*/
SELECT C.CUSTOMER_ID,C.FIRST_NAME,C.LAST_NAME,SUM(I.TOTAL) AS TOTAL
FROM CUSTOMER AS C
JOIN INVOICE AS I ON C.CUSTOMER_ID=I.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID
ORDER BY TOTAL DESC
LIMIT 1