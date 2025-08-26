#!/bin/bash

# AI Orchestrator installation script

set -e

echo "Installing AI Orchestrator..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create directory for AI Orchestrator
mkdir -p /opt/ai/orchestrator
cd /opt/ai/orchestrator

# Create docker-compose file for AI Orchestrator
cat > docker-compose.yml << EOF
version: '3.8'

services:
  ai-orchestrator:
    build: 
      context: .
      dockerfile: Dockerfile
    container_name: ai-orchestrator
    ports:
      - "5000:5000"
    environment:
      - RABBITMQ_URL=amqp://admin:password@rabbitmq:5672/
      - PROMETHEUS_URL=http://prometheus:9090
      - LOKI_URL=http://loki:3100
      - OPENSEARCH_URL=http://opensearch-node1:9200
      - NEO4J_URL=bolt://neo4j:7687
      - LOCALAI_URL=http://localai:8080
      - OLLAMA_URL=http://ollama:11434
    volumes:
      - ./config:/app/config
      - ./logs:/app/logs
    depends_on:
      - rabbitmq
      - prometheus
      - loki
      - opensearch-node1
      - neo4j
      - localai
      - ollama
    restart: unless-stopped

volumes:
  config:
  logs:
EOF

# Create a simple Dockerfile for the orchestrator
cat > Dockerfile << EOF
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "orchestrator.py"]
EOF

# Create requirements file
cat > requirements.txt << EOF
pydantic-ai
pika
requests
prometheus-client
neo4j
openai
EOF

# Create a simple orchestrator script
cat > orchestrator.py << EOF
#!/usr/bin/env python3

import asyncio
import logging
from typing import Dict, Any
from pydantic_ai import Agent, RunContext
from pydantic import BaseModel
import pika
import requests
import json

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Define data models
class SystemStatus(BaseModel):
    service: str
    status: str
    metrics: Dict[str, Any]

class RepairAction(BaseModel):
    service: str
    action: str
    priority: int

# AI Agent for system analysis
analyzer_agent = Agent(
    model='openai:gpt-4',
    result_type=RepairAction,
    system_prompt='You are an AI system administrator. Analyze system status and recommend repair actions.'
)

# RabbitMQ connection
def connect_rabbitmq():
    credentials = pika.PlainCredentials('admin', 'password')
    parameters = pika.ConnectionParameters('rabbitmq', 5672, '/', credentials)
    return pika.BlockingConnection(parameters)

# Function to check service status
def check_service_status(service_url: str, service_name: str) -> SystemStatus:
    try:
        response = requests.get(service_url, timeout=5)
        return SystemStatus(
            service=service_name,
            status="healthy" if response.status_code == 200 else "unhealthy",
            metrics={"response_time": response.elapsed.total_seconds()}
        )
    except Exception as e:
        return SystemStatus(
            service=service_name,
            status="unhealthy",
            metrics={"error": str(e)}
        )

# Function to send repair action to RabbitMQ
def send_repair_action(action: RepairAction):
    connection = connect_rabbitmq()
    channel = connection.channel()
    channel.queue_declare(queue='repair_actions')
    channel.basic_publish(
        exchange='',
        routing_key='repair_actions',
        body=json.dumps(action.dict())
    )
    connection.close()
    logger.info(f"Sent repair action: {action}")

# Main orchestrator loop
async def orchestrate():
    logger.info("AI Orchestrator started")
    
    while True:
        # Check status of all services
        services = [
            ("Prometheus", "http://prometheus:9090/-/healthy"),
            ("Loki", "http://loki:3100/ready"),
            ("OpenSearch", "http://opensearch-node1:9200/_cluster/health"),
            ("Neo4j", "http://neo4j:7474"),
            ("LocalAI", "http://localai:8080/models"),
            ("Ollama", "http://ollama:11434/api/tags")
        ]
        
        for service_name, service_url in services:
            status = check_service_status(service_url, service_name)
            logger.info(f"{service_name} status: {status}")
            
            # If service is unhealthy, ask AI agent for repair action
            if status.status != "healthy":
                # In a real implementation, we would use the analyzer_agent here
                # For now, we'll create a simple repair action
                action = RepairAction(
                    service=service_name,
                    action="restart_service",
                    priority=1 if status.status == "unhealthy" else 2
                )
                send_repair_action(action)
        
        # Wait before next check
        await asyncio.sleep(60)

if __name__ == "__main__":
    asyncio.run(orchestrate())
EOF

# Create config directory
mkdir -p config

# Create log entry
echo "$(date): AI Orchestrator installed" >> /var/log/ai-install/install.log

echo "AI Orchestrator installation completed!"
echo "To start the AI Orchestrator, navigate to /opt/ai/orchestrator and run:"
echo "docker-compose up -d"
echo "AI Orchestrator will be available at http://localhost:5000"