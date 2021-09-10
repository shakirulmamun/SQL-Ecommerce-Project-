go
Use SmartShopBD
go
 --------------------------------INSERT---------------------------------------
Insert Into Customers
Values(1, 'shakirulmamun','shakirulmamun125@gmail.com','Dhaka','028973454'),
(2, 'rafsanjony','jony09@gmail.com','Dhaka','023473454'),
(3, 'Adom', 'adom@gmail.com','Rangpur', '01994340043')
go
Insert Into Category
Values(1, 'Mobile'),(2, 'Computer'),(3, 'Electronics Product')
go
Insert Into Product
Values(1, 'Nokia', '50,000'),(2, 'Dell', '60,000'),(3, 'HP', '15,500'),(4, 'iPhone 11', '48,000'),(5, 'Samsung', '23,000'),
(6, 'Sony', '35,000'),(7, 'SonyMobile', '17,000'),(8,'Apple','100,000'),(9, 'Toshiba', '54,000'),(10,'Pendrive','7,00'),
(11,'Charger','1,000'),(12,'earphone','1,100'),(13,'Bettery','1,070')
go
Insert Into Orders
Values(1,'M107','01-01-2021'),(2,'C1010','02-01-2021'),(3,'C1000','03-01-2021'),
(4,'M104','04-01-2021'),(5,'M103','01-01-2021'),(6,'C0105','05-01-2021'),
(7,'M106','07-01-2021'),(8,'Apple','02-01-2021')
go
Insert Into Relation
Values(1,1,1,1),(1,1,4,3),(1,1,5,1),(1,1,7,1),
(2,2,2,2),(2,2,3,3),(2,2,8,7),(2,2,9,3),
(3,3,10,7),(3,3,11,4),(3,3,12,2),(3,3,6,1)
go

--select * from Customers
--select * from Category
--select * from Product
--select * from Orders
--select * from Relation


------------Join---------------

Select Customers.CustomerID, CustomerName, Category.CategoryName, Product.ProductName,
Orders.OrderNumber
From Relation Join Customers on
Relation.CustomerID = Customers.CustomerID Join Category on
Relation.CategoryID = Category.CategoryID Join Product on
Relation.ProductID = Product.ProductID Join Orders on
Relation.OrderID = Orders.OrderID
Where Customers.CustomerName = 'shakirulmamun';

------------Jonining Table With Having---------------
Select Count(ProductName) as [TotalName], Ca.CategoryName, Pr.ProductName
From Relation Re 
Join Customers Cu on Re.CustomerID = Cu.CustomerID 
Join Category ca on Re.CategoryID = Ca.CategoryID 
Join Product pr on Re.ProductID = Pr.ProductID
Group by Ca.CategoryName, Pr.ProductName
Having Ca.CategoryName = 'Mobile';

-----------------------------------------Sub Query---------------------------------------------

Select Category.CategoryID,Category.CategoryName, ProductName
From Category JOIN Relation
On Category.CategoryID = Relation.CategoryID JOIN Product
on Product.ProductID = Relation.ProductID
Where CategoryName IN (Select CategoryName from Category
Where Category.CategoryName = 'Mobile')
go

----------------searched case function-----------------------
Select CASE
    WHEN CategoryID = 1 THEN 'Excelent'
    WHEN CategoryID = 2 THEN 'Good'
    WHEN CategoryID = 3 THEN ' Not Bad'
    ELSE 'Not Found'
END AS [Column]
from Category
GROUP BY CategoryID;


----------------Insert Merge Value-----------------------
Insert into Categorymerge
values (1, 'Mobile'),(2, 'Computer'),(3, 'Electronics Product')
GO
----------------Update Merge Value-----------------------
MERGE INTO dbo.Category as c
USING dbo.Categorymerge as Cate
        ON c.CategoryID = Cate.CategoryID
WHEN MATCHED THEN
    UPDATE SET
      c.CategoryName = Cate.CategoryName
      WHEN NOT MATCHED THEN 
      INSERT (CategoryID, CategoryName)
      VALUES (Cate.CategoryID, Cate.CategoryName);
go

--select * from Categorymerge

------------------CTE--------------------------------------

With CategoryTotal (CategoryID, CategoryName)
as

(Select Category.CategoryID, Count (CategoryName) As TotalNumber
From Category JOIN Relation
On Category.CategoryID = Relation.CategoryID
Where CategoryName IN (Select CategoryName from Category)
Group by Category.CategoryID)

 --select * from CategoryTotal

 
----------------Update Query-----------------------
Update Customers set CustomerName = 'Kamal' where CustomerID = 2;

----------------Delete Query-----------------------
delete Category  where CategoryID = 2;

----------------Cast-----------------------
select cast('01-Jan-2021' AS date)

----------------Convert-----------------------
SELECT Datetime = CONVERT(datetime,'01-Jan-2021 10:00:10.00')

------------------Thanks--------------------------------------