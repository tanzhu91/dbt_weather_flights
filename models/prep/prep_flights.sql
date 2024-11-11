WITH flights_one_month AS (
    SELECT * 
    FROM {{ref('staging_flights_one_month')}}
),
flights_cleaned AS (
    SELECT 
        flight_date::DATE,
        TO_CHAR(dep_time, 'fm0000')::TIME AS dep_time,  -- Casting dep_time to TIME
        TO_CHAR(sched_dep_time, 'fm0000')::TIME AS sched_dep_time,  -- Casting scheduled departure time to TIME
        dep_delay,
        (dep_delay * '1 minute'::INTERVAL) AS dep_delay_interval,  -- Converting departure delay to INTERVAL
        TO_CHAR(arr_time, 'fm0000')::TIME AS arr_time,  -- Casting arrival time to TIME
        TO_CHAR(sched_arr_time, 'fm0000')::TIME AS sched_arr_time,  -- Casting scheduled arrival time to TIME
        arr_delay,
        (arr_delay * '1 minute'::INTERVAL) AS arr_delay_interval,  -- Converting arrival delay to INTERVAL
        airline,
        tail_number,
        flight_number,
        origin,
        dest,
        air_time,
        (air_time * '1 minute'::INTERVAL) AS air_time_interval,  -- Converting air time to INTERVAL
        actual_elapsed_time,
        (actual_elapsed_time * '1 minute'::INTERVAL) AS actual_elapsed_time_interval,  -- Converting actual elapsed time to INTERVAL
        (distance * 1.60934)::NUMERIC(6,2) AS distance_km,  -- Converting miles to kilometers
        cancelled,
        diverted
    FROM flights_one_month
)
SELECT * 
FROM flights_cleaned