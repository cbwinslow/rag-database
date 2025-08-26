#!/bin/bash

# Test script for AI components

echo "=== Testing AI Components ==="
echo

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed"
  exit 1
fi

# Check if services are running
echo "Checking if AI services are running..."
echo "====================================="

services=(
  "localai:8080"
  "open-webui:3001"
  "searxng:8088"
  "rabbitmq:15672"
  "ai-orchestrator:5000"
)

for service in "${services[@]}"; do
  name=${service%:*}
  port=${service#*:}
  
  if docker ps | grep -q "$name"; then
    echo "✅ $name is running"
  else
    echo "❌ $name is not running"
  fi
done

echo
echo "Checking service endpoints..."
echo "==========================="

# Test LocalAI
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/docs | grep -q "200"; then
  echo "✅ LocalAI is accessible"
else
  echo "❌ LocalAI is not accessible"
fi

# Test OpenWebUI
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3001 | grep -q "200"; then
  echo "✅ OpenWebUI is accessible"
else
  echo "❌ OpenWebUI is not accessible"
fi

# Test SearXNG
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8088 | grep -q "200"; then
  echo "✅ SearXNG is accessible"
else
  echo "❌ SearXNG is not accessible"
fi

# Test RabbitMQ
if curl -s -o /dev/null -w "%{http_code}" http://localhost:15672 | grep -q "200"; then
  echo "✅ RabbitMQ is accessible"
else
  echo "❌ RabbitMQ is not accessible"
fi

echo
echo "=== AI Component Testing Complete ==="