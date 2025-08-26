import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import ServiceControl from '../components/ServiceControl'
import { Service } from '../lib/types'

describe('ServiceControl', () => {
  const mockServices: Service[] = [
    {
      id: 'service-1',
      name: 'Service 1',
      status: 'running',
      port: 3000,
      type: 'database',
      description: 'First test service'
    },
    {
      id: 'service-2',
      name: 'Service 2',
      status: 'stopped',
      port: 3001,
      type: 'cache',
      description: 'Second test service'
    }
  ]

  it('renders service control component', () => {
    render(<ServiceControl services={mockServices} />)
    
    expect(screen.getByText('Service Control')).toBeInTheDocument()
    expect(screen.getByText('Select All')).toBeInTheDocument()
    expect(screen.getByText('Deselect All')).toBeInTheDocument()
  })

  it('allows service selection', async () => {
    const user = userEvent.setup()
    render(<ServiceControl services={mockServices} />)
    
    const checkboxes = screen.getAllByRole('checkbox')
    // First checkbox is the select all checkbox
    const serviceCheckbox = checkboxes[1]
    
    await user.click(serviceCheckbox)
    expect(serviceCheckbox).toBeChecked()
  })

  it('performs actions on selected services', async () => {
    const user = userEvent.setup()
    render(<ServiceControl services={mockServices} />)
    
    // Select a service
    const checkboxes = screen.getAllByRole('checkbox')
    await user.click(checkboxes[1])
    
    // Click start button
    const startButton = screen.getByText('Start')
    await user.click(startButton)
    
    // Check for action status message
    expect(screen.getByText(/Performing start on 1 services/)).toBeInTheDocument()
  })
})