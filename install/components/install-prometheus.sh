#!/bin/bash

# Prometheus installation script

set -e

echo "Installing Prometheus..."

# Check if Docker is installed
if command -v docker &> /dev/null
then
    echo "Installing Prometheus with Docker..."
    
    # Create directory for Prometheus
    mkdir -p /opt/monitoring/prometheus
    cd /opt/monitoring/prometheus
    
    # Create docker-compose file for Prometheus
    cat > docker-compose.yml << EOF
version: '3.8'

services:
  prometheus:
    image: prom/prometheus:v2.47.0
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - ./data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'
    restart: unless-stopped

volumes:
  data:
EOF

    # Create prometheus configuration
    cat > prometheus.yml << EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
      
  - job_name: 'opensearch'
    static_configs:
      - targets: ['opensearch-node1:9200']
      
  - job_name: 'loki'
    static_configs:
      - targets: ['loki:3100']
      
  - job_name: 'rabbitmq'
    static_configs:
      - targets: ['rabbitmq:15672']
EOF

    # Create log entry
    echo "$(date): Prometheus installed with Docker" >> /var/log/monitoring-install/install.log

    echo "Prometheus installation completed!"
    echo "To start Prometheus, navigate to /opt/monitoring/prometheus and run:"
    echo "docker-compose up -d"
    echo "Prometheus will be available at http://localhost:9090"
else
    # Create prometheus user
    useradd --no-create-home --shell /bin/false prometheus || true

    # Create directories
    mkdir -p /etc/prometheus
    mkdir -p /var/lib/prometheus

    # Set ownership
    chown prometheus:prometheus /etc/prometheus
    chown prometheus:prometheus /var/lib/prometheus

    # Download Prometheus
    cd /tmp
    wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
    tar xvf prometheus-2.47.0.linux-amd64.tar.gz

    # Copy binaries
    cp prometheus-2.47.0.linux-amd64/prometheus /usr/local/bin/
    cp prometheus-2.47.0.linux-amd64/promtool /usr/local/bin/

    # Set ownership on binaries
    chown prometheus:prometheus /usr/local/bin/prometheus
    chown prometheus:prometheus /usr/local/bin/promtool

    # Copy config files
    cp -r prometheus-2.47.0.linux-amd64/consoles /etc/prometheus
    cp -r prometheus-2.47.0.linux-amd64/console_libraries /etc/prometheus

    # Set ownership on config directories
    chown -R prometheus:prometheus /etc/prometheus/consoles
    chown -R prometheus:prometheus /etc/prometheus/console_libraries

    # Create basic prometheus.yml
    cat > /etc/prometheus/prometheus.yml << EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
EOF

    # Set ownership on config file
    chown prometheus:prometheus /etc/prometheus/prometheus.yml

    # Create systemd service
    cat > /etc/systemd/system/prometheus.service << EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd and start service
    systemctl daemon-reload
    systemctl start prometheus
    systemctl enable prometheus

    # Clean up
    rm -rf /tmp/prometheus-2.47.0.linux-amd64*

    # Create log entry
    echo "$(date): Prometheus installed" >> /var/log/monitoring-install/install.log

    echo "Prometheus installation completed!"
    echo "Prometheus is running on port 9090"
    echo "Access the web UI at http://localhost:9090"
fi