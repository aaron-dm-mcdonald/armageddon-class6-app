#!/bin/bash

# Startup script for bastion host/initialization of RDS DB Instance

# Update and install required dependencies
sudo dnf update -y
sudo dnf install -y mariadb105
sudo yum -y install telnet

# Ensure working directory and grab SQL initialization script
cd /home/ec2-user
curl -O https://raw.githubusercontent.com/aaron-dm-mcdonald/armageddon-class6-app/refs/heads/main/init.sql

# Create the .env file with database credentials (replace with actual values)
cat <<EOF > ./.env
DB_HOST=${db_host}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
EOF

# Load the env variables from the .env file
source .env

# Log in and initialize the database (using the mysql command directly with init.sql)
sudo mysql -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD < init.sql
