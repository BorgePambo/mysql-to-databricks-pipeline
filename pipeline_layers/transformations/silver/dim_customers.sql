CREATE OR REFRESH LIVE TABLE lakehouse.silver.dim_customers (
    CONSTRAINT customerid_not_null EXPECT (CustomerID IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT email_valid EXPECT (Email LIKE '%@%') ON VIOLATION DROP ROW
) AS
WITH cte_customers AS (
    SELECT
        CustomerID,
        CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS FullName,
        LOWER(Email) AS Email,
        TRIM(Occupation) AS Occupation,
        City,
        Country,
        CAST(CreatedAt AS TIMESTAMP) AS CreatedAt,
        CAST(ExtractedAt AS TIMESTAMP) AS ExtractedAt,
        ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY ExtractedAt DESC) AS rn
    FROM lakehouse.bronze.customers
)
SELECT
    CustomerID,
    FullName,
    Email,
    Occupation,
    City,
    Country,
    CreatedAt,
    ExtractedAt
FROM cte_customers
WHERE rn = 1;
