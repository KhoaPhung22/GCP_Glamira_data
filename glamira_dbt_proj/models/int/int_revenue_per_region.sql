{# {{ config(materialized='table') }}

WITH regional_revenue AS (
    SELECT 
        country_long,
        region,
        SUM(total_revenue) AS total_revenue,
    FROM {{ ref("stg_revenue") }}
    GROUP BY country_long,region
)
SELECT * FROM regional_revenue #}
