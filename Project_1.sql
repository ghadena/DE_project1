
#creating schema 
drop schema if exists project_1;
create schema project_1; 
use project_1; 

#creating country table 
DROP TABLE IF EXISTS country;
CREATE TABLE country (
	id integer not null,
    country_name varchar(225) not null,  
    country_code varchar(10) not null,  
    Region varchar(100) not null,        
    Year integer not null,          
    gdp_current_usd DECIMAL(20, 2),
    gdp_growth_annual_percent DECIMAL(5, 2),
    gdp_per_capita_current_usd DECIMAL(20, 2),
    gdp_per_capita_growth_annual_percent DECIMAL(5, 2),
    multidimensional_poverty_headcount_ratio DECIMAL(5, 2),
    population_density DECIMAL(10, 2),
    population_growth_annual_percent DECIMAL(5, 2),
    population_total DECIMAL(20, 2),
    poverty_gap DECIMAL(5, 2),
    poverty_headcount_ratio_215 DECIMAL(5, 2),
    poverty_headcount_ratio_365 DECIMAL(5, 2),
	PRIMARY KEY (id)
);

 # loading data into country table
LOAD DATA INFILE '/tmp/country.csv' 
INTO TABLE country
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, country_name, country_code, region, year, @gdp_current_usd, @gdp_growth_annual_percent, @gdp_per_capita_current_usd, @gdp_per_capita_growth_annual_percent, @multidimensional_poverty_headcount_ratio, @population_density, @population_growth_annual_percent, @population_total, @poverty_gap, @poverty_headcount_ratio_215, @poverty_headcount_ratio_365)
SET
    gdp_current_usd = NULLIF(@gdp_current_usd, ''),
    gdp_growth_annual_percent = NULLIF(@gdp_growth_annual_percent, ''),
    gdp_per_capita_current_usd = NULLIF(@gdp_per_capita_current_usd, ''),
    gdp_per_capita_growth_annual_percent = NULLIF(@gdp_per_capita_growth_annual_percent, ''),
    multidimensional_poverty_headcount_ratio = NULLIF(@multidimensional_poverty_headcount_ratio, ''),
    population_density = NULLIF(@population_density, ''),
    population_growth_annual_percent = NULLIF(@population_growth_annual_percent, ''),
    population_total = NULLIF(@population_total, ''),
    poverty_gap = NULLIF(@poverty_gap, ''),
    poverty_headcount_ratio_215 = NULLIF(@poverty_headcount_ratio_215, ''),
    poverty_headcount_ratio_365 = NULLIF(@poverty_headcount_ratio_365, '');
    

select * from country;

#dropping unused metrics to simplify tables 
ALTER TABLE country DROP COLUMN multidimensional_poverty_headcount_ratio;
ALTER TABLE country DROP COLUMN population_density;
ALTER TABLE country DROP COLUMN poverty_gap;
ALTER TABLE country DROP COLUMN poverty_headcount_ratio_215;
ALTER TABLE country DROP COLUMN poverty_headcount_ratio_365;






# creating healthcare spending table 
DROP TABLE IF EXISTS healthcare_spending;
CREATE TABLE healthcare_spending (
	id integer not null,
    country_name VARCHAR(225) NOT NULL,
    country_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL,
    ari_treatment DECIMAL(5, 2),
    births_attended DECIMAL(5, 2),
    community_health_workers DECIMAL(5, 2),
    current_health_expenditure_gdp DECIMAL(5, 2),
    health_expenditure_per_capita DECIMAL(20, 2),
    gov_health_expenditure DECIMAL(5, 2),
    private_health_expenditure DECIMAL(5, 2),
    external_health_expenditure DECIMAL(5, 2),
    hospital_beds_per_thousand DECIMAL(5, 2),
    immunization_dpt DECIMAL(5, 2),
    out_of_pocket_expenditure DECIMAL(5, 2),
    poverty_line_215 DECIMAL(5, 2),
    poverty_line_365 DECIMAL(5, 2),
    high_out_of_pocket_spending DECIMAL(5, 2),
    women_informed_decisions DECIMAL(5, 2),
    PRIMARY KEY (id)
);

