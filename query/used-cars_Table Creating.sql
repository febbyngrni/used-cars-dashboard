CREATE TABLE city(
	kota_id integer PRIMARY KEY,
	nama_kota varchar(100) NOT NULL,
	location point NOT NULL
);


CREATE TABLE users
(
	user_id integer PRIMARY KEY,
	kota_id integer NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	phone varchar(100) UNIQUE NOT NULL,
	rating numeric NOT NULL CHECK (rating > 0),
	CONSTRAINT fk_user_city
		FOREIGN KEY(kota_id)
		REFERENCES city(kota_id)
		ON DELETE RESTRICT
);


CREATE TABLE products
(
	product_id integer PRIMARY KEY,
	brand varchar(100) NOT NULL,
	model varchar(100) NOT NULL,
	body_type varchar(100) NOT NULL,
	year integer NOT NULL,
	price numeric NOT NULL CHECK (price > 0),
	type varchar(100) CHECK (type IN ('Automatic', 'Manual'))
);


CREATE TABLE ads
(
	ads_id integer PRIMARY KEY,
	product_id integer NOT NULL,
	user_id integer NOT NULL,
	title varchar(100) UNIQUE NOT NULL,
	date_posted timestamp NOT NULL,
	status varchar(100) NOT NULL CHECK (status in('Active', 'Inactive')),
	description text DEFAULT 'No Description',
	CONSTRAINT fk_user_ads
		FOREIGN KEY(user_id)
		REFERENCES users(user_id)
		ON DELETE RESTRICT,
	CONSTRAINT fk_productl_ads
		FOREIGN KEY(product_id)
		REFERENCES products(product_id)
		ON DELETE RESTRICT
);


CREATE TABLE bidding
(
	bid_id integer PRIMARY KEY,
	ads_id integer NOT NULL,
	bid_date timestamp NOT NULL,
	bid_price numeric NOT NULL CHECK (bid_price > 0),
	status varchar(100) CHECK (status in('Sent', 'Rejected', 'Accepted')),
	CONSTRAINT fk_ads_bidding
		FOREIGN KEY(ads_id)
		REFERENCES ads(ads_id)
		ON DELETE RESTRICT
);