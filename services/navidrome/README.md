# Navidrome

**Category**: Music  
**Repository**: https://github.com/navidrome/navidrome

Modern music streaming server compatible with Subsonic clients.

## Usage

Start this service:
```bash
just up navidrome
```

Stop this service:
```bash
just stop navidrome
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/navidrome/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
