json payload:

{
    "username": "admin",
    "password": "password",
    "picture": "colombia"
}

curl -X POST http://<your-ec2-public-ip>/auth -H "Content-Type: application/json" -d '{
    "username": "admin",
    "password": "password",
    "picture": "colombia"
}'

-------------

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


-----------

SELECT * FROM user WHERE username = %s AND password = %s

SELECT url FROM country WHERE country_name = %s
