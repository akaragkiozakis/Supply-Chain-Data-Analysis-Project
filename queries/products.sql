-- Displaying the products that are not discontinued
SELECT ProductName, COUNT(ProductName) AS products, IsDiscontinued
FROM supply_chain.product
WHERE IsDiscontinued = 0
GROUP BY IsDiscontinued, ProductName;


-- Displaying product name based on highest demand
SELECT p.ProductName, SUM(Quantity) AS maxQuantity
FROM supply_chain.product p
JOIN supply_chain.orderitem o ON o.ProductId = p.Id
GROUP BY p.ProductName
ORDER BY maxQuantity DESC
LIMIT 1;


-- Displaying all product details with ordered quantity size = 1
SELECT p.* 
FROM supply_chain.product p 
JOIN supply_chain.orderitem o ON o.ProductId = p.Id
WHERE o.Quantity = 1;


-- Displaying the companies that supply products whose cost is above 100
SELECT s.CompanyName
FROM supply_chain.supplier s
JOIN supply_chain.product p ON s.Id = p.SupplierId
WHERE p.UnitPrice > 100;


-- Displaying most famous products (>1000 sales) and suppliers (competitors)
SELECT p.Id, p.ProductName, SUM(o.Quantity) AS quantity, s.CompanyName
FROM supply_chain.product p
JOIN supply_chain.orderitem o ON o.ProductId = p.Id
JOIN supply_chain.supplier s ON s.Id = p.SupplierId
GROUP BY p.ProductName, p.Id, s.ContactName
HAVING SUM(o.quantity) > 1000
ORDER BY quantity DESC;


-- Finding out for which products the UK is dependent on imports
SELECT DISTINCT c.country AS UK, s.country AS import_from, p.productname 
FROM supply_chain.customer c 
JOIN supply_chain.supplier s ON s.country <> c.country
JOIN supply_chain.product p ON p.supplierid = s.id
WHERE c.country = 'uk';
