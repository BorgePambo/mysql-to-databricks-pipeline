CREATE OR REFRESH LIVE TABLE lakehouse.silver.fact_orders(
    CONSTRAINT orderid_not_null EXPECT (OrderID IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT customerid_not_null EXPECT (CustomerID IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT total_positive EXPECT (Total >= 0) ON VIOLATION DROP ROW

)AS
SELECT
    CAST(OrderID AS INT) OrderID,
    CustomerID,
    CAST(OrderDate AS DATE) AS OrderDate,
    CAST(Total AS DOUBLE) AS Total,
    ExtractedAt
FROM lakehouse.bronze.orders;

--Here is the error message:
