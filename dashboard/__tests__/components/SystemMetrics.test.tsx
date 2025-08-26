import { render, screen } from '@testing-library/react'
import SystemMetrics from '../components/SystemMetrics'

// Mock chart components since they require canvas
jest.mock('react-chartjs-2', () => ({
  Doughnut: () => <div data-testid="doughnut-chart" />,
  Bar: () => <div data-testid="bar-chart" />
}))

describe('SystemMetrics', () => {
  it('renders system metrics component', () => {
    render(<SystemMetrics />)
    
    expect(screen.getByText('System Metrics')).toBeInTheDocument()
    expect(screen.getByText('Resource Usage')).toBeInTheDocument()
    expect(screen.getByText('Usage Chart')).toBeInTheDocument()
  })

  it('displays metric values', () => {
    render(<SystemMetrics />)
    
    // These might be in the stats component
    // We'll check for the presence of stats elements
    const stats = screen.getAllByTestId('stat')
    expect(stats).toHaveLength(4) // CPU, Memory, Disk, Uptime
  })
})