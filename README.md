# SQL Bookstore Sales Analysis

This project analyzes bookstore sales data using SQL and PostgreSQL to answer business questions related to sales, customers, books, revenue, and inventory.

The project uses relational tables for Books, Customers, and Orders and applies SQL queries to extract useful business insights from the data.

## Database Structure

The project contains three main tables:

- Books
- Customers
- Orders

The Orders table connects customers and books using foreign keys.

## Business Questions Answered

### Sales Analysis

- Calculate total revenue generated from orders
- Find total quantity of books sold by genre
- Identify the most frequently ordered book
- Find the highest and second-highest order values
- Analyze monthly sales trends
- Compare current sales with previous month sales

### Customer Analysis

- Find customers with multiple orders
- Identify customers with high order counts
- Find the customer with the highest spending
- Count orders placed by each customer
- Identify customers who ordered every month in 2023
- Identify customers who have not ordered recently

### Book & Inventory Analysis

- Find the most expensive books
- Find books with the lowest stock
- Calculate remaining stock after fulfilled orders
- Identify books that have never been sold
- Analyze books sold by genre and author

## SQL Concepts Used

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- Aggregate Functions
- Subqueries
- Window Functions
- PARTITION BY
- LAG()
- Date & Time Functions

## Advanced SQL Analysis

The project also includes advanced queries using:

- Window functions for customer-level spending analysis
- LAG() for month-over-month sales comparison
- Subqueries for ranking and comparison
- Date-based customer activity analysis
- Inventory calculations using joins and aggregations

## Tools

- PostgreSQL
- SQL

## Project Objective

The objective of this project is to use SQL to transform relational bookstore data into meaningful business information that can support analysis of sales performance, customer behavior, product performance, and inventory status.

## Skills Demonstrated

- Relational database analysis
- Data querying
- Business problem solving
- Customer analysis
- Sales analysis
- Inventory analysis
- Advanced SQL
- Analytical thinking
