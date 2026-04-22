--Ülesanne 1

Create Database ÜL1;
USE ÜL1;
--Category (idCategory, Category_Name)
CREATE TABLE Category(
idCategory int PRIMARY KEY identity(1,1),
Category_Name varchar(15) not null)
SELECT * FROM Category;
INSERT INTO Category(Category_Name)
VALUES ('Test')
ALTER TABLE Category ADD CONSTRAINT  Category_Name UNIQUE (Category_Name);
INSERT INTO Category(Category_Name)
VALUES ('Koogiviljad')




--Kaup(kauba_kood,nimetus,liigi_kood,hind)
CREATE TABLE Product(
kauba_kood int PRIMARY KEY identity(1,1),
nimetus varchar(20) not null,
idCategory int, FOREIGN KEY (idCategory) REFERENCES Category(idCategory),
hind int not null,
)
SELECT * FROM Product;
--Täidame tabeli
INSERT INTO Product(nimetus,idCategory,hind)
VALUES ('Õun', 3, 4)

--Müük (müügi_kood, kauba_kood, ostja_kood, arv, kuupäev)
--Sale (idSale, idProduct, idCustomer, Count_pr, Date_of_sale)
CREATE TABLE Sale(
inSale int PRIMARY KEY identity(1,1),
idProduct int,
idCustomer int,
FOREIGN KEY (idProduct) REFERENCES Product(kauba_kood),
Count int,
Date_of_sale date)

SELECT * FROM Sale;
--TAbel CUSTOMER
CREATE TABLE Customer(
idCustomer int PRIMARY KEY identity(1,1),
Name varchar(100) not null,
Contact varchar(100))
ALTER table Sale ADD CONSTRAINT fkk_sale
FOREIGN KEY (idCustomer) REFERENCES Customer(idCustomer);


INSERT INTO Sale
VALUES(15,1,5,'2025-03-05')




SELECT * FROM Sale;
SELECT * FROM Product;
SELECT * FROM Category;
SELECT * FROM Customer;
