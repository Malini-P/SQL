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
('2','Banglore','+91-80-87654321', 'Koramangala', NULL, 'Karnataka', 'India', '560001', 'APAC'),
('3','Trichy','+91-8949385697','Navalpattu',NULL,'Tamil Nadu','India','631105','APAC'),
('4','Madurai','+91-2345768901','Othakadai',NULL,'Tamil Nadu','India','631106','APAC'),
('5','Tenkasi','+91-2349023456','Senkottai',NULL, 'Tamil Nadu','India','621102','APAC'),
('6','Karur','+91-2901393020','Paramathi',NULL,'Tamil Nadu','India','621115','APAC');

insert into Employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
values
(1001, 'Jerin',    'Yujin',     'x101', 'yujinjery1@gmail.com',    '1',     NULL , 'Sales Manager'),
(1002, 'Raina',    'Suresh',    'x102', 'sureshraina2@gmail.com',  '2',     1001 ,  'Sales rep'),
(1003, 'Sharma',   'Neha',      'x103', 'nehasharma3@gmail.com',   '3',      1001,  'Sales rep'),
(1004, 'Pradeepa', 'Anu',       'x104', 'anupradeepa4@gmail.com',  '4',      1001,  'Sales rep'),
(1005, 'Bharathi', 'Kannan',    'x105', 'kannanbharathi5@gmail.com','5',     1001,  'Sales rep'),
(1006, 'Kanna',    'Rajesh',    'x106', 'rajeshkanna6@gmail.com',   '6',     1001,  'Sales rep'),
(1007, 'Saheel',   'Mohammed',  'x107', 'mohammedsaheel7@gmail.com','1',     1001,  'Sales rep'),
(1008, 'Ranganathan','Pradeep', 'x108', 'pradeepranganathan8@gmail.com','2', 1001,  'Sales rep');

insert into ProductLines(productLine,textDescription,htmlDescription,image)
values
('Classic Cars', 'Vintage and classic model cars', NULL, NULL),
('Motorcycles', 'Racing and sports bikes' , NULL , NULL),
('Trucks and Buses','Model trucks and buses', NULL,NULL),
('Vintage Cars','Pre-war vintage car models',NULL,NULL),
('Planes','Model aircrafts and jets',NULL,NULL),
('Ships', 'Model ships and submarines',NULL,NULL),
('Trains', 'Model trains and locomotives',NULL,NULL);

insert into Products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP)
values
('S10_1678', '1969 Harley Davidson' , 'Motorcycles','1:10','Min Lin Diecast', 'Classic Harley Davidson bike model', 100,4800.00,6500.00),
('S12_1099','1968 Ford Mustang','Classic Cars', '1:12', 'Autoart Studio', 'Classic Ford Mustang model', 50, 9500.00, 12000.00),
('S10_2001','1956 Chevy Truck','Trucks and Buses','1:10','Highway Diecast','Classic Chevy truck model', 80, 3200.00, 4500.00),
('S12_2002', '1932 Ford Model A','Vintage Cars','1:12','Vintage Works','Pre-war Ford classic model', 60, 7500.00,9800.00),
('S18_2003','Spitfire Plane','Planes','1:18','AeroModels Inc','WWII Spitfire aircraft model',40, 5500.00, 7200.00),
('S24_2004', 'Titanic Ship Model', 'Ships', '1:24', 'OceanCraft co', 'Classic Titanic ship replica', 30, 8900.00, 11500.00),
('S32_2005', 'Steam Locomotive 1920', 'Trains', '1:32', 'RailWorks Studio', 'Vintage steam engine model', 70, 4100.00, 5800.00);

