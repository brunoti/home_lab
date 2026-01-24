# Sonarr

**Category**: Automation  
**Repository**: https://github.com/Sonarr/Sonarr

TV series collection manager with automated download handling.

## Usage

Start this service:
```bash
just up sonarr
```

Stop this service:
```bash
just stop sonarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/sonarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
