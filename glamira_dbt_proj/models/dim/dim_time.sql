{{ config(
    materialized='table'
) }}

SELECT 
    FARM_FINGERPRINT(time_stamp) AS time_id,
    {# TIMESTAMP_SECONDS(CAST(time_stamp AS INT64)) AS timestamp,  -- Convert Unix timestamp to TIMESTAMP #}
    EXTRACT(YEAR FROM TIMESTAMP_SECONDS(CAST(time_stamp AS INT64))) AS year,
    EXTRACT(MONTH FROM TIMESTAMP_SECONDS(CAST(time_stamp AS INT64))) AS month,
    EXTRACT(DAY FROM TIMESTAMP_SECONDS(CAST(time_stamp AS INT64))) AS day,
    EXTRACT(HOUR FROM TIMESTAMP_SECONDS(CAST(time_stamp AS INT64))) AS hour,
FROM {{ ref('stg_summary') }}
