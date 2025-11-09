CREATE OR REFRESH LIVE TABLE lakehouse.bronze.products
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT
  _airbyte_data:ProductID::int AS ProductID,
  _airbyte_data:ProductName::string AS ProductName,
  _airbyte_data:Category::string AS Category,
  _airbyte_data:UnitPrice::decimal(10,2) AS UnitPrice,
  _airbyte_data:Weight::decimal(10,2) AS Weight,
  _airbyte_data:CreatedAt::timestamp AS CreatedAt,
  current_timestamp() AS ingestion_ts_utc
FROM lakehouse.airbyte_internal.default_raw__stream_products