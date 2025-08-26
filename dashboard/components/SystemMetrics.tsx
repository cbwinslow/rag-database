'use client'

import { useState, useEffect } from 'react'
import { Chart as ChartJS, ArcElement, Tooltip, Legend, CategoryScale, LinearScale, BarElement } from 'chart.js'
import { Doughnut, Bar } from 'react-chartjs-2'
import { SystemMetrics } from '@/lib/types'

ChartJS.register(ArcElement, Tooltip, Legend, CategoryScale, LinearScale, BarElement)

export default function SystemMetrics() {
  const [metrics, setMetrics] = useState<SystemMetrics>({
    cpu: 45,
    memory: 65,
    disk: 30,
    uptime: '5 days, 3 hours'
  })

  const doughnutData = {
    labels: ['CPU', 'Memory', 'Disk'],
    datasets: [
      {
        data: [metrics.cpu, metrics.memory, metrics.disk],
        backgroundColor: [
          'rgba(255, 99, 132, 0.8)',
          'rgba(54, 162, 235, 0.8)',
          'rgba(255, 206, 86, 0.8)',
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
        ],
        borderWidth: 1,
      },
    ],
  }

  const barData = {
    labels: ['CPU', 'Memory', 'Disk'],
    datasets: [
      {
        label: 'Usage %',
        data: [metrics.cpu, metrics.memory, metrics.disk],
        backgroundColor: [
          'rgba(255, 99, 132, 0.6)',
          'rgba(54, 162, 235, 0.6)',
          'rgba(255, 206, 86, 0.6)',
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
        ],
        borderWidth: 1,
      },
    ],
  }

  const options = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        position: 'bottom' as const,
      },
    },
  }

  return (
    <div className="bg-base-200 rounded-box p-6 h-full">
      <h2 className="text-2xl font-bold mb-4">System Metrics</h2>
      
      <div className="grid grid-cols-2 gap-4 mb-6">
        <div className="bg-base-100 p-4 rounded-box">
          <h3 className="font-bold text-center mb-2">Resource Usage</h3>
          <div className="h-40">
            <Doughnut data={doughnutData} options={options} />
          </div>
        </div>
        
        <div className="bg-base-100 p-4 rounded-box">
          <h3 className="font-bold text-center mb-2">Usage Chart</h3>
          <div className="h-40">
            <Bar data={barData} options={options} />
          </div>
        </div>
      </div>
      
      <div className="stats stats-vertical lg:stats-horizontal shadow">
        <div className="stat">
          <div className="stat-title">CPU Usage</div>
          <div className="stat-value text-2xl">{metrics.cpu}%</div>
          <div className="stat-desc">42% higher than last month</div>
        </div>
        
        <div className="stat">
          <div className="stat-title">Memory</div>
          <div className="stat-value text-2xl">{metrics.memory}%</div>
          <div className="stat-desc">12% higher than last month</div>
        </div>
        
        <div className="stat">
          <div className="stat-title">Disk</div>
          <div className="stat-value text-2xl">{metrics.disk}%</div>
          <div className="stat-desc">5% lower than last month</div>
        </div>
        
        <div className="stat">
          <div className="stat-title">Uptime</div>
          <div className="stat-value text-xl">{metrics.uptime}</div>
          <div className="stat-desc">System running</div>
        </div>
      </div>
    </div>
  )
}