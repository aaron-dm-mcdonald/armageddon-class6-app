CREATE DATABASE user_db;

USE user_db;

-- Creating the country table
CREATE TABLE country (
    country_name VARCHAR(255) PRIMARY KEY,
    url VARCHAR(255) NOT NULL
);

-- Example data for country table
INSERT INTO country (country_name, url) VALUES
('thailand', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/thai-bad-4.jpg'),
('colombia', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/colombiana.jpg'),
('vietnam', 'https://www.instagram.com/p/DCquPAizq03/?utm_source=ig_web_copy_link'),
('poland', 'https://test-124655869758685.s3.us-east-1.amazonaws.com/polish.png');

-- Creating the user table
CREATE TABLE user (
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

-- Example data for user table
INSERT INTO user (username, password) VALUES
('admin', 'admin'),
('test-user-1', 'test'),
('test-user-2', 'test');
