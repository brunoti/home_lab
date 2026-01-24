# Immich

**Category**: Media  
**Repository**: https://github.com/immich-app/immich

Self-hosted photo and video backup solution with mobile apps.

## Usage

Start this service:
```bash
just up immich
```

Stop this service:
```bash
just stop immich
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/immich/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
