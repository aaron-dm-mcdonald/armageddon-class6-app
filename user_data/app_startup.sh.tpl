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
DB_HOST=${db_host}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
EOF

chmod 600 ./.env

# Load the env variables from the .env file
source ./.env

# Install the required Python packages
sudo pip3 install -r requirements.txt

# Run the Flask app with sudo and preserve environment variables
sudo -E python3 app.py &
