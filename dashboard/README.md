# Database Monitoring Dashboard

This is a Next.js application that provides a real-time dashboard for monitoring all installed database and monitoring services.

## Features

1. **Real-time Service Status** - View the current status of all services
2. **System Metrics** - Monitor CPU, memory, and disk usage
3. **Service Control** - Start, stop, and restart services
4. **Responsive Design** - Works on desktop and mobile devices
5. **Dark/Light Theme** - Toggle between themes based on preference

## Technology Stack

- **Next.js 13** - React framework with App Router
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first CSS framework
- **DaisyUI** - Component library for Tailwind CSS
- **Chart.js** - Data visualization
- **React Chartjs 2** - React wrapper for Chart.js

## Installation

1. Navigate to the dashboard directory:
   ```bash
   cd dashboard
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the development server:
   ```bash
   npm run dev
   ```

4. Open your browser to http://localhost:3000

## Building for Production

1. Build the application:
   ```bash
   npm run build
   ```

2. Start the production server:
   ```bash
   npm start
   ```

## Project Structure

```
dashboard/
├── app/                 # Next.js app directory
│   ├── api/             # API routes
│   ├── layout.tsx       # Root layout
│   └── page.tsx         # Main page
├── components/          # React components
│   ├── ServiceStatus.tsx # Service status display
│   ├── SystemMetrics.tsx # System metrics charts
│   └── ServiceControl.tsx # Service control panel
├── lib/                 # Utility functions and types
│   └── types.ts         # TypeScript types
├── styles/              # Global styles
│   └── globals.css      # Tailwind CSS imports
├── public/              # Static assets
├── package.json         # Project dependencies
├── tsconfig.json        # TypeScript configuration
├── tailwind.config.js   # Tailwind CSS configuration
└── postcss.config.js    # PostCSS configuration
```

## API Routes

- `GET /api/services` - Returns the status of all services

## Components

### ServiceStatus

Displays a table of all services with their current status, port, and type.

### SystemMetrics

Shows system resource usage with charts and statistics.

### ServiceControl

Provides controls to manage services (start, stop, restart).

## Customization

### Themes

The dashboard uses DaisyUI themes. You can change the theme by modifying the `data-theme` attribute in `app/layout.tsx`.

### Adding New Services

1. Add the service to the `services` array in `app/api/services/route.ts`
2. The dashboard will automatically display the new service

### Modifying Charts

Charts are implemented using Chart.js and react-chartjs-2. You can customize them by modifying the options in `components/SystemMetrics.tsx`.

## Deployment

The dashboard can be deployed to any platform that supports Next.js, including:

- Vercel (recommended)
- Netlify
- AWS
- Google Cloud
- Azure

For Vercel deployment:
1. Push the code to a GitHub repository
2. Import the repository in Vercel
3. Deploy!

## Future Enhancements

1. **Real Service Integration** - Connect to actual services to get real status
2. **Authentication** - Add user authentication and authorization
3. **Service Logs** - Display real-time service logs
4. **Alerts** - Implement alerting for service issues
5. **Historical Data** - Store and display historical metrics
6. **Service Details** - Detailed pages for each service