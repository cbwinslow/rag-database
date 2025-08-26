#!/bin/bash

# AI Services Status Checker
# This script checks the status of all AI-enhanced services

echo "=== AI Services Status Check ==="
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
    "RUNNING")
      echo -e "${GREEN}✓ RUNNING${NC} $message"
      ;;
    "STOPPED")
      echo -e "${RED}✗ STOPPED${NC} $message"
      ;;
    "WARNING")
      echo -e "${YELLOW}⚠ WARNING${NC} $message"
      ;;
    "UNKNOWN")
      echo -e "${YELLOW}? UNKNOWN${NC} $message"
      ;;
  esac
}

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
  echo -e "${RED}Error: Docker is not installed${NC}"
  exit 1
fi

if ! systemctl is-active --quiet docker; then
  echo -e "${RED}Error: Docker service is not running${NC}"
  exit 1
fi

echo "Checking Docker containers..."
echo "=========================="

# List of AI services to check
ai_services=(
  "localai"
  "open-webui"
  "searxng"
  "agentic-rag"
  "rabbitmq"
  "ai-orchestrator"
  "prometheus"
  "loki"
  "opensearch-node1"
  "opensearch-dashboards"
  "neo4j"
)

# Check each service
for service in "${ai_services[@]}"; do
  if docker ps --format '{{.Names}}' | grep -q "^$service$"; then
    print_status "RUNNING" "$service"
  else
    print_status "STOPPED" "$service"
  fi
done

echo
echo "Checking service endpoints..."
echo "=========================="

# Check service endpoints
endpoints=(
  "LocalAI:http://localhost:8080/health"
  "OpenWebUI:http://localhost:3001/api/health"
  "SearXNG:http://localhost:8088/healthz"
  "RabbitMQ Management:http://localhost:15672/api/healthchecks/node"
  "Prometheus:http://localhost:9090/-/healthy"
  "Loki:http://localhost:3100/ready"
  "OpenSearch:http://localhost:9200/_cluster/health"
  "Neo4j:http://localhost:7474"
)

for endpoint in "${endpoints[@]}"; do
  service=${endpoint%:*}
  url=${endpoint#*:}
  
  # Skip health checks for services that don't have health endpoints
  if [[ "$service" == "OpenWebUI" ]] || [[ "$service" == "SearXNG" ]] || [[ "$service" == "Neo4j" ]]; then
    # Just check if the main page is accessible
    if curl -s -o /dev/null -w "%{http_code}" "http://localhost:${url#*:}" | grep -q "200\|302"; then
      print_status "RUNNING" "$service endpoint accessible"
    else
      print_status "WARNING" "$service endpoint not accessible"
    fi
  else
    # Check health endpoint
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
      print_status "RUNNING" "$service health check passed"
    else
      print_status "WARNING" "$service health check failed"
    fi
  fi
done

echo
echo "=== Status Check Complete ==="