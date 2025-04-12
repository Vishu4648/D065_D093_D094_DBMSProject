show databases;
create database Expense_tracker;
use Expense_tracker;
-- Users table
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(100),
  created_at DATE
);

-- Categories table
CREATE TABLE categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(100)
);

-- Subcategories (normalized from categories)
CREATE TABLE subcategories (
  subcategory_id INT PRIMARY KEY,
  category_id INT,
  subcategory_name VARCHAR(100),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Payment Methods table
CREATE TABLE payment_methods (
  payment_method_id INT PRIMARY KEY,
  method_name VARCHAR(100),
  transaction_type VARCHAR(50)
);

-- Banks table
CREATE TABLE banks (
  bank_id INT PRIMARY KEY,
  bank_name VARCHAR(100),
  branch VARCHAR(100),
  account_number VARCHAR(20)
);

-- Expenses table
CREATE TABLE expenses (
  expense_id INT PRIMARY KEY,
  user_id INT,
  category_id INT,
  subcategory_id INT,
  payment_method_id INT,
  bank_id INT,
  amount DECIMAL(10,2),
  date DATE,
  description VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id),
  FOREIGN KEY (subcategory_id) REFERENCES subcategories(subcategory_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id),
  FOREIGN KEY (bank_id) REFERENCES banks(bank_id)
);

