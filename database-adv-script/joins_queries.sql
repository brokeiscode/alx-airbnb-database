-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * FROM booking AS b 
INNER JOIN "User" AS u ON b.user_id = u.user_id ORDER BY b.start_date DESC;

-- Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT * FROM property AS p 
LEFT JOIN review AS r ON p.property_id = r.property_id ORDER BY p.name ASC;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT * FROM "User" AS u 
FULL OUTER JOIN booking AS b ON u.user_id = b.user_id ORDER BY u.first_name ASC;