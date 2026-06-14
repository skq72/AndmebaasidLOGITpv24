Create database Vebipood;
Use Vebipood;

CREATE TABLE categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(50) NOT NULL
);

SELECT * FROM categories;

CREATE TABLE brands (
    brand_id INT PRIMARY KEY IDENTITY(1,1),
    brand_name VARCHAR(50) NOT NULL
);

SELECT * FROM brands;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(10)
);

SELECT * FROM customers;

CREATE TABLE stores (
    store_id INT PRIMARY KEY IDENTITY(1,1),
    store_name VARCHAR(100) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(10)
);

SELECT * FROM stores;

CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year INT NOT NULL,
    list_price DECIMAL(7, 2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

SELECT * FROM products;

CREATE TABLE staffs (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active INT NOT NULL,
    store_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (manager_id) REFERENCES staffs(staff_id)
);

SELECT * FROM staffs;

CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_status INT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

SELECT * FROM orders;

CREATE TABLE order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(7, 2) NOT NULL,
    discount DECIMAL(4, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT * FROM order_items;

CREATE TABLE stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT * FROM stocks;

INSERT INTO categories (category_name) VALUES ('Rattad'), ('Riided'), ('Tarvikud');
INSERT INTO brands (brand_name) VALUES ('Trek'), ('Electra'), ('Shimano');

INSERT INTO customers (first_name, last_name, email, city) 
VALUES ('Mari', 'Tamm', 'mari.tamm@example.com', 'Tallinn'),
       ('Jaan', 'Kask', 'jaan.kask@example.com', 'Tartu');

INSERT INTO stores (store_name, city) 
VALUES ('Tallinna Kesklinna Pood', 'Tallinn'),
       ('Tartu Lõunakeskuse Pood', 'Tartu');

INSERT INTO products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('Särk', 1, 2, 2026, 25.20),
       ('Maastikuratas X1', 1, 1, 2026, 899.99),
       ('Kiiver Pro', 3, 3, 2025, 45.00);

INSERT INTO staffs (first_name, last_name, email, active, store_id, manager_id) 
VALUES ('Andres', 'Murd', 'andres@pood.ee', 1, 1, NULL);

INSERT INTO staffs (first_name, last_name, email, active, store_id, manager_id) 
VALUES ('Katrin', 'Liiv', 'katrin@pood.ee', 1, 1, 1);

INSERT INTO orders (customer_id, order_status, order_date, required_date, store_id, staff_id) 
VALUES (1, 4, '2026-06-01', '2026-06-05', 1, 2);

INSERT INTO order_items (order_id, item_id, product_id, quantity, list_price, discount) 
VALUES (1, 1, 1, 2, 25.20, 0.10),
       (1, 2, 3, 1, 45.00, 0.00);

INSERT INTO stocks (store_id, product_id, quantity) 
VALUES (1, 1, 15),
       (1, 2, 5),
       (2, 3, 50);

SELECT * FROM products;
SELECT * FROM order_items;
SELECT * FROM brands;
SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM staffs;
SELECT * FROM stocks;
SELECT * FROM stores;
