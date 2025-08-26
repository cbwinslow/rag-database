#!/bin/bash

# LocalAI installation script

set -e

echo "Installing LocalAI..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for LocalAI
mkdir -p /opt/ai/localai
cd /opt/ai/localai

# Create docker-compose file for LocalAI
cat > docker-compose.yml << EOF
version: '3.6'

services:
  api:
    image: localai/localai:latest
    container_name: localai
    ports:
      - "8080:8080"
    environment:
      - MODELS_PATH=/models
      - DEBUG=true
    volumes:
      - ./models:/models
      - ./config:/config
    restart: unless-stopped
EOF

# Create models directory
mkdir -p models

# Create config directory
mkdir -p config

# Create log entry
echo "$(date): LocalAI installed" >> /var/log/ai-install/install.log

echo "LocalAI installation completed!"
echo "To start LocalAI, navigate to /opt/ai/localai and run:"
echo "docker-compose up -d"
echo "LocalAI will be available at http://localhost:8080"