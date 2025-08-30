-- Creating the Database
CREATE DATABASE ChurnDB
GO
USE ChurnDB
GO
select *
from CustomerChurn

-- Checking if all the entries are loaded
select count(*) as numberofentries from CustomerChurn 

-- Count of distinct entries in Churn
select Churn, count(*) as cnt 
from CustomerChurn
group by Churn 

-- Checking duplicates
select customerID, count(*) as c
from CustomerChurn
group by customerID 
having count(*)>1
-- customerID has 0 duplicate entries

-- Check for nulls/blanks in TotalCharges
select sum(case when TotalCharges is null then 1 else 0 end) as null_totalcharges
from CustomerChurn
-- 11 null entries in TotalCharges

/*DATA CLEANING */

-- 1) trim spaces in all the text fieds (trmming all the leading/trailing spaces)
update CustomerChurn
SET  customerID       = LTRIM(RTRIM(customerID)),
     gender           = LTRIM(RTRIM(gender)),
     Partner          = LTRIM(RTRIM(Partner)),
     Dependents       = LTRIM(RTRIM(Dependents)),
     PhoneService     = LTRIM(RTRIM(PhoneService)),
     MultipleLines    = LTRIM(RTRIM(MultipleLines)),
     InternetService  = LTRIM(RTRIM(InternetService)),
     OnlineSecurity   = LTRIM(RTRIM(OnlineSecurity)),
     OnlineBackup     = LTRIM(RTRIM(OnlineBackup)),
     DeviceProtection = LTRIM(RTRIM(DeviceProtection)),
     TechSupport      = LTRIM(RTRIM(TechSupport)),
     StreamingTV      = LTRIM(RTRIM(StreamingTV)),
     StreamingMovies  = LTRIM(RTRIM(StreamingMovies)),
     Contract         = LTRIM(RTRIM(Contract)),
     PaperlessBilling = LTRIM(RTRIM(PaperlessBilling)),
     PaymentMethod    = LTRIM(RTRIM(PaymentMethod)),
     Churn            = LTRIM(RTRIM(Churn));

-- There are 11 null entries in TotalCharges
ALTER TABLE CustomerChurn ALTER COLUMN TotalCharges FLOAT;

-- 2) Few entries in MultipleLines has (No phone service) instead of (No)
update CustomerChurn
set MultipleLines='No'
where MultipleLines='No phone service'

-- 3) Replace (No internet service) values with No

UPDATE CustomerChurn
SET OnlineSecurity   = 'No'
WHERE OnlineSecurity = 'No internet service';

UPDATE CustomerChurn
SET OnlineBackup   = 'No'
WHERE OnlineBackup = 'No internet service';

UPDATE CustomerChurn
SET DeviceProtection   = 'No'
WHERE DeviceProtection = 'No internet service';

UPDATE CustomerChurn
SET TechSupport   = 'No'
WHERE TechSupport = 'No internet service';

UPDATE CustomerChurn
SET StreamingTV   = 'No'
WHERE StreamingTV = 'No internet service';

UPDATE CustomerChurn
SET StreamingMovies   = 'No'
WHERE StreamingMovies = 'No internet service';

-- Checking the table after cleaning
select *
from CustomerChurn

-- Create a cleaned view

CREATE OR ALTER VIEW vw_CustomerChurn_Clean AS
SELECT
  customerID,
  gender,
  SeniorCitizen,
  Partner,
  Dependents,
  tenure,
  CASE
    WHEN tenure < 12 THEN '0-12'
    WHEN tenure BETWEEN 12 AND 24 THEN '12-24'
    WHEN tenure BETWEEN 25 AND 48 THEN '25-48'
    WHEN tenure BETWEEN 49 AND 60 THEN '49-60'
    ELSE '60+'
  END AS TenureBucket,
  PhoneService,
  MultipleLines,
  InternetService,
  OnlineSecurity,
  OnlineBackup,
  DeviceProtection,
  TechSupport,
  StreamingTV,
  StreamingMovies,
  Contract,
  PaperlessBilling,
  PaymentMethod,
  MonthlyCharges,
  TotalCharges,
  Churn,
  CASE WHEN Churn='Yes' THEN 1 ELSE 0 END AS ChurnFlag
FROM CustomerChurn;

-- Total rows in vw_customerchurn clean
SELECT COUNT(*) AS total_rows FROM vw_CustomerChurn_Clean;


-- QA check

-- Total Rows
select count(*) as total_rows from vw_CustomerChurn_Clean

-- Churn distribution

select Churn, count(*) as cnt
from vw_CustomerChurn_Clean
group by Churn

-- Tenure buckets
SELECT TenureBucket, COUNT(*) AS cnt FROM vw_CustomerChurn_Clean GROUP BY TenureBucket ORDER BY 1;

-- Exporting the cleaned data from SQL
select * from vw_CustomerChurn_Clean

-- Checking Null entries in Total charges
SELECT customerID, TotalCharges, tenure
FROM CustomerChurn
WHERE TotalCharges IS NULL;
-- these have tenure 0 so they are new customers who didn't get billed yet





