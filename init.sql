-- Step 1: Create a new database called 'user_db'.
-- A database is like a container that holds related tables.
CREATE DATABASE user_db;

-- Step 2: Switch to the 'user_db' database.
-- This tells the system that all subsequent operations will happen within this database.
USE user_db;

-- Step 3: Create a table named 'country'.
-- A table is a collection of related data organized in rows and columns.
-- Each column in the table is defined with a name and a data type.

-- The 'country' table has two columns:
-- 1. 'country_name' (Primary Key): A unique identifier for each row. No two countries can have the same name.
--    Data type: VARCHAR(255) - A variable-length text field that can hold up to 255 characters.
-- 2. 'url': A mandatory (NOT NULL) column that stores a URL (web address) associated with the country.
CREATE TABLE country (
    country_name VARCHAR(255) PRIMARY KEY, -- Primary Key ensures unique values for 'country_name'.
    url VARCHAR(255) NOT NULL              -- NOT NULL means this column cannot be left empty.
);

-- Step 4: Insert example data into the 'country' table.
-- The INSERT INTO statement adds rows to the table.
-- Each row represents a country and its associated URL.
INSERT INTO country (country_name, url) VALUES
('thailand', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/thai-bad-4.jpg'), -- Row 1: Thailand and its image URL.
('colombia', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/colombiana.jpg'), -- Row 2: Colombia and its image URL.
('vietnam', 'https://www.instagram.com/p/DCquPAizq03/?utm_source=ig_web_copy_link'),    -- Row 3: Vietnam and its Instagram link.
('lizzo', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcROVRD-SbhXKBjYx0uJhAGYMFBTBLKqmKQQo3A4XFxG-wM5AgxEKMM5AMMuFoRHNXqYYxCdtAahQj9kPXE9jd4d0w'), -- Row 4: Lizzo and her image URL.
('poland', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/polish.png');       -- Row 5: Poland and its image URL.

-- Step 5: Create a table named 'user'.
-- This table stores information about users who can access the application.

-- The 'user' table has two columns:
-- 1. 'username' (Primary Key): A unique identifier for each user.
--    Data type: VARCHAR(255) - A variable-length text field that can hold up to 255 characters.
-- 2. 'password': A mandatory (NOT NULL) column that stores the password for the user.
CREATE TABLE user (
    username VARCHAR(255) PRIMARY KEY, -- Primary Key ensures unique usernames.
    password VARCHAR(255) NOT NULL    -- NOT NULL means this column cannot be left empty.
);

-- Step 6: Insert example data into the 'user' table.
-- Each row represents a user with their username and password.
INSERT INTO user (username, password) VALUES
('admin', 'admin'),          -- Row 1: Admin user with a default password.
('test-user-1', 'test'),     -- Row 2: Test user 1 with a password 'test'.
('test-user-2', 'test');     -- Row 3: Test user 2 with a password 'test'.

-- At this point, the database 'user_db' contains two tables:
-- 1. 'country' - storing country names and their associated URLs.
-- 2. 'user' - storing usernames and their passwords.

-- Install MySQL CLI on AL 2023:
-- sudo dnf update -y
-- sudo dnf install -y mariadb105 

-- To connect to DB:
-- mysql -h <HOST> -u <USERNAME> -p
-- mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD


-- To select database, use this query:
-- USE user_db;

-- To delete the database, use this query:
-- DROP DATABASE user_db;

-- To view the contents of these tables, use the following queries:
-- View all rows in the 'country' table:
-- SELECT * FROM country;

-- View all rows in the 'user' table:
-- SELECT * FROM user;


-- Change a column value in a specific row after data is inserted:
-- UPDATE user SET password = 'test1' WHERE username = 'test-user-1';
