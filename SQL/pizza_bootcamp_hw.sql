create table customers (
  customerid int,
  name text,
  gender text,
  age int,
  address text);

insert into customers
values (1, "Mew","Female",35,"Bangna"), 
  (2, "Mao","Male",40,"Bangchak"), 
  (3, "Mai","Female",30,"Silom"), 
  (4, "Olivia","Female",25,"Sathorn"),
  (5,"Charlie","Male",19,"Bangna"), 
  (6,"Prasong","Male",50,"Bangchak");


create table orders (
  orderid int,
  name text,
  orderdate date,
  ordermenu text);

insert into orders
values (1,"Mew",'2024-01-22', "Hawaiian"),
  (2,"Mew",'2024-01-22',"Salmon"),
  (3,"Mew",'2024-01-22',"Salad"),
  (4,"Mao",'2024-01-25',"Pasta"),
  (5,"Mao",'2024-01-25',"Hawaiian"),
  (6,"Prasong",'2024-02-02',"Wine"),
  (7,"Prasong",'2024-02-02',"Salmon"),
  (8,"Mai",'2024-02-05',"Chicken_wing"),
  (9,"Olivia",'2024-02-03',"Salmon"),
  (10,"Charlie",'2024-01-15',"Salmon"),
  (11,"Charlie",'2024-01-20',"Burger");


create table menus (
  menid int,
  menu text,
  price int,
  cal int);

insert into menus
values (1,"Pasta",350,300), 
  (2,"Salmon",550,250), 
  (3,"Hawaiian",450,600), 
  (4,"Salad",280,150), 
  (5,"Burger",320,550),
  (6,"Chicken_wing",290,400),
  (7,"Steak",550,400),
  (8,"Wine",890,350);

.mode box
Select * from customers;
select * from orders;
select * from menus;

-- หาลูกค้าที่ซื้อเยอะที่สุด 
Select name, 
  sum(price) as total_spending,
  sum(cal) as total_cal,
  count(name) as num_order,
  round(avg(price),0) as avg_billvalue
  from orders o
  join menus m 
  on o.ordermenu = m.menu
  group by name
  order by total_spending desc;


  -- อยากรู้ว่า มีจำนวนออร์เดอร์ในแต่ละเดือนกี่ครั้ง ยอดขายรวมเท่าไหร่ 
select 
   strftime("%Y-%m",orderdate) as mthorder,
   count(orderid) as numberorder,
   Sum(price) as revenue
from orders 
join menus 
on orders.ordermenu = menus.menu
group by mthorder;

-- หาลูกค้าที่เป็นผู้หญิง อายุมากกว่า 25 ดูว่าอยู่ที่ไหน สั่งอะไรบ้าง 
   -- basic query
select o.name, gender, age, address, ordermenu
  from customers c
  join orders o
  on o.name = c.name

  where gender = 'Female' and age > 25
  order by age;

  
   -- WITH
with female_customer as (
  select * from customers
  where lower(gender) = 'female' and age > 25
)

select f.name, gender, age, address, ordermenu from orders o
join female_customer f
on f.name = o.name
order by age;

-- พื้นที่ไหน มียอดขายเยอะที่สุด 2 อันดับแรก
select address, 
  sum(price) as area_rev
from customers c
join orders o
on c.name = o.name
join menus m
on o.ordermenu = m.menu
  
group by address
order by area_rev desc
limit 2;

-- มีออร์เดอร์จากลูกค้าผู้หญิงกี่คน ผู้ชายกี่คน
select gender, count(o.name) as gendercount
from orders o
join customers c
on o.name = c.name
group by gender;

select * from customers
where name like 'M%';

select * from customers
where name like '_a_';

select * from customers
where not address = 'Bangna';


select * from orders
where orderdate between '2024-01-01' and '2024-01-31';


