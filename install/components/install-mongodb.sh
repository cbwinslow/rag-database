#!/bin/bash

# MongoDB installation script

set -e

echo "Installing MongoDB..."

# Import MongoDB public GPG key
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | apt-key add -

# Add MongoDB repository
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Update package list
apt update

# Install MongoDB
apt install -y mongodb-org

# Start and enable MongoDB
systemctl start mongod
systemctl enable mongod

# Create log entry
echo "$(date): MongoDB installed" >> /var/log/database-install/install.log

echo "MongoDB installation completed!"
echo "MongoDB is running on port 27017"