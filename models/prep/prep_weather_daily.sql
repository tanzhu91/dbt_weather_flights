WITH daily_data AS (
    SELECT * 
    FROM {{ref('staging_weather_daily')}}
),
add_features AS (
    SELECT *
        , DATE_PART('day', date) AS date_day
        , DATE_PART('month', date) AS date_month
        , DATE_PART('year', date) AS date_year
        , DATE_PART('week', date) AS cw
        , TO_CHAR(date, 'FMMonth') AS month_name
        , TO_CHAR(date, 'FMDay') AS weekday
    FROM daily_data 
),
add_more_features AS (
    SELECT *
        , (CASE 
            WHEN DATE_PART('month', date) IN (12, 1, 2) THEN 'winter'
            WHEN DATE_PART('month', date) IN (3, 4, 5) THEN 'spring'
            WHEN DATE_PART('month', date) IN (6, 7, 8) THEN 'summer'
            WHEN DATE_PART('month', date) IN (9, 10, 11) THEN 'autumn'
        END) AS season
    FROM add_features
)
SELECT *
FROM add_more_features
ORDER BY date;