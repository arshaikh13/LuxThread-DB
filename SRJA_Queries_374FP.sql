USE SRJA_Clothing;

-- 1. List all customers along with their tier, ordered by their total spending
SELECT Customer_ID, First_Name, Last_Name, Tier, Total_Spending
FROM Customer
ORDER BY Total_Spending DESC;

-- 2. Show 10 products and their categories, prices, and current stock levels
SELECT Product_ID, Name, Category, Price, Stock
FROM Product
ORDER BY Category, Price ASC LIMIT 10;

-- 3. Retrieve all orders with their customer details and tracking numbers
SELECT Orders.Order_ID, Orders.O_Date, Orders.Tracking_num, Customer.First_Name, Customer.Last_Name
FROM Orders
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
ORDER BY Orders.O_Date ASC;

-- 4. Find all products that have been reviewed positively
SELECT Product.Name, COUNT(Review.Review_Number) AS Positive_Reviews
FROM Review
JOIN Product ON Review.Product_ID = Product.Product_ID
WHERE Review.Is_Positive = TRUE
GROUP BY Product.Name
HAVING Positive_Reviews >= 1;

-- 5. List Gold-tier customers and their total spending
SELECT First_Name, Last_Name, Total_Spending
FROM Customer
WHERE Tier = 'Gold'
ORDER BY Total_Spending DESC;

-- 6. Show customers who redeemed a coupon along with coupon details
SELECT Customer.First_Name, Customer.Last_Name, Coupon.Coupon_ID, Coupon.Exp_Date, Coupon.Usage_Limit
FROM Consume_Coupon
JOIN Customer ON Consume_Coupon.Customer_ID = Customer.Customer_ID
JOIN Coupon ON Consume_Coupon.Coupon_ID = Coupon.Coupon_ID
WHERE Coupon.Is_Redeemed = TRUE;

-- 7. Identify products with inventory below the restock threshold
SELECT Product.Name, Product.Stock, Inventory_Alert.Restock_Threshold
FROM Inventory_Alert
JOIN Product ON Inventory_Alert.Product_ID = Product.Product_ID
WHERE Product.Stock < Inventory_Alert.Restock_Threshold;

-- 8. Show the total quantity and sales amount for each product sold
SELECT Product.Name, 
       SUM(Order_Details.Quantity) AS Total_Quantity, 
       SUM(Order_Details.Quantity * Order_Details.Price) AS Total_Sales
FROM Order_Details
JOIN Product ON Order_Details.Product_ID = Product.Product_ID
GROUP BY Product.Name
ORDER BY Total_Sales DESC;

-- 9. Display all loyalty program members with their tier and discount rate
SELECT Customer.First_Name, Customer.Last_Name, Loyalty_Program.Tier_Level, Loyalty_Program.Discount_Rate
FROM Member
JOIN Customer ON Member.Customer_ID = Customer.Customer_ID
JOIN Loyalty_Program ON Member.Lprogram_ID = Loyalty_Program.Lprogram_ID
ORDER BY Loyalty_Program.Tier_Level;

-- 10. Find the average spending of customers in each tier
SELECT Tier, AVG(Total_Spending) AS Avg_Spending
FROM Customer
GROUP BY Tier;

-- 11. Retrieve all orders marked as gifts with customer details
SELECT Orders.Order_ID, Orders.O_Date, Customer.First_Name, Customer.Last_Name
FROM Orders
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
WHERE Orders.Is_Gift = TRUE;

-- 12. Count the total number of orders placed by each customer
SELECT Customer.First_Name, Customer.Last_Name, COUNT(Orders.Order_ID) AS Total_Orders
FROM Orders
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
GROUP BY Customer.Customer_ID
ORDER BY Total_Orders DESC;

-- 13. Show the most reviewed products
SELECT Product.Name, COUNT(Review.Review_Number) AS Review_Count
FROM Review
JOIN Product ON Review.Product_ID = Product.Product_ID
GROUP BY Product.Product_ID
ORDER BY Review_Count DESC
LIMIT 5;

-- 14. List customers who have spent more than $500 but are not in the Gold tier
SELECT First_Name, Last_Name, Total_Spending, Tier
FROM Customer
WHERE Total_Spending > 500 AND Tier != 'Gold'
ORDER BY Total_Spending DESC;

-- 15. Find all orders that include a specific product
SELECT Orders.Order_ID, Orders.O_Date, Customer.First_Name, Customer.Last_Name
FROM Order_Details
JOIN Orders ON Order_Details.Order_ID = Orders.Order_ID
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
JOIN Product ON Order_Details.Product_ID = Product.Product_ID
WHERE Product.Name = 'T-Shirt';