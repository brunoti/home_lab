# Radarr

**Category**: Automation  
**Repository**: https://github.com/Radarr/Radarr

Movie collection manager with automated download handling.

## Usage

Start this service:
```bash
just up radarr
```

Stop this service:
```bash
just stop radarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/radarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
