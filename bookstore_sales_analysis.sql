-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

-----------------------------------
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

---------------------------------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\SQL REVISION ALL LESSONS\Practice Files SQL Projects\Practice Files SQL Projects\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\SQL REVISION ALL LESSONS\Practice Files SQL Projects\Practice Files SQL Projects\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\SQL REVISION ALL LESSONS\Practice Files SQL Projects\Practice Files SQL Projects\Orders.csv' 
CSV HEADER; 


--Basic Queries

--1) Retrieve all books in the "Fiction" genre
SELECT TITLE,AUTHOR,GENRE
FROM BOOKS 
WHERE GENRE ='Fiction';

--2) Find books published after the year 1950
SELECT TITLE,AUTHOR,GENRE,published_year
FROM BOOKS
WHERE published_year>1950
ORDER BY published_year;

--3) List all customers from the Canada
SELECT CUSTOMER_ID,NAME,EMAIL,CITY,COUNTRY
FROM CUSTOMERS
WHERE COUNTRY='Canada'; 

--4) Show orders placed in November 2023
SELECT B.BOOK_ID,B.TITLE,O.ORDER_ID,O.BOOK_ID,O.ORDER_DATE,O.QUANTITY
FROM BOOKS AS B 
LEFT JOIN ORDERS AS O 
ON B.BOOK_ID = O.BOOK_ID 
WHERE O.ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30'
AND O.QUANTITY IS NOT NULL
ORDER BY O.ORDER_DATE; 

--5) Retrieve the total stock of books available
SELECT SUM(STOCK) AS TOTAL_STOCK
FROM BOOKS
SELECT * FROM Books;
--6) Find the details of the most expensive book
SELECT * FROM BOOKS 
ORDER BY PRICE DESC LIMIT 1; 

--7) Show all customers who ordered more than 1 quantity of a book
SELECT * FROM ORDERS
WHERE QUANTITY>1;

--8) Retrieve all orders where the total amount exceeds $100
SELECT * FROM ORDERS
WHERE TOTAL_AMOUNT>101
ORDER BY TOTAL_AMOUNT;

--9) List all genres available in the Books table
SELECT DISTINCT(GENRE)
FROM BOOKS;

--10) Find the book with the lowest stock
SELECT  *
FROM BOOKS
ORDER BY STOCK ASC LIMIT 1;

--11) Calculate the total revenue generated from all orders
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM ORDERS;

--Advance Queries

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



--1) Retrieve the total number of books sold for each genre
SELECT B.GENRE,SUM(O.QUANTITY) AS TOTAL_SOLD 
FROM ORDERS AS O
JOIN BOOKS AS B
ON B.BOOK_ID = O.BOOK_ID
GROUP BY B.GENRE 

--2) Find the average price of books in the "Fantasy" genre

SELECT AVG(PRICE)::NUMERIC(10,2) AS AVG_PRICE 
FROM BOOKS 
WHERE GENRE = 'Fantasy';

--3) List customers who have placed at least 2 orders
SELECT O.CUSTOMER_ID,C.NAME,COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM ORDERS O
JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY O.CUSTOMER_ID,C.NAME
HAVING COUNT(O.ORDER_ID)>=2;

--4) Find the most frequently ordered book
SELECT B.TITLE,O.BOOK_ID,COUNT(ORDER_ID) AS ORDERED_BOOK
FROM ORDERS AS O
JOIN BOOKS AS B
ON B.BOOK_ID = O.BOOK_ID 
GROUP BY O.BOOK_ID,B.TITLE
ORDER BY ORDERED_BOOK DESC
LIMIT 1;

--5) Show the top 3 most expensive books of 'Fantasy' Genre
SELECT book_id,title,genre,price
FROM BOOKS
WHERE GENRE = 'Fantasy'
order by price desc
limit 3

--6) Retrieve the total quantity of books sold by each author
select b.author,sum(o.quantity) as sold_by_each_author
from orders as o
join books as b
on o.book_id = b.book_id 
group by b.author
order by b.author;

