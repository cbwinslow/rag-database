#!/bin/bash

# Test Runner Script
# This script runs the test suite for the dashboard application

echo "=== Running Dashboard Test Suite ==="
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

echo "Running tests..."
echo "==============="
echo

# Run tests based on arguments
if [ $# -eq 0 ]
then
    # Run all tests
    npm test
elif [ "$1" == "watch" ]
then
    # Run tests in watch mode
    npm run test:watch
elif [ "$1" == "coverage" ]
then
    # Run tests with coverage
    npm run test:coverage
elif [ "$1" == "unit" ]
then
    # Run unit tests
    npm run test:unit
elif [ "$1" == "integration" ]
then
    # Run integration tests
    npm run test:integration
elif [ "$1" == "e2e" ]
then
    # Run end-to-end tests
    npm run test:e2e
else
    echo "Usage: $0 [watch|coverage|unit|integration|e2e]"
    echo "  watch       - Run tests in watch mode"
    echo "  coverage    - Run tests with coverage report"
    echo "  unit        - Run unit tests only"
    echo "  integration - Run integration tests only"
    echo "  e2e         - Run end-to-end tests only"
    echo "  (no args)   - Run all tests"
fi