# Command Reference

Complete reference for all justfile commands in the home lab.

## Command Structure

All commands follow this pattern:
```bash
just <category> --<flag> <value>
```

## Setup Commands

### Installation

```bash
# Install all dependencies
just install

# Install specific dependency
just install --package orbstack
just install --package docker
```

### Mac Setup

```bash
# Complete Mac environment setup (installs OrbStack if needed)
just setup --target mac

# Setup OrbStack only
just setup --target orbstack

# Configure system preferences
just setup --target system
```

### Configuration Validation

```bash
# Validate all configuration
just setup --target config

# Validate specific service
just setup --target config --service jellyfin

# Check for missing environment variables
just setup --target check-env
```

## Service Management

### Starting Services

```bash
# Start all services
just services --action start

# Start specific service
just services --action start --name jellyfin

# Start service category
just services --action start --category media
```

### Stopping Services

```bash
# Stop all services
just services --action stop

# Stop specific service
just services --action stop --name jellyfin

# Stop gracefully with timeout
just services --action stop --timeout 30
```

### Restarting Services

```bash
# Restart all services
just services --action restart

# Restart specific service
just services --action restart --name jellyfin

# Force restart
just services --action restart --force
```

### Service Status

```bash
# View all service status
just services --action status

# Check specific service
just services --action status --name jellyfin

# Detailed status with health checks
just services --action status --detailed
```

### Service Logs

```bash
# View logs for specific service
just services --action logs --name jellyfin

# Follow logs in real-time
just services --action logs --name jellyfin --follow

# Show last N lines
just services --action logs --name jellyfin --lines 100

# Show logs with timestamps
just services --action logs --name jellyfin --timestamps
```

## Backup & Restore

### Backup Commands

```bash
# Backup to Google Drive
just backup --target gdrive

# Backup to Mega
just backup --target mega

# Local backup
just backup --target local

# Backup specific service
just backup --target gdrive --service jellyfin

# Backup without media files
just backup --target gdrive --exclude media

# Full backup with verification
just backup --target gdrive --verify
```

### Setup Backup Services

```bash
# Setup Google Drive
just backup --target gdrive --action setup

# Setup Mega
just backup --target mega --action setup

# Configure retention policy
just backup --target gdrive --action configure-retention
```

### List Backups

```bash
# List Google Drive backups
just backup --target gdrive --action list

# List Mega backups
just backup --target mega --action list

# List local backups
just backup --target local --action list
```

### Restore Commands

```bash
# Restore from Google Drive (latest)
just restore --source gdrive --date latest

# Restore from specific date
just restore --source gdrive --date 2026-01-10

# Restore specific service
just restore --source gdrive --service jellyfin --date latest

# Restore configuration only
just restore --source gdrive --config-only

# Restore with verification
just restore --source gdrive --date latest --verify
```

### Backup Verification

```bash
# Verify backup integrity
just backup --action verify --source gdrive

# Check backup info
just backup --action info --source gdrive --date 2026-01-10
```

## Music Services

### Koel

```bash
# Import music to Koel
just music --action import --service koel

# Import specific directory
just music --action import --service koel --path /path/to/music

# Re-scan library
just music --action scan --service koel

# Clear cache
just music --action clear-cache --service koel
```

### Navidrome

```bash
# Sync Navidrome library
just music --action sync --service navidrome

# Force full rescan
just music --action rescan --service navidrome

# Update metadata
just music --action update-metadata --service navidrome
```

### General Music Operations

```bash
# Import to all music services
just music --action import

# Check music service status
just music --action status

# View music service logs
just music --action logs --service koel
```

## Book Services

### Calibre

```bash
# Import books to Calibre
just books --action import --service calibre

# Import from specific directory
just books --action import --service calibre --path /path/to/books

# Convert book format
just books --action convert --format epub --input book.pdf

# Check library status
just books --action status --service calibre

# Rebuild library database
just books --action rebuild-db --service calibre
```

### Lazylibrarian

```bash
# Search for books
just books --action search --service lazylibrarian --query "Book Title"

# Import from Lazylibrarian to Calibre
just books --action import-from-lazy

# Sync libraries
just books --action sync --service lazylibrarian

# Check download queue
just books --action queue --service lazylibrarian
```

### Audiobookshelf

```bash
# Import audiobooks
just books --action import --service audiobookshelf --path /path/to/audiobooks

# Scan library
just books --action scan --service audiobookshelf

# Backup library
just books --action backup --service audiobookshelf
```

### General Book Operations

```bash
# Check all book service status
just books --action status

# Import to all book services
just books --action import-all
```

## Monitoring

### Health Checks

```bash
# Run full health check
just monitor --target health

# Check specific service
just monitor --target health --service jellyfin

# Detailed health report
just monitor --target health --detailed
```

### Resource Monitoring

```bash
# Check RAM usage
just monitor --target ram

# Check disk usage
just monitor --target disk

# Check CPU usage
just monitor --target cpu

# Full resource report
just monitor --target resources
```

