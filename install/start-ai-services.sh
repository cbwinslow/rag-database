#!/bin/bash

# Script to start all AI-enhanced services

echo "Starting all AI-enhanced services..."

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed"
  exit 1
fi

if ! systemctl is-active --quiet docker; then
  echo "Starting Docker service..."
  systemctl start docker
fi

# Create a common network for all services
docker network create ai-stack-network 2>/dev/null || true

# Start databases
echo "Starting databases..."
cd /opt/databases/supabase/docker && docker-compose up -d
cd /opt/databases/weaviate && docker-compose up -d
cd /opt/databases/qdrant && docker-compose up -d
cd /opt/databases/neo4j && docker-compose up -d

# Start monitoring
echo "Starting monitoring services..."
cd /opt/monitoring/prometheus && docker-compose up -d
cd /opt/monitoring/opensearch && docker-compose up -d
cd /opt/monitoring/loki && docker-compose up -d

# Start messaging
echo "Starting messaging service..."
cd /opt/messaging/rabbitmq && docker-compose up -d

# Start AI components
echo "Starting AI components..."
cd /opt/ai/localai && docker-compose up -d
cd /opt/ai/openwebui && docker-compose up -d
cd /opt/ai/searxng && docker-compose up -d
cd /opt/ai/agentic-rag && docker-compose up -d
cd /opt/ai/orchestrator && docker-compose up -d

echo "All AI-enhanced services started!"
echo "Use 'docker ps' to verify all containers are running."