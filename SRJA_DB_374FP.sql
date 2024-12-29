DROP DATABASE IF EXISTS SRJA_Clothing;
CREATE DATABASE SRJA_Clothing;
USE SRJA_Clothing;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Inventory_Alert;
DROP TABLE IF EXISTS Consume_Coupon;
DROP TABLE IF EXISTS Coupon;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Returns;
DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Loyalty_Program;
DROP TABLE IF EXISTS Customer;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Customer (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Tier ENUM('Bronze', 'Silver', 'Gold') DEFAULT 'Bronze',
    Total_Spending DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE Loyalty_Program (
    Lprogram_ID INT AUTO_INCREMENT PRIMARY KEY,
    Tier_Level ENUM('Bronze', 'Silver', 'Gold') NOT NULL,
    Discount_Rate DECIMAL(5, 2) NOT NULL
);

CREATE TABLE Member (
    Member_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Lprogram_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Lprogram_ID) REFERENCES Loyalty_Program(Lprogram_ID)
);

CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Stock INT NOT NULL
);

CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    O_Date DATE NOT NULL,
    Discount_Rate DECIMAL(5, 2) DEFAULT 0,
    Tracking_num VARCHAR(100),
    Is_Gift BOOLEAN DEFAULT FALSE,
    Is_Cancelled BOOLEAN DEFAULT FALSE,
    Customer_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Review (
    Review_Number INT AUTO_INCREMENT PRIMARY KEY,
    Is_Positive BOOLEAN NOT NULL,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Returns (
    Return_ID INT AUTO_INCREMENT PRIMARY KEY,
    Return_Date DATE NOT NULL,
    Purchase_Date DATE NOT NULL,
    Order_ID INT NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Coupon (
    Coupon_ID INT AUTO_INCREMENT PRIMARY KEY,
    Exp_Date DATE NOT NULL,
    Usage_Limit INT NOT NULL,
    Is_Redeemed BOOLEAN DEFAULT FALSE
);

CREATE TABLE Consume_Coupon (
    Consume_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Coupon_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Coupon_ID) REFERENCES Coupon(Coupon_ID)
);

CREATE TABLE Inventory_Alert (
    Alert_ID INT AUTO_INCREMENT PRIMARY KEY,
    Restock_Threshold INT NOT NULL,
    Inventory_Threshold INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);