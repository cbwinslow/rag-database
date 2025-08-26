#!/bin/bash

# Dashboard Development Startup Script
# This script starts the Next.js dashboard in development mode

echo "=== Starting Database Monitoring Dashboard (Development Mode) ==="
echo

# Check if we're in the dashboard directory
if [ ! -f "package.json" ]
then
    echo "Error: package.json not found. Please run this script from the dashboard directory."
    exit 1
fi

# Check if dependencies are installed
if [ ! -d "node_modules" ]
then
    echo "Dependencies not found. Installing dependencies..."
    npm install
fi

echo "Starting the dashboard in development mode..."
echo "Access the dashboard at http://localhost:3000"
echo "The application will automatically reload on code changes"
echo "Press Ctrl+C to stop the server"
echo

# Start the development server
npm run dev