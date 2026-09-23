-- Name: Uche Ogbodo
-- DBMS HW#2

-- Created database cofeeshop
create database coffeeshop;
use coffeeshop;

-- -- Table 1: Baristas
-- baristaID is the Primary Key

create table baristas (
	baristaID int primary key,
	name varchar(100),
	experience_level varchar(100)
);

-- Table 2: Shops
-- shopID is the primary key

create table shops (
	shopID int primary key,
	name varchar(100),
    city varchar(100)
);

-- Table 3: Pastries
-- pastryID is the primary key
create table pastries (
	pastryID int primary key,
    name varchar(100),
    category varchar(100),
    price decimal(5,2)
);

-- Table 4: Employs
-- Composite Primary keys: (baristaID, shopID)
-- Foreign keys: 
-- baristaID references baristas(baristaID)
-- shopID references shops(shopID)

create table employs (
	baristaID int,
    shopID int,
    primary key(baristaID,shopID),
    foreign key(baristaID)
		references baristas(baristaID),
	foreign key(shopID)
		references shops(shopID)
);

-- Table 5: Offers
-- Composite Primary Keys: (shopID, pastryID)
-- Foreign Keys: 
-- shopID references shops(shopID)
-- pastryID references pastries(pastryID)

create table offers (
	shopID int,
	pastryID int,
    date_added date,
    primary key(shopID, pastryID),
    foreign key(shopID)
		references shops(shopsID),
	foreign key(pastryID)
		references pastries(pastryID)

);

-- Part 2: Writing Queries

-- #1 Find the Average of Pastries for Each Category
select category, avg(price) as AvgPrice
from pastries
group by category;

 -- #2 Find the total number of baristas at each experience level from baristas table
 select experience_level, count(*) as Frequency
 from baristas
 group by experience_level;
 
 -- #3 Count the total number of shops located in each city from the shops table
 select city, count(*) as Total
 from shops
 group by city;
 
 -- #4 Find the maximum price among pastries for each category from the pastries tab;e
 select category, max(price) as highest_price
 from pastries
 group by category;
 
 -- #5 Count how many pastries have been added by each shop using shopID column from the offers table
 select shopID, count(*) as frequency
 from offers
 group by shopID;
 
 -- #6 Find the name, category, and price of any pastry whose price matches the maximum price within its category
select name, category, price
from pastries
where (category, price) IN (
    select category, max(price)
    from pastries
    group by category
);
 
 -- #7 Find the unique shop IDs from the offers table that have offered at least one pastry whose price is strictly greater than the overall average price of all pastries.
 select distinct shopID
 from offers
 join pastries on offers.pastryID = pastries.pastryID
 where price > (
 select avg(price) from pastries );
 
 #8 Find the shop ID and pastry ID for the records in the offers table that have the earliest date_added (minimum date).
select shopID, pastryID
from offers
order by date_added asc
limit 1;
 
 -- #9 Find the shop ID(s) that offer the highest number of pastries, utilizing a subquery to evaluate the maximum count per shop.
 select shopID
 from offers
 group by shopID
 order by count(*) desc
 limit 1;
 
 -- #10 Find the names of baristas who work at shops located in 'Seattle' using nested subqueries.
 select baristas.name
 from baristas
 join employs on baristas.baristaID = employs.baristaID
 join shops on employs.shopID = shops.shopID
 where city = 'Seattle';