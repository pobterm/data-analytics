-- Items table
CREATE TABLE Items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    price DECIMAL(10, 2),
    invoice_id INT,
    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id)
);

INSERT INTO Items (item_id, item_name, price, invoice_id)
VALUES
    (1, 'Coffee', 3.50, 1),
    (2, 'Tea', 2.50, 1),
    (3, 'Croissant', 2.00, 2),
    (4, 'Sandwich', 5.50, 2),
    (5, 'Cake', 4.00, 3),
    (6, 'Salad', 6.50, 3),
    (7, 'Smoothie', 4.50, 4),
    (8, 'Muffin', 2.50, 4),
    (9, 'Bagel', 3.00, 5),
    (10, 'Soup', 4.50, 5);

-- Invoices table
CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY,
    order_date DATETIME,
    customer_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

INSERT INTO Invoices (invoice_id, order_date, customer_id, item_id, quantity)
VALUES
    (1, '2023-01-01 08:30:00', 1, 1, 2),
    (2, '2023-01-02 12:45:00', 2, 3, 1),
    (3, '2023-01-03 10:15:00', 3, 5, 3),
    (4, '2023-01-04 09:00:00', 4, 2, 1),
    (5, '2023-01-05 11:30:00', 5, 4, 2),
    (6, '2023-01-06 14:00:00', 1, 6, 1),
    (7, '2023-01-07 16:45:00', 2, 8, 3),
    (8, '2023-01-08 13:20:00', 3, 10, 2),
    (9, '2023-01-09 18:00:00', 4, 7, 1),
    (10, '2023-01-10 20:30:00', 5, 9, 2),
    (11, '2023-01-11 11:15:00', 6, 5, 1),
    (12, '2023-01-12 15:00:00', 7, 4, 3),
    (13, '2023-01-13 17:45:00', 8, 3, 2),
    (14, '2023-01-14 14:30:00', 9, 1, 1),
    (15, '2023-01-15 10:00:00', 10, 2, 2),
    (16, '2023-01-16 12:45:00', 1, 8, 1),
    (17, '2023-01-17 09:30:00', 2, 6, 3),
    (18, '2023-01-18 14:15:00', 3, 9, 2),
    (19, '2023-01-19 16:00:00', 4, 7, 1),
    (20, '2023-01-20 11:45:00', 5, 10, 2);

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(255),
    birthdate DATE,
    member_date DATE
);

INSERT INTO Customers (customer_id, email, birthdate, member_date)
VALUES
    (1, 'customer1@example.com', '1990-01-15', '2022-01-01'),
    (2, 'customer2@example.com', '1985-05-20', '2022-02-05'),
    (3, 'customer3@example.com', '1988-08-10', '2022-03-10'),
    (4, 'customer4@example.com', '1995-03-25', '2022-04-15'),
    (5, 'customer5@example.com', '1980-12-05', '2022-05-20'),
    (6, 'customer6@example.com', '1993-09-18', '2022-06-25'),
    (7, 'customer7@example.com', '1987-06-30', '2022-07-30'),
    (8, 'customer8@example.com', '1994-02-14', '2022-08-05'),
    (9, 'customer9@example.com', '1982-04-22', '2022-09-10'),
    (10, 'customer10@example.com', '1998-07-08', '2022-10-15');

-- RUN PREVIEW
.print #######################
.print #### SQL Challenge ####
.print #######################

.print \n Items table
.mode box
select * from Items limit 5;

.print \n Invoices table
.mode box
select * from Invoices limit 5;

.print \n Customers table
.mode box
select * from Customers limit 5;

-- หายอดขายรวมของแต่ละสินค้าแต่ละรายการ เรียงตามลำดับไอดีของสินค้า
select i1.item_id, i1.item_name, sum(i2.quantity*i1.price) as sales 
from items i1
join invoices i2
on i1.item_id = i2.item_id
group by i1.item_id
order by i1.item_id ;

-- หายอดขายสะสมของลูกค้าแต่ละคน เรียงลำดับจากยอดขายสะสมมากไปน้อย
select c.customer_id, sum(i2.price*i1.quantity) as sales
from customers c
join invoices i1 on c.customer_id = i1.customer_id
join items i2 on i1.item_id = i2.item_id
group by c.customer_id
order by sales desc;

-- ให้จำแนกรายการสินค้า Dairy Products (3,4,5,8,9) หรือ Non-Dairy Products
select item_id, item_name,
  case 
  when item_id in (3,4,5,8,9) then 'Dairy Products'
  else 'Non-Dairy Products'
  end as product_category
from items;

-- คำนวณยอดขายสินค้าประเภท Dairy Products และ Non-Dairy Products พร้อมทั้งหาสัดส่วนยอดขายของสินค้าทั้งสอง
select
  case
  when items.item_id in (3,4,5,8,9) then 'Dairy Products'
  else 'Non-Dairy Products'
  end as product_category,
  sum(invoices.quantity) as quan_sold,
  sum(invoices.quantity)*100/(select sum(quantity) from invoices) as percent
from items 
join invoices on items.item_id = invoices.item_id
group by product_category;

-- คำนวณยอดขายรวมของแต่ละวันในสัปดาห์ (Sunday to Saturday)
select strftime('%w', i1.order_date) as day_of_week, sum(i1.quantity*i2.price) as sales
from invoices i1
join items i2 on i1.item_id = i2.item_id
group by day_of_week;

--  คำนวณยอดขายรวมแต่ละวันในสัปดาห์จำแนกตามสินค้าประเภท Dairy และ Non-Dairy
select strftime('%w', i1.order_date) as day_of_week, 
  case
  when i2.item_id in (3,4,5,8,9) then 'Dairy Products'
  else 'Non-Dairy Products'
  end as product_category,
  sum(i1.quantity*i2.price) as sales
from invoices i1
join items i2 on i1.item_id = i2.item_id
group by product_category, day_of_week;


