{{ config(materialized='table') }}

SELECT 
    session_id,
    ip,
    country_long,
    city,
    COUNT(DISTINCT action_type) AS unique_action_count,
    COUNT(*) AS total_actions,
FROM {{ ref('int_user_session') }}
GROUP BY session_id, ip, country_long, city