CREATE OR REFRESH LIVE TABLE lakehouse.silver.fact_orderdetails(
    CONSTRAINT orderid_not_null EXPECT (OrderID IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT productid_not_null EXPECT (ProductID IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT quantity_positive EXPECT (Quantity >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT unitprice_positive EXPECT (UnitPrice >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT total_positive EXPECT (Quantity * UnitPrice >= 0) ON VIOLATION DROP ROW
)
AS
SELECT
    CAST(OrderDetailID AS INT) AS OrderDetailID,
    CAST(OrderID AS INT) AS OrderID,
    CAST(ProductID AS INT) AS ProductID,
    CAST(Quantity AS DOUBLE) AS Quantity,
    CAST(UnitPrice AS DOUBLE) AS UnitPrice,
    Quantity * UnitPrice AS Total
FROM lakehouse.bronze.orderdetails;
