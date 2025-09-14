-- seed.sql

-- Drop existing data to avoid conflicts
DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM User;
DELETE FROM Payment_Method;

-- Seed User Table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hashedpassword1', '123-456-7890', 'guest'),
    (uuid_generate_v4(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashedpassword2', '234-567-8901', 'host'),
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashedpassword3', '345-678-9012', 'guest'),
    (uuid_generate_v4(), 'Bob', 'Brown', 'bob.brown@example.com', 'hashedpassword4', '456-789-0123', 'admin');

-- Seed Payment_Method Table
INSERT INTO Payment_Method (payment_method_id, method_name)
VALUES
    (uuid_generate_v4(), 'credit_card'),
    (uuid_generate_v4(), 'paypal'),
    (uuid_generate_v4(), 'stripe');

-- Seed Property Table
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
    (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), 'Cozy Cottage', 'A cozy cottage in the countryside.', 'Countryside', 100.00),
    (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), 'Downtown Apartment', 'A modern apartment in the city center.', 'City Center', 150.00),
    (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 'Beach House', 'A beautiful beach house with ocean views.', 'Beachside', 250.00);

-- Seed Booking Table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), '2025-09-01', '2025-09-07', 700.00, 'confirmed'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Downtown Apartment'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2025-09-10', '2025-09-15', 750.00, 'pending'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Beach House'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), '2025-09-20', '2025-09-25', 1250.00, 'canceled');

-- Seed Payment Table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method_id)
VALUES
    (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE status = 'confirmed'), 700.00, '2025-09-01', (SELECT payment_method_id FROM Payment_Method WHERE method_name = 'credit_card')),
    (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE status = 'pending'), 750.00, '2025-09-10', (SELECT payment_method_id FROM Payment_Method WHERE method_name = 'paypal'));

-- Seed Review Table
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), 5, 'Absolutely loved our stay!'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Downtown Apartment'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 4, 'Great location but a bit noisy.'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Beach House'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), 3, 'Nice place, but not as clean as expected.');

-- Seed Message Table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), 'Hi Jane! I would like to inquire about your property.'),
    (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 'Hello John! Feel free to ask any questions you may have.');
