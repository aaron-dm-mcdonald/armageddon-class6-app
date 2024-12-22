#!/bin/bash

# Update and install required dependencies
sudo yum update -y
sudo yum install -y git python3 python3-pip
sudo dnf install -y mariadb105 

# Clone the repository containing the app
cd /home/ec2-user
sudo git clone https://github.com/aaron-dm-mcdonald/armageddon-class6-app.git flask-app
cd flask-app

# Create the .env file with database credentials (replace with actual values)
cat <<EOF > src/.env
DB_HOST=database-1.cdw6y4mqq875.ap-northeast-1.rds.amazonaws.com
DB_USER=admin
DB_PASSWORD=password
DB_NAME=user_db
EOF

# Load the env variables from the .env file
source src/.env

# Log in and initialize the database (using the mysql command directly with init.sql)
mysql -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD < init.sql

# Move into app directory
cd src/

# Install the required Python packages
sudo pip3 install -r requirements.txt

# Run the Flask app with sudo and preserve environment variables
sudo -E python3 app.py &
