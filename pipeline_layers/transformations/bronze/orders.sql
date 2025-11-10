CREATE OR REFRESH LIVE TABLE lakehouse.bronze.orders
TBLPROPERTIES ("quality" = "bronze")
COMMENT "Dados brutos de pedidos extraídos do Airbyte (MySQL → Databricks)"
AS
SELECT
    _airbyte_data:OrderID AS OrderID,
    _airbyte_data:CustomerID AS CustomerID,
    _airbyte_data:OrderDate AS OrderDate,
    _airbyte_data:Total AS Total,
    _airbyte_extracted_at AS ExtractedAt
FROM lakehouse.airbyte_internal.default_raw__stream_orders;
