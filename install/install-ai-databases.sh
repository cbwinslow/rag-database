#!/bin/bash

# Main AI-enhanced database installation script
# This script installs all database components and AI orchestration tools

set -e  # Exit on any error

echo "Starting AI-enhanced database installation..."

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
  python3 \
  python3-pip \
  gnupg \
  lsb-release \
  ca-certificates

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Create necessary directories
mkdir -p /opt/databases/{postgresql,supabase,weaviate,qdrant,influxdb,clickhouse,redis,mongodb,neo4j}
mkdir -p /opt/monitoring/{prometheus,grafana,opensearch,loki}
mkdir -p /opt/ai/{localai,openwebui,searxng,agentic-rag,orchestrator}
mkdir -p /opt/messaging/rabbitmq
mkdir -p /var/log/{database-install,monitoring-install,ai-install,messaging-install}

echo "Installing individual components..."

# Install databases
echo "Installing databases..."
./components/install-postgresql.sh
./components/install-supabase.sh
./components/install-weaviate.sh
./components/install-qdrant.sh
./components/install-influxdb.sh
./components/install-clickhouse.sh
./components/install-redis.sh
./components/install-mongodb.sh
./components/install-neo4j.sh

# Install monitoring components
echo "Installing monitoring components..."
./components/install-prometheus.sh
./components/install-grafana.sh
./components/install-opensearch.sh
./components/install-opensearch-dashboards.sh
./components/install-loki.sh

# Install messaging component
echo "Installing messaging component..."
./components/install-rabbitmq.sh

# Install AI components
echo "Installing AI components..."
./components/ai/install-localai.sh
./components/ai/install-openwebui.sh
./components/ai/install-searxng.sh
./components/ai/install-agentic-rag.sh
./components/ai/install-pydantic-ai.sh
./components/ai/install-ai-orchestrator.sh

echo "All installations completed!"
echo "Check /var/log/ for installation logs."