### Performance Monitoring

```bash
# Generate performance report
just monitor --target performance

# Monitor specific service
just monitor --target service --name jellyfin

# Real-time monitoring
just monitor --target realtime

# Export metrics
just monitor --target export --format json
```

### Service-Specific Monitoring

```bash
# Monitor Jellyfin
just monitor --target service --name jellyfin

# Monitor with alerts
just monitor --target service --name jellyfin --alert

# Monitor multiple services
just monitor --target service --name "jellyfin,koel,calibre"
```

## Testing

### Disaster Recovery Tests

```bash
# Run disaster recovery test
just test --target disaster-recovery

# Test specific service recovery
just test --target disaster-recovery --service jellyfin

# Full recovery simulation
just test --target disaster-recovery --full
```

### Email Tests

```bash
# Test email configuration
just test --target email

# Send test notification
just test --target email --type notification

# Test alert emails
just test --target email --type alert
```

### Backup Tests

```bash
# Test backup procedures
just test --target backups

# Test specific backup target
just test --target backups --source gdrive

# Test restore procedures
just test --target restore
```

### Integration Tests

```bash
# Run all integration tests
just test --target integration

# Test service connectivity
just test --target connectivity

# Test data integrity
just test --target data-integrity
```

## Documentation

### Serve Documentation

```bash
# Start documentation server
just docs --action serve

# Serve on specific port
just docs --action serve --port 8080

# Serve with auto-reload
just docs --action serve --reload
```

### Build Documentation

```bash
# Build static documentation
just docs --action build

# Build and deploy
just docs --action build --deploy
```

### Update Documentation

```bash
# Update documentation dependencies
just docs --action update

# Regenerate all docs
just docs --action regenerate
```

## Advanced Commands

### Database Operations

```bash
# Backup all databases
just database --action backup

# Backup specific database
just database --action backup --name postgres

# Restore database
just database --action restore --name postgres --date 2026-01-10

# Run database maintenance
just database --action maintain
```

### Network Operations

```bash
# Check network connectivity
just network --action check

# Show port mappings
just network --action ports

# Test VPN connection
just network --action test-vpn

# Diagnose network issues
just network --action diagnose
```

### Maintenance

```bash
# Run system maintenance
just maintain --target system

# Clean Docker resources
just maintain --target docker

# Rotate logs
just maintain --target logs

# Update all services
just maintain --target update
```

## Flags and Options

### Global Flags

```bash
--verbose, -v     # Verbose output
--quiet, -q       # Quiet mode (errors only)
--dry-run         # Show what would be done without executing
--force, -f       # Force operation without confirmation
--help, -h        # Show help for command
```

### Common Options

```bash
--name <name>     # Specify service name
--service <svc>   # Specify service
--target <tgt>    # Specify target
--action <act>    # Specify action
--date <date>     # Specify date (YYYY-MM-DD)
--path <path>     # Specify file path
--port <port>     # Specify port number
```

## Examples

### Daily Operations

```bash
# Morning routine
just services --action status
just monitor --target health
just backup --target local

# Check specific service
just services --action logs --name jellyfin --lines 50

# Quick backup
just backup --target gdrive --exclude media
```

### Maintenance Tasks

```bash
# Weekly maintenance
just maintain --target system
just maintain --target docker
just test --target data-integrity

# Monthly tasks
just test --target disaster-recovery
just backup --target gdrive --verify
just maintain --target update
```

### Troubleshooting

```bash
# Service not working
just services --action logs --name <service> --follow
just services --action restart --name <service> --force
just monitor --target service --name <service>

# Performance issues
just monitor --target resources
just monitor --target ram
just services --action status --detailed

# Network issues
just network --action diagnose
just network --action check
```

## Quick Reference Table

| Category | Command | Description |
|----------|---------|-------------|
| Setup | `just install` | Install dependencies |
| Setup | `just setup --target mac` | Setup Mac environment |
| Services | `just services --action start` | Start all services |
| Services | `just services --action stop` | Stop all services |
| Services | `just services --action logs --name X` | View service logs |
| Backup | `just backup --target gdrive` | Backup to Google Drive |
| Restore | `just restore --source gdrive --date latest` | Restore latest backup |
| Music | `just music --action import --service koel` | Import music to Koel |
| Books | `just books --action import --service calibre` | Import books to Calibre |
| Monitor | `just monitor --target health` | Run health check |
| Monitor | `just monitor --target ram` | Check RAM usage |
| Test | `just test --target disaster-recovery` | Test recovery procedures |
| Docs | `just docs --action serve` | Start documentation server |

## Getting Help

For help with any command:
```bash
just --help
just <command> --help
just <category> --action help
```

For detailed documentation:
- [Installation Guide](../getting-started/installation.md)
- [Service Documentation](../services/)
- [Operations Guide](../operations/)
