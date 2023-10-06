CREATE OR REPLACE TABLE SNOWPIPE_DB.PUBLIC.NEO_ATTRIBUTES(
NEO_ID varchar,
NEO_REFERENCE_ID varchar,
NEO_NAME varchar,
NAME_LIMITTED varchar,
ABSOLUTE_MAGNITUDE_H varchar,
ESTIMATED_DIAMETER_MIN_KM number(10,2),
ESTIMATED_DIAMETER_MAX_KM number(10,2),
POTENTIALLY_HAZARDOUS varchar,
SENTRY_OBJECT varchar
);

CREATE OR REPLACE TABLE SNOWPIPE_DB.PUBLIC.NEO_ORBITS(
NEO_ID varchar,
ORBIT_ID varchar,
ORBIT_DETERMINATION_DATE date,
LAST_OBSERVATION_DATE date,
DATA_ARC_DAYS int,
INCLINATION number(10,2),
ORBITAL_PERIOD number(10,2),
ORBIT_CLASS_TYPE varchar,
ORBIT_CLASS_DESCRIPTION varchar
);

CREATE OR REPLACE TABLE SNOWPIPE_DB.PUBLIC.NEO_DATES(
NEO_ID varchar,
ORBITTING_BODY varchar,
RELATIVE_VELOCITY_KMS_HR number(10,2),
MISS_DISTANCE_KM number(30,2),
APPROACH_TIME varchar,
CLOSE_APPROACH_DATE date
);

CREATE OR REPLACE TABLE SNOWPIPE_DB.PUBLIC.NEO_GROUPED(
NEO_ID varchar,
AVG_RELATIVE_VELOCITY_KMS_HR number(10,2),
MAX_RELATIVE_VELOCITY_KMS_HR number(10,2),
MIN_RELATIVE_VELOCITY_KMS_HR number(10,2),
AVG_MISS_DISTANCE_KM number(30,2),
MAX_MISS_DISTANCE_KM number(30,2),
MIN_MISS_DISTANCE_KM number(30,2),
MAX_CLOSE_APPROACH_DATE date,
MIN_CLOSE_APPROACH_DATE date,
PREV_APPROACH_DATE date,
NEXT_APPROACH_DATE date
);
