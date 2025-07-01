CREATE TABLE Bookings_partition (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL REFERENCES Properties(property_id),
    user_id UUID NOT NULL REFERENCES Users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(12, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Create partitions for each year relevant to our data (2020-2025)
CREATE TABLE booking_y2020 PARTITION OF Bookings_partition
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE booking_y2021 PARTITION OF Bookings_partition
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE booking_y2022 PARTITION OF Bookings_partition
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE booking_y2023 PARTITION OF Bookings_partition
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_y2024 PARTITION OF Bookings_partition
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_y2025 PARTITION OF Bookings_partition
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');


CREATE TABLE booking_default PARTITION OF Bookings_partition DEFAULT;


-- population to test table
-- Generate bookings linked to different properties and guests
DO $$
BEGIN
FOR i IN 1..15 LOOP
INSERT INTO Bookings_partition (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
       gen_random_uuid(), 
       p.property_id,
       g.user_id,
       CURRENT_DATE + (rand_vals.s || ' days')::INTERVAL AS start_date,
       CURRENT_DATE + (rand_vals.s + rand_vals.q || ' days')::INTERVAL AS end_date,
       p.pricepernight * q AS total_price,
       (ARRAY['canceled','confirmed','pending'])[(floor(random() * 3) + 1)::INT]::booking_status
FROM
       (SELECT property_id,pricepernight FROM Properties ORDER BY random() LIMIT 1) p,
       (SELECT user_id FROM Users WHERE role = 'guest' ORDER BY random() LIMIT 1) g,
       -- generate_series(1, 15) AS i,
       LATERAL (
        SELECT 
            floor(random() * 20 + 1)::INT AS s, 
            floor(random() * 6 + 1)::INT AS q
    ) AS rand_vals
LIMIT 15;
END LOOP;
END $$;

-- Query
EXPLAIN ANALYZE
SELECT *
FROM Bookings_partition
WHERE start_date BETWEEN '2023-03-01' AND '2023-03-31';

EXPLAIN ANALYZE
SELECT *
FROM Bookings_partition
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';