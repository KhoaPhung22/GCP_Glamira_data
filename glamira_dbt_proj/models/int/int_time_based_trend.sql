{# {{ config(
    materialized='table'
) }}

WITH time_data AS (
    SELECT 
        dp.product_id,
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', s.local_time) AS timestamp,
        DATE(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', s.local_time)) AS transaction_date,
        EXTRACT(HOUR FROM PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', s.local_time)) AS transaction_hour,
        EXTRACT(WEEK FROM PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', s.local_time)) AS transaction_week,
        
        -- Count unique users
        COUNT(DISTINCT s.email_address) AS unique_users,

        -- Calculate total revenue using dim_product price
        SUM(SAFE_CAST(dp.price AS FLOAT64) * c.amount) AS total_revenue

    FROM {{ ref('stg_summary') }} AS s
    LEFT JOIN UNNEST(s.cart_products) AS c  -- Unnest cart_products
    LEFT JOIN {{ ref('dim_product') }} dp   -- Join with dim_product to get price
        ON c.product_id = dp.product_id 

    WHERE s.collection = 'checkout_success'  -- Filter for successful checkouts

    GROUP BY transaction_date, transaction_hour, transaction_week, timestamp, dp.product_id
    ORDER BY transaction_date
)

SELECT * FROM time_data
WHERE total_revenue IS NOT NULL #}