insert into Customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalcode,country,salesRepEmployeeNumber,
creditLimit) values
(2001,'ABC Traders','Rao','Vikram','+91-9876543210','Anna Nagar', NULL, 'Chennai', 'Tamil Nadu','600040','India',1002,150000.00),
(2002, 'XYZ Electronics','Patel','Amit','+91-9123467890','Indiranagar',NULL ,'Bangalore','Karnataka','560038','India',1003,200000.00),
(2003, 'PQR Stores', 'Singh','Rajesh','+91-9988776655', 'MG Road', NULL,'Mumbai','Maharashtra','400001','India',1004, 180000.00),
(2004,'LMN Traders','Gupta','Sunita','+91-9786756453','CP Area',NULL,'Delhi','Delhi','110002','India',1005,220000.00),
(2005, 'DEF Enterprises', 'Nair','Anitha','+91-9756354758','Banjara Hills',NULL,'Hyderabad','Telangana','500034','India',1006,160000.00),
(2006, 'GHI Solutions', 'Kulkarni','Prasad','+91-2537465768','FC Road',NULL, 'Pune','Maharashtra','411004','India',1007,190000.00),
(2007, 'JKL Industries', 'Bose','Subhash','+91-2536475889','Salt Lake',NULL,'Kolkata','West Bengal', '700091','India',1008, 210000.00);

insert into Orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber)
values
(30001,'2026-01-10','2026-01-15','2026-01-13', 'Shipped','Delivered on time', 2001),
(30002,'2026-01-12','2026-01-18',NULL, 'In Process', NULL, 2002),
(30003, '2026-02-01','2026-02-07','2026-02-05','Shipped','Express delivery', 2003),
(30004, '2026-02-03', '2026-02-10', NULL, 'In Process', NULL, 2004),
(30005, '2026-02-05', '2026-02-12','2026-02-10', 'Shipped', 'On Time', 2005),
(30006, '2026-02-07', '2026-02-14', NULL, 'On Hold', 'Payment pending', 2006),
(30007, '2026-02-09','2026-02-16', NULL,'In Process', NULL , 2007);

insert into orderDetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
values
(30001,'S10_1678',2,6500.00,1),
(30002,'S12_1099',1,12000.00,1),
(30003, 'S10_2001',3,4500.00,1),
(30004,'S12_2002',2, 9800.00,1),
(30005,'S18_2003',1,7200.00,1),
(30006,'S24_2004',2, 11500.00,1),
(30007,'S32_2005',4,5800.00,1);

insert into Payments(customerNumber,checkNumber,paymentDate,amount)
values
(2001,'CHK1001','2026-01-16',13000.00),
(2002,'CHK1002','2016-01-17',12000.00),
(2003,'CHK1003','2026-02-06', 13500.00),
(2004, 'CHK1004','2026-02-11',19600.00),
(2005,'CHK1005','2026-02-11',7200.00),
(2006,'CHK1006','2026-02-15',23000.00),
(2007,'CHK1007','2026-02-17',23200.00);

select * from Offices;
select * from Employees;
select * from ProductLines;
select * from Products;
select * from Customers;
select * from Orders;
select * from orderDetails;
select * from Payments;

-- 1. checking how many offices are located in TN

select * from Offices where state='Tamil Nadu';

-- 2. check the products quantityInstock greater than 50 

select * from Products where quantityInStock > 50;

-- 3. check the products where buyPrice greater than 5000.00 and MSRP less than 15000.00

select * from Products where buyPrice > 5000.00 and MSRP < 15000.00;

-- 4. check the Customers where creditLimit less than 200000.00 from Maharashtra state

select * from Customers where creditLimit < 200000.00 and state = 'Maharashtra';

-- 5. Find all orders that are still 'In Process'

select orderNumber,orderDate,CustomerNumber from Orders  where status = 'In Process';

-- 6. Ordering the values in ascending by priceEach

select * from orderDetails order by priceEach;

-- 7. printing the payment details if amount is greater than 10k also in descending order

select customerNumber,paymentDate,amount from Payments where amount > 10000.00 order by amount desc;

-- 8. checking the customers details within limit 4

select customerNumber,contactFirstName,phone,addressLine1,city,creditLimit from Customers Limit 4;

-- 9. Delete a payment records

Delete from payments where checkNumber ='CHK1007';

-- 10. Update creditlimit for a customer

update Customers set creditLimit = 250000.00 where customerNumber=2001;
select customerNumber,creditLimit from Customers;