#!/bin/bash

# Update and install required dependencies
sudo yum update -y
sudo yum install -y git python3 python3-pip
sudo dnf install mariadb105

# Clone the repository containing the app
cd /home/ec2-user
sudo git clone https://github.com/yourusername/your-repo.git flask-app
cd flask-app

# Install the required Python packages
sudo pip3 install -r requirements.txt

# Set environment variables for database connection
export DB_HOST=your-rds-endpoint
export DB_USER=your-db-username
export DB_PASSWORD=your-db-password


# Run the Flask app with sudo and preserve environment variables
sudo -E python3 app.py &
