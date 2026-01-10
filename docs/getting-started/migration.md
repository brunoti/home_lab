# Migration Guide: Monolithic to Modular Architecture

## Overview

This guide helps you migrate from the old monolithic `docker-compose.yml` to the new modular service architecture.

## What Changed

### Before (Monolithic)
- Single `docker-compose.yml` with all 31 services
- All services started/stopped together
- Harder to manage individual services

### After (Modular)
- Each service in its own `services/<name>/` directory
- Each service has its own `docker-compose.yml`
- Services can be managed individually or collectively
- Better organization and easier maintenance

## Migration Steps

### 1. Stop All Running Services

If you have services running with the old structure:

```bash
# Using the old docker-compose.yml (now preserved as docker-compose.yml.monolithic)
docker-compose -f docker-compose.yml.monolithic down
```

### 2. No Data Migration Needed

**Good news!** Your data is safe. The new structure uses the same volume paths:
- `./data/<service>/` - Service data
- `./config/<service>/` - Service configurations

No data migration is required.

### 3. Start Services with New Structure

```bash
# Start all services with new structure
just services --action start

# Or start services individually
just services --action start --name postgres
just services --action start --name redis
just services --action start --name jellyfin
```

### 4. Verify Services Are Running

```bash
# List all services and their status
just services --action list

# Check status
just services --action status
```

## New Commands

### Managing Individual Services

```bash
# Start a specific service
just services --action start --name jellyfin

# Stop a specific service
just services --action stop --name jellyfin

# Restart a specific service
just services --action restart --name jellyfin

# View logs for a service
just services --action logs --name jellyfin --follow
```

### Managing All Services

```bash
# Start all services
just services --action start

# Stop all services
just services --action stop

# Check status
just services --action status
```

## Key Differences

| Aspect | Old (Monolithic) | New (Modular) |
|--------|------------------|---------------|
| Structure | Single file | 31 directories |
| Start all | `docker-compose up -d` | `just services --action start` |
| Start one | `docker-compose up -d jellyfin` | `just services --action start --name jellyfin` |
| Stop all | `docker-compose down` | `just services --action stop` |
| Logs | `docker-compose logs jellyfin` | `just services --action logs --name jellyfin` |
| Data location | `./data/` | `./data/` (unchanged) |

## Benefits of New Structure

1. **Independent Management**: Start/stop services individually
2. **Clear Organization**: Each service in its own directory
3. **Better Documentation**: Each service has its own README
4. **Easier Troubleshooting**: Isolate and debug specific services
5. **Flexible Deployment**: Deploy only the services you need
6. **Better Git History**: Changes to services are easier to track

## Troubleshooting

### Services Won't Start

1. Ensure the homelab network exists:
```bash
docker network create homelab
```

2. Check if dependent services are running (postgres, redis)

3. View service logs:
```bash
just services --action logs --name <service> --follow
```

### Port Conflicts

If you have port conflicts from old containers:

```bash
# Remove all stopped containers
docker container prune -f

# Check what's using ports
docker ps -a
```

### Permission Issues

If you encounter permission issues:

```bash
# Check volume ownership
ls -la data/

# Fix if needed (example for jellyfin)
sudo chown -R $(id -u):$(id -g) data/jellyfin/
```

## Rollback (If Needed)

If you need to rollback to the old structure:

```bash
# Stop all services
just services --action stop

# Use the preserved monolithic file
docker-compose -f docker-compose.yml.monolithic up -d
```

## Reference: Old docker-compose.yml

The old monolithic `docker-compose.yml` has been preserved as:
```
docker-compose.yml.monolithic
```

You can reference it if needed, but the new modular structure is recommended.

## Getting Help

- Check service-specific README: `cat services/<service>/README.md`
- View documentation: `just docs --action serve`
- Read modular architecture guide: `docs/architecture/modular-services.md`

## Summary

✅ **No data loss** - All existing data remains in place  
✅ **Same functionality** - All services work exactly as before  
✅ **Better management** - New commands for individual service control  
✅ **Easy rollback** - Old structure preserved if needed  
✅ **Improved organization** - Cleaner directory structure  

The migration is straightforward and your data is safe!
