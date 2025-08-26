# Dashboard Installation Guide

This guide explains how to install and run the Database Monitoring Dashboard.

## Prerequisites

1. **Node.js** (version 18 or higher)
2. **npm** (version 9 or higher)
3. **Git**

## Installation Steps

1. **Navigate to the dashboard directory**:
   ```bash
   cd dashboard
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Run the development server**:
   ```bash
   npm run dev
   ```

4. **Access the dashboard**:
   Open your browser and navigate to http://localhost:3000

## Building for Production

1. **Build the application**:
   ```bash
   npm run build
   ```

2. **Start the production server**:
   ```bash
   npm start
   ```

## Configuration

The dashboard can be configured using environment variables:

- `PORT` - Port to run the server on (default: 3000)
- `NODE_ENV` - Environment (development/production)

## Deployment

The dashboard can be deployed to any platform that supports Node.js applications:

### Vercel (Recommended)
1. Push the code to a GitHub repository
2. Import the repository in Vercel
3. Deploy!

### Other Platforms
- Netlify
- AWS Elastic Beanstalk
- Google Cloud Run
- Azure App Service

## Troubleshooting

### Common Issues

1. **Port already in use**
   - Change the PORT environment variable
   - Kill the process using the port

2. **Dependency installation fails**
   - Clear npm cache: `npm cache clean --force`
   - Delete node_modules and package-lock.json
   - Run `npm install` again

3. **Build fails**
   - Check for TypeScript errors
   - Ensure all dependencies are installed

### Getting Help

If you encounter issues:
1. Check the console for error messages
2. Verify all prerequisites are installed
3. Check the documentation in the README.md file
4. Create an issue in the repository