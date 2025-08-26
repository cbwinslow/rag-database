#!/bin/bash

# Installation Verification Script
# This script verifies that all services are properly installed and running

echo "=== Database & Monitoring Stack Installation Verification ==="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
  local status=$1
  local message=$2
  case $status in
    "PASS")
      echo -e "${GREEN}✓ PASS${NC} $message"
      ;;
    "WARN")
      echo -e "${YELLOW}⚠ WARN${NC} $message"
      ;;
    "FAIL")
      echo -e "${RED}✗ FAIL${NC} $message"
      ;;
  esac
}

# Function to check if a service is running
check_service() {
  local service_name=$1
  if systemctl is-active --quiet $service_name; then
    print_status "PASS" "$service_name is running"
  else
    print_status "FAIL" "$service_name is not running"
  fi
}

# Function to check if a port is open
check_port() {
  local port=$1
  local service_name=$2
  if nc -z localhost $port 2>/dev/null; then
    print_status "PASS" "$service_name is accessible on port $port"
  else
    print_status "FAIL" "$service_name is not accessible on port $port"
  fi
}

# Function to check Docker containers
check_docker_container() {
  local container_name=$1
  if docker ps --format '{{.Names}}' | grep -q "^$container_name$"; then
    print_status "PASS" "Docker container $container_name is running"
  else
    print_status "FAIL" "Docker container $container_name is not running"
  fi
}

echo "Checking system services..."
echo "========================"
check_service "postgresql"
check_service "influxdb"
check_service "clickhouse-server"
check_service "redis"
check_service "mongod"
check_service "prometheus"
check_service "grafana-server"

echo
echo "Checking network ports..."
echo "======================="
check_port 5432 "PostgreSQL"
check_port 3000 "Supabase/Grafana"
check_port 8080 "Weaviate"
check_port 6333 "Qdrant"
check_port 8086 "InfluxDB"
check_port 8123 "ClickHouse"
check_port 6379 "Redis"
check_port 27017 "MongoDB"
check_port 9090 "Prometheus"
check_port 9200 "OpenSearch"
check_port 5601 "OpenSearch Dashboards"
check_port 3100 "Loki"

echo
echo "Checking Docker containers..."
echo "==========================="
check_docker_container "supabase-studio"
check_docker_container "weaviate-weaviate"
check_docker_container "qdrant-qdrant"
check_docker_container "opensearch-node1"
check_docker_container "opensearch-dashboards"
check_docker_container "loki-loki"
check_docker_container "promtail-promtail"

echo
echo "Checking Docker service..."
echo "========================"
if systemctl is-active --quiet docker; then
  print_status "PASS" "Docker service is running"
else
  print_status "FAIL" "Docker service is not running"
fi

echo
echo "=== Verification Complete ==="
echo
echo "Summary:"
echo "- Check for any FAIL messages above"
echo "- Services showing WARN may need attention"
echo "- Refer to installation logs in /var/log/ for detailed information"