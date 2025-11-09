-- Customers Bronze
CREATE OR REFRESH LIVE TABLE lakehouse.bronze.customers
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT
  _airbyte_data:CustomerID::string AS CustomerID,
  _airbyte_data:FirstName::string AS FirstName,
  _airbyte_data:LastName::string AS LastName,
  _airbyte_data:Email::string AS Email,
  _airbyte_data:Ocuppation::string AS Occupation,
  _airbyte_data:City::string AS City,
  _airbyte_data:Country::string AS Country,
  _airbyte_data:CreatedAt::timestamp AS CreatedAt,
  current_timestamp() AS ingestion_ts
FROM lakehouse.airbyte_internal.default_raw__stream_customers;