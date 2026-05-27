-- ============================================================
--  E-Commerce Sales & Customer Analytics Platform
--  Schema: Database Tables & Relationships
--  Author : Your Name
--  Version: 1.0
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

-- ─────────────────────────────────────────
-- 1. CUSTOMERS
-- ─────────────────────────────────────────
CREATE TABLE customers (
    customer_id     INT PRIMARY KEY AUTO_INCREMENT,
    full_name       VARCHAR(120)        NOT NULL,
    email           VARCHAR(200) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    city            VARCHAR(80),
    state           VARCHAR(80),
    region          VARCHAR(50),
    signup_date     DATE                NOT NULL,
    segment         ENUM('New','Repeat','VIP','Churned') DEFAULT 'New',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ─────────────────────────────────────────
-- 2. PRODUCTS
-- ─────────────────────────────────────────
CREATE TABLE products (
    product_id      INT PRIMARY KEY AUTO_INCREMENT,
    product_name    VARCHAR(200)    NOT NULL,
    category        VARCHAR(80)     NOT NULL,
    sub_category    VARCHAR(80),
    unit_cost       DECIMAL(10,2)   NOT NULL,
    unit_price      DECIMAL(10,2)   NOT NULL,
    stock_qty       INT             DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ─────────────────────────────────────────
-- 3. ORDERS
-- ─────────────────────────────────────────
CREATE TABLE orders (
    order_id        INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT             NOT NULL,
    order_date      DATE            NOT NULL,
    ship_date       DATE,
    status          ENUM('Pending','Shipped','Delivered','Cancelled','Returned') DEFAULT 'Pending',
    payment_method  VARCHAR(50),
    city            VARCHAR(80),
    state           VARCHAR(80),
    region          VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ─────────────────────────────────────────
-- 4. ORDER ITEMS
-- ─────────────────────────────────────────
CREATE TABLE order_items (
    item_id         INT PRIMARY KEY AUTO_INCREMENT,
    order_id        INT             NOT NULL,
    product_id      INT             NOT NULL,
    quantity        INT             NOT NULL,
    unit_price      DECIMAL(10,2)   NOT NULL,
    discount_pct    DECIMAL(5,2)    DEFAULT 0,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ─────────────────────────────────────────
-- 5. RETURNS
-- ─────────────────────────────────────────
CREATE TABLE returns (
    return_id       INT PRIMARY KEY AUTO_INCREMENT,
    order_id        INT             NOT NULL,
    return_date     DATE            NOT NULL,
    reason          VARCHAR(200),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ─────────────────────────────────────────
-- 6. USEFUL INDEXES
-- ─────────────────────────────────────────
CREATE INDEX idx_orders_date     ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_items_order     ON order_items(order_id);
CREATE INDEX idx_items_product   ON order_items(product_id);
CREATE INDEX idx_orders_region   ON orders(region);
