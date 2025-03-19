{{ config(
    materialized='table'
) }}

WITH geo_data AS (
    SELECT 
        s.ip,
        d.country_short,
        d.country_long,
        d.city,
        d.region,
        COUNT(DISTINCT s.user_id_db) AS unique_users,
        COUNT(s.order_id) AS total_orders,
    FROM {{ ref('stg_summary') }} AS s
    LEFT JOIN {{ ref('dim_location') }} AS d
    ON s.ip = d.ip
    WHERE s.collection = 'checkout_success'
    GROUP BY d.country_short, d.country_long, d.city, d.region, s.ip    
)

SELECT * FROM geo_data
