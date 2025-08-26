#!/bin/bash

# OpenWebUI installation script

set -e

echo "Installing OpenWebUI..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for OpenWebUI
mkdir -p /opt/ai/openwebui
cd /opt/ai/openwebui

# Create docker-compose file for OpenWebUI
cat > docker-compose.yml << EOF
version: '3.8'

services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3001:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    volumes:
      - ./data:/app/data
    depends_on:
      - ollama
    restart: unless-stopped

  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ./ollama:/root/.ollama
    restart: unless-stopped
EOF

# Create data directory
mkdir -p data

# Create ollama directory
mkdir -p ollama

# Create log entry
echo "$(date): OpenWebUI installed" >> /var/log/ai-install/install.log

echo "OpenWebUI installation completed!"
echo "To start OpenWebUI, navigate to /opt/ai/openwebui and run:"
echo "docker-compose up -d"
echo "OpenWebUI will be available at http://localhost:3001"