{{ config(materialized='table') }}

WITH product_data AS (
    SELECT 
        dp.product_id,
        dp.option_label,

        COUNT(DISTINCT dp.order_id) AS total_orders,  -- Unique orders per product
        SUM(SAFE_CAST(REPLACE(dp.price, ',', '') AS FLOAT64) * dp.amount) AS total_revenue, -- Ignore bad values
        AVG(SAFE_CAST(REPLACE(dp.price, ',', '') AS FLOAT64)) AS avg_price  -- Ignore bad values

    FROM {{ ref('dim_product') }} dp
    WHERE dp.product_id IS NOT NULL
    GROUP BY dp.product_id, dp.option_label  
    ORDER BY total_revenue DESC
)

SELECT * FROM product_data
ORDER BY total_revenue DESC
