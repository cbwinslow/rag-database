#!/bin/bash

# Loki installation script

set -e

echo "Installing Loki..."

# Check if Docker is installed
if command -v docker &> /dev/null
then
    echo "Installing Loki with Docker..."
    
    # Create directories
    mkdir -p /opt/monitoring/loki
    cd /opt/monitoring/loki
    
    # Create basic Loki config
    cat > loki-config.yml << EOF
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  path_prefix: /loki
  storage:
    filesystem:
      chunks_directory: /loki/chunks
      rules_directory: /loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-05-15
      store: boltdb
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 168h

ruler:
  alertmanager_url: http://localhost:9093
EOF

    # Create docker-compose file for Loki
    cat > docker-compose.yml << EOF
version: "3.8"

services:
  loki:
    image: grafana/loki:2.9.2
    container_name: loki
    ports:
      - "3100:3100"
    volumes:
      - ./loki-config.yml:/etc/loki/local-config.yaml
      - ./data:/loki
    command: -config.file=/etc/loki/local-config.yaml
    restart: unless-stopped

volumes:
  data:
EOF

    # Create log entry
    echo "$(date): Loki installed with Docker" >> /var/log/monitoring-install/install.log

    echo "Loki installation completed!"
    echo "To start Loki, navigate to /opt/monitoring/loki and run:"
    echo "docker-compose up -d"
    echo "Loki will be available at http://localhost:3100"
else
    # Create directories
    mkdir -p /opt/monitoring/loki
    mkdir -p /var/lib/loki

    # Create basic Loki config
    cat > /opt/monitoring/loki/loki-config.yml << EOF
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  path_prefix: /var/lib/loki
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-05-15
      store: boltdb
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 168h

ruler:
  alertmanager_url: http://localhost:9093
EOF

    # Create docker-compose file for Loki
    cat > /opt/monitoring/loki/docker-compose.yml << EOF
version: "3"

networks:
  loki:

services:
  loki:
    image: grafana/loki:2.9.2
    ports:
      - "3100:3100"
    volumes:
      - ./loki-config.yml:/etc/loki/local-config.yaml
      - /var/lib/loki:/var/lib/loki
    command: -config.file=/etc/loki/local-config.yaml
    networks:
      - loki
EOF

    # Create log entry
    echo "$(date): Loki installed" >> /var/log/monitoring-install/install.log

    echo "Loki installation completed!"
    echo "To start Loki, navigate to /opt/monitoring/loki and run:"
    echo "docker-compose up -d"
    echo "Loki will be available at http://localhost:3100"
fi