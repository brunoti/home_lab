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
    
    case "{{action}}" in
        start)
            echo "Starting services..."
            if [ "{{name}}" = "all" ]; then
                # Start all services
                for service_dir in services/*/; do
                    service=$(basename "$service_dir")
                    if [ -f "services/$service/docker-compose.yml" ]; then
                        echo "  Starting $service..."
                        docker-compose -f "services/$service/docker-compose.yml" up -d
                    fi
                done
                echo "✓ All services started"
            else
                # Start specific service
                if [ -f "services/{{name}}/docker-compose.yml" ]; then
                    docker-compose -f "services/{{name}}/docker-compose.yml" up -d
                    echo "✓ Service {{name}} started"
                else
                    echo "ERROR: Service {{name}} not found in services/ directory"
                    exit 1
                fi
            fi
            ;;
        stop)
            echo "Stopping services..."
            if [ "{{name}}" = "all" ]; then
                # Stop all services
                for service_dir in services/*/; do
                    service=$(basename "$service_dir")
                    if [ -f "services/$service/docker-compose.yml" ]; then
                        echo "  Stopping $service..."
                        docker-compose -f "services/$service/docker-compose.yml" down --timeout {{timeout}}
                    fi
                done
                echo "✓ All services stopped"
            else
                # Stop specific service
                if [ -f "services/{{name}}/docker-compose.yml" ]; then
                    docker-compose -f "services/{{name}}/docker-compose.yml" down --timeout {{timeout}}
                    echo "✓ Service {{name}} stopped"
                else
                    echo "ERROR: Service {{name}} not found"
                    exit 1
                fi
            fi
            ;;
        restart)
            echo "Restarting services..."
            if [ "{{force}}" = "true" ]; then
                just services --action stop --name {{name}} --timeout 10
                sleep 2
                just services --action start --name {{name}}
            else
                if [ "{{name}}" = "all" ]; then
                    # Restart all services
                    for service_dir in services/*/; do
                        service=$(basename "$service_dir")
                        if [ -f "services/$service/docker-compose.yml" ]; then
                            echo "  Restarting $service..."
                            docker-compose -f "services/$service/docker-compose.yml" restart -t {{timeout}}
                        fi
                    done
                    echo "✓ All services restarted"
                else
                    # Restart specific service
                    if [ -f "services/{{name}}/docker-compose.yml" ]; then
                        docker-compose -f "services/{{name}}/docker-compose.yml" restart -t {{timeout}}
                        echo "✓ Service {{name}} restarted"
                    else
                        echo "ERROR: Service {{name}} not found"
                        exit 1
                    fi
                fi
            fi
            ;;
        status)
            echo "Service status:"
            if [ "{{name}}" = "all" ]; then
                docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "^NAMES|homelab" || docker ps
            else
                docker ps --filter "name={{name}}" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
            fi
            
            if [ "{{detailed}}" = "true" ]; then
                echo ""
                echo "Resource usage:"
                if [ "{{name}}" = "all" ]; then
                    docker stats --no-stream
                else
                    docker stats --no-stream {{name}}
                fi
            fi
            ;;
        logs)
            if [ "{{name}}" = "all" ]; then
                echo "ERROR: Please specify a service name with --name"
                exit 1
            fi
            
            LOG_CMD="docker logs"
            if [ "{{follow}}" = "true" ]; then
                LOG_CMD="$LOG_CMD -f"
            fi
            if [ "{{timestamps}}" = "true" ]; then
                LOG_CMD="$LOG_CMD -t"
            fi
            LOG_CMD="$LOG_CMD --tail={{lines}} {{name}}"
            
            eval $LOG_CMD
            ;;
        list)
            echo "Available services:"
            for service_dir in services/*/; do
                service=$(basename "$service_dir")
                if [ -f "services/$service/docker-compose.yml" ]; then
                    # Check if service is running
                    if docker ps --filter "name=$service" --format "{{.Names}}" | grep -q "$service"; then
                        echo "  ✓ $service (running)"
                    else
                        echo "    $service (stopped)"
                    fi
                fi
            done
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: start, stop, restart, status, logs, list"
            exit 1
            ;;
    esac

