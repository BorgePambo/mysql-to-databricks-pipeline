CREATE OR REFRESH LIVE TABLE lakehouse.bronze.orderdetails
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT
  _airbyte_data:OrderDetailID::int AS OrderDetailID,
  _airbyte_data:OrderID::int AS OrderID,
  _airbyte_data:ProductID::int AS ProductID,
  _airbyte_data:Quantity::int AS Quantity,
  _airbyte_data:UnitPrice::decimal(10,2) AS UnitPrice,
  current_timestamp() AS ingestion_ts_utc
FROM lakehouse.airbyte_internal.default_raw__stream_orderdetails;