# Loading data into the healthcare spending table
LOAD DATA INFILE '/tmp/healthcare_spending.csv'
INTO TABLE healthcare_spending
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id,country_name, country_code, region, year, @ari_treatment, @births_attended, @community_health_workers, @current_health_expenditure_gdp, @health_expenditure_per_capita, @gov_health_expenditure, @private_health_expenditure, @external_health_expenditure, @hospital_beds_per_thousand, @immunization_dpt, @out_of_pocket_expenditure, @poverty_line_215, @poverty_line_365, @high_out_of_pocket_spending, @women_informed_decisions)
SET
    ari_treatment = NULLIF(@ari_treatment, ''),
    births_attended = NULLIF(@births_attended, ''),
    community_health_workers = NULLIF(@community_health_workers, ''),
    current_health_expenditure_gdp = NULLIF(@current_health_expenditure_gdp, ''),
    health_expenditure_per_capita = NULLIF(@health_expenditure_per_capita, ''),
    gov_health_expenditure = NULLIF(@gov_health_expenditure, ''),
    private_health_expenditure = NULLIF(@private_health_expenditure, ''),
    external_health_expenditure = NULLIF(@external_health_expenditure, ''),
    hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand, ''),
    immunization_dpt = NULLIF(@immunization_dpt, ''),
    out_of_pocket_expenditure = NULLIF(@out_of_pocket_expenditure, ''),
    poverty_line_215 = NULLIF(@poverty_line_215, ''),
    poverty_line_365 = NULLIF(@poverty_line_365, ''),
    high_out_of_pocket_spending = NULLIF(@high_out_of_pocket_spending, ''),
    women_informed_decisions = NULLIF(@women_informed_decisions, '');

select * from healthcare_spending;

#dropping unused metrics to simplify tables 
ALTER TABLE healthcare_spending DROP COLUMN ari_treatment;
ALTER TABLE healthcare_spending DROP COLUMN births_attended;
ALTER TABLE healthcare_spending DROP COLUMN community_health_workers;
ALTER TABLE healthcare_spending DROP COLUMN hospital_beds_per_thousand;
ALTER TABLE healthcare_spending DROP COLUMN immunization_dpt;
ALTER TABLE healthcare_spending DROP COLUMN poverty_line_215;
ALTER TABLE healthcare_spending DROP COLUMN poverty_line_365;
ALTER TABLE healthcare_spending DROP COLUMN women_informed_decisions;
ALTER TABLE healthcare_spending DROP COLUMN high_out_of_pocket_spending;


#creating health outcomes table 
DROP TABLE IF EXISTS healthcare_outcomes;
CREATE TABLE healthcare_outcomes (
    id INTEGER NOT NULL,
    country_name VARCHAR(225) NOT NULL,
    country_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL,
    access_to_electricity DECIMAL(5, 2),
    births_attended DECIMAL(5, 2),
    communicable_disease_deaths DECIMAL(5, 2),
    hiv_incidence DECIMAL(5, 2),
    life_expectancy_female DECIMAL(5, 2),
    life_expectancy_male DECIMAL(5, 2),
    life_expectancy_total DECIMAL(5, 2),
    maternal_death_risk DECIMAL(5, 2),
    low_birthweight_babies DECIMAL(5, 2),
    maternal_mortality_ratio DECIMAL(10, 2),
    mortality_rate_unsafe_conditions DECIMAL(10, 2),
    infant_mortality_rate DECIMAL(10, 2),
    under_5_mortality_rate DECIMAL(10, 2),
    basic_sanitation_services DECIMAL(5, 2),
    safely_managed_sanitation_services DECIMAL(5, 2),
    hiv_prevalence DECIMAL(5, 2),
    food_insecurity_moderate DECIMAL(5, 2),
    food_insecurity_severe DECIMAL(5, 2),
	primary key (id)
);

# Loading data into the healthcare outcomes table
LOAD DATA INFILE '/tmp/healthcare_outcomes.csv'
INTO TABLE healthcare_outcomes
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id,country_name, country_code, region, year, @access_to_electricity, @births_attended, @communicable_disease_deaths, @hiv_incidence, @life_expectancy_female, @life_expectancy_male, @life_expectancy_total, @maternal_death_risk, @low_birthweight_babies, @maternal_mortality_ratio, @mortality_rate_unsafe_conditions, @infant_mortality_rate, @under_5_mortality_rate, @basic_sanitation_services, @safely_managed_sanitation_services, @hiv_prevalence, @food_insecurity_moderate, @food_insecurity_severe)
SET
    access_to_electricity = NULLIF(@access_to_electricity, ''),
    births_attended = NULLIF(@births_attended, ''),
    communicable_disease_deaths = NULLIF(@communicable_disease_deaths, ''),
	hiv_incidence = NULLIF(@hiv_incidence, ''),
    life_expectancy_female = NULLIF(@life_expectancy_female, ''),
    life_expectancy_male = NULLIF(@life_expectancy_male, ''),
    life_expectancy_total = NULLIF(@life_expectancy_total, ''),
    maternal_death_risk = NULLIF(@maternal_death_risk, ''),
    low_birthweight_babies = NULLIF(@low_birthweight_babies, ''),
    maternal_mortality_ratio = NULLIF(@maternal_mortality_ratio, ''),
    mortality_rate_unsafe_conditions = NULLIF(@mortality_rate_unsafe_conditions, ''),
    infant_mortality_rate = NULLIF(@infant_mortality_rate, ''),
    under_5_mortality_rate = NULLIF(@under_5_mortality_rate, ''),
    basic_sanitation_services = NULLIF(@basic_sanitation_services, ''),
    safely_managed_sanitation_services = NULLIF(@safely_managed_sanitation_services, ''),
    hiv_prevalence = NULLIF(@hiv_prevalence, ''),
    food_insecurity_moderate = NULLIF(@food_insecurity_moderate, ''),
    food_insecurity_severe = NULLIF(@food_insecurity_severe, '');
    
