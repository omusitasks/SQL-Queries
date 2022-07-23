
-- PART II

-- QUestion 1

SELECT CONCAT(CONCAT(srp.SalesRepFName, ' '), srp.SalesRepLName) AS "SalesRep Name" ,
srp.SalesRepID As "Sales Rep ID", c.CommClass As "Commission Class", c.CommRate As "Commission Rate" 
FROM SALESREP srp
INNER JOIN COMMISSION c ON srp.CommClass = c.CommClass
ORDER BY srp.SalesRepLName ASC;


-- QUestion 2

SELECT OrderID AS "Order ID", ProdID AS "Product ID", ProdQty AS "Qty", ProdPrice, 
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price"
FROM ORDERDETAIL 
ORDER BY OrderID ASC, ProdID ASC;

-- QUestion 3


SELECT c.CustID, c.CustFName AS "CustFirstName", c.CustLName As "CustLastName", 
srp.SalesRepID, srp.SalesRepFName As SalesRepFirstName, srp.SalesRepLName As SalesRepLastName,
c.CustPhone, 
substr(c.CustPhone,1,3)||'-'||substr(c.CustPhone,4,3)||'-'||substr(c.CustPhone,7,4) as "Phone"
FROM CUSTOMER c
INNER JOIN SALESREP srp ON c.SalesRepID = srp.SalesRepID
ORDER BY c.CustID ASC;

-- QUestion 4

SELECT d.DeptID AS "Dept_ID", d.DeptName AS "Dept_Name",
 srp.SalesRepID As "Sales_Rep_ID",srp.SalesRepFName AS "First_Name", srp.SalesRepLName AS "Last_Name", 
 c.CommClass As "Commission_Class", MAX(c.CommRate) As "Commission_Rate" 
FROM SALESREP srp
INNER JOIN COMMISSION c ON srp.CommClass = c.CommClass
INNER JOIN DEPARTMENT d ON  srp.DeptID = d.DeptID;

-- QUestion 5

SELECT p.ProID AS "Product_ID", p.ProdName AS "Product_Name", pc.ProdCatName AS "Category", MAX(od.ProdPrice), 
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price"
FROM PRODUCT p
INNER JOIN PRODCAT pc ON p.ProCatID = pc.ProCatID
INNER JOIN ORDERDETAIL od  ON p.ProdID = od.ProdID
WHERE od.OrderID = 100;

-- QUestion 6

SELECT d.DeptName AS "Dept_Name", COUNT(srp.SalesRepID) AS "Sales_Rep_Count"
FROM SALESREP srp
INNER JOIN DEPARTMENT d ON srp.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY COUNT(srp.SalesRepID) ASC;

-- QUestion 7

SELECT SalesRepID As "Sales_Rep_ID",srp.SalesRepFName AS "First_Name", srp.SalesRepLName AS "Last_Name", 
CommRate As "Commission_Rate",FORMAT(CommRate, '#,##0.0%')
FROM SALESREP
WHERE CommRate <= 5 AND NOT CommRate = 0
ORDER BY CommRate DESC;

-- QUestion 8

SELECT o.OrderID, o.OrderDate, to_char(to_date( o.OrderDate,'MM/DD/YYYY'), 'MM/DD/YYYY'),
o.CustID, c.CustFName, c.CustLName, 
srp.SalesRepID ,srp.SalesRepFName, srp.SalesRepLName 
FROM ORDERS o
INNER JOIN CUSTOMER c ON o.CustID = c.CustID
INNER JOIN SALESREP srp ON c.SalesRepID = srp.SalesRepID
ORDER BY o.OrderID ASC;

-- QUestion 9

SELECT od.OrderID, p.ProID , p.ProdName, pc.ProdCatID AS "CatID", od.ProdPrice,
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price",
od.ProdQty AS "Qty",
(od.ProdPrice*od.ProdQty) AS ExtPrice
FROM ORDERDETAIL od
INNER JOIN PRODUCT p ON od.ProdID = p.ProdID
INNER JOIN PRODCAT pc ON p.ProCatID = pc.ProCatID
WHERE COUNT(od.OrderID) = 104
ORDER BY ExtPrice ASC;


