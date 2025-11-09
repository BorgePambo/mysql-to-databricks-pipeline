CREATE OR REFRESH LIVE TABLE lakehouse.bronze.orders
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT
  _airbyte_data:OrderID::string AS OrderID,
  _airbyte_data:CustomerID::string AS CustomerID,
  _airbyte_data:OrderDate::timestamp AS OrderDate,
  _airbyte_data:Total::decimal(10,2) AS Total,
  current_timestamp() AS ingestion_ts
FROM lakehouse.airbyte_internal.default_raw__stream_orders;