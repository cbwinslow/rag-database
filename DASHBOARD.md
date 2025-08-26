# Database & Monitoring Dashboard

This dashboard provides real-time monitoring of all installed database and monitoring services. It displays the status of each service, including whether it's running, accessible, and healthy.

## Features

1. **Service Status Monitoring** - Real-time status of all services
2. **Port Availability Check** - Verification of required ports
3. **Health Checks** - Application-specific health indicators
4. **Service Management** - Start/stop Docker services
5. **Installation Verification** - Check if all components are properly installed
6. **System Resource Monitoring** - CPU, memory, and disk usage

## Technology Stack

- **Frontend**: Next.js with TypeScript
- **UI Framework**: Tailwind CSS with DaisyUI components
- **Backend**: Next.js API routes
- **State Management**: React Context API
- **Real-time Updates**: Server-Sent Events (SSE)

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Browser Client                         │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌──────────────┐  ┌────────────────────┐ │
│  │  Dashboard  │  │  Services    │  │  System Metrics    │ │
│  │   Status    │  │   Status     │  │     Panel          │ │
│  └─────────────┘  └──────────────┘  └────────────────────┘ │
├─────────────────────────────────────────────────────────────┤
│                    Next.js Application                      │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌──────────────┐  ┌────────────────────┐ │
│  │   API       │  │   Health     │  │  System            │ │
│  │  Routes     │  │   Checks     │  │  Utilities         │ │
│  └─────────────┘  └──────────────┘  └────────────────────┘ │
├─────────────────────────────────────────────────────────────┤
│                 Service Communication Layer                 │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌──────────────┐  ┌────────────────────┐ │
│  │  Docker     │  │  System      │  │  Network           │ │
│  │  Engine     │  │  Services    │  │  Utilities         │ │
│  └─────────────┘  └──────────────┘  └────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Service Status Definitions

| Status | Meaning |
|--------|---------|
| ✅ Running | Service is active and responding |
| ⚠️ Warning | Service is running but with issues |
| ❌ Stopped | Service is not running |
| 🔧 Installing | Service is being installed |
| 🔄 Restarting | Service is restarting |
| 🚫 Unavailable | Service is unreachable |

## Ports Overview

| Service | Port | Protocol | Purpose |
|---------|------|----------|---------|
| Supabase | 3000 | HTTP | Dashboard |
| Weaviate | 8080 | HTTP | API |
| Qdrant | 6333 | HTTP | API |
| Qdrant | 6334 | gRPC | gRPC API |
| InfluxDB | 8086 | HTTP | API |
| ClickHouse | 8123 | HTTP | HTTP Interface |
| ClickHouse | 9000 | TCP | Native Interface |
| Redis | 6379 | TCP | Database |
| MongoDB | 27017 | TCP | Database |
| Prometheus | 9090 | HTTP | Dashboard |
| Grafana | 3000 | HTTP | Dashboard |
| OpenSearch | 9200 | HTTP | API |
| OpenSearch | 9600 | HTTP | Performance Analyzer |
| OpenSearch Dashboards | 5601 | HTTP | Dashboard |
| Loki | 3100 | HTTP | API |
| Promtail | 9080 | HTTP | Client |