-- QUestion 10

SELECT d.DeptID, d.DeptName, COUNT(srp.SalesRepID) As "SalesRepCount",
AVG(CommRate) As "AvgCommRate",FORMAT(CommRate, '#,##0.0%')
FROM SALESREP
GROUP BY d.DeptID
ORDER BY AVG(CommRate) ASC;

-- QUestion 11

SELECT srp.SalesRepID, srp.SalesRepFName , srp.SalesRepLName, d.DeptName, 
 c.CommClass, c.CommRate 
FROM SALESREP srp
INNER JOIN COMMISSION c ON srp.CommClass = c.CommClass
INNER JOIN DEPARTMENT d ON  srp.DeptID = d.DeptID
WHERE c.CommRate > 0
ORDER BY srp.SalesRepID ASC;

-- QUestion 12

SELECT srp.SalesRepID, 
CONCAT(CONCAT(srp.SalesRepFName, ' '), srp.SalesRepLName) AS "SalesRep_Name" ,
d.DeptID, d.DeptName
FROM SALESREP srp
INNER JOIN DEPARTMENT d ON  srp.DeptID = d.DeptID
WHERE srp.CommClass = "A"
ORDER BY d.DeptID ASC , srp.SalesRepID ASC;

-- QUestion 13

SELECT OrderID AS Order_ID, SUM(ProdQty) AS "Order_Total"
FROM ORDERDETAIL 
WHERE OrderID = 104;

-- QUestion 14

SELECT AVG(ProdPrice),
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Avg_Price"
FROM ORDERDETAIL;

-- QUestion 15

SELECT od.ProdID AS "ProductID", p.ProdName AS "Name",od.ProdPrice,
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price"
FROM ORDERDETAIL od
INNER JOIN PRODUCT p ON  od.ProdID = p.ProdID
WHERE MAX(COUNT(p.ProdID));

-- QUestion 16

SELECT COUNT(pc.ProdCatID) AS "Cat_ID", p.ProdID AS "Prod_ID", p.ProdName AS "Product_Name",MIN(p.ProdPrice),
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price"
FROM PRODUCT p
INNER JOIN PRODCAT pc ON  p.ProdCatID = pc.ProdCatID;

-- QUestion 17

SELECT pc.ProdCatName, p.ProdID , p.ProdName ,MIN(p.ProdPrice),
TO_CHAR(10000,'L99G999D99MI',
           'NLS_NUMERIC_CHARACTERS = ''.''''''
           NLS_CURRENCY = ''$'' ') AS "Price"
FROM PRODUCT p
INNER JOIN PRODCAT pc ON  p.ProdCatID = pc.ProdCatID
WHERE p.ProdPrice > AVG(p.ProdPrice);

-- QUestion 18

SELECT o.OrderID AS "Order ID", 
o.OrderDate AS "Order Date",to_char(to_date( o.OrderDate,'MM/DD/YYYY'), 'MM/DD/YYYY'), 
c.CustID AS "Cust ID", 
CONCAT(CONCAT(CustFName, ' '), CustLName) AS "Name" ,
c.CustPhone,
substr(c.CustPhone,1,3)||'-'||substr(c.CustPhone,4,3)||'-'||substr(c.CustPhone,7,4) as "Phone"
FROM ORDERs o
INNER JOIN CUSTOMER c ON  p.CustID = c.CustID
WHERE o.OrderDate <= "1/26/22"
ORDER BY o.OrderDate ASC, c.CustID ASC;

-- QUestion 19

SELECT CustID, CustFName AS "FirstName", CustLName As "LastName"
FROM CUSTOMER 
WHERE CustFName LIKE 'A%'
ORDER BY CustLName ASC;

-- QUestion 20

SELECT CustID AS "Customer ID", 
CONCAT(CONCAT(CustFName, ' '), CustLName) AS "Name" ,
CustPhone,
substr(CustPhone,1,3)||'-'||substr(CustPhone,4,3)||'-'||substr(CustPhone,7,4) as "Phone"
FROM CUSTOMER 
WHERE SalesRepID = 12;