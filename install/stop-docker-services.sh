#!/bin/bash

# Script to stop all Docker-based services

echo "Stopping all Docker-based services..."

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed"
  exit 1
fi

# Stop Supabase
echo "Stopping Supabase..."
cd /opt/databases/supabase/docker && docker-compose down

# Stop Weaviate
echo "Stopping Weaviate..."
cd /opt/databases/weaviate && docker-compose down

# Stop Qdrant
echo "Stopping Qdrant..."
cd /opt/databases/qdrant && docker-compose down

# Stop OpenSearch
echo "Stopping OpenSearch..."
cd /opt/monitoring/opensearch && docker-compose down

# Stop Loki
echo "Stopping Loki..."
cd /opt/monitoring/loki && docker-compose down

# Stop Promtail
echo "Stopping Promtail..."
cd /opt/monitoring/promtail && docker-compose down

echo "All Docker-based services stopped!"