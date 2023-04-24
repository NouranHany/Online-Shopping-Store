CREATE SCHEMA `onlinestore` ;
use `onlinestore`; 
CREATE TABLE `Customer` (
  `Id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `SecondName` varchar(255) NOT NULL,
  `Governorate` varchar(255)  NOT NULL,
  `City` varchar(255)  NOT NULL,
  `StreetName` varchar(255)  NOT NULL,
  `BuildingNumber` varchar(255)  NOT NULL,
  `AppartmentNumber` varchar(255) NOT NULL,
  `Gender` char,
  `PhoneNumber` int(32)  NOT NULL  UNIQUE,
  `Email` varchar(255)  NOT NULL  UNIQUE,
  `Password` varchar(255) NOT NULL  
);

CREATE TABLE `DeliveryMan` (
  `Id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `SecondName` varchar(255) NOT NULL,
  `Governorate` varchar(255)  NOT NULL,
  `City` varchar(255)  NOT NULL,
  `StreetName` varchar(255)  NOT NULL,
  `BuildingNumber` varchar(255)  NOT NULL,
  `AppartmentNumber` varchar(255)  NOT NULL,
  `PhoneNumber` int(32)  NOT NULL  UNIQUE,
  `Email` varchar(255) NOT NULL  UNIQUE,
  `Password` varchar(255) NOT NULL,
  `Salary` int DEFAULT 1000,
  `Bonus` int DEFAULT 0
);

CREATE TABLE `HR` (
  `Id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `SecondName` varchar(255) NOT NULL,
  `Governorate` varchar(255)  NOT NULL,
  `City` varchar(255)  NOT NULL,
  `StreetName` varchar(255)  NOT NULL,
  `BuildingNumber` varchar(255)  NOT NULL,
  `AppartmentNumber` varchar(255)  NOT NULL,
  `PhoneNumber` int(32)  NOT NULL UNIQUE,
  `Email` varchar(255) NOT NULL  UNIQUE,
  `Password` varchar(255) NOT NULL,
  `Salary` int DEFAULT 1000
);

CREATE TABLE `SalesMan` (
  `Id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `SecondName` varchar(255) NOT NULL,
  `Governorate` varchar(255)  NOT NULL,
  `City` varchar(255)  NOT NULL,
  `StreetName` varchar(255)  NOT NULL,
  `BuildingNumber` varchar(255)  NOT NULL,
  `AppartmentNumber` varchar(255)  NOT NULL,
  `PhoneNumber` int(32)  NOT NULL UNIQUE,
  `Email` varchar(255) NOT NULL  UNIQUE,
  `Password` varchar(255) NOT NULL,
  `Salary` int DEFAULT 1000
);

CREATE TABLE `Product` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CategoryID` INT NULL,
  `SupplierID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(19,4) NOT NULL,
  `Quantity` INT NULL,
  `Description` VARCHAR(255) NULL,
  `ExpiryDate` varchar(255) NULL,
  `ProductImage` VARCHAR(255) NULL,
  `Discount` INT ZEROFILL NULL,
  `EndTimeOffer` varchar(255) NULL,
  `Frequency` INT ZEROFILL NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `PromoCode` (
  `Code` varchar(255) PRIMARY KEY NOT NULL,
  `Discount` int NOT NULL,
  `EndTime` varchar(255) NOT NULL
);

CREATE TABLE `Order` (
  `CustomerId` int NOT NULL,
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `DeliveryManId` int Default Null,
  `TotalPayment` int NOT NULL,
  `IsDelivered` boolean Default false
);

CREATE TABLE `Supplier` (
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `PhoneNumber` int UNIQUE NOT NULL,
  `Email` varchar(255) unique NOT NULL
);

CREATE TABLE `Complaint` (
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `CustomerId` int NOT NULL,
  `Message` varchar(255)
);

CREATE TABLE `Category` (
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL
);

CREATE TABLE `OrderComponents` (
  `ProductId` int,
  `CustomerId` int,
  `OrderId` int,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`ProductId`, `CustomerId`, `OrderId`)
);

CREATE TABLE `CommentProduct` (
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Message` varchar(255),
  `CustomerId` int NOT NULL,
  `ProductId` int NOT NULL
);

CREATE TABLE `RateProduct` (
  `Rate` int NOT NULL,
  `CustomerId` int,
  `ProductId` int,
  PRIMARY KEY (`CustomerId`, `ProductId`)
);

CREATE TABLE `FeedBackDelivery` (
  `Id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Rate` int,
  `Message` varchar(255),
  `CustomerId` int,
  `DeliveryManId` int
);

CREATE TABLE `Request` (
  `RequestId` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `SalesManId` int,
  `ProductId` int,
  `Quantity` int NOT NULL
);

CREATE TABLE `Uses` (
  `CustomerId` int,
  `Code` varchar(255),
  PRIMARY KEY (`CustomerId`, `Code`)
);

ALTER TABLE `OrderComponents` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `OrderComponents` ADD FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`)  ON DELETE Restrict  ON UPDATE CASCADE;

ALTER TABLE `OrderComponents` ADD FOREIGN KEY (`OrderId`) REFERENCES `Order` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `Order` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `CommentProduct` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `CommentProduct` ADD FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `RateProduct` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `RateProduct` ADD FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `FeedBackDelivery` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE SET NULL  ON UPDATE CASCADE;

ALTER TABLE `FeedBackDelivery` ADD FOREIGN KEY (`DeliveryManId`) REFERENCES `DeliveryMan` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `Complaint` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)  ON DELETE CASCADE  ON UPDATE CASCADE;

ALTER TABLE `Order` ADD FOREIGN KEY (`DeliveryManId`) REFERENCES `DeliveryMan` (`Id`)  ON DELETE Set null  ON UPDATE CASCADE;

ALTER TABLE `Product` ADD FOREIGN KEY (`SupplierID`) REFERENCES `Supplier` (`Id`)  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Request` ADD FOREIGN KEY (`SalesManId`) REFERENCES `SalesMan` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `Request` ADD FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Uses` ADD FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Uses` ADD FOREIGN KEY (`Code`) REFERENCES `PromoCode` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Product` ADD FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE;