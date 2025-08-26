#!/bin/bash

# Neo4j installation script

set -e

echo "Installing Neo4j..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for Neo4j
mkdir -p /opt/databases/neo4j
cd /opt/databases/neo4j

# Create docker-compose file for Neo4j
cat > docker-compose.yml << EOF
version: '3.8'

services:
  neo4j:
    image: neo4j:5.12-community
    container_name: neo4j
    ports:
      - "7474:7474"
      - "7687:7687"
    environment:
      - NEO4J_AUTH=neo4j/password
      - NEO4J_PLUGINS=["apoc"]
    volumes:
      - ./data:/data
      - ./logs:/logs
    restart: unless-stopped
EOF

# Create data directory
mkdir -p data

# Create logs directory
mkdir -p logs

# Create log entry
echo "$(date): Neo4j installed" >> /var/log/database-install/install.log

echo "Neo4j installation completed!"
echo "To start Neo4j, navigate to /opt/databases/neo4j and run:"
echo "docker-compose up -d"
echo "Neo4j will be available at http://localhost:7474"
echo "Default credentials: neo4j/password"