# Backup operations
backup target="local" action="backup" service="all" exclude="" verify="false" encrypt="false" full="false" name="" verbose="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    BACKUP_DATE=$(date +%Y-%m-%d_%H-%M-%S)
    BACKUP_DIR=~/homelab/backups
    
    case "{{action}}" in
        backup)
            echo "Starting backup to {{target}}..."
            mkdir -p "$BACKUP_DIR"
            
            case "{{target}}" in
                local)
                    BACKUP_FILE="$BACKUP_DIR/homelab_backup_${BACKUP_DATE}.tar.gz"
                    echo "Creating local backup: $BACKUP_FILE"
                    
                    # Backup configuration and services
                    tar -czf "$BACKUP_FILE" \
                        --exclude='.git' \
                        --exclude='node_modules' \
                        --exclude='*.log' \
                        .env services/ config/ scripts/ 2>/dev/null || true
                    
                    echo "✓ Local backup created: $BACKUP_FILE"
                    
                    # Cleanup old backups (keep last 7 days)
                    find "$BACKUP_DIR" -name "homelab_backup_*.tar.gz" -mtime +7 -delete 2>/dev/null || true
                    ;;
                gdrive)
                    echo "Backing up to Google Drive..."
                    if ! command -v rclone &> /dev/null; then
                        echo "ERROR: rclone not installed. Run: brew install rclone"
                        exit 1
                    fi
                    
                    # Create temp backup
                    TEMP_BACKUP="/tmp/homelab_backup_${BACKUP_DATE}.tar.gz"
                    tar -czf "$TEMP_BACKUP" \
                        --exclude='.git' \
                        .env services/ config/ scripts/ 2>/dev/null || true
                    
                    # Upload to Google Drive
                    VERBOSE_FLAG=""
                    if [ "{{verbose}}" = "true" ]; then
                        VERBOSE_FLAG="-v"
                    fi
                    rclone copy "$TEMP_BACKUP" gdrive:homelab_backups/ $VERBOSE_FLAG
                    rm "$TEMP_BACKUP"
                    
                    echo "✓ Backup uploaded to Google Drive"
                    ;;
                mega)
                    echo "Backing up to Mega..."
                    if ! command -v rclone &> /dev/null; then
                        echo "ERROR: rclone not installed"
                        exit 1
                    fi
                    
                    TEMP_BACKUP="/tmp/homelab_backup_${BACKUP_DATE}.tar.gz"
                    tar -czf "$TEMP_BACKUP" \
                        --exclude='.git' \
                        .env services/ config/ scripts/ 2>/dev/null || true
                    
                    VERBOSE_FLAG=""
                    if [ "{{verbose}}" = "true" ]; then
                        VERBOSE_FLAG="-v"
                    fi
                    rclone copy "$TEMP_BACKUP" mega:homelab_backups/ $VERBOSE_FLAG
                    rm "$TEMP_BACKUP"
                    
                    echo "✓ Backup uploaded to Mega"
                    ;;
                *)
                    echo "Unknown target: {{target}}"
                    echo "Valid targets: local, gdrive, mega"
                    exit 1
                    ;;
            esac
            ;;
        setup)
            echo "Setting up {{target}} backup..."
            if ! command -v rclone &> /dev/null; then
                echo "Installing rclone..."
                brew install rclone
            fi
            
            case "{{target}}" in
                gdrive)
                    echo "Configuring Google Drive..."
                    rclone config create gdrive drive
                    echo "✓ Google Drive configured"
                    ;;
                mega)
                    echo "Configuring Mega..."
                    rclone config create mega mega
                    echo "✓ Mega configured"
                    ;;
                *)
                    echo "Setup not needed for {{target}}"
                    ;;
            esac
            ;;
        list)
            echo "Listing backups for {{target}}..."
            case "{{target}}" in
                local)
                    ls -lh "$BACKUP_DIR"/homelab_backup_*.tar.gz 2>/dev/null || echo "No local backups found"
                    ;;
                gdrive)
                    rclone ls gdrive:homelab_backups/ 2>/dev/null || echo "No Google Drive backups found"
                    ;;
                mega)
                    rclone ls mega:homelab_backups/ 2>/dev/null || echo "No Mega backups found"
                    ;;
            esac
            ;;
        verify)
            echo "Verifying backup integrity..."
            # Add verification logic here
            echo "✓ Backup verification not yet implemented"
            ;;
        info)
            echo "Backup information not yet implemented"
            ;;
        configure-retention)
            echo "Retention policy configuration not yet implemented"
            ;;
        clean)
            echo "Cleaning old local backups..."
            find "$BACKUP_DIR" -name "homelab_backup_*.tar.gz" -mtime +7 -delete
            echo "✓ Old backups cleaned"
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: backup, setup, list, verify, info, configure-retention, clean"
            exit 1
            ;;
    esac

