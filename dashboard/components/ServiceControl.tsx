'use client'

import { Service } from '@/lib/types'
import { useState } from 'react'

interface ServiceControlProps {
  services: Service[]
}

export default function ServiceControl({ services }: ServiceControlProps) {
  const [selectedServices, setSelectedServices] = useState<string[]>([])
  const [actionStatus, setActionStatus] = useState<string | null>(null)

  const toggleService = (id: string) => {
    if (selectedServices.includes(id)) {
      setSelectedServices(selectedServices.filter(serviceId => serviceId !== id))
    } else {
      setSelectedServices([...selectedServices, id])
    }
  }

  const selectAll = () => {
    setSelectedServices(services.map(service => service.id))
  }

  const deselectAll = () => {
    setSelectedServices([])
  }

  const performAction = (action: string) => {
    setActionStatus(`Performing ${action} on ${selectedServices.length} services...`)
    // Simulate API call
    setTimeout(() => {
      setActionStatus(`Successfully ${action}ed ${selectedServices.length} services`)
      setTimeout(() => setActionStatus(null), 3000)
    }, 1500)
  }

  return (
    <div className="bg-base-200 rounded-box p-6">
      <h2 className="text-2xl font-bold mb-4">Service Control</h2>
      
      {actionStatus && (
        <div className="alert alert-info mb-4">
          <span>{actionStatus}</span>
        </div>
      )}
      
      <div className="flex flex-wrap gap-2 mb-4">
        <button 
          className="btn btn-primary btn-sm"
          onClick={selectAll}
        >
          Select All
        </button>
        <button 
          className="btn btn-secondary btn-sm"
          onClick={deselectAll}
        >
          Deselect All
        </button>
        <div className="divider divider-horizontal"></div>
        <button 
          className="btn btn-success btn-sm"
          onClick={() => performAction('start')}
          disabled={selectedServices.length === 0}
        >
          Start
        </button>
        <button 
          className="btn btn-warning btn-sm"
          onClick={() => performAction('restart')}
          disabled={selectedServices.length === 0}
        >
          Restart
        </button>
        <button 
          className="btn btn-error btn-sm"
          onClick={() => performAction('stop')}
          disabled={selectedServices.length === 0}
        >
          Stop
        </button>
      </div>
      
      <div className="overflow-x-auto">
        <table className="table w-full">
          <thead>
            <tr>
              <th>
                <label>
                  <input 
                    type="checkbox" 
                    className="checkbox"
                    onChange={(e) => {
                      if (e.target.checked) {
                        selectAll()
                      } else {
                        deselectAll()
                      }
                    }}
                  />
                </label>
              </th>
              <th>Service</th>
              <th>Description</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            {services.map((service) => (
              <tr key={service.id} className="hover">
                <td>
                  <label>
                    <input 
                      type="checkbox" 
                      className="checkbox"
                      checked={selectedServices.includes(service.id)}
                      onChange={() => toggleService(service.id)}
                    />
                  </label>
                </td>
                <td>
                  <div className="font-bold">{service.name}</div>
                </td>
                <td>{service.description}</td>
                <td>
                  <span className="badge badge-ghost badge-sm">{service.status}</span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}