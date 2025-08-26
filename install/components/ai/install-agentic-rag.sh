#!/bin/bash

# Agentic RAG installation script

set -e

echo "Installing Agentic RAG..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for Agentic RAG
mkdir -p /opt/ai/agentic-rag
cd /opt/ai/agentic-rag

# Clone the Agentic RAG repository
git clone https://github.com/jiangxinke/Agentic-RAG-R1.git .

# Create docker-compose file for Agentic RAG
cat > docker-compose.yml << EOF
version: '3.8'

services:
  agentic-rag:
    build: .
    container_name: agentic-rag
    ports:
      - "8000:8000"
    environment:
      - PYTHONPATH=/app
    volumes:
      - ./app:/app
    restart: unless-stopped
EOF

# Create log entry
echo "$(date): Agentic RAG installed" >> /var/log/ai-install/install.log

echo "Agentic RAG installation completed!"
echo "To start Agentic RAG, navigate to /opt/ai/agentic-rag and run:"
echo "docker-compose up -d"
echo "Agentic RAG will be available at http://localhost:8000"