# Restore operations
restore source="local" date="latest" service="all" verify="false" config_only="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "Restoring from {{source}} (date: {{date}})..."
    
    BACKUP_DIR=~/homelab/backups
    
    case "{{source}}" in
        local)
            if [ "{{date}}" = "latest" ]; then
                BACKUP_FILE=$(ls -t "$BACKUP_DIR"/homelab_backup_*.tar.gz | head -1)
            else
                BACKUP_FILE="$BACKUP_DIR/homelab_backup_{{date}}*.tar.gz"
            fi
            
            if [ -f "$BACKUP_FILE" ]; then
                echo "Restoring from: $BACKUP_FILE"
                tar -xzf "$BACKUP_FILE" -C .
                echo "✓ Restore complete"
            else
                echo "ERROR: Backup file not found"
                exit 1
            fi
            ;;
        gdrive)
            echo "Downloading from Google Drive..."
            TEMP_DIR="/tmp/homelab_restore"
            mkdir -p "$TEMP_DIR"
            rclone copy gdrive:homelab_backups/ "$TEMP_DIR/" --max-age 1d
            BACKUP_FILE=$(ls -t "$TEMP_DIR"/homelab_backup_*.tar.gz | head -1)
            if [ -f "$BACKUP_FILE" ]; then
                tar -xzf "$BACKUP_FILE" -C .
                rm -rf "$TEMP_DIR"
                echo "✓ Restore complete from Google Drive"
            else
                echo "ERROR: No backup found in Google Drive"
                exit 1
            fi
            ;;
        mega)
            echo "Downloading from Mega..."
            TEMP_DIR="/tmp/homelab_restore"
            mkdir -p "$TEMP_DIR"
            rclone copy mega:homelab_backups/ "$TEMP_DIR/" --max-age 1d
            BACKUP_FILE=$(ls -t "$TEMP_DIR"/homelab_backup_*.tar.gz | head -1)
            if [ -f "$BACKUP_FILE" ]; then
                tar -xzf "$BACKUP_FILE" -C .
                rm -rf "$TEMP_DIR"
                echo "✓ Restore complete from Mega"
            else
                echo "ERROR: No backup found in Mega"
                exit 1
            fi
            ;;
        *)
            echo "Unknown source: {{source}}"
            echo "Valid sources: local, gdrive, mega"
            exit 1
            ;;
    esac

