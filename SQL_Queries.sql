Base data(SQL Queries)

SELECT
  CAST(trip_id AS STRING) AS ride_id,
  CAST(start_time AS TIMESTAMP) AS started_at,
  CAST(end_time AS TIMESTAMP) AS ended_at,
  usertype AS member_casual
FROM `first-bigquery-project-491412.Cyclist_rides.ride_2019_q1`

UNION ALL

SELECT
  CAST(ride_id AS STRING) AS ride_id,
  CAST(started_at AS TIMESTAMP) AS started_at,
  CAST(ended_at AS TIMESTAMP) AS ended_at,
  member_casual
FROM `first-bigquery-project-491412.Cyclist_rides.ride_2020_q1`

Total rides

SELECT COUNT(*) AS total_rides
FROM (
  SELECT
    CAST(trip_id AS STRING) AS ride_id
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2019_q1`

  UNION ALL

  SELECT
    CAST(ride_id AS STRING) AS ride_id
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2020_q1`
);

User type comparison

SELECT member_casual,
       COUNT(*) AS total_rides
FROM (
  SELECT
    CAST(trip_id AS STRING) AS ride_id,
    usertype AS member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2019_q1`

  UNION ALL

  SELECT
    CAST(ride_id AS STRING) AS ride_id,
    member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2020_q1`
)
GROUP BY member_casual;

Ride duration analysis

SELECT member_casual,
       AVG(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS avg_ride_length,
       MAX(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS max_ride_length
FROM (
  SELECT
    CAST(trip_id AS STRING) AS ride_id,
    CAST(start_time AS TIMESTAMP) AS started_at,
    CAST(end_time AS TIMESTAMP) AS ended_at,
    usertype AS member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2019_q1`

  UNION ALL

  SELECT
    CAST(ride_id AS STRING),
    CAST(started_at AS TIMESTAMP),
    CAST(ended_at AS TIMESTAMP),
    member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2020_q1`
)
GROUP BY member_casual;

Weekly usage pattern

SELECT member_casual,
       EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
       COUNT(*) AS total_rides,
       AVG(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS avg_duration
FROM (
  SELECT
    CAST(trip_id AS STRING) AS ride_id,
    CAST(start_time AS TIMESTAMP) AS started_at,
    CAST(end_time AS TIMESTAMP) AS ended_at,
    usertype AS member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2019_q1`

  UNION ALL

  SELECT
    CAST(ride_id AS STRING),
    CAST(started_at AS TIMESTAMP),
    CAST(ended_at AS TIMESTAMP),
    member_casual
  FROM `first-bigquery-project-491412.Cyclist_rides.ride_2020_q1`
)
GROUP BY member_casual, day_of_week
ORDER BY day_of_week;