--7) List the cities where customers who spent over $30 are located
select DISTINCT c.city,c.country,o.total_amount
from orders as o
join customers as c
on o.customer_id = c.customer_id
where o.total_amount>300
order by o.total_amount asc;

--8) Find the customer who spent the most on orders 
SELECT C.CUSTOMER_ID,C.NAME,SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
FROM ORDERS AS O
JOIN CUSTOMERS AS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID,C.NAME
ORDER BY TOTAL_SPENT DESC
LIMIT 1;

---9) Calculate the stock remaining after fulfilling all orders 
SELECT B.BOOK_ID,B.TITLE,B.STOCK, COALESCE(SUM(O.QUANTITY),0) FULLFILL_ORDERS, 
B.STOCK - COALESCE(SUM(QUANTITY),0) AS REMAIN_QUANTITY
FROM BOOKS AS B
LEFT JOIN ORDERS AS O
ON B.BOOK_ID = O.BOOK_ID
GROUP BY B.BOOK_ID ORDER BY B.BOOK_ID;

--find second highest order value 
select max(total_amount)
from orders 

select order_id,customer_id,total_amount
from orders
where total_amount = (select max(total_amount) from orders 
	where total_amount<(select max(total_amount) from orders))
	limit 1 


-------------------------------------------------------------------
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
---------------------------------------------------------------- 

--FIND TOTAL AMOUNT SPENT BY CUSTOMER WITH ORDER BY PARTITION BY
select order_id,
		customer_id,
		book_id,
		quantity,
		total_amount,
		sum(total_amount*quantity) over (partition by customer_id order by quantity) 
		as SPENT_AMOUNT_BY_CUSTOMER
from orders;  

--basic query find books that are published after 1950
SELECT title,author,published_year
FROM BOOKS
WHERE published_year>1950
order by published_year; 

--find difference in sales for last month
select month,
		total_sales,
		lag(total_sales) over (order by month) as previous_month_sales
from(select date_trunc('month',order_date) as month,
sum(quantity*total_amount) as total_sales
from orders
group by date_trunc('month',order_date));

--SHOW THE COUNTS OF ORDERS PER CUSTOMER 
SELECT CUSTOMER_ID, COUNT(*) AS ORDER_COUNT
FROM ORDERS 
GROUP BY CUSTOMER_ID;

--GET THE LATEST ORDERS PLACES BY EACH 
SELECT CUSTOMER_ID,ORDER_ID,MAX(ORDER_ID) AS LATEST
FROM ORDERS
GROUP BY CUSTOMER_ID;

--FIND BOOKS THAT ARE NEVER SOLD 
SELECT B.BOOK_ID,B.TITLE,O.QUANTITY
FROM BOOKS AS B
LEFT JOIN ORDERS AS O
ON B.BOOK_ID = O.BOOK_ID
WHERE O.BOOK_ID IS NULL; 

--COUNT CUSTOMER WITH MORE THAN 5 ORDERS
SELECT CUSTOMER_ID,COUNT(*) AS TOTAL_ORDERS
FROM ORDERS
GROUP BY CUSTOMER_ID
HAVING COUNT(*)>=5;

--FIND CUSTOMERS WHO ORDERS EVERY MONTH IN YEAR 2023
SELECT customer_id
FROM orders
WHERE order_date >= DATE '2023-01-01' AND order_date <  DATE '2024-01-01'
GROUP BY customer_id
HAVING COUNT(DISTINCT DATE_TRUNC('month', order_date)) = 12;

--FIND CHURNED CUSTOMERS WHO DID NOT ORDER IN LAST 6 MONTHS 
SELECT CUSTOMER_ID
FROM ORDERS 
GROUP BY CUSTOMER_ID
HAVING MAX(ORDER_DATE) <(NOW() - INTERVAL '6MONTHS'); 

--
