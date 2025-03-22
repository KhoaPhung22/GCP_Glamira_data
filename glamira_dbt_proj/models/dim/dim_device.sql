{{ config(
    materialized='table'
) }}

WITH device AS (
    SELECT
        device_id,
        user_agent,  
        resolution,  
        api_version,  
        email_address  
    FROM {{ ref('stg_summary') }} 
)

SELECT DISTINCT * FROM device;
