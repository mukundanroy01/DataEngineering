CREATE PROCEDURE Brazil_ECommerce_Tables
AS
BEGIN
	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Products')
	BEGIN

		CREATE TABLE Brazil_ECommerce_Products(
		Product_Id varchar(50),
		Product_Category varchar(50),
		Price float,
		Freight_Value float
		)
	END

	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Products
	END

	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Customers')
	BEGIN

		CREATE TABLE Brazil_ECommerce_Customers(
		Customer_Unique_Id varchar(50),
		Customer_Zip_Code varchar(50),
		Customer_City varchar(50),
		Customer_State varchar(20)
		)
	END

	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Customers
	END

	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Sellers')
	BEGIN
		CREATE TABLE Brazil_ECommerce_Sellers(
		Seller_Id varchar(50),
		Seller_Zip_Code varchar(50),
		Seller_City varchar(50),
		Seller_State varchar(50)
		)
	END

	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Sellers
	END

	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Reviews')
	BEGIN
		CREATE TABLE Brazil_ECommerce_Reviews(
		Review_Id varchar(50),
		Review_Score int
		)
	END

	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Reviews
	END

	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Orders')
	BEGIN
		CREATE TABLE Brazil_ECommerce_Orders(
		Order_Id varchar(50),
		Order_Status varchar(50),
		Product_Id varchar(50),
		Order_Item_Quantity int,
		Customer_Unique_Id varchar(50),
		Seller_Id varchar(50),
		Total_Payment float,
		Review_Id varchar(50),
		Order_Purchased_Dates date,
		Order_Estimated_Delivery_Dates date,
		Order_Delivered_Customer_Dates date
		)
	END
	
	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Orders
	END

	IF NOT EXISTS(SELECT name FROM sys.tables where name = 'Brazil_ECommerce_Orders_Agg')
	BEGIN
		CREATE TABLE Brazil_ECommerce_Orders_Agg(
		Order_Id varchar(50) ,
		Customer_Unique_Id varchar(50),
		Seller_Id varchar(50),
		Order_Delivery_Delay_Days int,
		Order_Life_Days int,
		Delay_in_Delivery varchar(10),
		Review_Score int
		)
	END

	ELSE
	BEGIN
		DELETE FROM Brazil_ECommerce_Orders_Agg
	END
END
