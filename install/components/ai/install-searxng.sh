#!/bin/bash

# SearXNG installation script

set -e

echo "Installing SearXNG..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for SearXNG
mkdir -p /opt/ai/searxng
cd /opt/ai/searxng

# Create docker-compose file for SearXNG
cat > docker-compose.yml << EOF
version: '3.7'

services:
  searxng:
    image: searxng/searxng:latest
    container_name: searxng
    ports:
      - "8088:8080"
    volumes:
      - ./searxng:/etc/searxng:rw
    environment:
      - SEARXNG_BASE_URL=https://localhost/searx/
    restart: unless-stopped
EOF

# Create searxng directory
mkdir -p searxng

# Create log entry
echo "$(date): SearXNG installed" >> /var/log/ai-install/install.log

echo "SearXNG installation completed!"
echo "To start SearXNG, navigate to /opt/ai/searxng and run:"
echo "docker-compose up -d"
echo "SearXNG will be available at http://localhost:8088"