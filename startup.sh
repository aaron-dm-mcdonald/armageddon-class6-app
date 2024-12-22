#!/bin/bash

# Update and install required dependencies
sudo yum update -y
sudo yum install -y git python3 python3-pip
sudo dnf install -y mariadb105 

# Clone the repository containing the app
cd /home/ec2-user
sudo git clone https://github.com/aaron-dm-mcdonald/armageddon-class6-app.git flask-app
cd flask-app



# Set environment variables for database connection
export DB_HOST=database-1.cdw6y4mqq875.ap-northeast-1.rds.amazonaws.com
export DB_USER=admin
export DB_PASSWORD=password

# Log in and initialize the database (using the mysql command directly with init.sql)
mysql -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD $DB_NAME < init.sql

# Move into app directory 
cd src/

# Install the required Python packages
sudo pip3 install -r requirements.txt

# Run the Flask app with sudo and preserve environment variables
sudo -E python3 app.py &
