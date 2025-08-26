export type ServiceStatus = 'running' | 'stopped' | 'warning' | 'installing' | 'restarting' | 'unavailable'

export interface Service {
  id: string
  name: string
  status: ServiceStatus
  port: number
  type: string
  description: string
}

export interface SystemMetrics {
  cpu: number
  memory: number
  disk: number
  uptime: string
}