{{ config(materialized='table') }}

WITH funnel AS (
    SELECT 
        ip,
        COUNT(CASE WHEN action_type = 'add_to_cart' THEN 1 END) AS add_to_cart_count,
        COUNT(CASE WHEN action_type = 'back_to_product' THEN 1 END) AS back_to_product_count,
        COUNT(CASE WHEN action_type = 'checkout' THEN 1 END) AS checkout_count,
        COUNT(CASE WHEN action_type = 'checkout_success' THEN 1 END) AS checkout_success_count
    FROM {{ ref('stg_user_journey') }}
    GROUP BY ip
)

SELECT 
    f.*,
    l.country_short,
    l.country_long,
    l.city,
    l.region,
    SAFE_DIVIDE(f.checkout_count, f.add_to_cart_count) AS cart_to_checkout_rate,
    SAFE_DIVIDE(f.checkout_success_count, f.checkout_count) AS checkout_to_success_rate,
    SAFE_DIVIDE(f.checkout_success_count, f.add_to_cart_count) AS overall_conversion_rate
FROM funnel f
LEFT JOIN {{ ref('dim_ip_locations') }} l
ON f.ip = l.ip
