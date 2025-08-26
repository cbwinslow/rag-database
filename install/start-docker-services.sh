#!/bin/bash

# Script to start all Docker-based services

echo "Starting all Docker-based services..."

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed"
  exit 1
fi

if ! systemctl is-active --quiet docker; then
  echo "Starting Docker service..."
  systemctl start docker
fi

# Start Supabase
echo "Starting Supabase..."
cd /opt/databases/supabase/docker && docker-compose up -d

# Start Weaviate
echo "Starting Weaviate..."
cd /opt/databases/weaviate && docker-compose up -d

# Start Qdrant
echo "Starting Qdrant..."
cd /opt/databases/qdrant && docker-compose up -d

# Start OpenSearch
echo "Starting OpenSearch..."
cd /opt/monitoring/opensearch && docker-compose up -d

# Start Loki
echo "Starting Loki..."
cd /opt/monitoring/loki && docker-compose up -d

# Start Promtail
echo "Starting Promtail..."
cd /opt/monitoring/promtail && docker-compose up -d

echo "All Docker-based services started!"
echo "Use 'docker ps' to verify all containers are running."