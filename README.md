# DBMS-project
# Expense Tracker - DBMS Project

## Project Overview
This **Expense Tracker** is a database-driven system designed to help users manage, track, and analyze their personal finances efficiently. It includes features like budgeting, recurring expense tracking, credit monitoring, and detailed report generation. The project was developed as part of the **Database Management System (DBMS)** coursework in the 4th semester of the B.Tech Computer Engineering program at **SVKM’s NMIMS, Indore Campus**.

## Team Members

| Roll No | Name              | Contribution                                                                 |
|---------|-------------------|------------------------------------------------------------------------------|
| D065    | Pratikshya Dash   | ER Diagram, Creating Database, Performing SQL Queries                        |
| D093    | Vaishnavi Gandhi  | Documentation, Performing SQL Queries                                        |
| D094    | Vansh Ray Jain    | ER to Relational Schema Conversion, Performing SQL Queries                   |

## Technologies Used

- **DBMS:** MySQL
- **Query Language:** SQL
- **Tools:** phpMyAdmin / MySQL Workbench
- **Report Writing:** MS Word
- **GitHub for Collaboration**

## Database Design

The system includes multiple entities like:
- **Users, Expenses, Categories, Subcategories**
- **Payment Methods, Banks, Budgets, Savings**
- **Credit, Recurring Expenses, Reports, Investments**

The database is fully normalized up to **3NF** and supports **foreign key constraints** to maintain data integrity.

## ER Diagram & Relational Model

The Entity-Relationship (ER) Diagram models real-world relationships such as:
- Users having multiple expenses
- Expenses linked to payment methods and banks
- One-to-one and one-to-many mappings

The **Relational Schema** was derived from the ERD and implemented using SQL DDL commands.

## SQL Implementation

- **Tables Created:** 12+
- **Sample Data:** 10 entries per table
- **Queries Written:** 50+ covering:
  - Aggregate Functions
  - JOINs (INNER, LEFT, FULL OUTER, NATURAL, THETA)
  - Subqueries
  - Data Filtering
  - Report Generation
  - Transactions
  - User Creation & Privilege Management

## Key Functionalities

- Record expenses with categories & subcategories
- Set budgets with alerts for overspending
- Track savings, credit, recurring bills, and investments
- Generate financial reports (monthly/category-wise)
- Simulate real-world SQL use cases

## How to Use

### 1. Setup MySQL Database
```sql
CREATE DATABASE expense_tracker;
USE expense_tracker;
-- Then run the SQL DDL & INSERT scripts (included in this repo)
```
### 2. Table Creation & Data Insertion
All tables and insert queries are available in `DBMS Project.sql` or `project.sql`.

### 3. Running Queries
Use MySQL CLI or phpMyAdmin to run the SQL queries from `queries.sql`.

## User Management & Access Control

```sql
-- Create users
CREATE USER 'analytics_user'@'localhost' IDENTIFIED BY 'securePass123';
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'superSecure!456';

-- Grant privileges
GRANT SELECT ON expense_tracker.expenses TO 'analytics_user'@'localhost';
GRANT ALL PRIVILEGES ON expense_tracker.* TO 'admin_user'@'localhost';
```

## Learning & Highlights

- **Practical DBMS Design**
- **Advanced SQL Techniques**
- **Team Collaboration**
- **Normalization & Data Integrity**
- **Hands-on MySQL Implementation**

## Future Enhancements
- Add web UI for real-time interaction
- Visual dashboards using charts (e.g., Chart.js)
- Export to Excel/PDF
- Integration with mobile apps

## GitHub Repository

[Click Here to View Project] - (https://github.com/Vishu4648/D065_D093_D094_DBMSProject.git)

## License

This project is intended for academic and educational purposes only. All rights reserved by the authors.
