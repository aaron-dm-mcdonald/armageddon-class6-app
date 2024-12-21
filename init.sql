CREATE DATABASE user_db;

USE user_db;

-- Creating the country table
CREATE TABLE country (
    country_name VARCHAR(255) PRIMARY KEY,
    url VARCHAR(255) NOT NULL
);

-- Example data for country table
INSERT INTO country (country_name, url) VALUES
('thailand', 'URL-1'),
('colombia', 'URL-2'),
('poland', 'URL-3');

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