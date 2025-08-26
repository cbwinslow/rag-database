#!/bin/bash

# ClickHouse installation script

set -e

echo "Installing ClickHouse..."

# Add ClickHouse repository
apt install -y apt-transport-https ca-certificates dirmngr
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4

echo "deb https://packages.clickhouse.com/deb stable main" > /etc/apt/sources.list.d/clickhouse.list

# Update package list
apt update

# Install ClickHouse server and client
apt install -y clickhouse-server clickhouse-client

# Start and enable ClickHouse
systemctl start clickhouse-server
systemctl enable clickhouse-server

# Create log entry
echo "$(date): ClickHouse installed" >> /var/log/database-install/install.log

echo "ClickHouse installation completed!"
echo "ClickHouse server is running on port 9000 (native) and 8123 (HTTP)"
echo "Default user: default (no password)"