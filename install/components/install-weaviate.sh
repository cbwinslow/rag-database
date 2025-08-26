#!/bin/bash

# Weaviate installation script

set -e

echo "Installing Weaviate..."

# Create docker-compose file for Weaviate
cat > /opt/databases/weaviate/docker-compose.yml << EOF
---
version: '3.4'
services:
  weaviate:
    command:
    - --host
    - 0.0.0.0
    - --port
    - '8080'
    - --scheme
    - http
    image: semitechnologies/weaviate:1.24.3
    ports:
    - 8080:8080
    volumes:
    - /var/weaviate:/var/lib/weaviate
    restart: on-failure:0
    environment:
      QUERY_DEFAULTS_LIMIT: 25
      AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED: 'true'
      PERSISTENCE_DATA_PATH: '/var/lib/weaviate'
      DEFAULT_VECTORIZER_MODULE: 'none'
      ENABLE_MODULES: ''
      CLUSTER_HOSTNAME: 'node1'
EOF

# Create log entry
echo "$(date): Weaviate installed" >> /var/log/database-install/install.log

echo "Weaviate installation completed!"
echo "To start Weaviate, navigate to /opt/databases/weaviate and run:"
echo "docker-compose up -d"
echo "Weaviate will be available at http://localhost:8080"