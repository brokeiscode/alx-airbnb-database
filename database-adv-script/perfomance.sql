-- initial query that retrieves all bookings along with the user details, property details, and payment details and save it on perfomance.sql

SELECT * 
FROM bookings b 
LEFT JOIN users u ON b.user_id = u.user_id 
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id

-- Analyze the query’s performance using EXPLAIN and identify any inefficiencies. (12ms)
-- Planning Time: 3.775 ms
-- Execution Time: 0.829 ms
EXPLAIN ANALYZE SELECT * 
FROM bookings b 
LEFT JOIN users u ON b.user_id = u.user_id 
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id

-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing. (5ms)
-- Planning Time: 0.452 ms
-- Execution Time: 0.314 ms
EXPLAIN ANALYZE 
SELECT 
    b.booking_id, b.start_date, b.end_date, b.total_price, b.status, 
    u.first_name, u.last_name, p.name, p.description, p.street_name, p.city, 
    p.state, p.country, p.zip_code, pay.payment_method
FROM bookings b 
LEFT JOIN users u ON b.user_id = u.user_id 
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id