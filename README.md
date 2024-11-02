# DE_project1
Healthcare Database ETL Project

Project Overview
This project, developed for the ECBS 5146 SQL and Different Shapes of Data course, implements an ETL process to support healthcare data analysis. It integrates and transforms data across multiple tables within MySQL, creating an operational layer, an analytical layer with aggregated metrics, and data marts for targeted insights. The ETL pipeline is automated using SQL stored procedures and scheduled events to keep data up-to-date.
Data Source
The data for this project was sourced from the World Bank Database: https://data.worldbank.org, which provides comprehensive and globally comparable information on healthcare expenditures, outcomes, and demographics across countries and regions.
Data Transformation and Cleaning
The raw data from the World Bank was initially in a tidy-wide format, containing multiple years and variables per country. To prepare the data for analysis, the following transformations and cleaning steps were applied:
Transforming: Transposed columns into tidy-long format to facilitate filtering and analysis across multiple years and variables for each country.
Formatting: Standardized column names to make them clear and consistent across tables. Some observations contained commas or special characters, which were corrected to avoid compatibility issues.
Merging: Merged the 3 tables with the country metadata table to add the region column, enhancing the dataset for regional analysis.
Reordering: Reordered columns for logical organization and ease of access, particularly for downstream transformations and analytics.
Null Handling: Dropped columns with a high proportion of null values if they were non-essential for core analyses. While some additional insights could be gained from these variables, their exclusion helps maintain data integrity.
Data Structuring - Facts and Dimensions of the database:
Fact - Healthcare Outcomes: Core metrics like life expectancy, mortality rate, and maternal health risk.
Dimension 1 - Healthcare Spending: Includes categories such as current government expenditure, health expenditure per capita, and expenditures categorized by government, private, external, and out-of-pocket.
Dimension 2 - Country Statistics: Provides economic and demographic context, including GDP, GDP growth rate, per capita GDP and population growth.
Dimension 3 - Location: Specifies the country name and region, enabling geographic analysis.
Dimension 4 - Time: Captures the year of data, supporting time-series and trend analysis.
Calculated Metrics: Additional metrics derived from raw data to enhance analytical insights, including: moving averages, expenditure categories, normalized expenditure values, life expectancy categories, and year-over-year change calculations for life expectancy and mortality rates.
These steps prepared the data for efficient querying and transformation within the ETL pipeline, enabling streamlined analytical insights.

Components and Implementation
Operational Layer
Tables: country, healthcare_spending, healthcare_outcomes.
Purpose: Stores raw data on demographics, health expenditures, and outcomes, serving as the foundational layer for transformations.
Analytical Layer
The HealthcareDatabase table forms the core of the analytical layer, combining and transforming data for easy access and analysis. Key transformations include:
Moving Average: for government health spending to show trends over time.
Expenditure Categories: based on percentiles for each type of spending.
Normalization: to enable fair comparisons across spending types.
Life Expectancy Categories: grouping countries based on life expectancy ranges.
Year-over-Year Change Calculations: for mortality and life expectancy rates.
Another table, RegionalHealthComparison, aggregates data by region, including metrics like average life expectancy, infant and maternal mortality rates, and per capita healthcare spending.
Data Marts (Views)
Data marts support specific analyses and include:
diff_health_expenditure: Shows healthcare spending and outcomes by expenditure type.
south_asiaregion and subsaharan_africaregion: Focus on healthcare data from these regions.
yr2022: Provides healthcare data for the year 2022 across all regions.
ETL Automation
The ETL process uses SQL stored procedures and events to ensure continuous updates:
CreateHealthcareDatabase handles transformations and loading.
UpdateHealthcareDatabaseEvent refreshes data every 30 seconds, keeping HealthcareDatabase current.
Messages table logs each update, creating a record of the pipeline’s activity.

Analytics Supported
This project enables a range of analyses to extract insights from healthcare data:
Regional Health Comparisons: Using RegionalHealthComparison, users can compare health outcomes and expenditure levels across regions, providing insights into how healthcare access and spending differ by region and affect health metrics.
Impact of Healthcare Expenditure on Life Expectancy: Through the diff_health_expenditure view, users can analyze how different expenditure types (government, private, external, and out-of-pocket) correlate with life expectancy, identifying which types of spending may be most beneficial for health outcomes.
GDP and Health Correlation: Assess how economic indicators (e.g., GDP per capita, GDP growth) correlate with health outcomes like life expectancy and maternal mortality. This analysis can reveal how economic performance impacts population health across different income levels.
Gender-Specific Life Expectancy Trends: Use life expectancy data by gender to explore gender disparities in health across regions or over time. Compare male and female life expectancy trends and analyze the factors influencing these disparities, such as health spending or socioeconomic conditions.
Population Growth and Health Access: Evaluate how population growth affects health outcomes and healthcare spending efficiency. Rapidly growing populations may experience different health challenges or access issues, which could reflect in health outcomes.
External Health Funding Effectiveness: Examine how external health expenditures, such as international aid, impact health outcomes across different regions or income levels, which can show the effectiveness of aid in improving local health conditions.
