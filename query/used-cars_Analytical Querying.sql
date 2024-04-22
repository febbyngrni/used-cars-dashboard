-- Analytical Query
-- Case 1
-- Ranking popularitas model mobil berdasarkan jumlah bid
SELECT
	model,
	COUNT(DISTINCT product_id) AS count_product,
	COUNT(DISTINCT bid_id) AS count_bid
FROM bidding b
JOIN ads USING(ads_id)
JOIN products USING(product_id)
GROUP BY 1
ORDER BY 3 DESC;

-- Case 2
-- Bandingkan harga mobil dengan harga rata-rata per kota
SELECT
	nama_kota,
	brand,
	model,
	year,
	price,
	AVG(price) OVER(PARTITION BY nama_kota) AS avg_car_city
FROM city
JOIN users u USING(kota_id)
JOIN ads USING(user_id)
JOIN products USING(product_id)
GROUP BY 1,2,3,4,5;

-- Case 3
-- Cari perbandingan tanggal user melakukan bid dengan bid selanjutnya
SELECT
	model,
	a.user_id,
	b.bid_date,
	LEAD(b.bid_date,1) OVER(PARTITION BY a.user_id ORDER BY b.bid_date) AS next_bid_date,
	b.bid_price,
	LEAD(b.bid_price,1) OVER(PARTITION BY a.user_id ORDER BY b.bid_date) AS next_bid_price
FROM bidding b
JOIN ads a USING(ads_id)
JOIN products USING(product_id)
ORDER BY 2,3;

-- Case 4
-- Membandingkan persentase perbedaan rata-rata harga berdasarkan model
-- dan rata-rata harga bid yang ditawarkan oleh customer pad 6 bulan terakhir
SELECT
	model,
	AVG(price) AS avg_price,
	AVG(b.bid_price) AS avg_bid_6months,
	AVG(price) - AVG(b.bid_price) AS difference,
	(AVG(price) - AVG(b.bid_price)) / AVG(price) * 100 AS difference_percent
FROM bidding b
JOIN ads USING(ads_id)
JOIN products USING(product_id)
WHERE b.bid_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY 1;

-- Case 5
-- Membuat window function rata-rata harga bid sebuah merk 
-- dan model selama 6 bulan terakhir
WITH avg_brand_cars AS(
    SELECT
        brand,
        model,
        b.bid_date,
		EXTRACT(MONTH FROM b.bid_date) AS bid_month,
        AVG(b.bid_price) OVER(PARTITION BY brand, model ORDER BY b.bid_date) AS avg_bid
    FROM 
		bidding b
    JOIN 
		ads USING(ads_id)
	JOIN 
		products USING(product_id)
    WHERE 
		bid_date >= DATE '2023-10-01' AND bid_date < DATE '2024-04-01'
		AND model = 'Toyota Agya'
)
SELECT
	brand,
	model,
	AVG(CASE WHEN bid_month = 10 THEN avg_bid ELSE NULL END) AS m_min_1,
	AVG(CASE WHEN bid_month = 11 THEN avg_bid ELSE NULL END) AS m_min_2,
	AVG(CASE WHEN bid_month = 12 THEN avg_bid ELSE NULL END) AS m_min_3,
	AVG(CASE WHEN bid_month = 1 THEN avg_bid ELSE NULL END) AS m_min_4,
	AVG(CASE WHEN bid_month = 2 THEN avg_bid ELSE NULL END) AS m_min_5,
	AVG(CASE WHEN bid_month = 3 THEN avg_bid ELSE NULL END) AS m_min_6
FROM 
	avg_brand_cars
GROUP BY 1,2;