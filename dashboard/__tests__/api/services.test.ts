import { GET } from '../app/api/services/route'

describe('Services API Route', () => {
  it('returns service data', async () => {
    const response = await GET()
    const data = await response.json()
    
    expect(response.status).toBe(200)
    expect(data.services).toBeDefined()
    expect(Array.isArray(data.services)).toBe(true)
    expect(data.services.length).toBeGreaterThan(0)
  })

  it('returns services with correct structure', async () => {
    const response = await GET()
    const data = await response.json()
    
    const service = data.services[0]
    expect(service).toHaveProperty('id')
    expect(service).toHaveProperty('name')
    expect(service).toHaveProperty('status')
    expect(service).toHaveProperty('port')
    expect(service).toHaveProperty('type')
    expect(service).toHaveProperty('description')
  })
})