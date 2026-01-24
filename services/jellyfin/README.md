# Jellyfin

**Category**: Media  
**Repository**: https://github.com/jellyfin/jellyfin

Free media server for movies, TV shows, music, and photos.

## Usage

Start this service:
```bash
just up jellyfin
```

Stop this service:
```bash
just stop jellyfin
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/jellyfin/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
