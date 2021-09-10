
Create Database SmartShopBD
on
(Name='SmartShopBD_Data_1',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL13.SA\MSSQL\DATA\SmartShopBD_Data_1.mdf',
Size=25mb,
Maxsize=100mb,
FileGrowth=5%
)
Log on
(Name='SmartShopBD_Log_1',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL13.SA\MSSQL\DATA\SmartShopBD_Log_1.ldf',
Size=5mb,
Maxsize=50mb,
FileGrowth=1%
)
GO
Create Table Customers
(
CustomerID int Primary key Not Null,
CustomerName varchar(50) null,
CustomerEmail varchar(50) null,
[Address] varchar(100) null,
Telephone varchar(50) null
)
go

Create Table Category
(
CategoryID int Primary Key Not Null,
CategoryName varchar(50) Null,
)
go
Create Table Product
(
ProductID int Primary Key Not Null,
ProductName varchar(50) Null,
Price varchar(50) Null,
)
go
Create Table Orders
(
OrderID int Primary Key Not Null,
OrderNumber varchar(50) Null,
OrderDate datetime Null
)
go
Create Table Relation
(
CustomerID int References Customers(CustomerID),
CategoryID int References Category(CategoryID),
ProductID int References Product(ProductID),
OrderID int References Orders(OrderID),
Primary key (CustomerID, CategoryID, ProductID, OrderID)
)
go

----------------Create Merge-----------------------
create table Categorymerge
(
CategoryID int primary key not null, 
CategoryName varchar (50)
)
go

------------ Index ---------------

Create NonClustered Index ix_Pro_ID
on Product(ProductID)
go

----------------------------- Trigger---------------------------

create table backTblProduct
(ProductID int primary key,
ProductName varchar(50));

------------------Insert Trigger Value-------------------------
insert into Product(ProductID,ProductName)
values(20,'HP')

--------------Update Triggers----------------
Create Trigger tr_Product_insert
On Product
After Insert, Update
As
Insert Into backTblProduct
(ProductID,ProductName)
Select 
i.ProductID,i.ProductName From inserted i;
Go

--select * from Product
--select * from backTblProduct



--drop table Product1
--drop table backTblProduct1
--drop trigger tr_Product_insert;

-------------------------------------------------Create a store procedure -------------------------------------
 Create Proc SpProduct
 @ProductID Int,
 @ProductName Varchar(20)

As
 Insert into Product(ProductID,ProductName)
 values (@ProductID,@ProductName)
Go
Exec SpProduct 17,Car
Go
Create Proc SpProductUpdate
@ProductID INT,
@ProductName Varchar(50)
AS
 Update Product SET ProductName=@ProductName
 WHERE ProductID=@ProductID
Go
EXEC SpProductUpdate 2,'Computer'
Go
Create Proc SpProductDelete
@ProductID INT
AS
DELETE FROM Product WHERE ProductID=@ProductID
Go
EXEC SpProductDelete 17

Go

-------------- - Scalar value function  ------------
Create Function fn_Scalarvalue()
RETURNS int
AS 
BEGIN
	declare @CategoryID int;
	set @CategoryID = (select count(re.CategoryID) AS NoOfCategory
	from Relation re join Category ce on re.CategoryID = ce.CategoryID
	where ce.CategoryName = 'Mobile' group by re.CategoryID)
    RETURN @CategoryID;
END;

--------view function-----
--select dbo.fn_Scalarvalue()

--------drop function-----
--drop function fn_Scalarvalue

-------------- - Table value function  ------------
Create Function fn_tableValue
()
Returns Table
Return
(
Select Count(ProductName) as [TotalName], Ca.CategoryName, Pr.ProductName
From Relation Re 
Join Customers Cu on Re.CustomerID = Cu.CustomerID 
Join Category ca on Re.CategoryID = Ca.CategoryID 
Join Product pr on Re.ProductID = Pr.ProductID
Group by Ca.CategoryName, Pr.ProductName
Having Ca.CategoryName = 'Computer'
);

--------view function-----
--Select * From dbo.fn_tableValue();

--------drop function-----
--drop function dbo.fn_tableValue

------------ View ---------------
Create View vw_Relation
as
Select Category.CategoryID, Count (CategoryName) As TotalNumber
From Category JOIN Relation
On Category.CategoryID = Relation.CategoryID
Where CategoryName IN (Select CategoryName from Category)
Group by Category.CategoryID
go

--select * from vw_Relation
--drop view vw_Relation


---------------Thanks--------------------