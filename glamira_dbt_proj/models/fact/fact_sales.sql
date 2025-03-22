{{ config(materialized='table') }}

-- 🏎 Pre-Aggregate Metrics to Reduce Row Processing
WITH aggregated_orders AS (
    SELECT
        product_id,
        COUNT(DISTINCT order_id) AS total_orders_per_product,  -- Aggregate by product
        COUNT(DISTINCT email_address) AS unique_users
    FROM {{ ref('stg_summary') }}
    GROUP BY product_id
),

aggregated_revenue AS (
    SELECT
        product_id,
        SUM(total_revenue) AS total_revenue  -- Aggregate revenue by product
    FROM {{ ref('stg_revenue') }}
    GROUP BY product_id
)

SELECT
    -- 📌 Order & Product Details
    CONCAT(CAST(ss.product_id AS STRING), '-', CAST(ss.store_id AS STRING)) AS sales_id,
    COALESCE(ss.order_id) AS order_id,  -- Avoid NULL values
    ss.product_id,
    FARM_FINGERPRINT(ss.ip) AS location_id,  -- Generate unique location_id efficiently
    sp.option_id,
    ss.store_id,
    FARM_FINGERPRINT(ss.time_stamp) as date_id,
    ss.device_id,
    sp.price,  -- Stored as FLOAT64 in `stg_product`

    -- 📊 Order Metrics
    ao.total_orders_per_product AS total_orders,

    -- 💰 Revenue Metrics
    COALESCE(ar.total_revenue, 0) AS total_revenue,  -- Avoid NULL values

FROM {{ ref('stg_summary') }} ss
INNER JOIN {{ ref('stg_product') }} sp
    ON ss.product_id = sp.product_id
LEFT JOIN aggregated_orders ao
    ON ss.product_id = ao.product_id
LEFT JOIN aggregated_revenue ar
    ON ss.product_id = ar.product_id
