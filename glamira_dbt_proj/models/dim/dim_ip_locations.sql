{{ config(materialized='table') }}

SELECT
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude,
    action_type
FROM {{ ref('stg_user_journey') }}

