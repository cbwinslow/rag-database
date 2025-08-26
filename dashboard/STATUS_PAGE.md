# Status Page Documentation

The status page provides a public-facing view of the system's operational status.

## Features

1. **Overall System Status** - Shows if all systems are operational
2. **Service Status** - Displays status of individual services
3. **System Metrics** - Shows current CPU, memory, and disk usage
4. **Incident Timeline** - Displays recent incidents and maintenance

## Access

The status page is available at `/status` on the dashboard application.

## API Endpoint

The status page uses the `/api/status` endpoint to retrieve system status information.

## Data Structure

The API returns the following data structure:

```json
{
  "overall": "operational",
  "timestamp": "2023-08-25T10:00:00Z",
  "services": {
    "databases": {
      "postgresql": "operational",
      "supabase": "operational",
      // ... other databases
    },
    "monitoring": {
      "prometheus": "operational",
      "grafana": "operational",
      // ... other monitoring services
    }
  },
  "system": {
    "cpu": 25,
    "memory": 45,
    "disk": 30
  }
}
```

## Implementation

In a production environment, the status API would:

1. Check actual service health
2. Query system metrics
3. Retrieve incident history from a database
4. Return real-time status information

For this implementation, the data is mocked for demonstration purposes.