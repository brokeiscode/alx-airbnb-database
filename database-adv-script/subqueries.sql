-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT p.* FROM Property p 
WHERE 
    p.property_id 
IN 
    (SELECT r.property_id FROM Review r GROUP BY r.property_id HAVING AVG(r.rating) > 4.0);

-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT u.* from "User" AS u WHERE (SELECT COUNT(*) FROM Booking b WHERE u.user_id = b.user_id) > 3;