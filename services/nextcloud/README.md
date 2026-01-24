# Nextcloud

**Category**: Cloud  
**Repository**: https://github.com/nextcloud/server

Self-hosted file sync, share, and collaboration platform.

## Usage

Start this service:
```bash
just up nextcloud
```

Stop this service:
```bash
just stop nextcloud
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/nextcloud/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
