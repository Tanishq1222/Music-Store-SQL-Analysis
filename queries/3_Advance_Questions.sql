/*	======================================================================
	Ques 1: Aomunt Spend by Each Customer on Top Artist
	Objective: Identify the single highest-selling artist, then calculate 
			   how much each customer has spend on that specific artist
    ======================================================================*/
    WITH best_selling_artist AS(
	SELECT ar.artist_id AS artist_id ,ar.name AS name,SUM(il.unit_price*il.quantity) AS Selling 
	FROM artist ar
	JOIN album al ON ar.artist_id = al.artist_id
	JOIN track t ON al.album_id = t.album_id
	JOIN invoice_line il ON t.track_id = il.track_id 
	GROUP BY  1
	ORDER BY 3 DESC
	LIMIT 1
	)

	SELECT c.customer_id ,CONCAT(c.first_name,' ',c.last_name) AS customer_name, c.email,
    ba.name AS artist_name,	ROUND(SUM(il.unit_price*il.quantity),2) AS amount_spend
	FROM customer c
	JOIN invoice i ON c.customer_id = i.customer_id
	JOIN invoice_line il ON i.invoice_id = il.invoice_id
	JOIN track t ON t.track_id = il.track_id
	JOIN album al ON al.album_id = t.album_id
	JOIN best_selling_artist ba ON ba.artist_id = al.artist_id
	GROUP BY 1,2,3,4
	ORDER BY 5 DESC;
/*	--------------------------------------------------------------------
	Technical Logic:
    - CTE ('best_selling_artist') Joins 'Artist' through 'Invoice_line' to
	  calculate the total revenue per artist and 'LIMIT 1' isolate the top one.
	- Main Query: Joins 'Customer' and 'Invoice_line' with CTE to filter sales
      strictly for the track belonging to top artist.
	
    Business Insight
    - Best Aritst: Queen (Artist id =5) is Chinook's #1 revenue-generating artist,
	   Toatl of ~$190.08
	- Top Spender: Hugh O'Relly has bought ~$27.72 of Queen's albums
    - There are total 43 customer who has bought Queen's album
    Business Impact:
   - Targeted Fan Engagement: Identifying super-fans for specific top artists enables 
     highly targeted cross-selling campaigns (e.g., offering exclusive box-set vinyls, 
     merchandise, or early concert ticket access directly to their top spenders)
    ---------------------------------------------------------------------------*/
    
     
/*	============================================================================
	Ques 2: Most Popular Music Genre By Country 
    Objective: Identify the top-selling genre in each country based on purchase count. 
              If multiple genres tie for the top spot, return all tied genres.
    ============================================================================*/
	WITH RECURSIVE
		genre_sales AS (
		SELECT c.country  , g.name AS genre , COUNT(g.name) AS purchase_count
		FROM customer c
		JOIN invoice i ON i.customer_id = c.customer_id
		JOIN invoice_line il ON i.invoice_id = il.invoice_id
		JOIN track t ON il.track_id = t.track_id
		JOIN genre g ON t.genre_id = g.genre_id 
		GROUP BY 2,1
	),
	max_per_country AS(
	SELECT country , MAX(purchase_count) AS max_purchase_count
	FROM genre_sales
	GROUP BY 1
	ORDER BY 1
	)

	SELECT gs.* 
	FROM genre_sales gs
	JOIN max_per_country mpc ON gs.country = mpc.country
	WHERE gs.purchase_count = mpc.max_purchase_count
	ORDER BY country;
/*  -------------------------------------------------------------------------
	Technical Logic:
    - (`genre_sales` CTE) Aggregates total track purchases per music genre for
      each country by joining customer, invoice, track, and genre tables.
	- (`max_per_country` CTE) Calculates the highest (maximum) purchase count 
	   achieved by any genre within each specific country.
    - (Final Query):** Joins the original genre sales data back to the maximum 
	   purchase counts per country, filtering to retain only the top-selling genre(s) for each region.
    
    Business Insight:
    - Rock Domination: Rock is the #1 genre in almost every country globally 
     (e.g., USA with 561 purchases, Canada with 333, Brazil with 205).    
    
    Business Impact:
    - Regional Marketing Strategy: Store inventory and localized promotions should heavily 
     feature Rock globally, while regional email campaigns can highlight tied sub-genres 
     in secondary markets.
   -----------------------------------------------------------------------------*/
   
   
/*	============================================================================
	Ques 3: Top Customer spend money on Music by Each Country
    Objective: Identifying the single highest spending customer in each country
			   For countries where multiple customers tie for top spend, 
               return all tied customers.
    ============================================================================*/
    WITH customer_country AS(
	SELECT c.customer_id ,c.first_name,c.last_name, i.billing_country AS country,
    SUM(i.total) AS total_spend,
	DENSE_RANK() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS dr 
	FROM invoice i
	JOIN customer c ON i.customer_id = c.customer_id
	GROUP BY 1,2,3,4
	ORDER BY 4,5 DESC)


	SELECT customer_id, first_name,last_name,country,ROUND(total_spend,2) AS total_spend 
	FROM customer_country
	WHERE dr = 1
	ORDER BY total_spend DESC;
/*	----------------------------------------------------------------------------------
	Technical Logic:
    - CTE (`customer_country`): 
     Joins `customer` and `invoice` on `customer_id` and aggregates total invoice amounts (`SUM(i.total)`) 
     grouped by customer and country.
   - Window Function (`DENSE_RANK()`): 
     Partitions records by `billing_country` and ranks customers by `total_spend` in descending order. 
     Assigns rank `1` to the top spender(s) in each country.
   - Final Query: 
     Filters for `dr = 1` to isolate the top customer per country while preserving ties if multiple 
     customers in a country share the maximum spend value.

   Business Insight:
   - Highest-Value Global Customer: František Wichterlová (Czech Republic) tops the entire database 
     with $144.54 in total purchases.
   - Top Regional Champions: Helena Holý (Prague/Czech Republic) and Hugh O'Reilly (Ireland) also lead 
     their respective national markets with high individual lifetime values.

   Business Impact:
   - VIP Localization & Community Building: Regional top spenders act as market anchor customers. 
     Engaging these specific high-value individuals with exclusive loyalty rewards or VIP event access 
     strengthens local brand advocacy in key geographic markets.