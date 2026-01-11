# Home Lab Justfile
# Simplified command structure with arguments
# Usage: just <category> --<flag> <value>

# Default recipe shows help
default:
    @just --list

# Install dependencies
install package="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{package}}" = "all" ]; then
        echo "Installing all dependencies..."
        command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install colima docker docker-compose || true
        echo "✓ Dependencies installed"
    else
        echo "Installing {{package}}..."
        brew install {{package}}
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
            # Start Colima if not running
            if ! colima status &> /dev/null; then
                echo "Starting Colima..."
                colima start --cpu 8 --memory 8 --disk 100 --arch aarch64 --vm-type vz --mount-type virtiofs || true
            fi
            echo "✓ Mac setup complete"
            ;;
        colima)
            echo "Setting up Colima..."
            colima start --cpu 8 --memory 8 --disk 100 --arch aarch64 --vm-type vz --mount-type virtiofs
            echo "✓ Colima started"
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
            echo "Valid targets: mac, colima, config, system, alerts"
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