select * from healthcare_outcomes;

#dropping unused metrics to simplify tables 

ALTER TABLE healthcare_outcomes DROP COLUMN access_to_electricity;
ALTER TABLE healthcare_outcomes DROP COLUMN births_attended;
ALTER TABLE healthcare_outcomes DROP COLUMN communicable_disease_deaths;
ALTER TABLE healthcare_outcomes DROP COLUMN hiv_incidence;
ALTER TABLE healthcare_outcomes DROP COLUMN low_birthweight_babies;
ALTER TABLE healthcare_outcomes DROP COLUMN food_insecurity_moderate;
ALTER TABLE healthcare_outcomes DROP COLUMN food_insecurity_severe;
ALTER TABLE healthcare_outcomes DROP COLUMN basic_sanitation_services;
ALTER TABLE healthcare_outcomes DROP COLUMN safely_managed_sanitation_services;
ALTER TABLE healthcare_outcomes DROP COLUMN hiv_prevalence;




################################################################## 
#creating a store procedure to merge all data into one table, so creating datamarts/views will be easier, 
#and also to insure that the datamarts/views's data is up to date 

# to process the sql request and avoid this error (Error Code: 2013. Lost connection to MySQL server during query):
-- Increase the wait timeout to 8 hours (28800 seconds)
SET SESSION wait_timeout = 28800;
SET SESSION interactive_timeout = 28800;
-- Increase network read/write timeout to handle large queries
SET SESSION net_read_timeout = 600;
SET SESSION net_write_timeout = 600;

#creating the database table:
DROP PROCEDURE IF EXISTS CreateHealthcareDatabase;

DELIMITER //

