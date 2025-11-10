CREATE OR REFRESH LIVE TABLE lakehouse.bronze.orderdetails
TBLPROPERTIES ("quality" = "bronze")
COMMENT "Tabela bronze de detalhes de pedidos do Airbyte"
AS
SELECT
    _airbyte_data:OrderID AS OrderID,
    _airbyte_data:Quantity AS Quantity,
    _airbyte_data:ProductID AS ProductID,
    _airbyte_data:UnitPrice AS UnitPrice,
    _airbyte_data:OrderDetailID AS OrderDetailID,
    _airbyte_extracted_at AS extracted_at
FROM lakehouse.airbyte_internal.default_raw__stream_orderdetails;
