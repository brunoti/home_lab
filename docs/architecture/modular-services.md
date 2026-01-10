# Modular Service Architecture

## Overview

The Home Lab repository has been restructured to use a modular architecture where each service is self-contained in its own directory. This provides better organization, easier management, and improved maintainability.

## Directory Structure

```
home_lab/
├── services/                      # All services organized by name
│   ├── jellyfin/
│   │   ├── docker-compose.yml    # Service definition
│   │   └── README.md             # Service-specific documentation
│   ├── postgres/
│   │   ├── docker-compose.yml
│   │   └── README.md
│   └── ...                        # 31 services total
├── config/                        # Shared configuration files
├── data/                          # Service data volumes (created at runtime)
├── scripts/                       # Helper scripts
├── docs/                          # Documentation
├── justfile                       # Task automation
└── .env                          # Environment variables
```

## Benefits

- **Independent service management** - Start, stop, or restart services individually
- **Clear dependencies** - Each service explicitly declares what it needs
- **Easy customization** - Modify services without affecting others
- **Better version control** - Track changes to individual services
- **Simplified troubleshooting** - Debug specific services easily

## Working with Services

### List Services
```bash
just services --action list
```

### Start Services
```bash
# Start all services
just services --action start

# Start specific service
just services --action start --name jellyfin
```

### Stop Services
```bash
# Stop all services
just services --action stop

# Stop specific service
just services --action stop --name jellyfin
```

### View Logs
```bash
just services --action logs --name jellyfin --follow
```

## Service Dependencies

Some services require others to be running first:

**Database-dependent services** (require postgres):
- immich, speedtest-tracker, koel, bookstore, affine, authelia, grafana, nginx-proxy-manager, nextcloud

**Redis-dependent services** (require redis):
- immich, affine, nextcloud

**Recommended start order:**
1. Start postgres and redis
2. Wait for databases to be ready
3. Start dependent services

## Configuration

- **Environment variables**: Shared `.env` file in repository root
- **Volume paths**: Relative to project root (../../data/, ../../config/)
- **Network**: All services use the `homelab` Docker network

## Adding a New Service

1. Create service directory: `mkdir -p services/myservice`
2. Create `docker-compose.yml` with service definition
3. Create `README.md` with documentation
4. Start the service: `just services --action start --name myservice`

See the full documentation for detailed examples and best practices.
