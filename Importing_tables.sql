USE music;

SET GLOBAL FOREIGN_KEY_CHECKS = 0;
Set Global local_infile =1;
Set SQL_Safe_updates=0;

-- Importing Album Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/album.csv'
INTO TABLE album
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 
			
            Select * from album;
            
-- Importing Artist Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/artist.csv'
INTO TABLE artist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			Select * from artist;
 
 -- Importing Employee Table
 ALTER TABLE employee
 DROP FOREIGN KEY fk_employee_reports;							-- Try This if it is giving Foreign key constraint are incompatible 
 
ALTER TABLE employee 
MODIFY birthdate VARCHAR(50),
MODIFY hire_date VARCHAR(50),
MODIFY reports_to VARCHAR(10);

LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/employee.csv'
INTO TABLE employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Fix empty reports_to string to NULL
UPDATE employee 
SET reports_to = NULL 
WHERE reports_to = '' OR reports_to = ' ';

-- Convert DD-MM-YYYY HH:MM strings into actual DATETIME
UPDATE employee 
SET birthdate = STR_TO_DATE(birthdate, '%Y-%m-%d %H:%i:%s')
WHERE birthdate IS NOT NULL AND birthdate != '';

UPDATE employee 
SET hire_date = STR_TO_DATE(hire_date, '%Y-%m-%d %H:%i:%s')
WHERE hire_date IS NOT NULL AND hire_date != '';

-- Change column types back to DATETIME and INT
ALTER TABLE employee 
MODIFY birthdate DATETIME,
MODIFY hire_date DATETIME,
MODIFY reports_to INT;

ALTER TABLE employee 
ADD CONSTRAINT fk_employee_reports 
FOREIGN KEY (reports_to) REFERENCES employee(employee_id);					-- Add foriegn key again 

			SELECT * FROM employee;
            
 -- Importing Customer Table
 LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from customer;

-- Importing Genre Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/genre.csv'
INTO TABLE genre
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from genre;

-- Importing Invoice Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/invoice.csv'
INTO TABLE invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from invoice;

-- Importing Media_type Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/media_type.csv'
INTO TABLE media_type
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from media_type;

-- Importing Playlist Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/playlist.csv'
INTO TABLE playlist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from playlist;
            
-- Importing PlayList_Track Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/playlist_track.csv'
INTO TABLE playlist_track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;            

			select * from playlist_track;
 
-- Importing Track Table 
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/track.csv'
INTO TABLE track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

			select * from track;
 
-- Importing Invoice_Line Table
LOAD DATA LOCAL INFILE 'D:/Music Store/Dataset/invoice_line.csv'
INTO TABLE invoice_line
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

            select * from invoice_line;
 


SET GLOBAL FOREIGN_KEY_CHECKS = 1;
SET SQL_Safe_updates=1;
 