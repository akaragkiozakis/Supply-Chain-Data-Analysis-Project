-- Calculating money saved per product (difference in UnitPrice)
SELECT o.OrderId, p.ProductName, o.Quantity, p.UnitPrice,
       SUM((p.UnitPrice - o.UnitPrice) * o.Quantity) AS amount_saved
FROM supply_chain.product p 
JOIN supply_chain.orderitem o ON o.ProductId = p.Id 
GROUP BY o.OrderId, p.ProductName, o.Quantity, p.UnitPrice
ORDER BY amount_saved DESC;

-- Calculating money saved per order
SELECT o.OrderId, 
       SUM((p.UnitPrice - o.UnitPrice) * o.Quantity) AS total_amount_saved 
FROM supply_chain.product p
JOIN supply_chain.orderitem o ON o.ProductId = p.Id
GROUP BY o.OrderId
ORDER BY total_amount_saved DESC;
