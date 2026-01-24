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

    if [ "{{ service }}" = "all" ]; then
        echo "Starting all services..."
        for service_dir in services/*/; do
            if [ -f "${service_dir}docker-compose.yml" ]; then
                service_name=$(basename "$service_dir")
                echo "Starting $service_name..."
                # Check environment variables before starting
                if ! ./scripts/check-env-vars.sh "$service_name" 2>&1; then
                    echo "Skipping $service_name due to missing environment variables"
                    continue
                fi
                (cd "$service_dir" && docker compose --env-file ../../.env up -d)
            fi
        done
        echo "✓ All services started"
    else
        service_dir="services/{{ service }}"
        if [ ! -d "$service_dir" ]; then
            echo "ERROR: Service '{{ service }}' does not exist"
            echo "Run 'just services list' to see available services"
            exit 1
        fi
        if [ ! -f "${service_dir}/docker-compose.yml" ]; then
            echo "ERROR: docker-compose.yml not found for service '{{ service }}'"
            exit 1
        fi
        echo "Checking environment variables for {{ service }}..."
        if ! ./scripts/check-env-vars.sh "{{ service }}" 2>&1; then
            echo "Cannot start {{ service }} due to missing environment variables"
            exit 1
        fi
        echo "Starting {{ service }}..."
        (cd "$service_dir" && docker compose --env-file ../../.env up -d)
        echo "✓ {{ service }} started"
    fi

# Stop all services or a specific service
stop service='all':
    #!/usr/bin/env bash
    set -euo pipefail

    if [ "{{ service }}" = "all" ]; then
        echo "Stopping all services..."
        for service_dir in services/*/; do
            if [ -f "${service_dir}docker-compose.yml" ]; then
                service_name=$(basename "$service_dir")
                echo "Stopping $service_name..."
                (cd "$service_dir" && docker compose --env-file ../../.env down)
            fi
        done
        echo "✓ All services stopped"
    else
        service_dir="services/{{ service }}"
        if [ ! -d "$service_dir" ]; then
            echo "ERROR: Service '{{ service }}' does not exist"
            echo "Run 'just services list' to see available services"
            exit 1
        fi
        if [ ! -f "${service_dir}/docker-compose.yml" ]; then
            echo "ERROR: docker-compose.yml not found for service '{{ service }}'"
            exit 1
        fi
        echo "Stopping {{ service }}..."
        (cd "$service_dir" && docker compose --env-file ../../.env down)
        echo "✓ {{ service }} stopped"
    fi

# Display help information
help:
    @just --list

# Install dependencies
install package="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{ package }}" = "all" ]; then
        echo "Installing all dependencies..."
        command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install --cask orbstack
        brew install docker docker-compose || true
        echo "✓ Dependencies installed"
    else
        echo "Installing {{ package }}..."
        if [ "{{ package }}" = "orbstack" ]; then
            brew install --cask {{ package }}
        else
            brew install {{ package }}
        fi
        echo "✓ {{ package }} installed"
    fi

# Setup commands - defaults to Mac
setup target="mac":
    #!/usr/bin/env bash
    set -euo pipefail
    case "{{ target }}" in
        mac)
            echo "Setting up Mac environment..."
            
            # Check for Homebrew, install if missing
            if ! command -v brew &> /dev/null; then
                echo "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            else
                echo "✓ Homebrew already installed"
            fi
            
            # Install OrbStack if not present
            if ! command -v orbctl &> /dev/null; then
                echo "Installing OrbStack..."
                brew install --cask orbstack
                echo "✓ OrbStack installed. It will start automatically."
            else
                echo "✓ OrbStack already installed"
            fi
            
            # Verify Docker is available
            if ! docker info &> /dev/null; then
                echo "⚠ Docker not available. Please ensure OrbStack is running."
                echo "You can start it from Applications or wait for it to auto-start."
                exit 1
            fi
            
            # Create homelab directories
            mkdir -p ~/homelab/{data,config,cache,logs,backups}
            echo "✓ Created homelab directories"
            
            # Setup .env if needed
            if [ ! -f .env ]; then
                echo "Creating .env from .env.example..."
                cp .env.example .env
                echo "⚠ Please run 'just password' to generate secure passwords"
            else
                echo "✓ .env file exists"
            fi
            
            # Create Docker network
            if ! docker network inspect homelab &>/dev/null; then
                echo "Creating homelab network..."
                docker network create homelab
            else
                echo "✓ homelab network exists"
            fi
            
            echo ""
            echo "===================================================="
            echo "✅ Mac setup complete!"
            echo ""
            echo "Next steps:"
            echo "  1. Run 'just password' if you haven't already"
            echo "  2. Run 'just up' to start all services"
            echo "  3. Visit http://localhost:3000 for Homepage dashboard"
            echo "===================================================="
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
        *)
            echo "Unknown target: {{ target }}"
            echo "Valid targets: mac, config"
            exit 1
            ;;
    esac

