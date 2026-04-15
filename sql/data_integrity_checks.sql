/* PROJECT: CodeX Marketing Analytics - India
    PURPOSE: Data Integrity & Quality Checks
    AUTHOR: [Sarowar Ahmed @sarowarahmed]
*/

-- 1. Check for Orphaned Records (Referential Integrity)
-- Ensures every respondent in the fact table exists in the dimension table.
SELECT COUNT(*) AS Orphaned_Respondents
FROM fact_survey_responses f
LEFT JOIN dim_respondents r ON f.Respondent_ID = r.Respondent_ID
WHERE r.Respondent_ID IS NULL;

-- 2. Validate Age Group Categories
-- Ensures no "unknown" or typo-ridden age groups entered the survey data.
SELECT DISTINCT Age_Group 
FROM dim_respondents 
WHERE Age_Group NOT IN ('15-18', '19-30', '31-45', '46-65', '65+');

-- 3. Check for Duplicate Survey Entries
-- A respondent should ideally only have one entry in the fact table.
SELECT Respondent_ID, COUNT(*) 
FROM fact_survey_responses
GROUP BY Respondent_ID
HAVING COUNT(*) > 1;

-- 4. Verify City Coverage
-- Ensures all 10 target Indian cities are present in the dataset.
SELECT COUNT(DISTINCT City_Name) AS Total_Cities 
FROM dim_cities;
