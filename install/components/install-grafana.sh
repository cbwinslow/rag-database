#!/bin/bash

# Grafana installation script

set -e

echo "Installing Grafana..."

# Check if Docker is installed
if command -v docker &> /dev/null
then
    echo "Installing Grafana with Docker..."
    
    # Create directory for Grafana
    mkdir -p /opt/monitoring/grafana
    cd /opt/monitoring/grafana
    
    # Create docker-compose file for Grafana
    cat > docker-compose.yml << EOF
version: '3.8'

services:
  grafana:
    image: grafana/grafana-enterprise
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - ./data:/var/lib/grafana
    restart: unless-stopped
    depends_on:
      - prometheus

volumes:
  data:
EOF

    # Create log entry
    echo "$(date): Grafana installed with Docker" >> /var/log/monitoring-install/install.log

    echo "Grafana installation completed!"
    echo "To start Grafana, navigate to /opt/monitoring/grafana and run:"
    echo "docker-compose up -d"
    echo "Grafana will be available at http://localhost:3000"
    echo "Default credentials: admin/admin"
else
    # Add Grafana repository
    wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list

    # Update package list
    apt update

    # Install Grafana
    apt install -y grafana

    # Start and enable Grafana
    systemctl start grafana-server
    systemctl enable grafana-server

    # Create log entry
    echo "$(date): Grafana installed" >> /var/log/monitoring-install/install.log

    echo "Grafana installation completed!"
    echo "Grafana is running on port 3000"
    echo "Default credentials: admin/admin"
    echo "Access the web UI at http://localhost:3000"
fi