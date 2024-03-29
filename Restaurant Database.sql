--Here is Part 1 of the SQL I used to answer the questions/scenarios posted in the LinkedIn Learning course titled "SQL Code Challenges" by Scott Simpson.  

/*
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views and Tables, Converting Data Types, Updating Information
*/

--Obtain a list of customers, including their full name and e-mail address, for restaurant's 5 year anniversary. Order by customer last name. -- 

SELECT 
    LastName, FirstName, Email
FROM 
    restaurant.Customers
ORDER BY 
    LastName;



--Create a table that holds customer's ID and how many will be atending the 5 year anniversary event-- 

CREATE TABLE Attending_Customers
("CustomerID" INTEGER, "PartySize" INTEGER);


 
--Sort dishes by price from budget friendly to expensive -- 

SELECT *
FROM 
  Dishes
ORDER BY 
  Price;



--Output two different menus, 1: Appetizers and beverages, 2: All the items besides beverages, sort both tables by type of dish-- 

SELECT *
FROM 
    dishes
WHERE 
    Type = "Appetizer" 
    OR 
    Type = "Beverage"
ORDER BY 
    Type;

SELECT *
FROM 
    dishes
WHERE 
    Type <> "Beverage" 
ORDER BY 
    Type;


 
--Add information from loyalty program sign up card, to customer's table --

INSERT INTO customers 
    (FirstName, LastName,
    Email, Address,
    City,State,
    Phone, Birthday)
VALUES 
    ("Karina", "Jones", 
    "karinajones7794@gmail.com", "1234 Toodaloo Lane", 
    "Los Angeles", "CA", 
    "323-656-0987", "1994-06-06");


  
--Update Customers table with customer's new mailing address. 

UPDATE Customers 
SET 
    Address = "74 Pine St.", 
    City = "New York", 
    State = "NY"
WHERE 
    CustomerID = "26";


  
--Delete customer "Taylor Jenkins from FL" from restaurant's e-mail list. Confirm the correct customer was deleted --  

SELECT * FROM Customers 
WHERE 
    FirstName = "Taylor" 
    AND 
    LastName = "Jenkins";



--Now I am deleting them from the Customers table -- 

DELETE FROM 
    Customers 
WHERE 
    CustomerID = "4";


 
--With a customer's e-mail and party size, enter their party size and CustomerID in the Attending_Customers table -- 
--Here I am looking up the customer by their e-mail address in our Customers table, so I can obtain their unique CustomerID -- 

SELECT * 
FROM
    Customers 
WHERE 
    Email = "atapley2j@kinetecoinc.com";



--Now I am inserting that customer and their party size into the Attending_Customers table --

INSERT INTO Attending_Customers 
    (CustomerID, PartySize) 
 VALUES 
    ("92", "4");

--Here is something NEW I learned from this course, how to utilize sub-queries for efficiency! So I used a SELECT statement inside of the INSERT query -- 

INSERT INTO Attending_Customers 
    (CustomerID, PartySize) 
VALUES 
    ((SELECT CustomerID FROM Customers WHERE Email ="atapley2j@kinetecoinc.com"), "4");


  
--Look up a customer's reservation on June 14th 2020, party size of 4, Last Name sounds like "Stevenson", without knowing the exact spelling of their last name -- 
--Will need to JOIN 2 tables to get desired results -- 

SELECT * 
FROM 
    Reservations;

SELECT * 
FROM
    Customers;



--Here I joined the Customers and Reservations table, displayed the full name, party size and reservation date. Used the LIKE operator to get similar matches that 
--start with "Ste". Answer - Customer name: Paco Stephenson -- 

SELECT 
    Customers.LastName, 
    Customers.FirstName, 
    Reservations.PartySize, 
    Reservations.Date
FROM 
    Customers
JOIN 
    Reservations 
ON 
    Customers.CustomerID = Reservations.CustomerID
WHERE 
    Customers.LastName LIKE "Ste%"
ORDER BY 
    Date DESC;


 
--Create a reservation (Sam McAdams, July 14th 2020, 6 PM, 5 people) using the provided customer information (Email - smac@rouxacademy.com, 555-555-1212) -- 
--First, check if the customer is already in our database. We need to enter a Customer ID, party size and date in the reservations table -- 

