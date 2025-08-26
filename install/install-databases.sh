#!/bin/bash

# Main database installation script
# This script installs all database components

set -e  # Exit on any error

echo "Starting database installation..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Update system packages
echo "Updating system packages..."
apt update && apt upgrade -y

# Install prerequisites
echo "Installing prerequisites..."
apt install -y \
  curl \
  wget \
  git \
  docker.io \
  docker-compose \
  gnupg \
  lsb-release \
  ca-certificates

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Create necessary directories
mkdir -p /opt/databases/{postgresql,supabase,weaviate,qdrant,influxdb,clickhouse,redis,mongodb}
mkdir -p /var/log/database-install

echo "Installing individual database components..."

# Install PostgreSQL with PostGIS and pgvector
echo "Installing PostgreSQL with PostGIS and pgvector..."
./components/install-postgresql.sh

# Install Supabase
echo "Installing Supabase..."
./components/install-supabase.sh

# Install Weaviate
echo "Installing Weaviate..."
./components/install-weaviate.sh

# Install Qdrant
echo "Installing Qdrant..."
./components/install-qdrant.sh

# Install InfluxDB
echo "Installing InfluxDB..."
./components/install-influxdb.sh

# Install ClickHouse
echo "Installing ClickHouse..."
./components/install-clickhouse.sh

# Install Redis
echo "Installing Redis..."
./components/install-redis.sh

# Install MongoDB
echo "Installing MongoDB..."
./components/install-mongodb.sh

echo "All database installations completed!"
echo "Check /var/log/database-install/ for installation logs."