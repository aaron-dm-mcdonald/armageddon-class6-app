#!/bin/bash

# Update and install required dependencies
sudo yum update -y
sudo yum install -y git python3 python3-pip


# Clone the repository containing the app
cd /home/ec2-user
sudo git clone https://github.com/aaron-dm-mcdonald/armageddon-class6-app.git flask-app
cd flask-app/src

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

# Install the required Python packages
sudo pip3 install -r requirements.txt

# Run the Flask app with sudo and preserve environment variables
sudo -E python3 app.py &