SELECT * 
FROM 
    Customers
WHERE 
    Email = "smac@kinetecoinc.com";



--I found out the customer is not in our database, so I need to add them to our Customers table first. 

INSERT INTO Customers 
    (FirstName, LastName, Email, Phone)
VALUES 
    ("Sam", "McAdams", "smac@rouxacademy.com", "555-555-1212");



--Now I can add their reservation into the Reservations table. 
INSERT INTO Reservations 
    (CustomerID, Date, PartySize)
VALUES 
    ("102", "2020-07-14 18:00:00", "5");


  
--Create a to-go order by finding the customer, creating the order record, adding items to the order and finding the total cost of the order -- 
--First, I am trying to see if this customer already exists in our database. Answer: She does exist and her CustomerID = 70 -- 

SELECT *
FROM 
    Customers
WHERE 
    FirstName = "Loretta";



--Here, I am inserting the given information from the customer's to-go order into the Orders table. OrderID = 1001 -- 

INSERT INTO Orders 
    (OrderID, CustomerID, OrderDate)
VALUES 
    ("1001", "70", "2022-05-15 13:00:00");



--Next, I searched for the dish IDs for each dish she ordered. Answers: House salad = 7, Mini Cheeseburgers = 4. Smoothie = 20-- 

SELECT * 
FROM 
    Dishes
WHERE 
    Name = "House Salad" 
    OR 
    Name = "Mini Cheeseburgers" 
    OR 
    Name = "Tropical Blue Smoothie";



--Then, I am creating the order in the OrdersDishes table by inserting OrderID, DishIDs, and OrderDishesID (start @ 4022) for each item -- 


INSERT INTO OrdersDishes 
    (OrdersDishesID, OrderID, DishID) 
VALUES 
    ("4022", "1001", "7");
INSERT INTO OrdersDishes 
    (OrdersDishesID, OrderID, DishID) 
VALUES 
    ("4023", "1001", "4");
INSERT INTO OrdersDishes 
    (OrdersDishesID, OrderID, DishID) 
VALUES 
    ("4024", "1001", "20");

--Finally, I am pulling the customer's to-go order information from 5/15/2022 by JOINing four different tables and adding all the prices of her items together 
--for a total cost. Answer = $21.00 -- 

SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    Orders.OrderDate, 
    OrdersDishes.OrderID, 
    SUM(Dishes.Price) AS "Total Price"
FROM Customers 
JOIN Orders ON 
    Customers.CustomerID = Orders.CustomerID
JOIN OrdersDishes ON 
    OrdersDIshes.OrderID = Orders.OrderID
JOIN Dishes ON 
    Dishes.DishID = OrdersDishes.DishID
WHERE 
    FirstName = "Loretta" 
    AND   
    OrderDate LIKE "2022%";


  
--Set customer Cleo Goldwater's favorite dish to Quinoa Salmon Salad -- 

--First, I am looking for Cleo's unique CustomerID-- 

SELECT 
    CustomerID 
 FROM 
    Customers 
 WHERE 
    FirstName= "Cleo" 
    AND 
    LastName = "Goldwater"'



UPDATE 
    Customers 
SET 
    FavoriteDish = (SELECT DishID FROM Dishes WHERE Name = "Quinoa Salmon Salad")
WHERE 
    CustomerID = "42";



-- Lastly, I am checking my work by joining the Dishes and Customer tables to see Cleo Goldwater's new favorite dish.--

SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    Dishes.Name, 
    Customers.FavoriteDish
FROM  
    Customers
JOIN Dishes ON 
    Customers.FavoriteDish = Dishes.DishID
ORDER BY 
    Customers.FirstName;


  
--Generate a list of the five customers who have placed the most to-go orders. Include number of orders made, full name, e-mail, sort by number of orders (most to 
-- least). Answer: Top 5: Blythe, Luciano, Yves, Norby and Oralla -- 

SELECT 
    COUNT(Orders.OrderID) AS Total_Orders, 
    Customers.FirstName, 
    Customers.LastName, 
    Customers.Email
FROM 
    Orders
JOIN Customers ON 
    Orders.CustomerID = Customers.CustomerID
GROUP BY 
    Orders.CustomerID
ORDER BY 
    Total_Orders DESC
LIMIT 5;
