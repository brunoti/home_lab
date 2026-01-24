# Prowlarr

**Category**: Automation  
**Repository**: https://github.com/Prowlarr/Prowlarr

Indexer manager for Sonarr and Radarr.

## Usage

Start this service:
```bash
just up prowlarr
```

Stop this service:
```bash
just stop prowlarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/prowlarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