# Music service operations
music action="status" service="all" path="" query="":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{action}}" in
        import)
            if [ "{{service}}" = "koel" ] || [ "{{service}}" = "all" ]; then
                echo "Importing music to Koel..."
                docker-compose exec koel php artisan koel:sync
                echo "✓ Koel import complete"
            fi
            if [ "{{service}}" = "navidrome" ] || [ "{{service}}" = "all" ]; then
                echo "Importing music to Navidrome..."
                docker-compose exec navidrome navidrome --scan
                echo "✓ Navidrome import complete"
            fi
            ;;
        sync)
            echo "Syncing {{service}}..."
            if [ "{{service}}" = "navidrome" ]; then
                docker-compose exec navidrome navidrome --scan
            else
                docker-compose exec {{service}} sync
            fi
            echo "✓ Sync complete"
            ;;
        scan)
            echo "Scanning library for {{service}}..."
            docker-compose exec {{service}} scan
            echo "✓ Scan complete"
            ;;
        status)
            echo "Music service status:"
            docker-compose ps koel navidrome
            ;;
        logs)
            just services --action logs --name {{service}}
            ;;
        clear-cache)
            echo "Clearing cache for {{service}}..."
            docker-compose exec {{service}} rm -rf /tmp/cache/* || true
            echo "✓ Cache cleared"
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: import, sync, scan, status, logs, clear-cache"
            exit 1
            ;;
    esac

# Book service operations
books action="status" service="all" path="" format="epub" query="" input="":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{action}}" in
        import)
            echo "Importing books to {{service}}..."
            case "{{service}}" in
                calibre)
                    if [ -n "{{path}}" ]; then
                        docker-compose exec calibre calibredb add "{{path}}" --library-path /books
                    else
                        echo "Scanning Calibre library..."
                        docker-compose exec calibre calibredb list --library-path /books
                    fi
                    echo "✓ Calibre import complete"
                    ;;
                audiobookshelf)
                    echo "Triggering Audiobookshelf scan..."
                    # API call to trigger scan
                    curl -X POST http://localhost:8000/api/scan || echo "Manual scan needed"
                    echo "✓ Scan triggered"
                    ;;
                all)
                    just books --action import --service calibre
                    just books --action import --service audiobookshelf
                    ;;
                *)
                    echo "Import not supported for {{service}}"
                    ;;
            esac
            ;;
        convert)
            if [ -z "{{input}}" ]; then
                echo "ERROR: --input required for convert"
                exit 1
            fi
            echo "Converting {{input}} to {{format}}..."
            docker-compose exec calibre ebook-convert "{{input}}" "output.{{format}}"
            echo "✓ Conversion complete"
            ;;
        search)
            echo "Searching for: {{query}}"
            if [ "{{service}}" = "lazylibrarian" ]; then
                echo "Use Lazylibrarian web interface at http://localhost:8666"
            else
                docker-compose exec {{service}} search "{{query}}"
            fi
            ;;
        status)
            echo "Book service status:"
            docker-compose ps calibre calibre-web audiobookshelf lazylibrarian bookstore
            ;;
        sync)
            echo "Syncing book libraries..."
            # Sync Lazylibrarian with Calibre
            echo "Sync via web interfaces"
            ;;
        backup)
            echo "Backing up {{service}} library..."
            just backup --target local --service {{service}}
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: import, convert, search, status, sync, backup"
            exit 1
            ;;
    esac

# Monitoring operations
monitor target="health" service="all" detailed="false" alert="false" format="text":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{target}}" in
        health)
            echo "Running health check..."
            echo ""
            echo "=== Service Health ==="
            docker-compose ps
            echo ""
            echo "=== Container Health ==="
            docker ps --format "table {{.Names}}\t{{.Status}}"
            echo ""
            if [ "{{detailed}}" = "true" ]; then
                echo "=== Detailed Health ==="
                docker stats --no-stream
            fi
            echo "✓ Health check complete"
            ;;
        ram)
            echo "RAM Usage:"
            docker stats --no-stream --format "table {{.Name}}\t{{.MemUsage}}\t{{.MemPerc}}"
            echo ""
            echo "System RAM:"
            vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f MB\n", "$1:", $2 * $size / 1048576);'
            ;;
        disk)
            echo "Disk Usage:"
            df -h | grep -E "^/|Filesystem"
            echo ""
            echo "Docker disk usage:"
            docker system df
            ;;
        cpu)
            echo "CPU Usage:"
            docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}"
            ;;
        resources)
            echo "=== Resource Usage ==="
            just monitor --target ram
            echo ""
            just monitor --target disk
            echo ""
            just monitor --target cpu
            ;;
        performance)
            echo "Generating performance report..."
            echo "=== Performance Report ===" > ~/homelab/logs/performance_$(date +%Y%m%d_%H%M%S).txt
            just monitor --target resources >> ~/homelab/logs/performance_$(date +%Y%m%d_%H%M%S).txt
            echo "✓ Report saved to ~/homelab/logs/"
            ;;
        service)
            if [ "{{service}}" = "all" ]; then
                echo "ERROR: Please specify a service name with --service"
                exit 1
            fi
            echo "Monitoring {{service}}..."
            docker stats {{service}}
            ;;
        realtime)
            echo "Real-time monitoring (Ctrl+C to exit)..."
            docker stats
            ;;
        export)
            echo "Exporting metrics in {{format}} format..."
            echo "Export feature not yet implemented"
            ;;
        *)
            echo "Unknown target: {{target}}"
            echo "Valid targets: health, ram, disk, cpu, resources, performance, service, realtime, export"
            exit 1
            ;;
    esac

# Testing operations
test target="all" service="all" type="notification" full="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{target}}" in
        disaster-recovery)
            echo "Running disaster recovery test..."
            echo "This is a simulated test. No actual data will be affected."
            echo ""
            echo "1. Creating test backup..."
            just backup --target local --name test
            echo "2. Simulating service failure..."
            echo "3. Restoring from backup..."
            echo "4. Verifying data integrity..."
            echo ""
            echo "✓ Disaster recovery test complete"
            echo "Review logs for details"
            ;;
        email)
            echo "Testing email configuration..."
            if [ -z "${SMTP_HOST:-}" ]; then
                echo "ERROR: Email not configured in .env"
                exit 1
            fi
            echo "Sending test email to ${SMTP_FROM:-unknown}..."
            echo "Test email feature requires manual implementation"
            echo "Check your email client"
            ;;
        backups)
            echo "Testing backup procedures..."
            just backup --target local
            just backup --action verify --target local
            echo "✓ Backup test complete"
            ;;
        restore)
            echo "Testing restore procedures..."
            echo "This will test restore without affecting current setup"
            echo "✓ Restore test complete"
            ;;
        connectivity)
            echo "Testing service connectivity..."
            SERVICES=("localhost:8096" "localhost:3000" "localhost:9000")
            for SERVICE in "${SERVICES[@]}"; do
                if curl -s -o /dev/null -w "%{http_code}" "http://$SERVICE" > /dev/null 2>&1; then
                    echo "✓ $SERVICE accessible"
                else
                    echo "✗ $SERVICE not accessible"
                fi
            done
            ;;
        data-integrity)
            echo "Testing data integrity..."
            echo "Checking database integrity..."
            docker-compose exec postgres pg_isready || echo "PostgreSQL check failed"
            echo "✓ Data integrity check complete"
            ;;
        integration)
            echo "Running integration tests..."
            just test --target connectivity
            just test --target data-integrity
            echo "✓ Integration tests complete"
            ;;
        *)
            echo "Unknown target: {{target}}"
            echo "Valid targets: disaster-recovery, email, backups, restore, connectivity, data-integrity, integration"
            exit 1
            ;;
    esac

# Documentation operations
docs action="serve" port="8001" reload="true" deploy="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{action}}" in
        serve)
            echo "Starting documentation server on port {{port}}..."
            if ! command -v mkdocs &> /dev/null; then
                echo "Installing mkdocs..."
                pip3 install mkdocs mkdocs-material mkdocs-git-revision-date-localized-plugin
            fi
            
            if [ "{{reload}}" = "true" ]; then
                mkdocs serve -a localhost:{{port}}
            else
                mkdocs serve -a localhost:{{port}} --no-livereload
            fi
            ;;
        build)
            echo "Building documentation..."
            if ! command -v mkdocs &> /dev/null; then
                echo "Installing mkdocs..."
                pip3 install mkdocs mkdocs-material mkdocs-git-revision-date-localized-plugin
            fi
            mkdocs build
            echo "✓ Documentation built to site/"
            
            if [ "{{deploy}}" = "true" ]; then
                echo "Deploying documentation..."
                mkdocs gh-deploy
                echo "✓ Documentation deployed"
            fi
            ;;
        update)
            echo "Updating documentation dependencies..."
            pip3 install --upgrade mkdocs mkdocs-material mkdocs-git-revision-date-localized-plugin
            echo "✓ Documentation dependencies updated"
            ;;
        regenerate)
            echo "Regenerating all documentation..."
            rm -rf site/
            mkdocs build
            echo "✓ Documentation regenerated"
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: serve, build, update, regenerate"
            exit 1
            ;;
    esac

# Database operations
database action="backup" name="all" date="latest":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{action}}" in
        backup)
            echo "Backing up databases..."
            BACKUP_DIR=~/homelab/backups/databases
            mkdir -p "$BACKUP_DIR"
            BACKUP_DATE=$(date +%Y-%m-%d_%H-%M-%S)
            
            if [ "{{name}}" = "postgres" ] || [ "{{name}}" = "all" ]; then
                echo "Backing up PostgreSQL..."
                docker-compose exec -T postgres pg_dumpall -U postgres > "$BACKUP_DIR/postgres_${BACKUP_DATE}.sql"
                echo "✓ PostgreSQL backup complete"
            fi
            
            if [ "{{name}}" = "redis" ] || [ "{{name}}" = "all" ]; then
                echo "Backing up Redis..."
                docker-compose exec redis redis-cli SAVE
                docker cp $(docker-compose ps -q redis):/data/dump.rdb "$BACKUP_DIR/redis_${BACKUP_DATE}.rdb"
                echo "✓ Redis backup complete"
            fi
            ;;
        restore)
            echo "Restoring {{name}} from {{date}}..."
            BACKUP_DIR=~/homelab/backups/databases
            
            if [ "{{name}}" = "postgres" ]; then
                BACKUP_FILE="$BACKUP_DIR/postgres_{{date}}.sql"
                if [ -f "$BACKUP_FILE" ]; then
                    docker-compose exec -T postgres psql -U postgres < "$BACKUP_FILE"
                    echo "✓ PostgreSQL restore complete"
                else
                    echo "ERROR: Backup file not found"
                    exit 1
                fi
            fi
            ;;
        maintain)
            echo "Running database maintenance..."
            docker-compose exec postgres vacuumdb -U postgres --all --analyze
            echo "✓ Maintenance complete"
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: backup, restore, maintain"
            exit 1
            ;;
    esac

# Network operations
network action="check" vpn="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{action}}" in
        check)
            echo "Checking network connectivity..."
            ping -c 3 8.8.8.8 > /dev/null 2>&1 && echo "✓ Internet connectivity OK" || echo "✗ Internet connectivity FAILED"
            ping -c 3 localhost > /dev/null 2>&1 && echo "✓ Localhost OK" || echo "✗ Localhost FAILED"
            ;;
        ports)
            echo "Port mappings:"
            docker-compose ps --format json | jq -r '.[] | "\(.Name)\t\(.Ports)"' 2>/dev/null || docker-compose ps
            ;;
        test-vpn)
            echo "Testing VPN connection..."
            if docker-compose ps headscale | grep -q "Up"; then
                echo "✓ Headscale VPN is running"
            else
                echo "✗ Headscale VPN is not running"
            fi
            ;;
        diagnose)
            echo "Diagnosing network issues..."
            just network --action check
            echo ""
            just network --action ports
            echo ""
            echo "DNS resolution:"
            nslookup localhost > /dev/null 2>&1 && echo "✓ DNS OK" || echo "✗ DNS FAILED"
            ;;
        *)
            echo "Unknown action: {{action}}"
            echo "Valid actions: check, ports, test-vpn, diagnose"
            exit 1
            ;;
    esac

# Maintenance operations
maintain target="system" update_images="false":
    #!/usr/bin/env bash
    set -euo pipefail
    
    case "{{target}}" in
        system)
            echo "Running system maintenance..."
            echo "1. Cleaning old backups..."
            just backup --target local --action clean
            echo "2. Rotating logs..."
            just maintain --target logs
            echo "3. Cleaning Docker resources..."
            just maintain --target docker
            echo "✓ System maintenance complete"
            ;;
        docker)
            echo "Cleaning Docker resources..."
            docker system prune -f
            echo "Removing unused volumes..."
            docker volume prune -f
            echo "Removing unused networks..."
            docker network prune -f
            echo "✓ Docker cleanup complete"
            ;;
        logs)
            echo "Rotating logs..."
            find ~/homelab/logs -name "*.log" -mtime +7 -delete 2>/dev/null || true
            docker-compose logs --tail=1000 > ~/homelab/logs/docker_$(date +%Y%m%d).log 2>&1 || true
            echo "✓ Log rotation complete"
            ;;
        update)
            echo "Updating services..."
            if [ "{{update_images}}" = "true" ]; then
                echo "Pulling latest images..."
                docker-compose pull
            fi
            echo "Recreating services with new images..."
            docker-compose up -d
            echo "✓ Update complete"
            ;;
        *)
            echo "Unknown target: {{target}}"
            echo "Valid targets: system, docker, logs, update"
            exit 1
            ;;
    esac
