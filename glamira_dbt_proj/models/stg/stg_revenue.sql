{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        s.order_id, 
        c.product_id,
        dp.price, 
        dp.currency,
        c.amount,
        o.option_id,
        o.option_label,
        o.value_id,
        o.value_label,
        l.country_long,
        l.region,
        l.city,
        l.latitude,
        l.longitude
    FROM `glamira-project-2.glamira_warehouse.summary2` AS s
    LEFT JOIN UNNEST(s.cart_products) AS c  -- Unnest cart_products array
    LEFT JOIN UNNEST(c.option) AS o         -- Unnest option array inside cart_products
    LEFT JOIN {{ ref("stg_product") }} AS dp  
        ON c.product_id = dp.product_id  -- Joining dim_product for price data
    LEFT JOIN {{ ref("dim_location") }} AS l  
        ON s.ip = l.ip  -- Mapping user location
    WHERE c.product_id IS NOT NULL
)

SELECT 
    order_id,
    product_id,
    option_id,
    option_label,
    value_id,
    value_label,
    country_long,
    region,
    city,
    latitude,
    longitude,
    price,
    amount,
    SAFE_CAST(price AS FLOAT64) * amount AS total_revenue  -- Calculating revenue
FROM base
WHERE SAFE_CAST(price AS FLOAT64) * amount >0
ORDER BY total_revenue DESC

