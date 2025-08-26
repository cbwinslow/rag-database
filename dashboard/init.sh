#!/bin/bash

# Dashboard Initialization Script
# This script initializes the Next.js dashboard application

echo "=== Database Monitoring Dashboard Initialization ==="
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    echo "Node.js is not installed. Please install Node.js version 18 or higher."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v)
echo "Node.js version: $NODE_VERSION"

# Check if npm is installed
if ! command -v npm &> /dev/null
then
    echo "npm is not installed. Please install npm."
    exit 1
fi

# Check npm version
NPM_VERSION=$(npm -v)
echo "npm version: $NPM_VERSION"

echo
echo "Installing dependencies..."
echo "========================"

# Install dependencies
npm install

if [ $? -eq 0 ]
then
    echo
    echo "Dependencies installed successfully!"
    echo
    echo "To start the development server, run:"
    echo "  npm run dev"
    echo
    echo "The dashboard will be available at http://localhost:3000"
else
    echo
    echo "Failed to install dependencies. Please check the error messages above."
    exit 1
fi