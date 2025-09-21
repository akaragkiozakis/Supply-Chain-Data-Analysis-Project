CREATE TABLE `customer` (
   `Id` int NOT NULL,
   `FirstName` varchar(40) NOT NULL,
   `LastName` varchar(40) NOT NULL,
   `City` varchar(40) DEFAULT NULL,
   `Country` varchar(40) DEFAULT NULL,
   `Phone` varchar(20) DEFAULT NULL,
   PRIMARY KEY (`Id`),
   KEY `IndexCustomerName` (`LastName`,`FirstName`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `orderitem` (
   `Id` int NOT NULL,
   `OrderId` int NOT NULL,
   `ProductId` int NOT NULL,
   `UnitPrice` decimal(12,2) NOT NULL DEFAULT '0.00',
   `Quantity` int NOT NULL DEFAULT '1',
   PRIMARY KEY (`Id`),
   KEY `IndexOrderItemOrderId` (`OrderId`),
   KEY `IndexOrderItemProductId` (`ProductId`),
   CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`),
   CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`Id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `orders` (
   `Id` int NOT NULL,
   `OrderDate` datetime DEFAULT NULL,
   `OrderNumber` varchar(10) DEFAULT NULL,
   `CustomerId` int NOT NULL,
   `TotalAmount` decimal(12,2) DEFAULT '0.00',
   PRIMARY KEY (`Id`),
   KEY `IndexOrderCustomerId` (`CustomerId`),
   KEY `IndexOrderOrderDate` (`OrderDate`),
   CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `product` (
   `Id` int NOT NULL,
   `ProductName` varchar(50) NOT NULL,
   `SupplierId` int NOT NULL,
   `UnitPrice` decimal(12,2) DEFAULT '0.00',
   `Package` varchar(30) DEFAULT NULL,
   `IsDiscontinued` bit(1) NOT NULL DEFAULT b'0',
   PRIMARY KEY (`Id`),
   KEY `IndexProductSupplierId` (`SupplierId`),
   KEY `IndexProductName` (`ProductName`),
   CONSTRAINT `product_ibfk_1` FOREIGN KEY (`SupplierId`) REFERENCES `supplier` (`Id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci 



CREATE TABLE `supplier` (
   `Id` int NOT NULL,
   `CompanyName` varchar(40) NOT NULL,
   `ContactName` varchar(50) DEFAULT NULL,
   `ContactTitle` varchar(40) DEFAULT NULL,
   `City` varchar(40) DEFAULT NULL,
   `Country` varchar(40) DEFAULT NULL,
   `Phone` varchar(30) DEFAULT NULL,
   `Fax` varchar(30) DEFAULT NULL,
   PRIMARY KEY (`Id`),
   KEY `IndexSupplierName` (`CompanyName`),
   KEY `IndexSupplierCountry` (`Country`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci 