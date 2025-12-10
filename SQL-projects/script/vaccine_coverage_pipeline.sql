/* ===========================================
   0. CREATE / SELECT DATABASE
   =========================================== */

CREATE DATABASE IF NOT EXISTS vaccine_coverage;
USE vaccine_coverage;


/* ===========================================
   1. RAW TABLE + LOAD DATA
   =========================================== */

-- Clean slate if re-running
DROP TABLE IF EXISTS flu_vax_state_region;
DROP TABLE IF EXISTS us_state_region;
DROP TABLE IF EXISTS flu_state;
DROP TABLE IF EXISTS flu_raw;

-- Raw table structure matching CSV
CREATE TABLE flu_raw (
    vaccine            VARCHAR(50),
    geography_type     VARCHAR(50),
    geography          VARCHAR(100),
    fips               VARCHAR(20),
    season_survey_year VARCHAR(10),
    month              INT NULL,
    dimension_type     VARCHAR(100),
    dimension          VARCHAR(100),
    estimate_pct       VARCHAR(20),
    ci_95              VARCHAR(50),
    sample_size        INT NULL,
    coverage_pct       DECIMAL(5,2) NULL  -- we'll fill this later
);

-- Load CSV from secure_file_priv Uploads folder
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Influenza_Vaccination_Coverage_for_All_Ages__6__Months_.csv'
INTO TABLE flu_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    vaccine,
    geography_type,
    geography,
    fips,
    season_survey_year,
    @month,
    dimension_type,
    dimension,
    @estimate_pct,
    ci_95,
    @sample_size
)
SET
    month        = NULLIF(@month, ''),
    estimate_pct = NULLIF(@estimate_pct, ''),
    sample_size  = NULLIF(@sample_size, '');


/* ===========================================
   2. CLEAN COVERAGE INTO NUMERIC
   =========================================== */

-- Convert text estimate_pct (like '45.3' or '45.3%') into numeric coverage_pct
UPDATE flu_raw
SET coverage_pct = CASE
    WHEN estimate_pct IS NULL OR estimate_pct = '' THEN NULL
    ELSE CAST(
        NULLIF(
            REGEXP_REPLACE(estimate_pct, '[^0-9.]', ''), 
            ''
        ) AS DECIMAL(5,2)
    )
END;


/* OPTIONAL: sanity check
SELECT estimate_pct, coverage_pct
FROM flu_raw
LIMIT 10;
*/


/* ===========================================
   3. CREATE FLU_STATE (STATE-LEVEL, ALL AGES 6+)
   =========================================== */

CREATE TABLE flu_state AS
SELECT
    season_survey_year      AS season_year,
    geography               AS state,
    coverage_pct,
    sample_size,
    geography_type,
    dimension_type,
    dimension
FROM flu_raw
WHERE
    geography_type LIKE 'State%'   -- keep state-level rows
    AND dimension_type LIKE 'Age%' -- age dimension only
    AND (
        dimension LIKE 'All%'      -- all ages
        OR dimension LIKE '%6 months%'  -- or explicit 6+ months
    )
    AND coverage_pct IS NOT NULL;

-- Add Healthy People target and gap to target
ALTER TABLE flu_state
ADD COLUMN target_pct   DECIMAL(5,2) DEFAULT 70.00,
ADD COLUMN gap_to_target DECIMAL(5,2);

UPDATE flu_state
SET gap_to_target = coverage_pct - target_pct;


/* OPTIONAL: quick look
SELECT season_year, state, coverage_pct, gap_to_target
FROM flu_state
LIMIT 10;
*/


/* ===========================================
   4. CORE ANALYSES (NO REGIONS)
   =========================================== */

-- 4.1 National trend over time
SELECT
    season_year,
    ROUND(AVG(coverage_pct), 2) AS avg_coverage_pct
FROM flu_state
GROUP BY season_year
ORDER BY season_year;

