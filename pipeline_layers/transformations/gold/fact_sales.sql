CREATE OR REFRESH LIVE TABLE lakehouse.gold.fact_sales
AS
SELECT
    UUID() AS SurrogateKey,
    p.ProductName,
    p.Category AS ProductCategory,
    d.UnitPrice,
    d.Quantity,
    d.Total,
    o.OrderDate,
    c.FullName AS CustomerName,
    c.Country,
    c.City
FROM lakehouse.silver.fact_orderdetails AS d
INNER JOIN lakehouse.silver.dim_products AS p
    ON d.ProductID = p.ProductID
INNER JOIN lakehouse.silver.fact_orders AS o
    ON d.OrderID = o.OrderID
INNER JOIN lakehouse.silver.dim_customers AS c
    ON o.CustomerID = c.CustomerID;
