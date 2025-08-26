'use client'

import { useState, useEffect } from 'react'
import ServiceStatus from '@/components/ServiceStatus'
import SystemMetrics from '@/components/SystemMetrics'
import ServiceControl from '@/components/ServiceControl'
import { Service } from '@/lib/types'

export default function Home() {
  const [services, setServices] = useState<Service[]>([])
  const [loading, setLoading] = useState(true)

  // Mock data for demonstration
  const mockServices: Service[] = [
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

  useEffect(() => {
    // Simulate API call
    setTimeout(() => {
      setServices(mockServices)
      setLoading(false)
    }, 1000)
  }, [])

  return (
    <div className="min-h-screen bg-base-100">
      <div className="container mx-auto px-4 py-8">
        <div className="text-center mb-10">
          <h1 className="text-4xl font-bold text-primary mb-2">Database & Monitoring Dashboard</h1>
          <p className="text-lg text-secondary">Real-time status of all installed services</p>
        </div>

        {loading ? (
          <div className="flex justify-center items-center h-64">
            <div className="loading loading-spinner loading-lg"></div>
          </div>
        ) : (
          <>
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
              <div className="lg:col-span-2">
                <ServiceStatus services={services} />
              </div>
              <div>
                <SystemMetrics />
              </div>
            </div>

            <div className="mb-8">
              <ServiceControl services={services} />
            </div>
          </>
        )}
      </div>
    </div>
  )
}