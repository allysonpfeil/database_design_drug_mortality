-- creating a view (vw_ALL) that contains the full dataset as downloaded -- 

CREATE VIEW vw_ALL
AS
SELECT
c.FIPS_County AS FIPS_County,
dpm.Stat_Year AS Stat_Year,
s.State_Name AS State,
s.FIPS_State AS FIPS_State,
c.County_Name AS County,
p.Population AS Population,
dpm.Modeled_Death_Rate AS Model_Based_Death_Rate,
dpm.Modeled_Standard_Deviation AS Standard_Deviation,
dpm.Lower_Bound_Confidence AS Lower_Confidence_Limit,
dpm.Upper_Bound_Confidence AS Upper_Confidence_Limit,
c.County_Category AS Urban_Rural_Category,
c.Census_Division AS Census_Division
FROM COUNTY c
INNER JOIN DRUG_POISONING_MORTALITY dpm
ON c.FIPS_County = dpm.FIPS_County
INNER JOIN STATE s
ON s.FIPS_State = dpm.FIPS_State
INNER JOIN POPULATION p
ON p.Population_ID = dpm.Population_ID;
