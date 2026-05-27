-- ============================================================
--  E-Commerce Analytics Platform — All Dashboard Queries
--  Sections: Sales KPIs · Customer · Product · Regional · Advanced
-- ============================================================

USE ecommerce_analytics;

-- ════════════════════════════════════════
--  SECTION 1 : SALES KPIs
-- ════════════════════════════════════════

-- 1.1  Total Revenue (current year)
SELECT
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
  AND o.status NOT IN ('Cancelled', 'Returned');

-- 1.2  Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE YEAR(order_date) = YEAR(CURDATE())
  AND status NOT IN ('Cancelled', 'Returned');

-- 1.3  Net Profit
SELECT
    ROUND(
        SUM(oi.quantity * oi.unit_price  * (1 - oi.discount_pct / 100)) -
        SUM(oi.quantity * p.unit_cost),
    2) AS net_profit
FROM orders o
JOIN order_items oi ON o.order_id  = oi.order_id
JOIN products   p  ON oi.product_id = p.product_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
  AND o.status NOT IN ('Cancelled', 'Returned');

-- 1.4  Average Order Value (AOV)
SELECT
    ROUND(
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) /
        COUNT(DISTINCT o.order_id),
    2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
  AND o.status NOT IN ('Cancelled', 'Returned');

-- 1.5  Monthly Revenue & Profit Trend (for line chart)
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m')                                           AS month,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)    AS revenue,
    ROUND(SUM(oi.quantity * (oi.unit_price * (1 - oi.discount_pct/100) - p.unit_cost)), 2) AS profit
FROM orders o
JOIN order_items oi ON o.order_id   = oi.order_id
JOIN products   p  ON oi.product_id = p.product_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
  AND o.status NOT IN ('Cancelled', 'Returned')
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- 1.6  YoY Revenue Comparison
SELECT
    YEAR(o.order_date) AS yr,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY YEAR(o.order_date)
ORDER BY yr;


-- ════════════════════════════════════════
--  SECTION 2 : CUSTOMER ANALYTICS
-- ════════════════════════════════════════

-- 2.1  Top 10 Customers by Revenue
SELECT
    c.customer_id,
    c.full_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id)                                                           AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)            AS lifetime_value
FROM customers   c
JOIN orders      o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY c.customer_id, c.full_name, c.city, c.state
ORDER BY lifetime_value DESC
LIMIT 10;

-- 2.2  Repeat Customers (ordered more than once)
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    WHERE status NOT IN ('Cancelled', 'Returned')
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) repeat_cust;

-- 2.3  Customer Retention Rate (cohort: customers who returned next month)
WITH cohort AS (
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS first_month
    FROM orders
    GROUP BY customer_id
),
activity AS (
    SELECT DISTINCT
        o.customer_id,
        DATE_FORMAT(o.order_date, '%Y-%m') AS active_month
    FROM orders o
)
SELECT
    c.first_month,
    COUNT(DISTINCT c.customer_id)                          AS cohort_size,
    COUNT(DISTINCT a.customer_id)                          AS retained_next_month,
    ROUND(COUNT(DISTINCT a.customer_id) * 100.0 /
          COUNT(DISTINCT c.customer_id), 2)                AS retention_pct
FROM cohort c
LEFT JOIN activity a
       ON c.customer_id = a.customer_id
      AND a.active_month = DATE_FORMAT(
              DATE_ADD(STR_TO_DATE(CONCAT(c.first_month,'-01'), '%Y-%m-%d'),
                       INTERVAL 1 MONTH), '%Y-%m')
GROUP BY c.first_month
ORDER BY c.first_month;

-- 2.4  Customer Segmentation (RFM — Recency, Frequency, Monetary)
WITH rfm_raw AS (
    SELECT
        c.customer_id,
        c.full_name,
        DATEDIFF(CURDATE(), MAX(o.order_date))                                   AS recency_days,
        COUNT(DISTINCT o.order_id)                                               AS frequency,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS monetary
    FROM customers   c
    JOIN orders      o  ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    WHERE o.status NOT IN ('Cancelled','Returned')
    GROUP BY c.customer_id, c.full_name
),
rfm_scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency)         AS f_score,
        NTILE(5) OVER (ORDER BY monetary)          AS m_score
    FROM rfm_raw
)
SELECT
    customer_id,
    full_name,
    recency_days,
    frequency,
    monetary,
    r_score, f_score, m_score,
    (r_score + f_score + m_score)                AS rfm_total,
    CASE
        WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal'
        WHEN (r_score + f_score + m_score) >= 7  THEN 'Potential'
        WHEN r_score <= 2                        THEN 'At Risk'
        ELSE 'Lost'
    END AS segment_label
FROM rfm_scored
ORDER BY rfm_total DESC;


-- ════════════════════════════════════════
--  SECTION 3 : PRODUCT ANALYTICS
-- ════════════════════════════════════════

-- 3.1  Best-Selling Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity)                                                              AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)    AS revenue,
    ROUND(SUM(oi.quantity * (oi.unit_price * (1 - oi.discount_pct/100)
              - p.unit_cost)), 2)                                                 AS profit,
    ROUND(SUM(oi.quantity * (oi.unit_price * (1 - oi.discount_pct/100)
              - p.unit_cost)) * 100.0 /
          NULLIF(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)),0), 2) AS margin_pct
