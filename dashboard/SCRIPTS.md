# Dashboard Scripts Documentation

This document describes the various scripts available in the dashboard directory.

## Initialization Scripts

### `init.sh`
Initializes the dashboard application by installing all dependencies.

**Usage**:
```bash
./init.sh
```

**What it does**:
1. Checks if Node.js and npm are installed
2. Verifies versions
3. Installs all dependencies with `npm install`

## Startup Scripts

### `start-dev.sh`
Starts the dashboard in development mode with hot reloading.

**Usage**:
```bash
./start-dev.sh
```

**What it does**:
1. Checks if dependencies are installed
2. Starts the Next.js development server
3. Application available at http://localhost:3000
4. Automatically reloads on code changes

### `start.sh`
Starts the dashboard in production mode.

**Usage**:
```bash
./start.sh
```

**What it does**:
1. Checks if dependencies are installed
2. Builds the application if needed
3. Starts the production server
4. Application available at http://localhost:3000

## Test Scripts

### `test.sh`
Runs the test suite with various options.

**Usage**:
```bash
./test.sh              # Run all tests
./test.sh watch        # Run tests in watch mode
./test.sh coverage     # Run tests with coverage report
./test.sh unit         # Run unit tests only
./test.sh integration  # Run integration tests only
./test.sh e2e          # Run end-to-end tests only
```

## Directory Structure

```
dashboard/
├── init.sh          # Initialization script
├── start-dev.sh     # Development startup script
├── start.sh         # Production startup script
├── test.sh          # Test runner script
├── package.json     # Project dependencies
├── ...              # Other files
```

## Prerequisites

All scripts require:
- Node.js (version 18 or higher)
- npm (version 9 or higher)
- Bash shell

## Troubleshooting

### Common Issues

1. **Permission denied**
   - Make sure scripts are executable: `chmod +x *.sh`

2. **Command not found**
   - Ensure you're running scripts from the dashboard directory

3. **Node.js not found**
   - Install Node.js from https://nodejs.org/

### Getting Help

For issues with these scripts:
1. Check the console output for error messages
2. Verify all prerequisites are installed
3. Check file permissions
4. Review the script contents for troubleshooting