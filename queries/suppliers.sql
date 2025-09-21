-- Displaying the list of companies along with the product name they supply
SELECT s.CompanyName, p.ProductName, p.Id
FROM supply_chain.product p
LEFT JOIN supply_chain.supplier s ON p.SupplierId = s.Id;

-- Customers and suppliers in the same country
SELECT c.*, s.* 
FROM supply_chain.customer c
JOIN supply_chain.supplier s ON s.Country = c.Country;

-- Customers with no supplier in their country
SELECT c.*, s.* 
FROM supply_chain.customer c
LEFT JOIN supply_chain.supplier s ON s.Country = c.Country
WHERE s.Country IS NULL;

-- Suppliers with no customers in their country
SELECT * 
FROM supply_chain.customer c
RIGHT JOIN supply_chain.supplier s ON s.Country = c.Country
WHERE c.Country IS NULL;
