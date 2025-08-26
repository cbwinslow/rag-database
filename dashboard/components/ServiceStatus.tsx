import { Service, ServiceStatus } from '@/lib/types'

interface ServiceStatusProps {
  services: Service[]
}

export default function ServiceStatus({ services }: ServiceStatusProps) {
  const getStatusColor = (status: ServiceStatus) => {
    switch (status) {
      case 'running': return 'bg-green-500'
      case 'warning': return 'bg-yellow-500'
      case 'stopped': return 'bg-red-500'
      case 'installing': return 'bg-blue-500'
      case 'restarting': return 'bg-purple-500'
      case 'unavailable': return 'bg-gray-500'
      default: return 'bg-gray-500'
    }
  }

  const getStatusText = (status: ServiceStatus) => {
    switch (status) {
      case 'running': return 'Running'
      case 'warning': return 'Warning'
      case 'stopped': return 'Stopped'
      case 'installing': return 'Installing'
      case 'restarting': return 'Restarting'
      case 'unavailable': return 'Unavailable'
      default: return 'Unknown'
    }
  }

  const getServiceIcon = (type: string) => {
    switch (type) {
      case 'database': return '💾'
      case 'vector': return '🔍'
      case 'timeseries': return '📈'
      case 'analytics': return '📊'
      case 'cache': return '⚡'
      case 'document': return '📄'
      case 'monitoring': return '📺'
      case 'search': return '🔎'
      case 'logging': return '📝'
      default: return '⚙️'
    }
  }

  return (
    <div className="bg-base-200 rounded-box p-6">
      <h2 className="text-2xl font-bold mb-4">Service Status</h2>
      <div className="overflow-x-auto">
        <table className="table w-full">
          <thead>
            <tr>
              <th>Service</th>
              <th>Status</th>
              <th>Port</th>
              <th>Type</th>
            </tr>
          </thead>
          <tbody>
            {services.map((service) => (
              <tr key={service.id} className="hover">
                <td>
                  <div className="flex items-center space-x-3">
                    <div className="avatar">
                      <div className="mask mask-squircle w-12 h-12 bg-base-300 flex items-center justify-center">
                        <span className="text-xl">{getServiceIcon(service.type)}</span>
                      </div>
                    </div>
                    <div>
                      <div className="font-bold">{service.name}</div>
                      <div className="text-sm opacity-50">{service.description}</div>
                    </div>
                  </div>
                </td>
                <td>
                  <div className="flex items-center">
                    <div className={`w-3 h-3 rounded-full mr-2 ${getStatusColor(service.status)}`}></div>
                    <span>{getStatusText(service.status)}</span>
                  </div>
                </td>
                <td>
                  <div className="badge badge-ghost badge-sm">{service.port}</div>
                </td>
                <td>
                  <div className="badge badge-outline badge-sm">{service.type}</div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}