import { render, screen } from '@testing-library/react'
import ServiceStatus from '../components/ServiceStatus'
import { Service } from '../lib/types'

describe('ServiceStatus', () => {
  const mockServices: Service[] = [
    {
      id: 'test-service',
      name: 'Test Service',
      status: 'running',
      port: 3000,
      type: 'database',
      description: 'A test service'
    }
  ]

  it('renders service data correctly', () => {
    render(<ServiceStatus services={mockServices} />)
    
    expect(screen.getByText('Test Service')).toBeInTheDocument()
    expect(screen.getByText('A test service')).toBeInTheDocument()
    expect(screen.getByText('3000')).toBeInTheDocument()
  })

  it('displays correct status color', () => {
    render(<ServiceStatus services={mockServices} />)
    
    const statusIndicator = screen.getByTestId('status-indicator')
    expect(statusIndicator).toHaveClass('bg-green-500')
  })

  it('handles empty service list', () => {
    render(<ServiceStatus services={[]} />)
    
    // Table should still render but with no data rows
    const rows = screen.getAllByRole('row')
    // Only header row should be present
    expect(rows).toHaveLength(1)
  })
})