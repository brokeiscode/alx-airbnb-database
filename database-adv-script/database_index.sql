-- Before and After Indexes performance measure
EXPLAIN ANALYZE SELECT * FROM bookings AS b 
INNER JOIN users AS u ON b.user_id = u.user_id ORDER BY b.start_date DESC;

EXPLAIN ANALYZE SELECT * FROM properties AS p 
LEFT JOIN reviews AS r ON p.property_id = r.property_id ORDER BY p.name ASC;

EXPLAIN ANALYZE SELECT * FROM properties WHERE country = 'Nigeria';

-- Index Optimization
CREATE INDEX Booking_user_idx ON Bookings(user_id);
CREATE INDEX Review_property_idx ON Reviews(property_id);
CREATE INDEX Booking_start_date_idx ON Bookings(start_date);
CREATE INDEX Property_name_idx ON Properties(name);
CREATE INDEX Property_country_idx ON Properties(country);
CREATE INDEX Property_host_id_idx ON Properties(host_id);