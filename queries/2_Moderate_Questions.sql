/*  =====================================================================
	Ques 1: Identigying Rock Music Listener 
    Objestive: Identify all the unique customer who have purchased the 
               'Rock' genre Track
    =====================================================================*/
    SELECT DISTINCT c.email,
		   c.first_name,
           c.last_name,
           g.name as Genre
	from customer c
    JOIN invoice i on c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name = "Rock"
    ORDER BY c.email;
/*  ---------------------------------------------------------------------
	Technical Logic:
    - Join customer -> Invoice -> Invoice_line -> track -> Genre
    - Using Where condition Get only 'Rock' music Genre
    - Sort Result by Email in asecding order and Use 'Distinct' to 
	  eliminate duplicate customers
      
	Business Insight:
    -100% of Chinook's active customer base have purchased at least 
     one time 'Rock' Music. (Exactly 59 Customers) 
	Business Impact: Because every customer engages with Rock music,
     Rock serves as Chinook's primary product anchor
   ---------------------------------------------------------------------*/  
   
   
/*  =====================================================================
	Ques 2: Top 10 Rock Music Artist
    Objective: Identifying the top 10 rock bands/artist based on there total
			   number of rock track in the store catalog tom invite them 
               for Music festival
    =====================================================================*/
	SELECT 
    ar.artist_id,
    ar.name AS artist_name,
    COUNT(t.track_id) AS total_rock_tracks
	FROM artist ar
	JOIN album al ON ar.artist_id = al.artist_id
	JOIN track t ON al.album_id = t.album_id
	JOIN genre g ON t.genre_id = g.genre_id
	WHERE g.name = 'Rock'
	GROUP BY 
    ar.artist_id, 
    ar.name
	ORDER BY total_rock_tracks DESC
	LIMIT 10;
/*  ----------------------------------------------------------------------
	Technical logic:
    - Traverses artist -> album -> track -> genre
    - Filtering specifically for track " where genre.name = 'Rock' "
	- Groups record by "artist.artist_id" and "artiset.name"
    - Uses "Count(track.track_id)" to tally the total number of track per artist
    - Sort the result in desceanding order by track counts and applies "limit 10"

    Business Insight:
   - Top Artist: Led Zeppelin dominates the catalog with 114 rock tracks.
   - Key Performers: Other top rock acts include U2,Deep Purple Iron Maiden,
     Pearl Jam and Van Halen, who form the backbone of Chinook's rock library.
     
     Business Impact: Inviting these top 10 artist in upcoming promotional
	  event directly engages the highest portion of customer base, as 100% 
	  of our customer pruchases rock music.
   -------------------------------------------------------------------------*/
   
   
/*  ==========================================================================
	Ques 3: Track longer Than Average Song length
	Objective: Identifying all the song that exceed the average track duration
			   and ordered by duration descending 
    ==========================================================================*/
    SELECT name,milliseconds FROM track 
	WHERE milliseconds > (SELECT AVG(milliseconds) FROM track )
	ORDER BY  milliseconds DESC;
/*  -------------------------------------------------------------------------------------------
	Technical logic:
    - Uses Subquery to calculate avg duration across all the track
    - Filtering the records using where condition to select only track exceeding average baseline
	- Sort the result by duration in descending order
    
	Business Insight:
   - Average Song Length: ~393,599 milliseconds (~3.93 minutes / 236 seconds).
   - Longer-Than-Average Tracks: 494 tracks out of 3,503 exceed the average duration.
   - Longest Track: "Occupation / Precipice" (5,286,953 ms / ~88.12 minutes) — a long-form 
     audio/video file.

   Business Impact:
   - Pricing Strategy Evaluation: Longer tracks (like audiobooks, live sets, or podcasts) 
     consume more store storage/bandwidth. Management can evaluate whether track pricing 
     should remain flat ($0.99) or scale based on track duration thresholds.
    --------------------------------------------------------------------------------------------*/ 
    