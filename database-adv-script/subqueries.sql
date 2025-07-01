-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT p.* FROM properties p 
WHERE 
    p.property_id 
IN 
    (SELECT r.property_id FROM reviews r GROUP BY r.property_id HAVING AVG(r.rating) > 4.0);

-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT u.* from users AS u WHERE (SELECT COUNT(*) FROM bookings b WHERE u.user_id = b.user_id) > 3;