from flask import Flask, jsonify, request, render_template, render_template_string
from dotenv import load_dotenv
import requests
import pymysql
import os

app = Flask(__name__)



############### Database Config ###############

# Load environment variables from the .env file
load_dotenv()

# Retrieve environment variables
DB_HOST = os.getenv('DB_HOST')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_NAME = 'user_db'

# Connect to the database
def get_db_connection():
    return pymysql.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )

############### Routes ###############

# Route for the homepage
@app.route('/')
def homepage():
    return render_template('index.html')



############### Functions for EC2 Metadata ###############

# Function to get metadata
def get_metadata(path):
    url = f"http://169.254.169.254/latest/meta-data/{path}"
    response = requests.get(url, headers={"X-aws-ec2-metadata-token": get_metadata_token()})
    return response.text

# Get the IMDSv2 token
def get_metadata_token():
    url = "http://169.254.169.254/latest/api/token"
    headers = {"X-aws-ec2-metadata-token-ttl-seconds": "21600"}
    response = requests.put(url, headers=headers)
    return response.text


############### Endpoints for Metadata API ###############

# Route to fetch EC2 region
@app.route('/metadata/region', methods=['GET'])
def metadata_region():
    # Fetch the availability zone
    az = get_metadata("placement/availability-zone")
    # Region is the AZ name with the last character removed
    region = az[:-1]
    return jsonify({"region": region}), 200

# Route to fetch EC2 instance name
@app.route('/metadata/instance-name', methods=['GET'])
def metadata_instance_name():
    # Fetch the instance name from the EC2 instance metadata
    instance_name = get_metadata("tags/Name")
    return jsonify({"instance-name": instance_name}), 200



############### DB Endpoints ###############

# Route to authenticate user and return the URL for the selected country
@app.route('/auth', methods=['POST'])
def auth():
    # Get data from the request
    username = request.json.get('username')
    password = request.json.get('password')
    picture = request.json.get('picture')  # the country (e.g., 'colombia', 'poland', 'thai')

    if not username or not password or not picture:
        return jsonify({"error": "Missing required parameters"}), 400

    # Connect to the database
    conn = get_db_connection()
    cursor = conn.cursor()

    # Query to check if the username and password are valid
    cursor.execute("SELECT * FROM user WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()

    if not user:
        return jsonify({"error": "Invalid username or password"}), 401

    # Query to get the URL corresponding to the selected country
    cursor.execute("SELECT url FROM country WHERE country_name = %s", (picture,))
    country = cursor.fetchone()

    if not country:
        return jsonify({"error": "Invalid country selection"}), 400

    # If valid, return the URL for the country
    return jsonify({"url": country['url']})

############### Main ###############

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
