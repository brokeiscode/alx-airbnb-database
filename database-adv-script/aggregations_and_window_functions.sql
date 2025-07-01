-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT b.user_id,(SELECT first_name FROM "User" where user_id = b.user_id ), COUNT(*) AS total_bookings FROM Booking b GROUP BY b.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
-- RANK()
SELECT 
    p.property_id,
    p.name,
    COUNT(b.property_id) AS total_bookings, 
    RANK() OVER (ORDER BY COUNT(b.property_id) DESC) AS booking_rank
FROM 
    Property p
LEFT JOIN Booking b ON b.property_id = p.property_id
GROUP BY p.property_id,p.name;

--- ROW NUMBER()
SELECT 
    p.property_id,
    p.name,
    COUNT(b.property_id) AS total_bookings, 
    ROW_NUMBER() OVER (ORDER BY COUNT(b.property_id) DESC) AS booking_row
FROM 
    Property p
LEFT JOIN Booking b ON b.property_id = p.property_id
GROUP BY p.property_id,p.name;
