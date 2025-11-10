CREATE OR REFRESH LIVE TABLE lakehouse.bronze.products
TBLPROPERTIES ("quality" = "bronze")
COMMENT "Produtos brutos importados do Airbyte"
AS
SELECT
    _airbyte_data:ProductID AS ProductID,
    _airbyte_data:ProductName AS ProductName,
    _airbyte_data:Category AS Category,
    _airbyte_data:UnitPrice AS UnitPrice,
    _airbyte_data:Weight AS Weight,
    _airbyte_data:CreatedAt AS CreatedAt,
    _airbyte_extracted_at AS ExtractedAt
FROM lakehouse.airbyte_internal.default_raw__stream_products;
