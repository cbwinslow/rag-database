# Database & Monitoring Stack Setup

This project contains installation scripts for a comprehensive database and monitoring stack. All components are free and open-source.

## Database Components

1. **Supabase** - Full-stack Firebase alternative with PostgreSQL backend
2. **PostgreSQL** - Advanced relational database with PostGIS and pgvector extensions
3. **Weaviate** - Vector database for AI applications
4. **Qdrant** - Vector similarity search engine
5. **InfluxDB** - Time-series database
6. **ClickHouse** - Column-oriented analytical database
7. **Redis** - In-memory data structure store
8. **MongoDB** - Document-oriented NoSQL database

## Monitoring & Logging Components

1. **Prometheus** - Metrics collection and monitoring
2. **Grafana** - Visualization and dashboard platform
3. **OpenSearch** - Search and analytics suite (part of OLK stack)
4. **Loki** - Log aggregation system (part of OLK stack)
5. **Promtail** - Log shipper for Loki (part of OLK stack)

## Installation Scripts

All installation scripts are in the `install/` directory:
- `install-databases.sh` - Installs all database components
- `install-monitoring.sh` - Installs all monitoring components
- `verify-installation.sh` - Checks if services are running properly
- `start-docker-services.sh` - Starts all Docker-based services
- `stop-docker-services.sh` - Stops all Docker-based services
- Individual scripts for each component in `install/components/`

## Prerequisites

- Ubuntu/Debian-based Linux system (recommended)
- Docker and Docker Compose
- Git
- curl, wget
- sudo privileges

## Quick Start

```bash
# Make scripts executable
chmod +x install/*.sh

# Install databases
./install/install-databases.sh

# Install monitoring stack
./install/install-monitoring.sh

# Verify installation
./install/verify-installation.sh

# Start Docker services
./install/start-docker-services.sh
```