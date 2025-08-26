#!/bin/bash

# InfluxDB installation script

set -e

echo "Installing InfluxDB..."

# Add InfluxDB repository
wget -qO- https://repos.influxdata.com/influxdata-archive_compat.key | apt-key add -
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/influxdb.list

# Update package list
apt update

# Install InfluxDB
apt install -y influxdb

# Start and enable InfluxDB
systemctl start influxdb
systemctl enable influxdb

# Create log entry
echo "$(date): InfluxDB installed" >> /var/log/database-install/install.log

echo "InfluxDB installation completed!"
echo "InfluxDB is running on port 8086"
echo "Access the web UI at http://localhost:8086"