# Lidarr

**Category**: Automation  
**Repository**: https://github.com/Lidarr/Lidarr

Music collection manager with automated download handling. Integrates with Prowlarr for indexer management and Transmission for automated downloads.

## Usage

Start this service:
```bash
just up lidarr
```

Stop this service:
```bash
just stop lidarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/lidarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
