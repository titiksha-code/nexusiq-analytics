-- ============================================================
--  Sample Seed Data — for demo & testing
-- ============================================================

USE ecommerce_analytics;

INSERT INTO customers (full_name, email, phone, city, state, region, signup_date, segment) VALUES
('Anika Reddy',    'anika.reddy@email.com',    '9876543210', 'Hyderabad',  'Telangana',    'South',  '2022-03-15', 'VIP'),
('Sameer Mehta',   'sameer.mehta@email.com',   '9823456781', 'Mumbai',     'Maharashtra',  'West',   '2022-06-20', 'VIP'),
('Priya Kapoor',   'priya.kapoor@email.com',   '9812345670', 'Delhi',      'Delhi',        'North',  '2023-01-10', 'Repeat'),
('Rahul Verma',    'rahul.verma@email.com',    '9834567892', 'Bengaluru',  'Karnataka',    'South',  '2023-04-05', 'Repeat'),
('Sneha Iyer',     'sneha.iyer@email.com',     '9856789013', 'Chennai',    'Tamil Nadu',   'South',  '2023-07-22', 'New'),
('Arjun Singh',    'arjun.singh@email.com',    '9878901234', 'Jaipur',     'Rajasthan',    'North',  '2023-09-18', 'New'),
('Neha Sharma',    'neha.sharma@email.com',    '9890123455', 'Pune',       'Maharashtra',  'West',   '2024-01-03', 'New'),
('Vikas Gupta',    'vikas.gupta@email.com',    '9812309876', 'Kolkata',    'West Bengal',  'East',   '2024-02-14', 'Churned');

INSERT INTO products (product_name, category, sub_category, unit_cost, unit_price, stock_qty) VALUES
('Wireless Earbuds Pro',    'Electronics',  'Audio',       35.00,  72.00,  840),
('Smart Watch X2',          'Wearables',    'Smartwatch',  55.00, 115.00,  520),
('USB-C Hub 7-in-1',        'Accessories',  'Connectivity', 8.50,  24.99,  310),
('Laptop Stand v3',         'Accessories',  'Ergonomics',   6.00,  18.99,   42),
('Mechanical Keyboard TKL', 'Electronics',  'Input',       28.00,  64.99,  180),
('LED Desk Lamp Smart',     'Accessories',  'Lighting',    12.00,  29.99,  270),
('Webcam HD 1080p',         'Electronics',  'Video',       22.00,  49.99,  390),
('Phone Holder Car Mount',  'Accessories',  'Mobility',     3.50,   9.99,  620);

INSERT INTO orders (customer_id, order_date, ship_date, status, payment_method, city, state, region) VALUES
(1,'2024-01-05','2024-01-07','Delivered','UPI',        'Hyderabad', 'Telangana',   'South'),
(2,'2024-01-12','2024-01-14','Delivered','Credit Card', 'Mumbai',    'Maharashtra', 'West'),
(3,'2024-02-03','2024-02-05','Delivered','Debit Card',  'Delhi',     'Delhi',       'North'),
(4,'2024-02-18','2024-02-20','Delivered','UPI',         'Bengaluru', 'Karnataka',   'South'),
(1,'2024-03-10','2024-03-12','Delivered','UPI',         'Hyderabad', 'Telangana',   'South'),
(5,'2024-03-22','2024-03-24','Delivered','Net Banking',  'Chennai',   'Tamil Nadu',  'South'),
(2,'2024-04-08','2024-04-10','Delivered','Credit Card', 'Mumbai',    'Maharashtra', 'West'),
(6,'2024-04-15','2024-04-17','Delivered','UPI',         'Jaipur',    'Rajasthan',   'North'),
(3,'2024-05-02','2024-05-04','Delivered','Debit Card',  'Delhi',     'Delhi',       'North'),
(7,'2024-05-20','2024-05-22','Delivered','UPI',         'Pune',      'Maharashtra', 'West');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_pct) VALUES
(1,  1, 2, 72.00, 0),
(1,  2, 1,115.00, 5),
(2,  2, 1,115.00, 0),
(2,  3, 2, 24.99, 10),
(3,  1, 1, 72.00, 0),
(3,  5, 1, 64.99, 0),
(4,  2, 1,115.00, 0),
(4,  6, 2, 29.99, 5),
(5,  1, 3, 72.00, 5),
(6,  7, 1, 49.99, 0),
(6,  8, 2,  9.99, 0),
(7,  2, 2,115.00, 10),
(8,  4, 1, 18.99, 0),
(8,  3, 1, 24.99, 5),
(9,  5, 1, 64.99, 0),
(10, 6, 1, 29.99, 0);
