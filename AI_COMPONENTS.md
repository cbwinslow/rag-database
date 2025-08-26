# AI-Enhanced Database & Monitoring Stack

This document describes the AI-enhanced components added to the database and monitoring stack.

## AI Components Overview

### 1. LocalAI
LocalAI is a self-hosted, drop-in replacement for OpenAI API that runs locally. It provides:
- Local inference for language models
- API compatibility with OpenAI
- Support for various model formats

### 2. OpenWebUI
OpenWebUI is a user-friendly interface for interacting with LLMs:
- Web-based chat interface
- Support for multiple LLM backends
- Model management capabilities

### 3. SearXNG
SearXNG is a privacy-respecting metasearch engine:
- Aggregates results from multiple search sources
- No user tracking or profiling
- Customizable search experience

### 4. Agentic RAG
Agentic RAG is a framework for retrieval-augmented generation with autonomous agents:
- Combines search and generation capabilities
- Agent-based approach to information retrieval
- Reinforcement learning for improved reasoning

### 5. RabbitMQ
RabbitMQ is a message broker for inter-service communication:
- Reliable message queuing
- Support for multiple messaging protocols
- Clustering and high availability

### 6. Pydantic AI
Pydantic AI is a framework for building AI agents with structured data:
- Type-safe AI interactions
- Integration with Pydantic data models
- Support for multiple LLM providers

### 7. AI Orchestrator
The AI Orchestrator is the central intelligence of the system:
- Monitors all services and components
- Analyzes system health and performance
- Coordinates repair and maintenance actions
- Acts as the "brain" of the entire stack

## Service Communication Architecture

```
                    +------------------+
                    |  AI Orchestrator |
                    +------------------+
                             |
                    +--------+---------+
                    |   RabbitMQ       |
                    +--------+---------+
                             |
    +----------------+-------+------+-----------------+
    |                |              |                 |
+---+----+    +------+--+    +-----+----+    +-------+-----+
|Prometheus|    | OpenSearch|    |   Loki   |    |   Neo4j     |
+----------+    +-----------+    +----------+    +-------------+
    |                |              |                 |
+---+----+    +------+--+    +-----+----+    +-------+-----+
|Grafana |    | OpenSearch|    | Promtail |    | Applications|
|        |    | Dashboards|    |          |    |             |
+--------+    +-----------+    +----------+    +-------------+

                    +------------------+
                    |     LocalAI      |
                    +------------------+
                             |
                    +--------+---------+
                    |   OpenWebUI      |
                    +------------------+

                    +------------------+
                    |     SearXNG      |
                    +------------------+

                    +------------------+
                    |   Agentic RAG    |
                    +------------------+
```

## Installation

To install all AI components:

```bash
./db-manager.sh install-ai
```

## Starting Services

To start all AI-enhanced services:

```bash
./db-manager.sh start-ai
```

## Service Endpoints

| Service | Port | URL |
|---------|------|-----|
| LocalAI | 8080 | http://localhost:8080 |
| OpenWebUI | 3001 | http://localhost:3001 |
| SearXNG | 8088 | http://localhost:8088 |
| Agentic RAG | 8000 | http://localhost:8000 |
| RabbitMQ | 5672/15672 | amqp://localhost:5672, http://localhost:15672 |
| AI Orchestrator | 5000 | http://localhost:5000 |

## AI Orchestrator Functionality

The AI Orchestrator provides the following capabilities:

1. **System Monitoring**
   - Continuous health checks of all services
   - Performance metric collection
   - Anomaly detection

2. **Intelligent Analysis**
   - AI-powered analysis of system status
   - Predictive failure detection
   - Root cause analysis

3. **Automated Repair**
   - Autonomous service restarts
   - Configuration adjustments
   - Resource allocation optimization

4. **Knowledge Management**
   - Centralized knowledge base
   - Learning from past incidents
   - Best practices implementation

5. **Agent Coordination**
   - Task distribution to specialized agents
   - Inter-agent communication
   - Result aggregation and reporting

## Configuration

The AI Orchestrator can be configured through environment variables in the docker-compose.yml file:

- `RABBITMQ_URL` - Connection string for RabbitMQ
- `PROMETHEUS_URL` - URL for Prometheus metrics
- `LOKI_URL` - URL for Loki logging
- `OPENSEARCH_URL` - URL for OpenSearch
- `NEO4J_URL` - URL for Neo4j database
- `LOCALAI_URL` - URL for LocalAI service
- `OLLAMA_URL` - URL for Ollama service

## Extending the System

To add new components to the AI-orchestrated system:

1. Create an installation script in `/install/components/ai/`
2. Add the service to the AI Orchestrator's monitoring list
3. Configure communication through RabbitMQ
4. Implement health checks and repair actions