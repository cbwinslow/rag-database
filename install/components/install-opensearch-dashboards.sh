#!/bin/bash

# OpenSearch Dashboards installation script

set -e

echo "Installing OpenSearch Dashboards..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for OpenSearch Dashboards
mkdir -p /opt/monitoring/opensearch-dashboards
cd /opt/monitoring/opensearch-dashboards

# Create docker-compose file for OpenSearch Dashboards
cat > docker-compose.yml << EOF
version: '3'
services:
  opensearch-dashboards:
    image: opensearchproject/opensearch-dashboards:2.11.0
    container_name: opensearch-dashboards
    ports:
      - "5601:5601"
    environment:
      OPENSEARCH_HOSTS: '["http://opensearch-node1:9200"]'
      DISABLE_SECURITY_DASHBOARDS_PLUGIN: "true"
    networks:
      - opensearch-net
    depends_on:
      - opensearch-node1

networks:
  opensearch-net:
    external: true
EOF

# Create log entry
echo "$(date): OpenSearch Dashboards installed" >> /var/log/monitoring-install/install.log

echo "OpenSearch Dashboards installation completed!"
echo "To start OpenSearch Dashboards, navigate to /opt/monitoring/opensearch-dashboards and run:"
echo "docker-compose up -d"
echo "OpenSearch Dashboards will be available at http://localhost:5601"