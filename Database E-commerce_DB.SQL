-- Database: E-commerce_DB

-- Drop database if it exists to ensure a clean slate
DROP DATABASE IF EXISTS E_commerce_DB;

-- Create the E-commerce_DB database
CREATE DATABASE E_commerce_DB;

-- Use the newly created database
USE E_commerce_DB;

-- Table: Categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(255) UNIQUE
);

-- Table: Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_supplier
        FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address TEXT
);

-- Table: Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Table: Order_Items
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_order
        FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE, -- If an order is deleted, its items should also be deleted
    CONSTRAINT fk_product
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    UNIQUE (order_id, product_id) -- Ensures a product appears only once per order item
);

-- Optional: Insert some sample data to test the schema
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Gadgets and electronic devices'),
('Books', 'Fiction and non-fiction books'),
('Apparel', 'Clothing and accessories');

INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email) VALUES
('TechGadgets Inc.', 'Alice Smith', '123-456-7890', 'alice@techgadgets.com'),
('Bookworm Publishers', 'Bob Johnson', '987-654-3210', 'bob@bookworm.com');

INSERT INTO Products (product_name, description, price, stock_quantity, category_id, supplier_id) VALUES
('Laptop Pro X', 'Powerful laptop for professionals', 1200.00, 50, 1, 1),
('The Great Novel', 'A captivating read', 25.00, 200, 2, 2),
('Smartphone Z', 'Latest model smartphone', 800.00, 150, 1, 1);

INSERT INTO Customers (first_name, last_name, email, phone_number, address) VALUES
('John', 'Doe', 'john.doe@example.com', '555-123-4567', '123 Main St, Anytown'),
('Jane', 'Smith', 'jane.smith@example.com', '555-987-6543', '456 Oak Ave, Somewhere');

INSERT INTO Orders (customer_id, total_amount, order_status) VALUES
(1, 1225.00, 'Delivered'),
(2, 800.00, 'Processing');

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 25.00),
(2, 3, 1, 800.00);