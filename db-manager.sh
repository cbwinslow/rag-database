#!/bin/bash

# Main AI-Enhanced Database & Monitoring Stack Script
# This script provides a unified interface for the entire stack

echo "=== AI-Enhanced Database & Monitoring Stack Manager ==="
echo

show_help() {
    echo "Usage: $0 [command]"
    echo
    echo "Commands:"
    echo "  install        - Install all database and monitoring services"
    echo "  install-ai     - Install all AI-enhanced services"
    echo "  start-services - Start all Docker-based services"
    echo "  start-ai       - Start all AI-enhanced services"
    echo "  stop-services  - Stop all Docker-based services"
    echo "  verify         - Verify installation and service status"
    echo "  status-ai      - Check status of AI services"
    echo "  dashboard      - Start the monitoring dashboard"
    echo "  test           - Run the test suite"
    echo "  help           - Show this help message"
    echo
}

case "$1" in
    install)
        echo "Installing database and monitoring services..."
        echo "============================================="
        cd install
        chmod +x *.sh
        chmod +x components/*.sh
        sudo ./install-databases.sh
        sudo ./install-monitoring.sh
        cd ..
        ;;
    install-ai)
        echo "Installing AI-enhanced services..."
        echo "================================="
        cd install
        chmod +x *.sh
        chmod +x components/*.sh
        chmod +x components/ai/*.sh
        sudo ./install-ai-databases.sh
        cd ..
        ;;
    start-services)
        echo "Starting Docker services..."
        echo "========================="
        cd install
        ./start-docker-services.sh
        cd ..
        ;;
    start-ai)
        echo "Starting AI-enhanced services..."
        echo "=============================="
        cd install
        ./start-ai-services.sh
        cd ..
        ;;
    stop-services)
        echo "Stopping Docker services..."
        echo "========================="
        cd install
        ./stop-docker-services.sh
        cd ..
        ;;
    verify)
        echo "Verifying installation..."
        echo "======================"
        cd install
        ./verify-installation-detailed.sh
        cd ..
        ;;
    status-ai)
        echo "Checking AI services status..."
        echo "============================"
        cd install
        ./check-ai-status.sh
        cd ..
        ;;
    dashboard)
        echo "Starting monitoring dashboard..."
        echo "============================="
        cd dashboard
        ./start-dev.sh
        cd ..
        ;;
    test)
        echo "Running test suite..."
        echo "=================="
        cd dashboard
        ./test.sh
        cd ..
        ;;
    help)
        show_help
        ;;
    *)
        show_help
        ;;
esac