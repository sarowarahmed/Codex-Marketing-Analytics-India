/* PROJECT: CodeX Marketing Analytics - India
    PURPOSE: Database Performance Optimization (Indexing)
    AUTHOR: [Sarowar Ahmed @sarowarahmed]
*/

-- 1. Create Index for Respondent Joins
-- This speeds up queries filtering by age, gender, or individual respondents.
CREATE NONCLUSTERED INDEX IX_FactSurvey_RespondentID 
ON fact_survey_responses (Respondent_ID);

-- 2. Create Index for City Joins
-- Crucial for performance when generating reports based on City Tiers or Names.
CREATE NONCLUSTERED INDEX IX_FactSurvey_CityID 
ON fact_survey_responses (City_ID);

-- 3. Create Index for Brand/Consumption Joins
-- Helpful if specific brand perception analysis is done frequently.
-- (Assuming 'Current_Brand' is a frequent filter column in your fact table)
CREATE NONCLUSTERED INDEX IX_FactSurvey_CurrentBrand 
ON fact_survey_responses (Current_Brand);

-- 4. Verify Index Creation
SELECT 
    t.name AS Table_Name, 
    i.name AS Index_Name, 
    i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name = 'fact_survey_responses';
