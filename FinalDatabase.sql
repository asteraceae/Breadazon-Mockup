DROP TABLE IF EXISTS OrderLine_T;
DROP TABLE IF EXISTS Payment_T;
DROP TABLE IF EXISTS Order_T;
DROP TABLE IF EXISTS Product_T;
DROP TABLE IF EXISTS User_T;
DROP TABLE IF EXISTS Employee_T;
DROP TABLE IF EXISTS Bakery_T;



CREATE TABLE Bakery_T
(bakery_ID NUMERIC(6,0) NOT NULL, address VARCHAR(60),city VARCHAR(30),state VARCHAR(30),zipcode NUMERIC(5,0),bakery_name VARCHAR(30),
CONSTRAINT Bakery_PK PRIMARY KEY(bakery_ID));

CREATE TABLE Product_T
(product_ID NUMERIC(11,0) NOT NULL, bakery_ID NUMERIC(6,0) NOT NULL, batch_date VARCHAR(30), product_name VARCHAR(30),category VARCHAR(30),image_file VARCHAR(60),sell_by_date VARCHAR(30),price DECIMAL(5,2),description VARCHAR(60),
CONSTRAINT Product_PK PRIMARY KEY(product_ID),
CONSTRAINT Product_FK FOREIGN Key(bakery_ID) REFERENCES Bakery_T(bakery_ID));
#add category and product image for each new product

CREATE TABLE User_T
(id int(10)NOT NULL, account_ID VARCHAR(99), address VARCHAR(60),city VARCHAR(30),state VARCHAR(30),zipcode NUMERIC(5,0),date_created VARCHAR(25), name VARCHAR(25), email VARCHAR(60), login VARCHAR(60), pass_word VARCHAR(60), phone_num VARCHAR(30),paid varchar(6) NOT NULL,
CONSTRAINT User_PK PRIMARY KEY(id));

CREATE TABLE Employee_T
(employee_ID NUMERIC(11,0), name VARCHAR(30), address VARCHAR(60),city VARCHAR(30),state VARCHAR(30),zipcode NUMERIC(5,0),phone_num VARCHAR(30),
CONSTRAINT Employee_PK PRIMARY KEY(employee_ID));

CREATE TABLE Order_T
(order_ID NUMERIC(8,0) NOT NULL, id int(10)NOT NULL, time_submitted VARCHAR(25), delivery_address VARCHAR(60), delivery_city VARCHAR(60),delivery_state VARCHAR(30),delivery_zipcode NUMERIC(5,0), delivery_name VARCHAR(25),
CONSTRAINT Order_PK PRIMARY KEY(order_ID),
CONSTRAINT Order_FK FOREIGN KEY(id) REFERENCES User_T(id));



CREATE TABLE Payment_t
(payment_ID NUMERIC(7,0) NOT NULL,order_ID NUMERIC(8,0), payment_type VARCHAR(25), card_no VARCHAR(30), CVV VARCHAR(30),billing_address VARCHAR(60),billing_city VARCHAR(60),billing_state VARCHAR(30),billing_zipcode NUMERIC(5,0), amount NUMERIC, processing_status VARCHAR(25),
CONSTRAINT Payment_PK PRIMARY KEY(payment_ID),
CONSTRAINT Payment_FK1 FOREIGN KEY(order_ID) REFERENCES Order_T(order_ID));

CREATE TABLE OrderLine_T
(product_ID NUMERIC(11,0) NOT NULL,order_ID NUMERIC(8,0) NOT NULL,order_quantity NUMERIC,
CONSTRAINT OrderLine_PK PRIMARY KEY (product_ID, order_ID),
CONSTRAINT OrderLine_FK1 FOREIGN KEY (product_ID) REFERENCES Product_T(product_ID),
CONSTRAINT OrderLine_FK2 FOREIGN KEY (order_ID) REFERENCES Order_T(order_ID));

DELETE FROM Bakery_T;
DELETE FROM Product_T;
DELETE FROM User_T;
DELETE FROM Employee_T;
DELETE FROM Payment_T;
DELETE FROM Order_T;
DELETE FROM OrderLine_T;


INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100000,'1000 Big Street','Chicago','IL',60660,'Big Street Bake Inc');
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100001,'619 Clinton Drive','Dorchester','MA',02125,'Bakely Inc');
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100002,'8235 Fordham Street','Trumbull','CT',06611,'CheeseCakeFactory');
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100003,'82 Elmwood Drive','Millville','NJ',08332,'Sakai Bakely');

INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678901, 100000, '2021-12-1', 'Hot Dog','Sandwiches','Hot Dog.png', '2021-12-2','6.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678902, 100000, '2021-12-1', 'Tuna Sandwich','Sandwiches','Tuna Sandwich.png', '2021-12-2','3.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678903, 100000, '2021-12-1', 'CheeseSteak Sandwich','Sandwiches','CheeseSteak Sandwich.png', '2021-12-2','2.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678904, 100000, '2021-12-1', 'Chicken Sandwich','Sandwiches','Chicken Sandwich.png', '2021-12-2','4.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678905, 100000, '2021-12-1', 'Vegan Sandwich','Sandwiches','Vegan Sandwich.png', '2021-12-2','5.49','It is sooo gooood');

INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678906, 100001, '2021-12-1', 'Crusty French Baguette','Baguette','Crusty French Baguette.png', '2021-12-2','15.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678907, 100001, '2021-12-1', 'Plain Baguette','Baguette','Plain Baguette.png', '2021-12-2','20.99','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678908, 100001, '2021-12-1', 'Salted Baguette','Baguette','Salted Baguette.png', '2021-12-2','25.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678909, 100001, '2021-12-1', 'Spicy Baguette','Baguette','Spicy Baguette.png', '2021-12-2','30.49','It is sooo gooood');

INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678910, 100002, '2021-12-1', 'Chocolate Donuts','Donuts','Chocolate Donuts.png', '2021-12-2','14.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678911, 100002, '2021-12-1', 'Sugar Donuts','Donuts','Sugar Donuts.png', '2021-12-2','12.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678912, 100002, '2021-12-1', 'Candy Donuts','Donuts','Candy Donuts.png', '2021-12-2','30.49','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678913, 100002, '2021-12-1', 'Szechuan Donuts','Donuts','Szechuan Donuts.png', '2021-12-2','22.49','It is sooo gooood');

INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678914, 100003, '2021-12-1', 'Birthday Cake','Cake','Birthday Cake.png', '2021-12-2','40.00','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678915, 100003, '2021-12-1', 'Plain Cake','Cake','Plain Cake.png', '2021-12-2','30.00','It is sooo gooood');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name,category,image_file, sell_by_date, price,description)
VALUES (12345678916, 100003, '2021-12-1', 'Cheese Cake','Cake','Cheese Cake.png', '2021-12-2','30.00','It is sooo gooood');

INSERT INTO user_t (id, account_ID, address,city,state,zipcode,date_created , name, email, login, pass_word, phone_num)
VALUES (7777777777,'AdminAccount','1280 Lake Ave','Chicago','IL',60060,'2021-12-1','Zihan Zheng','zzheng1@luc.edu','zzheng1','password','800-820-8820');
INSERT INTO user_t (id, account_ID, address,city,state,zipcode,date_created , name, email, login, pass_word, phone_num)
VALUES (1000000001,'Non-PrimaryAcc0001','1335 Granville Ave','IL','Chicago',60060,'2021-12-1','Fake Name','fakeass@gmail.com','Faker','99999999999','820-890-1120');
INSERT INTO user_t (id, account_ID, address,city,state,zipcode,date_created , name, email, login, pass_word, phone_num)
VALUES (1000000002,'AdminAccout','1280 Lake Ave','Chicago','IL',60060,'2021-12-1','Zihan Zheng','zzheng1@luc.edu','zzheng1','password','800-820-8820');
#I am not sure if we need account_ID here.

INSERT INTO employee_t (employee_ID, name, address,city,state,zipcode,phone_num)
VALUES (11111111111,'Zihan Zheng','1280 Lake Ave','Chicago','IL',60060,'800-820-8820');
INSERT INTO employee_t (employee_ID, name, address,city,state,zipcode,phone_num)
VALUES (11111111112,'Daisy Reyes','37 Helen St','Mentor','OH',44060,'859-139-3333');
INSERT INTO employee_t (employee_ID, name, address,city,state,zipcode,phone_num)
VALUES (11111111113,'Alvin Avic','8 Ridge St','La Porte','IN',46350,'400-882-3823');


INSERT INTO order_t (order_ID,id,time_submitted, delivery_address, delivery_city,delivery_state,delivery_zipcode, delivery_name)
VALUES(20000001,2222222222,'2021-12-1','1335 Granville Ave','Chicago','IL',60060,'Faker Lee');
INSERT INTO order_t (order_ID,id,time_submitted, delivery_address, delivery_city,delivery_state,delivery_zipcode, delivery_name)
VALUES(20000002,8888888888,'2021-12-1','1335 Granville Ave','Chicago','IL',60060,'Faker Lee');


INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678902,20000001,2);
INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678903,20000001,2);
INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678903,20000002,3);

INSERT INTO payment_t (payment_ID, order_ID, payment_type, card_no, CVV, billing_address, billing_city,billing_state, billing_zipcode, amount, processing_status)
VALUES(5555551,20000001,'credit card','','','1335 Granville Ave','Chicago','IL',60060,'65.99','succeed');
INSERT INTO payment_t (payment_ID, order_ID, payment_type, card_no, CVV, billing_address, billing_city,billing_state, billing_zipcode, amount, processing_status)
VALUES(5555552,20000002,'credit card','','','1335 Granville Ave','Chicago','IL',60060,'122.99','denied');
