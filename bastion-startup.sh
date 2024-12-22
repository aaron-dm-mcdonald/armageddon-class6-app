#!/bin/bash

# Startup script for bastion host/initalization of RDS DB Instance

# Update and install required dependencies
sudo dnf update -y
sudo dnf install -y mariadb105 

# Ensure working directory and grab SQL initalization script 
cd /home/ec2-user
curl -O https://raw.githubusercontent.com/aaron-dm-mcdonald/armageddon-class6-app/refs/heads/main/init.sql

# Create the .env file with database credentials (replace with actual values)
cat <<EOF > ./.env
DB_HOST=database-1.cdw6y4mqq875.ap-northeast-1.rds.amazonaws.com
DB_USER=admin
DB_PASSWORD=password
DB_NAME=user_db
EOF

chmod 600 ./.env

# Load the env variables from the .env file
source ./.env

# Log in and initialize the database (using the mysql command directly with init.sql)
mysql -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD < init.sql