CREATE OR REFRESH LIVE TABLE lakehouse.bronze.customers
TBLPROPERTIES ("quality" = "bronze")
COMMENT "Dados brutos extraídos do Airbyte (MySQL → Databricks)"
AS
SELECT
    _airbyte_data:CustomerID AS CustomerID,
    _airbyte_data:FirstName AS FirstName,
    _airbyte_data:LastName AS LastName,
    _airbyte_data:Email AS Email,
    _airbyte_data:Ocuppation AS Occupation,
    _airbyte_data:City AS City,
    _airbyte_data:Country AS Country,
    _airbyte_data:CreatedAt AS CreatedAt,
    _airbyte_extracted_at AS ExtractedAt
FROM lakehouse.airbyte_internal.default_raw__stream_customers;
