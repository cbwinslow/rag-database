# Architecture Diagram

```mermaid
graph TD
    A[User Browser] --> B[Next.js Dashboard]
    B --> C[API Routes]
    C --> D[System Services]
    C --> E[Docker Services]
    C --> F[Network Utilities]
    
    D --> D1[PostgreSQL]
    D --> D2[InfluxDB]
    D --> D3[ClickHouse]
    D --> D4[Redis]
    D --> D5[MongoDB]
    D --> D6[Prometheus]
    D --> D7[Grafana]
    
    E --> E1[Supabase]
    E --> E2[Weaviate]
    E --> E3[Qdrant]
    E --> E4[OpenSearch]
    E --> E5[Loki]
    E --> E6[Promtail]
    
    F --> F1[Port Checks]
    F --> F2[Health Checks]
    
    subgraph "System Services"
        D1
        D2
        D3
        D4
        D5
        D6
        D7
    end
    
    subgraph "Docker Services"
        E1
        E2
        E3
        E4
        E5
        E6
    end
    
    subgraph "Monitoring Dashboard"
        A
        B
        C
    end
    
    subgraph "System Utilities"
        F
    end
```

This diagram shows the architecture of the complete solution:

1. **User Browser** - Accesses the Next.js dashboard
2. **Next.js Dashboard** - Frontend application providing the user interface
3. **API Routes** - Backend endpoints that communicate with services
4. **System Services** - Services installed directly on the system
5. **Docker Services** - Services running in Docker containers
6. **System Utilities** - Network and health checking utilities