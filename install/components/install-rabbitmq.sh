#!/bin/bash

# RabbitMQ installation script

set -e

echo "Installing RabbitMQ..."

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Create directory for RabbitMQ
mkdir -p /opt/messaging/rabbitmq
cd /opt/messaging/rabbitmq

# Create docker-compose file for RabbitMQ
cat > docker-compose.yml << EOF
version: '3.8'

services:
  rabbitmq:
    image: rabbitmq:3-management
    container_name: rabbitmq
    ports:
      - "5672:5672"
      - "15672:15672"
    environment:
      - RABBITMQ_DEFAULT_USER=admin
      - RABBITMQ_DEFAULT_PASS=password
    volumes:
      - ./data:/var/lib/rabbitmq
    restart: unless-stopped
EOF

# Create data directory
mkdir -p data

# Create log entry
echo "$(date): RabbitMQ installed" >> /var/log/messaging-install/install.log

echo "RabbitMQ installation completed!"
echo "To start RabbitMQ, navigate to /opt/messaging/rabbitmq and run:"
echo "docker-compose up -d"
echo "RabbitMQ will be available at:"
echo "  AMQP: http://localhost:5672"
echo "  Management: http://localhost:15672"
echo "  Default credentials: admin/password"