FROM products    p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders      o  ON oi.order_id  = o.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- 3.2  Low-Performing Products (bottom 10 by revenue)
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(oi.quantity), 0)                                                AS units_sold,
    ROUND(COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)), 0), 2) AS revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders      o  ON oi.order_id  = o.order_id
                        AND o.status NOT IN ('Cancelled','Returned')
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue ASC
LIMIT 10;

-- 3.3  Category Revenue Share
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS revenue,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) * 100.0 /
          SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)))
          OVER (), 2)                                                           AS revenue_share_pct
FROM products    p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders      o  ON oi.order_id  = o.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY p.category
ORDER BY revenue DESC;

-- 3.4  Profit Margin by Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * (oi.unit_price * (1 - oi.discount_pct/100) - p.unit_cost)), 2) AS profit,
    ROUND(SUM(oi.quantity * (oi.unit_price * (1 - oi.discount_pct/100) - p.unit_cost)) * 100.0 /
          NULLIF(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)),0), 2)       AS margin_pct
FROM products    p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders      o  ON oi.order_id  = o.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY p.category
ORDER BY margin_pct DESC;


-- ════════════════════════════════════════
--  SECTION 4 : REGIONAL ANALYTICS
-- ════════════════════════════════════════

-- 4.1  Sales by State
SELECT
    o.state,
    COUNT(DISTINCT o.order_id)                                                   AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)    AS revenue
FROM orders      o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY o.state
ORDER BY revenue DESC;

-- 4.2  Sales by City (top 20)
SELECT
    o.city,
    o.state,
    COUNT(DISTINCT o.order_id)                                                   AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)    AS revenue
FROM orders      o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY o.city, o.state
ORDER BY revenue DESC
LIMIT 20;

-- 4.3  Revenue Heatmap — Region × Month
SELECT
    o.region,
    DATE_FORMAT(o.order_date, '%Y-%m')                                           AS month,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)    AS revenue
FROM orders      o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY o.region, DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY o.region, month;


-- ════════════════════════════════════════
--  SECTION 5 : ADVANCED ADD-ONS
-- ════════════════════════════════════════

-- 5.1  Sales Forecasting — 3-Month Moving Average (baseline for forecasting)
WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m')                                       AS month,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS revenue
    FROM orders      o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status NOT IN ('Cancelled','Returned')
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    ROUND(AVG(revenue) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3m
FROM monthly
ORDER BY month;

-- 5.2  Product Co-purchase / Recommendation Insights
--      (Customers who bought product A also bought product B)
SELECT
    a.product_id        AS product_a,
    pa.product_name     AS product_a_name,
    b.product_id        AS product_b,
    pb.product_name     AS product_b_name,
    COUNT(*)            AS co_purchase_count
FROM order_items a
JOIN order_items b  ON a.order_id    = b.order_id
                   AND a.product_id != b.product_id
JOIN products   pa ON a.product_id   = pa.product_id
JOIN products   pb ON b.product_id   = pb.product_id
GROUP BY a.product_id, pa.product_name, b.product_id, pb.product_name
HAVING co_purchase_count > 10
ORDER BY co_purchase_count DESC
LIMIT 20;

-- 5.3  Customer Lifetime Value (CLV) Prediction Proxy
--      CLV ≈ AOV × Purchase Frequency × Avg Customer Lifespan (months)
SELECT
    c.customer_id,
    c.full_name,
    c.segment,
    COUNT(DISTINCT o.order_id)                                                       AS orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2)        AS total_spend,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) /
          NULLIF(COUNT(DISTINCT o.order_id),0), 2)                                   AS aov,
    DATEDIFF(MAX(o.order_date), MIN(o.order_date))                                   AS active_days,
    ROUND(
        (SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) /
         NULLIF(DATEDIFF(MAX(o.order_date), MIN(o.order_date)), 0)) * 365,
    2)                                                                               AS projected_annual_clv
FROM customers   c
JOIN orders      o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY c.customer_id, c.full_name, c.segment
ORDER BY projected_annual_clv DESC
LIMIT 20;

-- 5.4  Churn Risk — Customers with no order in last 90 days
SELECT
    c.customer_id,
    c.full_name,
    c.email,
    MAX(o.order_date)                        AS last_order_date,
    DATEDIFF(CURDATE(), MAX(o.order_date))   AS days_since_last_order,
    COUNT(DISTINCT o.order_id)               AS total_orders
FROM customers c
JOIN orders    o ON c.customer_id = o.customer_id
WHERE o.status NOT IN ('Cancelled','Returned')
GROUP BY c.customer_id, c.full_name, c.email
HAVING days_since_last_order > 90
ORDER BY days_since_last_order DESC;

-- 5.5  Return Rate by Product
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id)              AS total_orders,
    COUNT(DISTINCT r.order_id)               AS returned_orders,
    ROUND(COUNT(DISTINCT r.order_id) * 100.0 /
          NULLIF(COUNT(DISTINCT oi.order_id), 0), 2) AS return_rate_pct
FROM products    p
JOIN order_items oi ON p.product_id  = oi.product_id
LEFT JOIN returns r  ON oi.order_id  = r.order_id
GROUP BY p.product_id, p.product_name
ORDER BY return_rate_pct DESC;
