#!/bin/bash

# Main monitoring installation script
# This script installs all monitoring and logging components

set -e  # Exit on any error

echo "Starting monitoring stack installation..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Create necessary directories
mkdir -p /opt/monitoring/{prometheus,grafana,opensearch,loki,promtail}
mkdir -p /var/log/monitoring-install

echo "Installing individual monitoring components..."

# Install Prometheus
echo "Installing Prometheus..."
./components/install-prometheus.sh

# Install Grafana
echo "Installing Grafana..."
./components/install-grafana.sh

# Install OpenSearch
echo "Installing OpenSearch..."
./components/install-opensearch.sh

# Install Loki
echo "Installing Loki..."
./components/install-loki.sh

# Install Promtail
echo "Installing Promtail..."
./components/install-promtail.sh

echo "All monitoring installations completed!"
echo "Check /var/log/monitoring-install/ for installation logs."