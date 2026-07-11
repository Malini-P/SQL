create database IF NOT exists sales_management;

use sales_management;

create table Offices(
officeCode varchar(15) primary key,
city varchar(100),
phone varchar(20),
addressLine1 varchar(200),
addressLine2 varchar(200),
state varchar(100),
country varchar(100),
postalCode varchar(10),
territory varchar(30));

create table Employees(
employeeNumber int primary key,
lastName varchar(50),
firstName varchar(50),
extension varchar(50),
email varchar(100),
officeCode varchar(10),
reportsTo int,
jobTitle varchar(200),
foreign key (officeCode) references Offices(officeCode),
foreign key (reportsTo) references Employees(employeeNumber));

create table ProductLines(
productLine varchar(50) primary key,
textDescription varchar(4000) default null,
htmlDescription mediumtext default null,
image blob default null);

create table Products(
productCode varchar(15)  primary key,
productName varchar(70) not null,
productLine varchar(50),
productScale varchar(70),
productVendor varchar(70),
productDescription text,
quantityInStock int,
buyPrice decimal(10,2),
MSRP decimal(10,2),
foreign key (productLine) references ProductLines(productLine));

create table Customers(
customerNumber int primary key,
customerName varchar(100),
contactLastName varchar(50),
contactFirstName varchar(50),
phone varchar(20),
addressLine1 varchar(1000),
addressLine2 varchar(1000),
city varchar(100),
state varchar(100),
postalcode int,
country varchar(100),
salesRepEmployeeNumber int,
creditLimit decimal(10,2),
foreign key (salesRepEmployeeNumber) references Employees(employeeNumber));

create table Orders(
orderNumber int primary key,
orderDate date,
requiredDate date,
shippedDate date,
status varchar(50),
comments text,
customerNumber int,
foreign key (customerNumber) references Customers(customerNumber));

create table orderDetails(
orderNumber int,
productCode varchar(15),
quantityOrdered int,
priceEach decimal(10,2),
orderLineNumber smallint,
foreign key (orderNumber) references Orders(orderNumber),
foreign key (productCode) references Products(productCode));

create table Payments(
customerNumber int,
checkNumber varchar(50) primary key,
paymentDate date,
amount decimal(10,2),
foreign key (customerNumber) references Customers(customerNumber));

insert into Offices(officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory)
values
('1','Chennai', '+91-44-12345678', 'T Nagar' , NULL, 'Tamil Nadu','India','600017','APAC'),
('2','Banglore','+91-80-87654321', 'Koramangala', NULL, 'Karnataka', 'India', '560001', 'APAC');

insert into Employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
values
(1002, 'Jerin','Yujin', 'x101', 'yujinjery1@gmail.com', '1', NULL , 'Sales Manager'),
(1056, 'Raina','Suresh','x102','sureshraina2@gmail.com','1',1002, 'Sales rep'),
(1076, 'Sharma','Neha', 'x103','nehasharma3@gmail.com','2',1002, 'Sales rep');

insert into ProductLines(productLine,textDescription,htmlDescription,image)
values
('Classic Cars', 'Vintage and classic model cars', NULL, NULL),
('Motorcycles', 'Racing and sports bikes' , NULL , NULL);

insert into Products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP)
values
('S10_1678', '1969 Harley Davidson' , 'Motorcycles','1:10','Min Lin Diecast', 'Classic Harley Davidson bike model', 100,4800.00,6500.00),
('S12_1099','1968 Ford Mustang','Classic Cars', '1:12', 'Autoart Studio', 'Classic Ford Mustang model', 50, 9500.00, 12000.00);

insert into Customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalcode,country,salesRepEmployeeNumber,
creditLimit) values
(2001,'ABC Traders','Rao','Vikram','+91-9876543210','Anna Nagar', NULL, 'Chennai', 'Tamil Nadu','600040','India',1056,150000.00),
(2002, 'XYZ Electronics','Patel','Amit','+91-9123467890','Indiranagar',NULL ,'Bangalore','Karnataka','560038','India',1076,200000.00);

insert into Orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber)
values
(30001,'2026-01-10','2026-01-15','2026-01-13', 'Shipped','Delivered on time', 2001),
(30002,'2026-01-12','2026-01-18',NULL, 'In Process', NULL, 2002);

insert into orderDetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
values
(30001,'S10_1678',2,6500.00,1),
(30002,'S12_1099',1,12000.00,1);

insert into Payments(customerNumber,checkNumber,paymentDate,amount)
values
(2001,'CHK1001','2026-01-16',13000.00),
(2002,'CHK1002','2016-01-17',12000.00);

select * from Offices;
select * from Employees;
select * from ProductLines;
select * from Products;
select * from Customers;
select * from Orders;
select * from orderDetails;
select * from Payments;