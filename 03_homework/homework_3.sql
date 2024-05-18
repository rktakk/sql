-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT vendor_id
,count(booth_number)
FROM vendor_booth_assignments
GROUP BY vendor_id

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT customer_last_name, customer_first_name,
    sum(quantity * cost_to_customer_per_qty) AS total_spend
FROM customer c
INNER JOIN customer_purchases cp 
	ON c.customer_id = cp.customer_id
GROUP BY customer_last_name, customer_first_name
HAVING sum(quantity * cost_to_customer_per_qty) > 2000.00;

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

CREATE TEMP TABLE new_vendor AS
SELECT *
FROM vendor;
INSERT INTO new_vendor 
VALUES ('10', 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT 
    CAST(strftime('%Y', market_date) AS INTEGER) AS year,
    CAST(strftime('%m', market_date) AS INTEGER) AS month,
    customer_id
FROM customer_purchases;

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2019. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spend
FROM customer_purchases
WHERE 
    CAST(strftime('%Y', market_date) AS INTEGER) = 2019
    AND CAST(strftime('%m', market_date) AS INTEGER) = 4
GROUP BY customer_id;
