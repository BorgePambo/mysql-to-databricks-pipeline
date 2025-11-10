CREATE OR REFRESH LIVE TABLE lakehouse.silver.dim_products (
    CONSTRAINT unitprice_positive EXPECT (UnitPrice >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT weight_positive EXPECT (Weight >= 0) ON VIOLATION DROP ROW
) AS
WITH cte_products AS (
    SELECT 
        ProductID,
        ProductName,
        Category,
        CAST(UnitPrice AS DOUBLE) AS UnitPrice,
        CAST(Weight AS DOUBLE) AS Weight,
        CAST(CreatedAt AS DATE) AS CreatedAt,
        ExtractedAt,
        ROW_NUMBER() OVER(PARTITION BY ProductID, ProductName ORDER BY ExtractedAt DESC) AS rn
    FROM lakehouse.bronze.products
)
SELECT 
    ProductID,
    ProductName,
    Category,
    UnitPrice,
    Weight,
    CreatedAt,
    ExtractedAt
FROM cte_products
WHERE rn = 1;