-- 4.2 States furthest from target (latest season)
SELECT
    state,
    coverage_pct,
    gap_to_target
FROM flu_state
WHERE season_year = (SELECT MAX(season_year) FROM flu_state)
ORDER BY gap_to_target ASC   -- most negative (worst) first
LIMIT 10;

-- 4.3 Persistent under-performers (multi-year)
SELECT
    state,
    ROUND(AVG(gap_to_target), 2) AS avg_gap_to_target,
    COUNT(*) AS seasons
FROM flu_state
GROUP BY state
HAVING seasons >= 3
ORDER BY avg_gap_to_target ASC
LIMIT 10;


/* ===========================================
   5. REGION LOOKUP TABLE (US 50 STATES)
   =========================================== */

CREATE TABLE us_state_region (
    state  VARCHAR(100) PRIMARY KEY,
    region VARCHAR(50)
);

INSERT INTO us_state_region (state, region) VALUES
('Alabama','South'),
('Alaska','West'),
('Arizona','West'),
('Arkansas','South'),
('California','West'),
('Colorado','West'),
('Connecticut','Northeast'),
('Delaware','South'),
('Florida','South'),
('Georgia','South'),
('Hawaii','West'),
('Idaho','West'),
('Illinois','Midwest'),
('Indiana','Midwest'),
('Iowa','Midwest'),
('Kansas','Midwest'),
('Kentucky','South'),
('Louisiana','South'),
('Maine','Northeast'),
('Maryland','South'),
('Massachusetts','Northeast'),
('Michigan','Midwest'),
('Minnesota','Midwest'),
('Mississippi','South'),
('Missouri','Midwest'),
('Montana','West'),
('Nebraska','Midwest'),
('Nevada','West'),
('New Hampshire','Northeast'),
('New Jersey','Northeast'),
('New Mexico','West'),
('New York','Northeast'),
('North Carolina','South'),
('North Dakota','Midwest'),
('Ohio','Midwest'),
('Oklahoma','South'),
('Oregon','West'),
('Pennsylvania','Northeast'),
('Rhode Island','Northeast'),
('South Carolina','South'),
('South Dakota','Midwest'),
('Tennessee','South'),
('Texas','South'),
('Utah','West'),
('Vermont','Northeast'),
('Virginia','South'),
('Washington','West'),
('West Virginia','South'),
('Wisconsin','Midwest'),
('Wyoming','West');


/* ===========================================
   6. REGION-AUGMENTED TABLE
   =========================================== */

CREATE TABLE flu_vax_state_region AS
SELECT
    f.season_year,
    f.state,
    r.region,
    f.coverage_pct,
    f.sample_size,
    f.target_pct,
    f.gap_to_target
FROM flu_state f
LEFT JOIN us_state_region r
  ON f.state = r.state;


/* ===========================================
   7. REGION-LEVEL ANALYSES
   =========================================== */

-- 7.1 Region-level trends over time
SELECT
    season_year,
    region,
    ROUND(AVG(coverage_pct), 2) AS region_coverage_pct
FROM flu_vax_state_region
WHERE region IS NOT NULL
GROUP BY season_year, region
ORDER BY season_year, region;

-- 7.2 States furthest from target (latest season, with region)
SELECT
    state AS state_name,
    region,
    coverage_pct,
    gap_to_target
FROM flu_vax_state_region
WHERE region IS NOT NULL
  AND season_year = (SELECT MAX(season_year) FROM flu_vax_state_region)
ORDER BY gap_to_target ASC
LIMIT 10;

-- 7.3 Persistent under-performers by region (multi-year)
SELECT
    state AS state_name,
    region,
    ROUND(AVG(gap_to_target), 2) AS avg_gap_to_target,
    COUNT(*) AS seasons
FROM flu_vax_state_region
WHERE region IS NOT NULL
GROUP BY state, region
HAVING seasons >= 3
ORDER BY avg_gap_to_target ASC
LIMIT 10;








                      