-- Budgets table
CREATE TABLE budgets (
  budget_id INT PRIMARY KEY,
  user_id INT,
  category_id INT,
  amount DECIMAL(10,2),
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Savings table
CREATE TABLE savings (
  savings_id INT PRIMARY KEY,
  user_id INT,
  goal_amount DECIMAL(10,2),
  amount_saved DECIMAL(10,2),
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Credit table
CREATE TABLE credit (
  credit_id INT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  interest_rate DECIMAL(5,2),
  due_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Recurring Expenses table
CREATE TABLE recurring_expenses (
  recurring_expense_id INT PRIMARY KEY,
  user_id INT,
  category_id INT,
  subcategory_id INT,
  payment_method_id INT,
  amount DECIMAL(10,2),
  frequency VARCHAR(50),
  next_due_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id),
  FOREIGN KEY (subcategory_id) REFERENCES subcategories(subcategory_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);

-- Reports table
CREATE TABLE reports (
  report_id INT PRIMARY KEY,
  user_id INT UNIQUE,
  total_income DECIMAL(10,2),
  total_expense DECIMAL(10,2),
  savings_summary DECIMAL(10,2),
  generated_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Investments table
CREATE TABLE investments (
  investment_id INT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  type VARCHAR(50),
  return_rate DECIMAL(5,2),
  start_date DATE,
  maturity_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- USERS
INSERT INTO users VALUES 
(1, 'Alice', 'alice@example.com', 'password123', '2023-01-01'),
(2, 'Bob', 'bob@example.com', 'password456', '2023-01-02'),
(3, 'Charlie', 'charlie@example.com', 'password789', '2023-01-03'),
(4, 'David', 'david@example.com', 'password321', '2023-01-04'),
(5, 'Eva', 'eva@example.com', 'password654', '2023-01-05'),
(6, 'Frank', 'frank@example.com', 'password987', '2023-01-06'),
(7, 'Grace', 'grace@example.com', 'passwordabc', '2023-01-07'),
(8, 'Hannah', 'hannah@example.com', 'passworddef', '2023-01-08'),
(9, 'Ian', 'ian@example.com', 'passwordghi', '2023-01-09'),
(10, 'Jane', 'jane@example.com', 'passwordjkl', '2023-01-10');

-- CATEGORIES
INSERT INTO categories VALUES 
(1, 'Food'), (2, 'Transportation'), (3, 'Utilities'), (4, 'Healthcare'), (5, 'Entertainment'), 
(6, 'Education'), (7, 'Shopping'), (8, 'Insurance'), (9, 'Travel'), (10, 'Others');

-- SUBCATEGORIES
INSERT INTO subcategories VALUES 
(1, 1, 'Groceries'), (2, 1, 'Restaurants'), (3, 2, 'Public Transport'), (4, 2, 'Fuel'), 
(5, 3, 'Electricity'), (6, 3, 'Water'), (7, 4, 'Medicine'), (8, 4, 'Doctor Visits'), 
(9, 5, 'Movies'), (10, 5, 'Concerts'), (11, 6, 'Tuition'), (12, 6, 'Books'), 
(13, 7, 'Clothing'), (14, 7, 'Accessories'), (15, 8, 'Health Insurance'), (16, 8, 'Car Insurance'), 
(17, 9, 'Flights'), (18, 9, 'Hotels'), (19, 10, 'Gifts'), (20, 10, 'Donations');

-- PAYMENT METHODS
INSERT INTO payment_methods (payment_method_id, method_name, transaction_type) VALUES
(1, 'Cash', 'Expense'),
(2, 'Credit Card', 'Expense'),
(3, 'Debit Card', 'Expense'),
(4, 'UPI', 'Expense'),
(5, 'Net Banking', 'Expense'),
(6, 'Wallet', 'Expense'),
(7, 'Cheque', 'Expense'),
(8, 'Bank Transfer', 'Expense'),
(9, 'EMI', 'Expense'),
(10, 'Other', 'Expense');

-- BANKS
INSERT INTO banks (bank_id, bank_name, branch, account_number) VALUES 
(1, 'Bank of America', 'USA', '1234567890'),
(2, 'Chase', 'USA', '2345678901'),
(3, 'Wells Fargo', 'USA', '3456789012'),
(4, 'Citibank', 'USA', '4567890123'),
(5, 'HSBC', 'UK', '5678901234'),
(6, 'Barclays', 'UK', '6789012345'),
(7, 'Deutsche Bank', 'Germany', '7890123456'),
(8, 'BNP Paribas', 'France', '8901234567'),
(9, 'ICICI Bank', 'India', '9012345678'),
(10, 'HDFC Bank', 'India', '0123456789');

-- EXPENSES
INSERT INTO expenses VALUES 
(1, 10, 7, 6, 9, 6, 339.61, '2024-04-29', 'Description 1'),
(2, 4, 6, 18, 9, 10, 87.00, '2024-07-21', 'Description 2'),
(3, 4, 1, 4, 6, 1, 475.56, '2024-03-11', 'Description 3'),
(4, 4, 9, 19, 2, 7, 400.25, '2024-02-01', 'Description 4'),
(5, 2, 1, 19, 4, 7, 332.17, '2024-01-17', 'Description 5'),
(6, 6, 6, 3, 6, 2, 420.19, '2024-11-25', 'Description 6'),
(7, 10, 4, 7, 3, 7, 315.08, '2024-08-02', 'Description 7'),
(8, 3, 9, 1, 5, 4, 201.56, '2024-09-14', 'Description 8'),
(9, 10, 7, 17, 1, 9, 196.72, '2024-10-30', 'Description 9'),
(10, 6, 8, 2, 2, 10, 471.38, '2024-01-21', 'Description 10');

-- BUDGETS
INSERT INTO budgets VALUES 
(1, 1, 3, 1712.13, '2024-02-22', '2024-03-23'),
(2, 6, 7, 1017.66, '2024-07-26', '2024-08-25'),
(3, 6, 9, 1013.64, '2024-08-09', '2024-09-08'),
(4, 6, 3, 1854.18, '2024-02-12', '2024-03-13'),
(5, 1, 3, 1660.91, '2024-06-28', '2024-07-28'),
(6, 9, 5, 1523.90, '2024-06-28', '2024-07-28'),
(7, 3, 1, 1407.13, '2024-01-02', '2024-02-01'),
(8, 9, 6, 1926.19, '2024-08-07', '2024-09-06'),
(9, 10, 10, 540.33, '2024-05-12', '2024-06-11'),
(10, 6, 5, 740.38, '2024-07-01', '2024-07-31');

-- SAVINGS
INSERT INTO savings VALUES 
(1, 1, 4002.44, 3541.35, '2024-09-18', '2024-11-17'),
(2, 2, 2580.81, 1139.05, '2024-05-27', '2024-07-26'),
(3, 3, 2542.50, 2279.69, '2024-06-21', '2024-08-20'),
(4, 4, 1773.76, 1474.13, '2024-02-07', '2024-04-07'),
(5, 5, 3926.60, 3911.38, '2024-04-06', '2024-06-05'),
(6, 6, 3897.63, 2025.34, '2024-10-15', '2024-12-14'),
(7, 7, 2485.02, 1440.11, '2024-06-01', '2024-07-31'),
(8, 8, 3660.01, 3064.99, '2024-10-24', '2024-12-23'),
(9, 9, 4499.40, 3865.62, '2024-01-14', '2024-03-14'),
(10, 10, 1042.23, 605.16, '2024-03-18', '2024-05-17');

-- CREDIT
INSERT INTO credit VALUES 
(1, 1, 4264.11, 11.55, '2024-03-28'),
(2, 2, 1686.12, 12.43, '2024-07-23'),
(3, 3, 2285.46, 5.45, '2024-06-20'),
(4, 4, 4377.52, 4.17, '2024-09-07'),
(5, 5, 1270.98, 12.59, '2024-01-10'),
(6, 6, 4577.94, 14.33, '2024-11-09'),
(7, 7, 4160.88, 8.09, '2024-03-18'),
(8, 8, 2756.30, 7.61, '2024-06-01'),
(9, 9, 3059.04, 6.87, '2024-03-14'),
(10, 10, 4186.38, 14.31, '2024-02-01');

-- RECURRING EXPENSES
INSERT INTO recurring_expenses VALUES 
(1, 9, 8, 5, 5, 720.14, 'Yearly', '2024-11-11'),
(2, 9, 9, 8, 2, 537.98, 'Weekly', '2024-08-01'),
(3, 1, 6, 18, 4, 179.76, 'Monthly', '2024-07-22'),
(4, 2, 10, 6, 10, 279.83, 'Monthly', '2024-09-07'),
(5, 5, 1, 11, 1, 264.90, 'Yearly', '2024-01-21'),
(6, 1, 6, 9, 9, 850.18, 'Monthly', '2024-07-06'),
(7, 6, 5, 5, 9, 457.99, 'Monthly', '2024-01-23'),
(8, 2, 2, 15, 10, 291.02, 'Yearly', '2024-06-15'),
(9, 10, 9, 12, 7, 958.45, 'Monthly', '2024-11-26'),
(10, 2, 10, 6, 3, 184.23, 'Monthly', '2024-01-22');

-- REPORTS
INSERT INTO reports VALUES 
(1, 1, 6351.73, 2855.26, 3496.47, '2024-06-28'),
(2, 2, 8124.40, 553.48, 7570.92, '2024-08-22'),
(3, 3, 2183.62, 1146.21, 1037.41, '2024-06-22'),
(4, 4, 3237.84, 755.31, 2482.53, '2024-08-04'),
(5, 5, 4733.52, 1804.73, 2928.79, '2024-04-13'),
(6, 6, 8755.22, 3154.28, 5600.94, '2024-03-27'),
(7, 7, 5956.91, 1211.91, 4745.00, '2024-01-23'),
(8, 8, 2032.87, 764.42, 1268.45, '2024-09-18'),
(9, 9, 9567.29, 4353.21, 5214.08, '2024-03-11'),
(10, 10, 7494.21, 1997.42, 5496.79, '2024-01-19');

-- INVESTMENTS
INSERT INTO investments VALUES 
(1, 1, 3435.74, 'Bonds', 5.24, '2024-04-29', '2024-07-28'),
(2, 2, 6464.64, 'Stocks', 5.09, '2024-08-23', '2024-11-21'),
(3, 3, 5990.52, 'Real Estate', 4.47, '2024-01-24', '2024-04-23'),
(4, 4, 9647.88, 'Mutual Funds', 3.62, '2024-07-10', '2024-10-08'),
(5, 5, 8793.61, 'Stocks', 9.42, '2024-03-18', '2024-06-16'),
(6, 6, 1505.02, 'Bonds', 6.21, '2024-06-22', '2024-09-20'),
(7, 7, 1045.63, 'Real Estate', 6.28, '2024-01-17', '2024-04-16'),
(8, 8, 4727.17, 'Stocks', 4.82, '2024-01-15', '2024-04-14'),
(9, 9, 9425.36, 'Mutual Funds', 3.83, '2024-04-25', '2024-07-24'),
(10, 10, 4057.11, 'Bonds', 7.51, '2024-01-15', '2024-04-14');

Question query:

USE expense_tracker;

-- Top 5 most expensive purchases
SELECT description, amount, date 
FROM expenses 
ORDER BY amount DESC 
LIMIT 5;

-- Monthly total expenses (last 6 months)
SELECT 
  DATE_FORMAT(date, '%y-%m') AS month, 
  SUM(amount) AS total_spent 
FROM expenses 
WHERE date >= '2024-10-13' -- Avoid using function on column
GROUP BY month 
ORDER BY month DESC;

-- Total expenses by category
SELECT 
  c.category_name, 
  SUM(e.amount) AS total 
FROM expenses e 
JOIN categories c ON e.category_id = c.category_id 
GROUP BY c.category_name 
ORDER BY total DESC;

-- Average daily spending in the current month
SELECT AVG(daily_total) AS average_spent 
FROM (
  SELECT 
    date, 
    SUM(amount) AS daily_total 
  FROM expenses 
  WHERE date >= DATE_FORMAT(CURDATE(), '%Y-%m-01') 
    AND date <= CURDATE()
  GROUP BY date
) daily;

-- Expenses above budget by category
SELECT 
  e.expense_id, 
  e.amount, 
  c.category_name, 
  b.amount AS budget_amount 
FROM expenses e 
JOIN categories c ON e.category_id = c.category_id 
JOIN budgets b 
  ON b.category_id = e.category_id AND b.user_id = e.user_id 
WHERE e.amount > b.amount;

-- Users who exceeded any category budget
SELECT DISTINCT u.user_id, u.name 
FROM users u 
JOIN expenses e ON u.user_id = e.user_id 
JOIN budgets b 
  ON b.category_id = e.category_id AND b.user_id = e.user_id 
WHERE e.amount > b.amount;

-- Remaining budget per category
SELECT 
  b.user_id, 
  c.category_name, 
  b.amount - COALESCE(SUM(e.amount), 0) AS remaining_budget 
FROM budgets b 
JOIN categories c ON b.category_id = c.category_id 
LEFT JOIN expenses e 
  ON e.category_id = b.category_id AND e.user_id = b.user_id 
GROUP BY b.user_id, c.category_name, b.amount;

-- Monthly budget vs actual spending
SELECT 
  u.user_id, 
  DATE_FORMAT(CURDATE(), '%y-%m') AS month, 
  SUM(DISTINCT b.amount) AS total_budget, 
  SUM(e.amount) AS total_spent 
FROM users u 
LEFT JOIN budgets b ON b.user_id = u.user_id 
LEFT JOIN expenses e 
  ON e.user_id = u.user_id 
  AND e.date BETWEEN DATE_FORMAT(CURDATE(), '%Y-%m-01') AND LAST_DAY(CURDATE()) 
GROUP BY u.user_id;

-- Active recurring expenses
SELECT * 
FROM recurring_expenses 
WHERE next_due_date IS NOT NULL;

-- Upcoming recurring expenses in next 10 days
SELECT * 
FROM recurring_expenses 
WHERE next_due_date BETWEEN CURDATE() AND '2025-04-21';

-- Total monthly recurring commitment per user
SELECT 
  user_id, 
  SUM(amount) AS monthly_commitment 
FROM recurring_expenses 
GROUP BY user_id;

-- Credit usage percentage per user
SELECT 
  user_id, 
  ROUND(amount / 100, 2) AS credit_usage_percentage 
FROM credit 
WHERE amount > 0;

-- Users nearing credit limit (over 90%)
SELECT 
  user_id, 
  amount, 
  10000 AS credit_limit 
FROM credit 
WHERE amount > 9000;

-- Total expenses by payment method
SELECT 
  p.method_name, 
  SUM(e.amount) AS total_spent 
FROM expenses e 
JOIN payment_methods p ON e.payment_method_id = p.payment_method_id 
GROUP BY p.method_name 
ORDER BY total_spent DESC;

-- Payment methods used by each user
SELECT DISTINCT 
  u.user_id, 
  u.name, 
  p.method_name 
FROM users u 
JOIN expenses e ON u.user_id = e.user_id 
JOIN payment_methods p ON e.payment_method_id = p.payment_method_id;

-- Bank-wise expense analysis
SELECT 
  b.bank_name, 
  SUM(e.amount) AS total_spent 
FROM expenses e 
JOIN banks b ON e.bank_id = b.bank_id 
GROUP BY b.bank_name;

-- Expenses summary per user
SELECT 
  u.user_id, 
  u.name, 
  COUNT(e.expense_id) AS num_expenses, 
  SUM(e.amount) AS total_spent 
FROM users u 
LEFT JOIN expenses e ON u.user_id = e.user_id 
GROUP BY u.user_id;

-- Highest spending user
SELECT 
  u.user_id, 
  u.name, 
  SUM(e.amount) AS total_spent 
FROM users u 
JOIN expenses e ON u.user_id = e.user_id 
GROUP BY u.user_id 
ORDER BY total_spent DESC 
LIMIT 1;

-- User-wise investment amount
SELECT 
  u.user_id, 
  u.name, 
  SUM(i.amount) AS total_invested 
FROM users u 
JOIN investments i ON u.user_id = i.user_id 
GROUP BY u.user_id;

-- Top 3 expense categories per user
SELECT 
  user_id, 
  category_id, 
  total 
FROM (
  SELECT 
    user_id, 
    category_id, 
    SUM(amount) AS total, 
    RANK() OVER (PARTITION BY user_id ORDER BY SUM(amount) DESC) AS rnk 
  FROM expenses 
  GROUP BY user_id, category_id
) ranked 
WHERE rnk <= 3;

-- Month-over-month spending change
SELECT 
  month, 
  total_spent, 
  total_spent - LAG(total_spent) OVER (ORDER BY month) AS change 
FROM (
  SELECT 
    DATE_FORMAT(date, '%y-%m') AS month, 
    SUM(amount) AS total_spent 
  FROM expenses 
  GROUP BY month
) monthly;

-- Total savings per user
SELECT 
  user_id, 
  SUM(amount_saved) AS total_savings 
FROM savings 
GROUP BY user_id;

-- Savings vs expenses per user
SELECT 
  s.user_id, 
  SUM(s.amount_saved) AS savings, 
  SUM(e.amount) AS expenses 
FROM savings s 
JOIN expenses e ON s.user_id = e.user_id 
GROUP BY s.user_id;

-- Expenses in current year grouped by month
SELECT 
  DATE_FORMAT(date, '%y-%m') AS month, 
  SUM(amount) AS total 
FROM expenses 
WHERE YEAR(date) = YEAR(CURDATE()) 
GROUP BY month;

-- Day of week analysis
SELECT 
  DAYNAME(date) AS weekday, 
  COUNT(*) AS num_expenses, 
  SUM(amount) AS total_spent 
FROM expenses 
GROUP BY weekday 
ORDER BY FIELD(weekday, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Expenses between specific dates
SELECT * 
FROM expenses 
WHERE date BETWEEN '2024-01-01' AND '2024-03-31';

-- Filter expenses by keyword in description
SELECT * 
FROM expenses 
WHERE description LIKE '%groceries%';

-- Investments with return above 10%
SELECT * 
FROM investments 
WHERE return_rate > 10;

-- High-value expenses over 1000
SELECT * 
FROM expenses 
WHERE amount > 1000;

-- Inactive recurring expenses
SELECT * 
FROM recurring_expenses 
WHERE next_due_date IS NULL;

-- =====================================
-- FULL OUTER JOIN (Expenses + Budgets)
-- =====================================
-- Note: FULL OUTER JOIN is not directly supported in MySQL. Simulated using UNION of LEFT and RIGHT JOINs.
SELECT 
  COALESCE(e.category_id, b.category_id) AS category_id,
  c.category_name,
  SUM(e.amount) AS total_spent,
  b.amount AS budget
FROM expenses e
LEFT JOIN budgets b 
  ON e.category_id = b.category_id AND e.user_id = b.user_id
JOIN categories c 
  ON c.category_id = e.category_id
GROUP BY category_id, category_name, b.amount

UNION

SELECT 
  COALESCE(e.category_id, b.category_id) AS category_id,
  c.category_name,
  SUM(e.amount) AS total_spent,
  b.amount AS budget
FROM budgets b
LEFT JOIN expenses e 
  ON b.category_id = e.category_id AND b.user_id = e.user_id
JOIN categories c 
  ON c.category_id = b.category_id
GROUP BY category_id, category_name, b.amount;

-- =====================================
-- NATURAL JOIN (Categories & Subcategories)
-- =====================================
-- Assumes both tables share `category_id`
SELECT * 
FROM categories 
NATURAL JOIN subcategories;

-- =====================================
-- THETA JOIN (Custom condition expenses > 2 * savings)
-- =====================================
SELECT 
  e.user_id, 
  e.amount AS expense, 
  s.amount_saved AS savings
FROM expenses e
JOIN savings s ON e.user_id = s.user_id
WHERE e.amount > 2 * s.amount_saved;

-- =====================================
-- MULTI JOIN (Users + Expenses + Categories + Banks + Payment Methods)
-- =====================================
SELECT 
  u.name,
  e.description,
  e.amount,
  c.category_name,
  p.method_name,
  b.bank_name,
  e.date
FROM expenses e
JOIN users u ON e.user_id = u.user_id
JOIN categories c ON e.category_id = c.category_id
JOIN payment_methods p ON e.payment_method_id = p.payment_method_id
JOIN banks b ON e.bank_id = b.bank_id;

-- =====================================
-- CREATING USERS
-- =====================================
CREATE USER 'analytics_user'@'localhost' IDENTIFIED BY 'securePass123';
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'superSecure!456';

-- =====================================
-- GRANTING PRIVILEGES
-- =====================================
-- Read-only user
GRANT SELECT ON expense_tracker.expenses TO 'analytics_user'@'localhost';
GRANT SELECT ON expense_tracker.reports TO 'analytics_user'@'localhost';

-- Admin user with full access
GRANT ALL PRIVILEGES ON expense_tracker.* TO 'admin_user'@'localhost';

-- =====================================
-- REVOKING ACCESS
-- =====================================
REVOKE SELECT, INSERT, UPDATE ON expense_tracker.expenses FROM 'analytics_user'@'localhost';

-- =====================================
-- TRANSACTION FOR SENSITIVE INFORMATION
-- =====================================
START TRANSACTION;

-- Credit usage (sensitive)
INSERT INTO credit (user_id, amount, date_used)
VALUES (3, 2500.00, CURDATE());

-- Matching investment entry
INSERT INTO investments (user_id, investment_type, amount, return_rate, investment_date)
VALUES (3, 'Mutual Fund', 2500.00, 9.5, CURDATE());

-- Commit both only if successful
COMMIT;

-- In case of error
-- ROLLBACK;
