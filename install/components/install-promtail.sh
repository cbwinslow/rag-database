#!/bin/bash

# Promtail installation script

set -e

echo "Installing Promtail..."

# Create directories
mkdir -p /opt/monitoring/promtail
mkdir -p /var/log/promtail

# Create basic Promtail config
cat > /opt/monitoring/promtail/promtail-config.yml << EOF
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
EOF

# Create docker-compose file for Promtail
cat > /opt/monitoring/promtail/docker-compose.yml << EOF
version: "3"

networks:
  loki:

services:
  promtail:
    image: grafana/promtail:2.9.2
    volumes:
      - ./promtail-config.yml:/etc/promtail/config.yml
      - /var/log:/var/log
    command: -config.file=/etc/promtail/config.yml
    networks:
      - loki
    ports:
      - "9080:9080"
EOF

# Create log entry
echo "$(date): Promtail installed" >> /var/log/monitoring-install/install.log

echo "Promtail installation completed!"
echo "To start Promtail, navigate to /opt/monitoring/promtail and run:"
echo "docker-compose up -d"
echo "Note: Promtail requires Loki to be running at http://localhost:3100"