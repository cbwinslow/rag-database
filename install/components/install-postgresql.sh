#!/bin/bash

# PostgreSQL installation script with PostGIS and pgvector extensions

set -e

echo "Installing PostgreSQL with PostGIS and pgvector..."

# Add PostgreSQL official repository
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Update package list
apt update

# Install PostgreSQL and extensions
apt install -y \
  postgresql-16 \
  postgresql-client-16 \
  postgresql-contrib-16 \
  postgresql-16-postgis-3 \
  postgresql-16-postgis-3-scripts \
  postgresql-server-dev-16

# Start and enable PostgreSQL
systemctl start postgresql
systemctl enable postgresql

# Install pgvector from source
sudo -u postgres git clone --branch v0.5.0 https://github.com/pgvector/pgvector.git /tmp/pgvector
cd /tmp/pgvector
sudo -u postgres make
sudo -u postgres make install
cd /

# Clean up
rm -rf /tmp/pgvector

# Create a log entry
echo "$(date): PostgreSQL installed with PostGIS and pgvector" >> /var/log/database-install/install.log

echo "PostgreSQL installation completed!"
echo "PostgreSQL is running on port 5432"
echo "Default database: postgres"
echo "Default user: postgres (no password by default)"