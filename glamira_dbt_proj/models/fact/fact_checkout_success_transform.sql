{{ config(materialized='table') }}

WITH checkout_success AS (
    SELECT 
        ip, 
        country_short, 
        country_long, 
        city, 
        region, 
        latitude, 
        longitude,
        COUNT(*) AS success_count
    FROM {{ ref('stg_checkout_success') }} 
    WHERE source_collection = 'checkout_success'
    GROUP BY 1,2,3,4,5,6,7
)

SELECT * FROM checkout_success
