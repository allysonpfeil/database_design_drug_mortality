-- DQL --

SELECT ROUND(AVG(Model_Based_Death_Rate), 2) AS Drug_Poisoning_Death_Rate, Urban_Rural_Category
FROM vw_ALL
GROUP BY Urban_Rural_Category;

/*
This query demonstrates the drug poisoning death rate as an aggregate of all years by urban or rural category.
The average is rounded to 2 decimal points for ease of viewing.
This data demonstrates that medium metro and noncore (the most rural areas) have a similar drug poisoning rate.
Interesting, micropolitans have a drastically lower rate than either noncore or medium metro
*/

SELECT ROUND(AVG(Model_Based_Death_Rate), 2), Stat_Year, Urban_Rural_Category
FROM vw_ALL
GROUP BY Stat_Year, Urban_Rural_Category
ORDER BY Stat_Year ASC;

/*
This query demonstrates the drug poisoning death rate by year and urban or rural category.
The average is rounded to 2 decimal points for ease of viewing.
This data would be very interesting to then plot as a time series, so year/year comparisons among county types can be studied...
... as well as general trends over time (increases).
*/

SELECT ROUND(AVG(Model_Based_Death_Rate), 2), ROUND(AVG(Lower_Confidence_Limit), 2), ROUND(AVG(Upper_Confidence_Limit), 2), County, Urban_Rural_Category
FROM vw_ALL
GROUP BY County, Urban_Rural_Category
ORDER BY County DESC;

/*
This query demonstrates the drug poisoning death rate plus the confidence intervals an aggregate of all years by urban or rural category...
... while also displaying the county name for ease of study.
The average is rounded to 2 decimal points for ease of viewing.
This data would be very interesting to then plot for comparisons among county types and within (such as medium metro) can be studied...
... and identify if there are any outliers that may have impacted the previous SQL queries.
*/

SELECT ROUND(MAX(Model_Based_Death_Rate), 2), County
FROM vw_ALL
GROUP BY County;

/*
This query demonstrates the maximum drug poisoning death rate as an aggregate of all years by county name.
The average is rounded to 2 decimal points for ease of viewing.
This data would be very interesting to then compare to the average statistically, and seek out public health reasons for why.
*/

SELECT ROUND(AVG(Model_Based_Death_Rate), 2), ROUND(AVG(Lower_Confidence_Limit), 2), ROUND(AVG(Upper_Confidence_Limit), 2), County, Stat_Year
FROM vw_ALL
GROUP BY County, Stat_Year
ORDER BY County ASC, Stat_Year ASC;

/*
This query demonstrates the drug poisoning death rate plus the confidence intervals by year and by county name.
The average is rounded to 2 decimal points for ease of viewing.
This data would be very interesting to then plot for comparisons among counties and over time trends within the same population.
*/
