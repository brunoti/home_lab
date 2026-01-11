# Home Lab Justfile
# Simplified command structure with arguments
# Usage: just <category> --<flag> <value>

# Default recipe shows help
default:
    @just --list

# Start all services or a specific service
up service='all':
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Ensure network exists
    if ! docker network inspect homelab &>/dev/null; then
        echo "Creating homelab network..."
        docker network create homelab
    fi
    
    if [ "{{service}}" = "all" ]; then
        echo "Starting all services..."
        for service_dir in services/*/; do
            if [ -f "${service_dir}docker-compose.yml" ]; then
                service_name=$(basename "$service_dir")
                echo "Starting $service_name..."
                (cd "$service_dir" && docker compose up -d)
            fi
        done
        echo "✓ All services started"
    else
        service_dir="services/{{service}}"
        if [ ! -d "$service_dir" ]; then
            echo "ERROR: Service '{{service}}' does not exist"
            echo "Run 'just services list' to see available services"
            exit 1
        fi
        if [ ! -f "${service_dir}/docker-compose.yml" ]; then
            echo "ERROR: docker-compose.yml not found for service '{{service}}'"
            exit 1
        fi
        echo "Starting {{service}}..."
        (cd "$service_dir" && docker compose up -d)
        echo "✓ {{service}} started"
    fi

# Stop all services or a specific service
stop service='all':
    #!/usr/bin/env bash
    set -euo pipefail
    
    if [ "{{service}}" = "all" ]; then
        echo "Stopping all services..."
        for service_dir in services/*/; do
            if [ -f "${service_dir}docker-compose.yml" ]; then
                service_name=$(basename "$service_dir")
                echo "Stopping $service_name..."
                (cd "$service_dir" && docker compose down)
            fi
        done
        echo "✓ All services stopped"
    else
        service_dir="services/{{service}}"
        if [ ! -d "$service_dir" ]; then
            echo "ERROR: Service '{{service}}' does not exist"
            echo "Run 'just services list' to see available services"
            exit 1
        fi
        if [ ! -f "${service_dir}/docker-compose.yml" ]; then
            echo "ERROR: docker-compose.yml not found for service '{{service}}'"
            exit 1
        fi
        echo "Stopping {{service}}..."
        (cd "$service_dir" && docker compose down)
        echo "✓ {{service}} stopped"
    fi

# Display help information
help:
    @just --list

# Install dependencies
install package="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{package}}" = "all" ]; then
        echo "Installing all dependencies..."
        command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install --cask orbstack
        brew install docker docker-compose || true
        echo "✓ Dependencies installed"
    else
        echo "Installing {{package}}..."
        if [ "{{package}}" = "orbstack" ]; then
            brew install --cask {{package}}
        else
            brew install {{package}}
        fi
        echo "✓ {{package}} installed"
    fi

# Setup commands
setup target="mac" service="all":
    #!/usr/bin/env bash
    set -euo pipefail
    case "{{target}}" in
        mac)
            echo "Setting up Mac environment..."
            # Check for Homebrew
            if ! command -v brew &> /dev/null; then
                echo "Homebrew not found. Please run: just install"
                exit 1
            fi
            # OrbStack starts automatically after installation
            # Verify Docker is available
            if ! docker info &> /dev/null; then
                echo "Docker not available. Please ensure OrbStack is installed and running."
                echo "You can install it with: brew install --cask orbstack"
                exit 1
            fi
            echo "✓ Mac setup complete"
            ;;
        orbstack)
            echo "Setting up OrbStack..."
            if ! command -v brew &> /dev/null; then
                echo "Homebrew not found. Please install it first."
                exit 1
            fi
            brew install --cask orbstack
            echo "✓ OrbStack installed. It will start automatically."
            ;;
        config)
            echo "Validating configuration..."
            if [ ! -f .env ]; then
                echo "ERROR: .env file not found. Copy .env.example to .env"
                exit 1
            fi
            # Check for empty required variables
            EMPTY=$(grep -E "^[A-Z_]+=\s*$" .env | wc -l || true)
            if [ "$EMPTY" -gt 0 ]; then
                echo "WARNING: Found $EMPTY empty environment variables"
                grep -E "^[A-Z_]+=\s*$" .env || true
            else
                echo "✓ Configuration valid"
            fi
            ;;
        system)
            echo "Configuring system preferences..."
            # Create directories
            mkdir -p ~/homelab/{data,config,cache,logs,backups}
            echo "✓ System configured"
            ;;
        alerts)
            echo "Configuring alerts..."
            echo "Alert configuration requires manual setup in Grafana"
            echo "Visit: http://localhost:3000"
            ;;
        *)
            echo "Unknown target: {{target}}"
            echo "Valid targets: mac, orbstack, config, system, alerts"
            exit 1
            ;;
    esac

# Service management - works with new modular structure
services action="status" name="all" category="all" timeout="30" follow="false" lines="100" timestamps="false" detailed="false" force="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Ensure network exists
    if ! docker network inspect homelab &>/dev/null; then
        echo "Creating homelab network..."
        docker network create homelab
    fi
    
    case "{{action}}" in
        status)
            echo "Checking homelab service status..."
            docker ps --format "table {{'{{'}}.Names{{'}}'}}\t{{'{{'}}.Status{{'}}'}}\t{{'{{'}}.Ports{{'}}'}}" | grep -E "^NAMES|homelab" || docker ps
            ;;
        list)
            echo "Available services:"
            for service_dir in services/*/; do
                if [ -f "${service_dir}docker-compose.yml" ]; then
                    service_name=$(basename "$service_dir")
                    echo "  - $service_name"
                fi
            done
            ;;
        *)
            echo "Action {{action}} not yet implemented"
            exit 1
            ;;
    esac