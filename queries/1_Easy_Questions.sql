/*  ========================================================================
	Ques 1: Senior-Most-Employee Identification
    Objective : Identify the highest-ranking employee based on the job level
    ========================================================================*/
    
Select 	
	employee_id,
	concat(first_name,' ',last_name) as full_name,
    title,
    reports_to,
    levels
from employee
where levels = (Select max(levels) from employee);
/* 
	-------------------------------------------------------------------------
    Technical Logic:
    - Uses Subquery to dynamically fetch the maximum in 'levels'
    - Filtering the 'employee' table by using where clause to handle ties
	  gracefully, if there is Multiple employees hold the highest level
    
    BUSINESS Insight / Result:
    - Senior-Most-Employee: Mohan Madan (employee_id = 9)
    - Current Title: Senior General Manager (Level = L7)
    - Business Impact : As the top Ranking Manager, Mohan Madan serves
	  as the root node of the Organizational chart (report_to = NULL)
    --------------------------------------------------------------------------*/  
      
      
/* 	============================================================================
	Ques 2: Counries with the most Invoices
    Objective: Identifying the geographical regions generating the highest voluume of invoices.
    ============================================================================*/
    
    select billing_country as Country,
    count(*) as Total_invoice,
    round(sum(total),2) as Total_revenue
    from invoice
    group by billing_country
    order by Total_invoice desc;
/* 
	----------------------------------------------------------------------------------	
	Technical Logic: 
    - Groups record in the 'invoice' table by 'billing_country'
    - Uses 'count(*)' to calculate the total number of Transaction per country
    - Uses'Sum(total)' rounded upto 2 decimal for calculating total sales revenue.
    - sort the result in descreasing order by invoice volume 
    
    Business Insight:
    - Most invoice - USA leads globally with 131 invoices generating $1040.49 in revenue
    - least  invoice - Argentina generated the fewest with 5 invoices
    - Business Impact : The USA accounts for ~21% of Total invoice transaction (131 of 614)
	  and ~25% of total store revenue , making it Chinook's primary geographic market.
    -----------------------------------------------------------------------------------*/


/* 	=====================================================================================
	Ques 3: Top 3 Highest Invoice Values 
    Objective: Identifying the single highest transaction totals records in invoice table
    =====================================================================================*/
    SELECT 	invoice_id,
			customer_id,
			total
    FROM invoice
	ORDER BY total DESC
    LIMIT 3;
/*  ---------------------------------------------------------------------------------------
	Technical Logic:
    - Sort all the records in the 'invoice' table by 'total' in descending order
    - Uses 'LIMIT 3' to isolate only top 3 single transaction values. 
    
    Business Insight:
    - Top Single Purchase: Invoice #183 (Customer id = 42) had the highest single order at $23.75
    - 2nd & 3rd Highest Purchase: Invoice #92 and #31 (Customer ID's = 32 and 3) had both tied at #19.8 
    - Second & third value : customer id = 32 and 3 has order same amount of $19.8
    Business Impact: Single invoice amounts peaks upto $25, indicating high value sales
     stem from mutiple individual purchases
    ---------------------------------------------------------------------------------------*/
    
    
 /*	 ========================================================================================   
	 Ques 4: City with highest sales ( or revenue)
     Objective: Identifying the single top-earning city by the total revenue of the Promotional
				Music Festival
     ========================================================================================*/
     SELECT billing_city AS City,
			ROUND(SUM(total),2) AS total_revenue
	 FROM invoice
     group by billing_city
     order by total_revenue desc
     LIMIT 1;
/* 	 -----------------------------------------------------------------------------------------
     Techical Logic:
     - Grouping the records of 'invoice' table by 'billing_city'
     - Uses 'SUM' to get the total sales by cities and round it upto 2 decimal places
     - Sorting the result by 'total_revenue' in descding order
     - Uses 'LIMIT 1' to isolate the highest-Performing city
     
     Business Insight:
     - Prague has genrated highest revenue across all the cities, Totaling $273.24
     Business Impact: Hosting the Promotional Music Festival in Prague for maximizies 
	  marketing ROI by targeting Chinook's local customer base.
    -----------------------------------------------------------------------------------------*/ 
    
    
/*	==========================================================================================
	Ques 5: Identification of the Top Revenue (or "Best Customer")
    Objective: Customer who has spend the most money overall across all the invoices
    =====================================================================================*/
    Select c.customer_id,
		   CONCAT(c.first_name," ",c.last_name) as full_name,
		   c.country,
           round(sum(i.total),2) as total_spend
    from invoice i
    JOIN customer c ON i.customer_id = c.customer_id
    GROUP BY c.customer_id,
			 c.firt_name,
             c.last_name,
             c.country
    ORDER BY total_spend DESC
    LIMIT 1;
/*  ---------------------------------------------------------------------------------------
	Technical Logic:
   - Performs an INNER JOIN between `customer` and `invoice` on `customer_id`.
   - Groups records by customer fields (`customer_id`, `first_name`, `last_name`, `country`).
   - Uses `SUM(i.total)` rounded to 2 decimal places to calculate lifetime customer value (CLV).
   - Sorts results by `total_spent` in descending order and applies `LIMIT 1` to isolate the top spender.
      
   Business Insight:
   - Best Customer: František Wichterlová (Customer ID: 5) residing in the Czech Republic.
   - Total Spend: $144.54 across all invoice transactions.
	Business Impact: Identifying top spenders enables targeted loyalty rewards, 
     personalized promotional offers.
   -----------------------------------------------------------------------------------------*/ 