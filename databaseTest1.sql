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
(product_ID NUMERIC(11,0) NOT NULL, bakery_ID NUMERIC(6,0) NOT NULL, batch_date VARCHAR(30), product_name VARCHAR(30), sell_by_date VARCHAR(30),
CONSTRAINT Product_PK PRIMARY KEY(product_ID),
CONSTRAINT Product_FK FOREIGN Key(bakery_ID) REFERENCES Bakery_T(bakery_ID));

CREATE TABLE User_T
(user_ID NUMERIC(10,0), account_ID VARCHAR(99), address VARCHAR(60),city VARCHAR(30),state VARCHAR(30),zipcode NUMERIC(5,0),date_created VARCHAR(25), name VARCHAR(25), email VARCHAR(60), login VARCHAR(60), pass_word VARCHAR(60), phone_num VARCHAR(30),
CONSTRAINT User_PK PRIMARY KEY(user_ID));

CREATE TABLE Employee_T
(employee_ID NUMERIC(11,0), name VARCHAR(30), address VARCHAR(60),city VARCHAR(30),state VARCHAR(30),zipcode NUMERIC(5,0),phone_num VARCHAR(30),
CONSTRAINT Employee_PK PRIMARY KEY(employee_ID));

CREATE TABLE Order_T
(order_ID NUMERIC(8,0) NOT NULL,time_submitted VARCHAR(25), delivery_address VARCHAR(60), delivery_city VARCHAR(60),delivery_state VARCHAR(30),delivery_zipcode NUMERIC(5,0), delivery_name VARCHAR(25), CONSTRAINT Order_PK PRIMARY KEY(order_ID));

CREATE TABLE Payment_t
(payment_ID NUMERIC(7,0) NOT NULL,order_ID NUMERIC(8,0), payment_type VARCHAR(25), billing_address VARCHAR(60),billing_city VARCHAR(60),billing_state VARCHAR(30),billing_zipcode NUMERIC(5,0), amount NUMERIC, processing_status VARCHAR(25),
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
VALUES (100000,'1000 Big Street','Chicago','IL',60660,'Plain Bread');
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100001,'1000 Big Street','Chicago','IL',60660,'Hot Dog'); 
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100003,'1000 Big Street','Chicago','IL',60660,'Cheese Cake');
INSERT INTO bakery_t (bakery_ID, address,city,state,zipcode,bakery_name)
VALUES (100004,'1000 Big Street','Chicago','IL',60660,'Plain Cake');

INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name, sell_by_date)
VALUES (12345678901, 100000, '2020-12-1', 'Plain Bread', '2021-12-2');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name, sell_by_date)
VALUES (12345678902, 100001, '2020-12-1', 'Hot Dog', '2021-12-2');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name, sell_by_date)
VALUES (12345678903, 100003, '2020-12-1', 'Cheese Cake', '2021-12-2');
INSERT INTO product_t (product_ID, bakery_ID, batch_date, product_name, sell_by_date)
VALUES (12345678904, 100004, '2020-12-1', 'Plain Cake', '2021-12-2');

INSERT INTO user_t (user_ID, account_ID, address,city,state,zipcode,date_created , name, email, login, pass_word, phone_num)
VALUES (7777777777,'AdminAccount','1280 Lake Ave','Chicago','IL',60060,'2021-12-1','Zihan Zheng','zzheng1@luc.edu','zzheng1','password','800-820-8820');
INSERT INTO user_t (user_ID, account_ID, address,city,state,zipcode,date_created , name, email, login, pass_word, phone_num)
VALUES (1000000001,'Non-PrimaryAcc0001','1335 Granville Ave','IL','Chicago',60060,'2021-12-1','Fake Name','fakeass@gmail.com','Faker','99999999999','820-890-1120');
#I am not sure if we need account_ID here.

INSERT INTO employee_t (employee_ID, name, address,city,state,zipcode,phone_num)
VALUES (11111111111,'Zihan Zheng','1280 Lake Ave','Chicago','IL',60060,'800-820-8820');

INSERT INTO order_t (order_ID,time_submitted, delivery_address, delivery_city,delivery_state,delivery_zipcode, delivery_name)
VALUES(20000001,'2021-12-1','1335 Granville Ave','Chicago','IL',60060,'Faker Lee');
INSERT INTO order_t (order_ID,time_submitted, delivery_address, delivery_city,delivery_state,delivery_zipcode, delivery_name)
VALUES(20000002,'2021-12-1','1335 Granville Ave','Chicago','IL',60060,'Faker Lee');


INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678902,20000001,2);
INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678903,20000001,2);
INSERT INTO orderline_t (product_ID,order_ID, order_quantity)
VALUES(12345678903,20000002,3);

INSERT INTO payment_t (payment_ID, order_ID, payment_type, billing_address, billing_city,billing_state, billing_zipcode, amount, processing_status)
VALUES(5555551,20000001,'credit card','1335 Granville Ave','Chicago','IL',60060,'65.99','succeed');
INSERT INTO payment_t (payment_ID, order_ID, payment_type, billing_address, billing_city,billing_state, billing_zipcode, amount, processing_status)
VALUES(5555552,20000002,'credit card','1335 Granville Ave','Chicago','IL',60060,'122.99','denied');












