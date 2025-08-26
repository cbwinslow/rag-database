#!/bin/bash

# OpenSearch installation script

set -e

echo "Installing OpenSearch..."

# Create docker-compose file for OpenSearch
mkdir -p /opt/monitoring/opensearch
cat > /opt/monitoring/opensearch/docker-compose.yml << EOF
version: '3'
services:
  opensearch-node1:
    image: opensearchproject/opensearch:2.11.0
    container_name: opensearch-node1
    environment:
      - cluster.name=opensearch-cluster
      - node.name=opensearch-node1
      - discovery.seed_hosts=opensearch-node1
      - cluster.initial_cluster_manager_nodes=opensearch-node1
      - bootstrap.memory_lock=true
      - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m"
      - DISABLE_SECURITY_PLUGIN=true
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    volumes:
      - opensearch-data1:/usr/share/opensearch/data
    ports:
      - 9200:9200
      - 9600:9600
    networks:
      - opensearch-net

  opensearch-dashboards:
    image: opensearchproject/opensearch-dashboards:2.11.0
    container_name: opensearch-dashboards
    ports:
      - 5601:5601
    environment:
      OPENSEARCH_HOSTS: '["http://opensearch-node1:9200"]'
      DISABLE_SECURITY_DASHBOARDS_PLUGIN: "true"
    networks:
      - opensearch-net

volumes:
  opensearch-data1:

networks:
  opensearch-net:
EOF

# Create log entry
echo "$(date): OpenSearch installed" >> /var/log/monitoring-install/install.log

echo "OpenSearch installation completed!"
echo "To start OpenSearch, navigate to /opt/monitoring/opensearch and run:"
echo "docker-compose up -d"
echo "OpenSearch will be available at http://localhost:9200"
echo "OpenSearch Dashboards will be available at http://localhost:5601"