# Generate secure passwords for all database and secret variables
password:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "🔐 Generating secure passwords for database services"
    echo "===================================================="
    echo ""

    # Check if .env exists
    if [ ! -f .env ]; then
        echo "Creating .env from .env.example..."
        cp .env.example .env
    fi

    # Function to generate a strong 64-character password
    generate_password() {
        openssl rand -hex 32
    }

    # List of variables that need strong passwords
    # Database passwords
    declare -a PASSWORD_VARS=(
        "POSTGRES_PASSWORD"
        "REDIS_PASSWORD"
        "AUTHELIA_STORAGE_POSTGRES_PASSWORD"
        "GF_DATABASE_PASSWORD"
        "KOEL_DB_PASSWORD"
        "SPEEDTEST_TRACKER_DB_PASSWORD"
        "IMMICH_DB_PASSWORD"
        "NEXTCLOUD_DB_PASSWORD"
        "AUDIOBOOKSHELF_DB_PASSWORD"
    )

    # Admin passwords
    declare -a ADMIN_PASSWORD_VARS=(
        "GRAFANA_ADMIN_PASSWORD"
        "GRAFANA_SECURITY_ADMIN_PASSWORD"
        "KOEL_ADMIN_PASSWORD"
        "PIHOLE_WEBPASSWORD"
        "PIHOLE_ADMIN_PASSWORD"
        "PORTAINER_ADMIN_PASSWORD"
        "TRANSMISSION_RPC_PASSWORD"
        "NEXTCLOUD_ADMIN_PASSWORD"
        "NGINX_ADMIN_PASSWORD"
        "FILEBROWSER_ADMIN_PASSWORD"
    )

    # Secrets and keys (JWT, session, app keys)
    declare -a SECRET_VARS=(
        "AFFINE_JWT_SECRET"
        "AUTHELIA_JWT_SECRET"
        "AUTHELIA_SESSION_SECRET"
        "KOEL_APP_KEY"
        "SPEEDTEST_TRACKER_APP_KEY"
        "NEXTCLOUD_SECRET"
        "IMMICH_JWT_SECRET"
    )

    # API keys
    declare -a API_KEY_VARS=(
        "RADARR_API_KEY"
        "SONARR_API_KEY"
        "PROWLARR_API_KEY"
    )

    echo "Generating database passwords..."
    for var in "${PASSWORD_VARS[@]}"; do
        password=$(generate_password)
        if grep -q "^${var}=" .env; then
            # Check if variable is empty or has placeholder
            current_value=$(grep "^${var}=" .env | cut -d= -f2-)
            if [ -z "$current_value" ] || [ "$current_value" = "password" ] || [ "$current_value" = "changeme" ]; then
                sed -i.bak "s|^${var}=.*|${var}=${password}|" .env
                echo "  ✓ ${var}"
            else
                echo "  ⊘ ${var} (already set, skipping)"
            fi
        else
            echo "${var}=${password}" >> .env
            echo "  ✓ ${var}"
        fi
    done

    echo ""
    echo "Generating admin passwords..."
    for var in "${ADMIN_PASSWORD_VARS[@]}"; do
        password=$(generate_password)
        if grep -q "^${var}=" .env; then
            current_value=$(grep "^${var}=" .env | cut -d= -f2-)
            if [ -z "$current_value" ] || [ "$current_value" = "password" ] || [ "$current_value" = "changeme" ]; then
                sed -i.bak "s|^${var}=.*|${var}=${password}|" .env
                echo "  ✓ ${var}"
            else
                echo "  ⊘ ${var} (already set, skipping)"
            fi
        else
            echo "${var}=${password}" >> .env
            echo "  ✓ ${var}"
        fi
    done

    echo ""
    echo "Generating secrets and keys..."
    for var in "${SECRET_VARS[@]}"; do
        secret=$(generate_password)
        if grep -q "^${var}=" .env; then
            current_value=$(grep "^${var}=" .env | cut -d= -f2-)
            if [ -z "$current_value" ] || [ "$current_value" = "secret" ] || [ "$current_value" = "changeme" ]; then
                sed -i.bak "s|^${var}=.*|${var}=${secret}|" .env
                echo "  ✓ ${var}"
            else
                echo "  ⊘ ${var} (already set, skipping)"
            fi
        else
            echo "${var}=${secret}" >> .env
            echo "  ✓ ${var}"
        fi
    done

    echo ""
    echo "Generating API keys..."
    for var in "${API_KEY_VARS[@]}"; do
        # Generate a shorter 32-char key for API keys
        api_key=$(openssl rand -hex 16)
        if grep -q "^${var}=" .env; then
            current_value=$(grep "^${var}=" .env | cut -d= -f2-)
            if [ -z "$current_value" ]; then
                sed -i.bak "s|^${var}=.*|${var}=${api_key}|" .env
                echo "  ✓ ${var}"
            else
                echo "  ⊘ ${var} (already set, skipping)"
            fi
        else
            echo "${var}=${api_key}" >> .env
            echo "  ✓ ${var}"
        fi
    done

    # Clean up backup files
    rm -f .env.bak

    echo ""
    echo "===================================================="
    echo "✅ Password generation complete!"
    echo ""
    echo "All database passwords, admin passwords, secrets, and API keys"
    echo "have been generated and saved to .env file."
    echo ""
    echo "⚠️  IMPORTANT:"
    echo "  - Keep your .env file secure and never commit it to git"
    echo "  - Backup your .env file in a secure location"
    echo "  - Variables that already had values were skipped"
    echo ""
    echo "To regenerate a specific password, delete it from .env and run:"
    echo "  just password"
    echo ""
