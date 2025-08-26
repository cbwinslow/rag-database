#!/bin/bash

# Redis installation script

set -e

echo "Installing Redis..."

# Install Redis
apt install -y redis-server

# Start and enable Redis
systemctl start redis
systemctl enable redis

# Create log entry
echo "$(date): Redis installed" >> /var/log/database-install/install.log

echo "Redis installation completed!"
echo "Redis is running on port 6379"