CREATE PROCEDURE CreateHealthcareDatabase()
BEGIN
    DROP TABLE IF EXISTS HealthcareDatabase;
    CREATE TABLE HealthcareDatabase AS
    SELECT 
        c.id, 
        c.country_name, 
        c.region,
        c.year, 
        
        -- GDP and Population Data from Country Table
        c.gdp_current_usd,
        c.gdp_growth_annual_percent, 
        c.gdp_per_capita_current_usd, 
        c.gdp_per_capita_growth_annual_percent, 
        c.population_growth_annual_percent,
        c.population_total,

        -- Healthcare spending and outcomes
        hs.current_health_expenditure_gdp, 
        hs.health_expenditure_per_capita, 
        hs.gov_health_expenditure,
        hs.private_health_expenditure,
        hs.external_health_expenditure,
        hs.out_of_pocket_expenditure,
	
        ho.life_expectancy_female,
        ho.life_expectancy_male,
		ho.life_expectancy_total,
        ho.maternal_death_risk,
        ho.maternal_mortality_ratio,
        ho.mortality_rate_unsafe_conditions, 
        ho.infant_mortality_rate,
        ho.under_5_mortality_rate,

        -- Moving average for government health spending (removes yearly fluctuations)
        AVG(hs.gov_health_expenditure) OVER (PARTITION BY c.country_name ORDER BY c.year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
        AS gov_health_spending_moving_avg,

        -- Categorization for different health expenditures
        NTILE(5) OVER (ORDER BY hs.gov_health_expenditure) AS gov_expenditure_category,
        NTILE(5) OVER (ORDER BY hs.private_health_expenditure) AS private_expenditure_category,
        NTILE(5) OVER (ORDER BY hs.external_health_expenditure) AS external_expenditure_category,
        NTILE(5) OVER (ORDER BY hs.out_of_pocket_expenditure) AS oop_expenditure_category,

        -- Normalizing health expenditure values
        (hs.gov_health_expenditure - MIN(hs.gov_health_expenditure) OVER ()) / 
        (MAX(hs.gov_health_expenditure) OVER () - MIN(hs.gov_health_expenditure) OVER ()) AS normalized_gov_expenditure,

        (hs.private_health_expenditure - MIN(hs.private_health_expenditure) OVER ()) / 
        (MAX(hs.private_health_expenditure) OVER () - MIN(hs.private_health_expenditure) OVER ()) AS normalized_private_expenditure,

        (hs.external_health_expenditure - MIN(hs.external_health_expenditure) OVER ()) / 
        (MAX(hs.external_health_expenditure) OVER () - MIN(hs.external_health_expenditure) OVER ()) AS normalized_external_expenditure,

        (hs.out_of_pocket_expenditure - MIN(hs.out_of_pocket_expenditure) OVER ()) / 
        (MAX(hs.out_of_pocket_expenditure) OVER () - MIN(hs.out_of_pocket_expenditure) OVER ()) AS normalized_oop_expenditure,

        -- Custom Life Expectancy Categories
        CASE 
            WHEN ho.life_expectancy_total < 50 THEN 'Very Low'
            WHEN ho.life_expectancy_total >= 50 AND ho.life_expectancy_total < 60 THEN 'Low'
            WHEN ho.life_expectancy_total >= 60 AND ho.life_expectancy_total < 70 THEN 'Medium'
            WHEN ho.life_expectancy_total >= 70 AND ho.life_expectancy_total < 72 THEN 'Global Average'
            WHEN ho.life_expectancy_total >= 72 THEN 'Above Global Average'
        END AS life_expectancy_category,

        -- Year-over-year percentage change calculations for mortality metrics
        LAG(ho.under_5_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year) AS prev_under_5_mortality_rate,
        ((ho.under_5_mortality_rate - LAG(ho.under_5_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year)) / 
        LAG(ho.under_5_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year)) * 100 AS under_5_mortality_rate_change_percent,

        LAG(ho.maternal_mortality_ratio) OVER (PARTITION BY c.country_name ORDER BY c.year) AS prev_maternal_mortality_ratio,
        ((ho.maternal_mortality_ratio - LAG(ho.maternal_mortality_ratio) OVER (PARTITION BY c.country_name ORDER BY c.year)) / 
        LAG(ho.maternal_mortality_ratio) OVER (PARTITION BY c.country_name ORDER BY c.year)) * 100 AS maternal_mortality_ratio_change_percent,

        LAG(ho.infant_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year) AS prev_infant_mortality_rate,
        ((ho.infant_mortality_rate - LAG(ho.infant_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year)) / 
        LAG(ho.infant_mortality_rate) OVER (PARTITION BY c.country_name ORDER BY c.year)) * 100 AS infant_mortality_rate_change_percent,

        -- Gender Life Expectancy Gap
        (ho.life_expectancy_female - ho.life_expectancy_male) AS gender_life_expectancy_gap,

        -- Female-to-Male Life Expectancy Ratio
        (ho.life_expectancy_female / ho.life_expectancy_male) AS female_to_male_life_expectancy_ratio

    FROM 
        country AS c
    left JOIN 
        healthcare_spending AS hs ON c.country_code = hs.country_code AND c.year = hs.year
    left JOIN 
        healthcare_outcomes AS ho ON c.country_code = ho.country_code AND c.year = ho.year
    ORDER BY 
        c.id;
END //

DELIMITER ;

CALL CreateHealthcareDatabase();

select * from HealthcareDatabase;







SHOW VARIABLES LIKE "event_scheduler";
SET GLOBAL event_scheduler = ON;
SHOW GRANTS FOR CURRENT_USER;
SELECT * FROM information_schema.EVENTS WHERE EVENT_NAME = 'UpdateHealthcareDatabaseEvent';

########################################################################################
#creating messages table to be notified when new rows are added to the table
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each message
    message_column VARCHAR(255) NOT NULL -- Column to store the message content
);

################################################################################################
#creating a shedule 

drop event UpdateHealthcareDatabaseEvent;

DELIMITER $$

CREATE EVENT UpdateHealthcareDatabaseEvent
ON SCHEDULE EVERY 5 second
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Log the event execution into the messages table
    #INSERT INTO messages SELECT CONCAT('Event triggered at: ', NOW());
     INSERT INTO messages (message_column) 
    VALUES (CONCAT('Healthcare database update triggered at: ', NOW()));

    -- Call the procedure to update the HealthcareDatabase
    CALL CreateHealthcareDatabase();

