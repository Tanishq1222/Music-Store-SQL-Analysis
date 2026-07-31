CREATE DATABASE music;
USE music;


SET Foreign_key_checks = 0;

CREATE TABLE artist (
    artist_id VARCHAR(50) NOT NULL,
    name VARCHAR(120),
    PRIMARY KEY (artist_id)
);

-- Create album table
CREATE TABLE album (
    album_id VARCHAR(50) NOT NULL,
    title VARCHAR(120),
    artist_id VARCHAR(30),
    PRIMARY KEY (album_id)
);

-- Create customer table
CREATE TABLE customer (
    customer_id INT NOT NULL,
    first_name CHAR(50),
    last_name CHAR(50),
    company VARCHAR(120),
    address VARCHAR(120),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(50),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(50),
    support_rep_id INT,
    PRIMARY KEY (customer_id)
);

-- Create employee table
CREATE TABLE employee (
    employee_id VARCHAR(50) NOT NULL,
    last_name CHAR(50),
    first_name CHAR(50),
    title VARCHAR(50),
    reports_to VARCHAR(30),
    levels VARCHAR(10),
    birthdate DATETIME,
    hire_date DATETIME,
    address VARCHAR(120),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(30),
    postal_code VARCHAR(30),
    phone VARCHAR(30),
    fax VARCHAR(30),
    email VARCHAR(30),
    PRIMARY KEY (employee_id)
);

CREATE TABLE genre (
    genre_id VARCHAR(50) NOT NULL,
    name VARCHAR(120),
    PRIMARY KEY (genre_id)
);

-- Create invoice table
CREATE TABLE invoice (
    invoice_id INT NOT NULL,
    customer_id INT,
    invoice_date DATETIME,
    billing_address VARCHAR(120),
    billing_city VARCHAR(30),
    billing_state VARCHAR(30),
    billing_country VARCHAR(30),
    billing_postal VARCHAR(30),
    total DOUBLE,
    PRIMARY KEY (invoice_id)
);

-- Create invoice_line table
CREATE TABLE invoice_line (
    invoice_line_id VARCHAR(50) NOT NULL,
    invoice_id INT,
    track_id INT,
    unit_price DOUBLE,
    quantity DOUBLE,
    PRIMARY KEY (invoice_line_id)
);

-- Create media_type table
CREATE TABLE media_type (
    media_type_id VARCHAR(50) NOT NULL,
    name VARCHAR(120),
    PRIMARY KEY (media_type_id)
);

-- Create playlist table
CREATE TABLE playlist (
    playlist_id VARCHAR(50) NOT NULL,
    name VARCHAR(120),
    PRIMARY KEY (playlist_id)
);

-- Create playlist_track table (typically a junction table without a single primary key)
CREATE TABLE playlist_track (
    playlist_id VARCHAR(50),
    track_id INT
);

-- Create track table
CREATE TABLE track (
    track_id INT NOT NULL,
    name VARCHAR(150),
    album_id VARCHAR(50),
    media_type_id VARCHAR(50),
    genre_id VARCHAR(50),
    composer VARCHAR(190),
    milliseconds INT,
    bytes INT,
    unit_price DOUBLE,
    PRIMARY KEY (track_id)
);

-- Primary Key Constraints
ALTER TABLE album ADD CONSTRAINT album_pkey PRIMARY KEY (album_id);
ALTER TABLE artist ADD CONSTRAINT artist_pkey PRIMARY KEY (artist_id);
ALTER TABLE customer ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
ALTER TABLE employee ADD CONSTRAINT employee2_pkey PRIMARY KEY (employee_id);
ALTER TABLE genre ADD CONSTRAINT genre_pkey PRIMARY KEY (genre_id);
ALTER TABLE invoice_line ADD CONSTRAINT invoice_line_pkey PRIMARY KEY (invoice_line_id);
ALTER TABLE invoice ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);
ALTER TABLE media_type ADD CONSTRAINT media_type_pkey PRIMARY KEY (media_type_id);
ALTER TABLE playlist ADD CONSTRAINT playlist_pkey PRIMARY KEY (playlist_id);
ALTER TABLE track ADD CONSTRAINT track_pkey PRIMARY KEY (track_id);


-- Varchar to INT
ALTER TABLE employee Modify COLUMN employee_id INT NOT NULL;
ALTER TABLE employee Modify COLUMN reports_to INT;
ALTER TABLE album Modify COLUMN album_id INT NOT NULL;
ALTER TABLE album Modify COLUMN artist_id INT NOT NULL;
ALTER TABLE artist Modify COLUMN artist_id INT NOT NULL;
ALTER TABLE genre Modify COLUMN genre_id INT NOT NULL;
ALTER TABLE invoice_line Modify COLUMN invoice_line_id INT NOT NULL;
ALTER TABLE invoice_line Modify COLUMN unit_price DOUBLE;
ALTER TABLE invoice_line Modify COLUMN quantity INT;
ALTER TABLE media_type Modify COLUMN media_type_id INT NOT NULL;
ALTER TABLE playlist Modify COLUMN playlist_id INT NOT NULL;
ALTER TABLE playlist_track Modify COLUMN playlist_id INT NOT NULL;
ALTER TABLE track MODIFY album_id INT;
ALTER TABLE track MODIFY media_type_id INT;
ALTER TABLE track MODIFY genre_id INT;


 
-- Foreign key
ALTER TABLE album 
ADD CONSTRAINT fk_album_artist 
FOREIGN KEY (artist_id) REFERENCES artist(artist_id);

ALTER TABLE customer 
ADD CONSTRAINT fk_customer_employee 
FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id);

ALTER TABLE invoice 
ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE invoice_line 
ADD CONSTRAINT fk_invoiceline_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
ADD CONSTRAINT fk_invoiceline_track FOREIGN KEY (track_id) REFERENCES track(track_id);

ALTER TABLE track 
ADD CONSTRAINT fk_track_album FOREIGN KEY (album_id) REFERENCES album(album_id),
ADD CONSTRAINT fk_track_mediatype FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id),
ADD CONSTRAINT fk_track_genre FOREIGN KEY (genre_id) REFERENCES genre(genre_id);

ALTER TABLE playlist_track 
ADD CONSTRAINT fk_playlisttrack_playlist FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
ADD CONSTRAINT fk_playlisttrack_track FOREIGN KEY (track_id) REFERENCES track(track_id);

ALTER TABLE employee 
ADD CONSTRAINT fk_employee_reports 
FOREIGN KEY (reports_to) REFERENCES employee(employee_id);

