 Database Setup and Schema Design (E-commerce)

## Objective
This task focuses on learning to create databases, tables, and define relationships using SQL, along with understanding fundamental database design concepts.

## Domain Chosen
For this task, I've chosen an **E-commerce** domain. This domain allows for a clear illustration of common database entities and their relationships.

## Deliverables

### 1. ER Diagram (Conceptual Design)
Below is a conceptual representation of the Entity-Relationship Diagram (ERD) for the E-commerce database. In a real-world scenario, this would be generated using a tool like MySQL Workbench or pgAdmin.
![ER TASK1](https://github.com/user-attachments/assets/4a32a7f0-0c32-4412-9a98-7ff12caa9bdf)

**Entities and Key Attributes:**

* **Customers:**
    * `customer_id` (PK)
    * `first_name`
    * `last_name`
    * `email` (UNIQUE)
    * `phone_number`
    * `address`

* **Categories:**
    * `category_id` (PK)
    * `category_name` (UNIQUE)
    * `description`

* **Suppliers:**
    * `supplier_id` (PK)
    * `supplier_name`
    * `contact_person`
    * `phone_number`
    * `email` (UNIQUE)

* **Products:**
    * `product_id` (PK)
    * `product_name`
    * `description`
    * `price`
    * `stock_quantity`
    * `category_id` (FK to Categories)
    * `supplier_id` (FK to Suppliers)

* **Orders:**
    * `order_id` (PK)
    * `customer_id` (FK to Customers)
    * `order_date`
    * `total_amount`
    * `order_status`

* **Order_Items:** (Junction table for Many-to-Many between Orders and Products)
    * `order_item_id` (PK)
    * `order_id` (FK to Orders)
    * `product_id` (FK to Products)
    * `quantity`
    * `unit_price`
    * Unique constraint on (`order_id`, `product_id`)

**Relationships:**

* `Customers` **places** `Orders` (One-to-Many)
* `Orders` **contains** `Order_Items` (One-to-Many)
* `Products` **are part of** `Order_Items` (One-to-Many)
* `Products` **belong to** `Categories` (Many-to-One)
* `Products` **are supplied by** `Suppliers` (Many-to-One)

---

### 2. SQL Script to Create Schema
The `ecommerce_schema.sql` file in this repository contains the Data Definition Language (DDL) script to create the `E_commerce_DB` database and its tables, including primary keys, foreign keys, and other constraints. It also includes sample data insertion to demonstrate the schema in action.

**Key features of the SQL script:**
* **Database Creation:** `CREATE DATABASE E_commerce_DB;`
* **Table Definitions:** `CREATE TABLE` statements for all identified entities.
* **Primary Keys:** Defined using `PRIMARY KEY` constraint for unique identification of records.
* **Foreign Keys:** Defined using `FOREIGN KEY` constraints to establish relationships and ensure referential integrity. `ON UPDATE CASCADE` and `ON DELETE RESTRICT/CASCADE` rules are applied appropriately.
* **Other Constraints:** `NOT NULL`, `UNIQUE`, and `CHECK` constraints are used to enforce data integrity.
* **AUTO_INCREMENT:** Used for primary keys to automatically generate unique IDs.

You can execute this script in a MySQL environment (e.g., MySQL Workbench, command-line client) to set up the database.

---

## Key Concepts Demonstrated

* **DDL (Data Definition Language):** The commands used to define database schema (e.g., `CREATE TABLE`, `DROP DATABASE`).
* **Normalization:** The schema is designed with an eye towards normalization, reducing data redundancy and improving data integrity (e.g., separating categories and suppliers into their own tables).
* **ER Diagrams:** The conceptual design phase involved identifying entities, attributes, and relationships, which are the building blocks of an ER diagram.
* **Primary Keys:** Uniquely identifying records within a table.
* **Foreign Keys:** Establishing links between tables and enforcing referential integrity.
* **Constraints:** Rules applied to columns to ensure data accuracy and reliability.
* **AUTO_INCREMENT:** Automatic generation of unique identifiers for primary keys.
* **Composite Key:** The `UNIQUE (order_id, product_id)` constraint on `Order_Items` implicitly defines a composite key, ensuring a product isn't duplicated within a single order's items.

---

## How to Use
1.  Clone this repository: `git clone [Your-GitHub-Repo-Link]`
2.  Navigate to the cloned directory.
3.  Open `ecommerce_schema.sql` in your preferred MySQL client (e.g., MySQL Workbench, HeidiSQL, or a command-line interface).
4.  Execute the script. This will create the `E_commerce_DB` database and populate it with tables and some sample data.
