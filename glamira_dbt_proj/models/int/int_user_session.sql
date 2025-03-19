{{ config(materialized='view') }}

WITH actions AS (
    SELECT 
        ip,
        source_collection AS action_type, 
        country_long,
        city,
        ROW_NUMBER() OVER (PARTITION BY ip ORDER BY source_collection) AS action_order
    FROM {{ ref('stg_user_journey') }}
)

SELECT 
    ip,
    action_type,
    action_order,
    country_long,
    city,
    GENERATE_UUID() AS session_id  -- Assigning a unique session ID for each row
FROM actions
