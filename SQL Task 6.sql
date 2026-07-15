create database if not exists dog_db;

use dog_db;

create table dog_data(
dog_id int primary key,
dog_breed varchar(50),
rate decimal(10,2));

create table buyer_data(
buyer_id int primary key,
buyer_name varchar(50),
city varchar(50));

create table sales(
sale_id int primary key,
dog_id int,
buyer_id int,
buying_month varchar(20),
quantity int,
rate decimal(10,2),
foreign key (dog_id) references dog_data(dog_id),
foreign key (buyer_id) references buyer_data(buyer_id));

insert into dog_data values
(1, 'Labrador', 25000.00),
(2, 'Golden Retriever', 30000.00),
(3, 'German Shepherd', 35000.00),
(4, 'Pomeranian', 15000.00),
(5, 'Beagle', 20000.00);

insert into buyer_data values
(101, 'Malini', 'Trichy'),
(102, 'Yujin', 'TVMalai'),
(103, 'Kattapa', 'Salem'),
(104, 'Sivagami', 'Sivakasi'),
(105, 'Bahubali', 'Banglore');

insert into sales values
(1, 1, 101, 'Jan 2026', 2, 25000.00),
(2, 2, 102, 'Jan 2026', 1, 30000.00),
(3, 3, 103, 'Feb 2026', 3, 35000.00),
(4, 4, 104, 'Feb 2026', 2, 15000.00),
(5, 5, 105, 'Mar 2026', 1, 20000.00),
(6, 1, 102, 'Mar 2026', 2, 25000.00),
(7, 2, 103, 'Apr 2026', 1, 30000.00),
(8, 3, 104, 'Apr 2026', 2, 35000.00),
(9, 4, 101, 'May 2026', 3, 15000.00),
(10, 5, 105, 'May 2026', 2, 20000.00);


select * from dog_data;

select * from buyer_data;

select * from sales;

# Window Functions #

-- 1. RANK() - Rank dogs by rate

select *,
rank() over(order by rate desc) as rk
from dog_data;


-- 2. DENSE RANK() - Rank dogs by rate

select *,
rank() over(order by rate desc) as rk
from sales;

select *,
dense_rank() over(order by rate desc) as rk
from sales;


-- 3. sum() over() - Running total revenue per dogID

select *,
sum(quantity * rate) over(partition by dog_id order by buying_month) as partition_by_dogID
from sales;


-- 4. avg() over() - Avg sale amount per dog breed

select *,
avg(quantity * rate) over(partition by dog_id order by buyer_id) as avg_sales
from sales;


-- 5. COUNT() - Count total sales per dog breed

select sale_id, dog_id, buyer_id, buying_month,
count(sale_id) over(partition by dog_id) as totalSalesPerBreed
from sales;


-- 6.LAG() & LEAD() - Compare quantity with prev & next sale

select *,
lag(quantity) over(partition by dog_id order by sale_id) as avg_sales
from sales;

select *,
lead(quantity) over(partition by dog_id order by sale_id) as avg_sales
from sales;


# Stored Procedures#

-- 1. Without Parameters - Get all dog values

delimiter $$
create procedure get_dog_values()
begin
   select * from dog_data;
end $$
delimiter ;
call get_dog_values;


-- 2. With input parameter - Get values by Dogbreed

delimiter $$
create procedure get_dogBreed(in dogBreed varchar(50))
begin
   select * from dog_data as Breed
   where dog_breed = dogBreed;
end $$
delimiter ;
call get_dogBreed('Pomeranian');
call get_dogBreed('Labrador');


-- 3. With input parameter - Get values by sale_id

delimiter $$
create procedure get_sales_values(in saleID int)
begin
   select * from sales as sales
   where sale_id = saleID;
end $$
delimiter ;
call get_sales_values(2);
call get_sales_values(8);

