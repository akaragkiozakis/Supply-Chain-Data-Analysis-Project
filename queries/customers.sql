-- Counting how many customers every country has
SELECT COUNT(Id) AS customers, Country
FROM supply_chain.customer
GROUP BY Country;


-- Displaying customer information about who stays in Mexico
SELECT Id, CONCAT(FirstName, ' ', LastName) AS FullName, City, Phone
FROM supply_chain.customer
WHERE Country = 'Mexico';


-- Displaying the total amount ordered by each customer from high to low
SELECT CONCAT(FirstName, ' ', LastName) AS FullName,
       SUM(TotalAmount) AS Total_amount
FROM supply_chain.customer c
JOIN supply_chain.orders o ON o.CustomerId = c.Id
GROUP BY FullName
ORDER BY Total_Amount DESC;


-- Displaying the customer details who ordered more than 10 products in a single order
SELECT *
FROM (
    SELECT DISTINCT c.*, COUNT(o.CustomerId) OVER(PARTITION BY c.Id) AS orders
    FROM supply_chain.orders o
    JOIN supply_chain.customer c ON c.Id = o.CustomerId
) AS sub
WHERE orders > 10
ORDER BY orders DESC;


-- Displaying the customer list who belong to the same city and country (>=2 customers)
SELECT * 
FROM (
    SELECT COUNT(Id) OVER(PARTITION BY Country, City) AS total_customers, 
           CONCAT(FirstName, ' ', LastName) AS FullName, 
           Country
    FROM supply_chain.customer
) AS sub
WHERE total_customers >= 2;


