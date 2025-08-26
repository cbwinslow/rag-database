import { NextResponse } from 'next/server'
import { Service } from '@/lib/types'

// Mock data - in a real implementation, this would check actual service status
const services: Service[] = [
  {
    id: 'postgresql',
    name: 'PostgreSQL',
    status: 'running',
    port: 5432,
    type: 'database',
    description: 'Advanced relational database'
  },
  {
    id: 'supabase',
    name: 'Supabase',
    status: 'running',
    port: 3000,
    type: 'database',
    description: 'Firebase alternative with PostgreSQL'
  },
  {
    id: 'weaviate',
    name: 'Weaviate',
    status: 'warning',
    port: 8080,
    type: 'vector',
    description: 'Vector database for AI applications'
  },
  {
    id: 'qdrant',
    name: 'Qdrant',
    status: 'running',
    port: 6333,
    type: 'vector',
    description: 'Vector similarity search engine'
  },
  {
    id: 'influxdb',
    name: 'InfluxDB',
    status: 'stopped',
    port: 8086,
    type: 'timeseries',
    description: 'Time-series database'
  },
  {
    id: 'clickhouse',
    name: 'ClickHouse',
    status: 'running',
    port: 8123,
    type: 'analytics',
    description: 'Column-oriented analytical database'
  },
  {
    id: 'redis',
    name: 'Redis',
    status: 'running',
    port: 6379,
    type: 'cache',
    description: 'In-memory data structure store'
  },
  {
    id: 'mongodb',
    name: 'MongoDB',
    status: 'running',
    port: 27017,
    type: 'document',
    description: 'Document-oriented NoSQL database'
  },
  {
    id: 'prometheus',
    name: 'Prometheus',
    status: 'running',
    port: 9090,
    type: 'monitoring',
    description: 'Metrics collection and monitoring'
  },
  {
    id: 'grafana',
    name: 'Grafana',
    status: 'running',
    port: 3000,
    type: 'monitoring',
    description: 'Visualization and dashboard platform'
  },
  {
    id: 'opensearch',
    name: 'OpenSearch',
    status: 'running',
    port: 9200,
    type: 'search',
    description: 'Search and analytics suite'
  },
  {
    id: 'loki',
    name: 'Loki',
    status: 'running',
    port: 3100,
    type: 'logging',
    description: 'Log aggregation system'
  }
]

export async function GET() {
  // In a real implementation, we would check actual service status here
  // For now, we'll return the mock data
  return NextResponse.json({ services })
}