-- Transactional Query
-- Case 1
-- Mencari mobil keluaran 2015 ke atas
SELECT 
	product_id,
	brand,
	model,
	year,
	price
FROM 
	products
WHERE 
	year > 2015;

-- Case 2
-- Menambahkan 1 data bid produk baru
INSERT INTO 
	bidding
VALUES
	(201, 56, '2022-03-04', 185500000 ,'Accepted');

-- Case 3
-- Melihat semua mobil yang dijual 1 akun yang paling baru
SELECT
	product_id
	brand,
	model,
	year,
	price,
	date_posted
FROM 
	products
JOIN 
	ads USING(product_id)
JOIN 
	users u USING(user_id)
WHERE 
	u.user_id = (SELECT MAX(user_id) FROM users);

-- Case 4
-- Mencari mobil bekas yang termurah berdasarkan keyword 'Yaris'
SELECT
	product_id,
	brand,
	model,
	year,
	price
FROM 
	products
WHERE 
	model LIKE '%Yaris'
ORDER BY 5 ASC;

-- Case 5
-- Mencari mobil bekas terdekat dengan longitude, latitude
-- 1. Membuat function untuk menghitung jarak menggunakan haversine distance
CREATE FUNCTION haversine_distance(point1 POINT, point2 POINT)
RETURNS FLOAT AS $$
DECLARE
    lon1 FLOAT := radians(point1[0]);
    lat1 FLOAT := radians(point1[1]);
    lon2 FLOAT := radians(point2[0]);
    lat2 FLOAT := radians(point2[1]);
    
    dlon FLOAT := lon2 - lon1;
    dlat FLOAT := lat2 - lat1;
    a FLOAT;
    c FLOAT;
    r FLOAT := 6371;
    jarak FLOAT;
	
BEGIN
    -- haversine formula
    a := sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
    c := 2 * asin(sqrt(a));
    jarak := r * c;
    
    RETURN jarak;
    
END;
$$ LANGUAGE plpgsql;

-- 2. Mencari mobil bekas terdekat
WITH city_distance AS(
	SELECT 
		kota_id,
		nama_kota,
		(SELECT haversine_distance(
			(SELECT location FROM city WHERE nama_kota = 'Kota Jakarta Pusat'),
			location)
		) AS distance
	FROM city
	GROUP BY 1
)
, min_distance AS(
	SELECT*
	FROM 
		city_distance
	WHERE 
		distance = (SELECT MIN(distance) FROM city_distance)
)
SELECT
	product_id,
	brand,
	model,
	year,
	price,
	md.distance
FROM 
	min_distance md
JOIN 
	users USING(kota_id)
JOIN 
	ads USING(user_id)
JOIN 
	products USING(product_id)