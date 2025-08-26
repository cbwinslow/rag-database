import { GET } from '../app/api/health/route'

describe('Health API Route', () => {
  it('returns health status', async () => {
    const response = await GET()
    const data = await response.json()
    
    expect(response.status).toBe(200)
    expect(data.status).toBe('ok')
    expect(data.timestamp).toBeDefined()
    expect(data.version).toBeDefined()
  })

  it('returns correct data structure', async () => {
    const response = await GET()
    const data = await response.json()
    
    expect(data).toEqual({
      status: 'ok',
      timestamp: expect.any(String),
      version: expect.any(String)
    })
  })
})