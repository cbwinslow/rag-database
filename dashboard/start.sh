#!/bin/bash

# Dashboard Startup Script
# This script starts the Next.js dashboard application

echo "=== Starting Database Monitoring Dashboard ==="
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

# Check if build is needed
if [ ! -d ".next" ]
then
    echo "Build not found. Building the application..."
    npm run build
fi

echo "Starting the dashboard..."
echo "Access the dashboard at http://localhost:3000"
echo "Press Ctrl+C to stop the server"
echo

# Start the server
npm start