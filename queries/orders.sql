-- Displaying the total orders delivered every year
SELECT YEAR(OrderDate) AS year, COUNT(*) AS total_orders
FROM supply_chain.orders
GROUP BY year;

-- Calculating year-wise total revenue
SELECT YEAR(OrderDate) AS year,
       SUM(o.UnitPrice * o.Quantity) AS total_revenue
FROM supply_chain.orderitem o
JOIN supply_chain.orders od ON o.OrderId = od.Id
GROUP BY year;

-- Displaying the customer with max payment including all his orders
WITH max_payment AS (
  SELECT o.CustomerId, 
         CONCAT(c.FirstName, ' ', c.LastName) AS FullName, 
         SUM(o.TotalAmount) AS total
  FROM supply_chain.orders o
  JOIN supply_chain.customer c ON o.CustomerId = c.Id
  GROUP BY FullName, o.CustomerId
  ORDER BY total DESC
  LIMIT 1
)
SELECT m.FullName, m.total AS Amount
FROM max_payment m
UNION ALL
SELECT m.FullName, o.TotalAmount AS Amount
FROM max_payment m
JOIN supply_chain.orders o ON o.CustomerId = m.CustomerId
ORDER BY Amount DESC;

-- Displaying the total amount ordered by each customer
SELECT CONCAT(FirstName, ' ', LastName) AS FullName,
       SUM(TotalAmount) AS Total_amount
FROM supply_chain.customer c
JOIN supply_chain.orders o ON o.CustomerId = c.Id
GROUP BY FullName
ORDER BY Total_Amount DESC;