END$$

DELIMITER ;

################################################################################################  
#testing the schdule 
select * from country; 
describe country; 
#creating new entry 
DELETE FROM country WHERE id = 01010101;
insert into country VALUES (01010101, 'Ghadena_town', 'GHA', 'Vienna', 2003, NULL, NULL, NULL, NULL, NULL, NULL);

#checking if heathcaredatabse is updated
select * from messages; 
SELECT * FROM HealthcareDatabase ORDER BY id;





#######################################################################################
#creating datamarts/views 

#regional datamarts

DROP VIEW IF EXISTS SubSaharan_AfricaRegion;
CREATE VIEW `SubSaharan_AfricaRegion` AS
SELECT * FROM HealthcareDatabase WHERE HealthcareDatabase.Region = 'Sub-Saharan Africa';
select * from subsaharan_africaregion;

DROP VIEW IF EXISTS South_AsiaRegion;
CREATE VIEW `South_AsiaRegion` AS
SELECT * FROM HealthcareDatabase WHERE HealthcareDatabase.Region = 'South Asia';
select * from south_asiaregion;

#yearly datamarts 
DROP VIEW IF EXISTS YR2022;
CREATE VIEW `YR2022` AS
SELECT * FROM HealthcareDatabase WHERE HealthcareDatabase.Year = 2022;
select * from YR2022;


#analytical datamarts 
# creating a data mart to analyse the following: 
	#Is there a difference among the types of healthcare expenditure (government, private, external, out-of-pocket) 
    #on the health outcomes (life expectancy, mortality rates, and preventable deaths)? 
		#We can run a regression analysis to determine whether certain expenditure types are more effective than others. 

drop view if exists Diff_health_expenditure; 
create view Diff_health_expenditure as 
	select 
	id, country_name, region, year, current_health_expenditure_gdp, health_expenditure_per_capita, 
	gov_health_expenditure, private_health_expenditure, external_health_expenditure, out_of_pocket_expenditure, 
	gov_expenditure_category, private_expenditure_category, external_expenditure_category, oop_expenditure_category 

	life_expectancy_female, life_expectancy_male, life_expectancy_total, life_expectancy_category,
	maternal_death_risk, maternal_mortality_ratio, mortality_rate_unsafe_conditions, infant_mortality_rate, under_5_mortality_rate
	from HealthcareDatabase; 
    
select * from Diff_health_expenditure;



##################################################################################################################################################
#extra: creating regional aggregations: 
#Are there region specific trends? Are the LICs in Asia worse or better than the LICs in sub saharan africa in terms of health outcomes? 
	#We can create aggreaget the data for each region and compare the statistical results on a regional scale.

drop procedure if exists RegionalHealthComparison;

DELIMITER //

CREATE PROCEDURE RegionalHealthComparison()
	BEGIN
	drop table if exists RegionalHealthComparison;
    create table RegionalHealthComparison as
	with regional_aggregates as (
		select 
            c.region,
            c.year, 
			 -- Average health outcomes for the region
			AVG(ho.life_expectancy_total) AS avg_life_expectancy,
			AVG(ho.infant_mortality_rate) AS avg_infant_mortality_rate,
			AVG(ho.maternal_mortality_ratio) AS avg_maternal_mortality_ratio,
			
			-- Average healthcare expenditure
			AVG(hs.gov_health_expenditure) AS avg_gov_health_expenditure,
			AVG(hs.private_health_expenditure) AS avg_private_health_expenditure,
			AVG(hs.health_expenditure_per_capita) AS avg_health_expenditure_per_capita
		from 
			country c 
		JOIN 
			healthcare_spending hs ON c.country_code = hs.country_code AND c.year = hs.year
		JOIN 
			healthcare_outcomes ho ON c.country_code = ho.country_code AND c.year = ho.year
		WHERE 
			c.region in (select distinct region from country)
		GROUP BY 
			c.region, c.year
)

	select 
        region, 
        year, 
        -- Aggregated health outcomes
		avg_life_expectancy,
		avg_infant_mortality_rate,
		avg_maternal_mortality_ratio,
    
    -- Aggregated healthcare spending
		avg_gov_health_expenditure,
		avg_private_health_expenditure,
		avg_health_expenditure_per_capita
    
	FROM 
		regional_aggregates

     order by region, year; 

end//

DELIMITER ;

call RegionalHealthComparison();
select * from RegionalHealthComparison; 



    
        
    









