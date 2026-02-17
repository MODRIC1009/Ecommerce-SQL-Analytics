# E-commerce Sales & Customer Analytics (SQL Project)

## Project Overview
This project performs an end-to-end analysis of a real-world e-commerce dataset using SQL.  
The objective is to extract actionable business insights related to revenue trends, customer behaviour, product performance, and operational efficiency.

The project demonstrates practical SQL skills using a multi-table relational database, similar to real-world business environments.

## Dataset
- Source: Brazilian E-commerce Public Dataset (Olist)
- Size: 100,000+ orders
- Real-world transactional data

### Main Tables
- **customers** – Customer demographic information
- **orders** – Order-level transaction data
- **order_items** – Product-level details for each order
- **products** – Product catalog information
- **payments** – Payment details for each order

## Database Schema
The project uses a relational schema with multiple related tables connected through primary and foreign keys.

Key relationships:
- One customer can place multiple orders.
- One order can contain multiple products.
- Each order can have one or more payments.

See the ER diagram in the `docs/` folder.

## Key Business Questions Answered
1. What is the total revenue generated?
2. How does revenue change over time?
3. Who are the top customers by spending?
4. Which products and categories perform best?
5. What payment methods are most commonly used?
6. What is the average delivery time?
7. What percentage of customers are repeat buyers?

## Key Insights
- A small percentage of customers generate a large share of total revenue.
- Credit cards are the dominant payment method across transactions.
- Top-performing product categories drive a significant portion of sales.
- Revenue shows seasonal peaks during specific months.
- Most orders are successfully delivered.
- Repeat customers have higher lifetime value than new customers.
- A limited number of products contribute disproportionately to revenue.
- Delivery times remain consistent across most orders.

## SQL Techniques Used
- Multi-table joins
- Aggregations and grouping
- Subqueries
- CASE statements
- Window functions
- Time-series analysis
- Customer lifetime value calculations

## Tools & Technologies
- MySQL
- MySQL Workbench
- SQL

## Skills Demonstrated
- Relational database design
- SQL query optimisation
- Data aggregation and analysis
- Customer behaviour analysis
- Business insight generation
- Time-based revenue analysis

## Author
Nihal  
B.Tech IT Student  
