#!/bin/bash

# Verification script to check if all services are running

echo "=== Database & Monitoring Stack Verification ==="
echo

echo "Checking system services..."
echo "PostgreSQL: $(systemctl is-active postgresql)"
echo "InfluxDB: $(systemctl is-active influxdb)"
echo "ClickHouse: $(systemctl is-active clickhouse-server)"
echo "Redis: $(systemctl is-active redis)"
echo "MongoDB: $(systemctl is-active mongod)"
echo "Prometheus: $(systemctl is-active prometheus)"
echo "Grafana: $(systemctl is-active grafana-server)"
echo

echo "Checking Docker containers..."
if command -v docker &> /dev/null; then
  echo "Docker service: $(systemctl is-active docker)"
  echo "Running containers:"
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
  echo "Docker is not installed"
fi
echo

echo "Checking network ports..."
ports=(3000 6333 8080 8086 8123 9090 9200 5601 3100 6379 27017)
for port in "${ports[@]}"; do
  if nc -z localhost $port; then
    echo "Port $port: OPEN"
  else
    echo "Port $port: CLOSED"
  fi
done
echo

echo "=== Verification Complete ==="