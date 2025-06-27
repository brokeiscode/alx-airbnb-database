-- ==============================================
-- Improved Real-World Sample Data Inserts for PostgreSQL
-- ==============================================


-- Generate distinct users with meaningful names and roles
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
       (gen_random_uuid(), 'John', 'Doe', 'john.doe@example.com', 'hashedpass1', '+2348012345001', 'host'),
       (gen_random_uuid(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashedpass2', '+2348012345002', 'host'),
       (gen_random_uuid(), 'Michael', 'Brown', 'michael.brown@example.com', 'hashedpass3', '+2348012345003', 'host'),
       (gen_random_uuid(), 'Emma', 'Johnson', 'emma.johnson@example.com', 'hashedpass4', '+2348012345004', 'guest'),
       (gen_random_uuid(), 'David', 'Lee', 'david.lee@example.com', 'hashedpass5', '+2348012345005', 'guest'),
       (gen_random_uuid(), 'Sophia', 'Williams', 'sophia.williams@example.com', 'hashedpass6', '+2348012345006', 'guest'),
       (gen_random_uuid(), 'Olivia', 'Taylor', 'olivia.taylor@example.com', 'hashedpass7', '+2348012345007', 'admin'),
       (gen_random_uuid(), 'Ethan', 'Anderson', 'ethan.anderson@example.com', 'hashedpass8', '+2348012345008', 'guest'),
       (gen_random_uuid(), 'Lucas', 'White', 'lucas.white@example.com', 'hashedpass9', '+2348012345009', 'guest'),
       (gen_random_uuid(), 'Mia', 'Martin', 'mia.martin@example.com', 'hashedpass10', '+2348012345010', 'guest');

-- Generate properties with different hosts
INSERT INTO Property (property_id, host_id, name, description, street_name, city, state, country, zip_code, pricepernight)
SELECT 
       gen_random_uuid(), 
       u.user_id, 
       CONCAT((ARRAY['Cozy Apartment ', 'Luxury Block ','Casear Project Apt '])[(floor(random() * 3) + 1)::INT], i), 
       CONCAT('Beautiful property number ', i), 
       CONCAT(
              (floor(random() * 100) + 1)::int, ' ', 
              (ARRAY['John', 'Adeniyi', 'Isaac', 'Ajose', 'Joel', 'Chevron'])[(floor(random() * 6) + 1)::INT],' ', 
              (ARRAY['Jones', 'John', 'Ogunnaike', 'Adeogun', 'Williams', 'Taylor'])[(floor(random() * 6) + 1)::INT], ' ', 
              (ARRAY['Street', 'Close', 'Estate', 'Road'])[(floor(random() * 4) + 1)::INT]
       ), 
       'Ikeja', 
       'Lagos', 
       'Nigeria', 
       CONCAT('10000', i), 
       (100 + i * 20)
FROM 
       (SELECT user_id FROM "User" WHERE role = 'host' LIMIT 3) u,
       generate_series(1, 3) AS i
LIMIT 10;

-- Generate bookings linked to different properties and guests
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT 
       gen_random_uuid(), 
       p.property_id,
       g.user_id,
       CURRENT_DATE + (i * 2 || ' days')::INTERVAL,
       CURRENT_DATE + (i * 2 + 3 || ' days')::INTERVAL,
       500 + (i * 50),
       CASE WHEN i % 3 = 0 THEN 'canceled' WHEN i % 2 = 0 THEN 'confirmed' ELSE 'pending' END::booking_status
FROM 
       (SELECT property_id FROM Property ORDER BY random() LIMIT 6) p,
       (SELECT user_id FROM "User" WHERE role = 'guest' ORDER BY random() LIMIT 4) g,
       generate_series(1, 15) AS i
LIMIT 15;

-- Generate payments linked to bookings
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
SELECT 
       gen_random_uuid(), 
       booking_id, 
       total_price,
       CASE WHEN random() < 0.33 THEN 'paypal' WHEN random() < 0.66 THEN 'credit_card' ELSE 'stripe' END::payment_method_type
FROM 
       Booking;

-- Generate 20 messages between random, different users
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
SELECT 
       gen_random_uuid(),
       s.user_id,
       r.user_id,
       CONCAT('Hello message ', i)
FROM 
       (SELECT user_id FROM "User" ORDER BY random() LIMIT 6) s,
       (SELECT user_id FROM "User" ORDER BY random() LIMIT 6) r,
       generate_series(1, 20) AS i
WHERE 
       s.user_id <> r.user_id
LIMIT 20;

-- Generate reviews with different properties and guests
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
SELECT
    gen_random_uuid(),
    b.property_id,
    b.user_id,
    (1 + floor(random() * 4))::INT, -- Rating between 1 and 5
    CONCAT('Great stay, awesome place') -- More specific comment
FROM
    Booking b
ORDER BY
    random()
LIMIT 10;