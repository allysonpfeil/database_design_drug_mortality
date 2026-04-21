-- adding the data to the tables
-- planned order: STATE -> POPULATION-> COUNTY -> DRUG_POISONING_MORTALITY

-- STATE -- 
INSERT INTO STATE
(FIPS_State)
SELECT DISTINCT `FIPS State` from BULK_RECORDS;

UPDATE STATE s, BULK_RECORDS b
SET s.State_Name = b.State
WHERE s.FIPS_State = b.`FIPS State`;

-- POPULATION --
INSERT INTO POPULATION
(Population)
SELECT DISTINCT Population from BULK_RECORDS;

ALTER TABLE BULK_RECORDS
ADD Population_ID INT;

UPDATE BULK_RECORDS b
JOIN POPULATION p
ON p.Population = b.Population
SET b.Population_ID = p.Population_ID;

-- COUNTY --
INSERT INTO COUNTY
(FIPS_County)
SELECT DISTINCT FIPS from BULK_RECORDS;

UPDATE COUNTY c, BULK_RECORDS b
SET c.County_Name = b.County
WHERE c.FIPS_County = b.FIPS;

UPDATE COUNTY c, BULK_RECORDS b
SET c.Census_Division = b.`Census Division`
WHERE c.FIPS_County = b.FIPS;

UPDATE COUNTY c, BULK_RECORDS b
SET c.County_Category = b.`Urban/Rural Category`
WHERE c.FIPS_County = b.FIPS;

-- DRUG_POISONING_MORTALITY --
SELECT * FROM DRUG_POISONING_MORTALITY;
SELECT * FROM BULK_RECORDS;

INSERT INTO DRUG_POISONING_MORTALITY
(Modeled_Death_Rate)
SELECT DISTINCT `Model-based Death Rate` from BULK_RECORDS;

ALTER TABLE BULK_RECORDS
ADD Mortality_ID INT;

UPDATE BULK_RECORDS b
JOIN DRUG_POISONING_MORTALITY dpm
ON ROUND(dpm.Modeled_Death_Rate, 3) = ROUND(b.`Model-based Death Rate`, 3)
SET b.Mortality_ID = dpm.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.Modeled_Standard_Deviation = b.`Standard Deviation`
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.Lower_Bound_Confidence = b.`Lower Confidence Limit`
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.Upper_Bound_Confidence = b.`Upper Confidence Limit`
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.Stat_Year = b.`Year`
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.FIPS_State = b.`FIPS State`
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.FIPS_County = b.FIPS
WHERE dpm.Mortality_ID = b.Mortality_ID;

UPDATE DRUG_POISONING_MORTALITY dpm, BULK_RECORDS b
SET dpm.Population_ID = b.Population_ID
WHERE dpm.Mortality_ID = b.Mortality_ID;
