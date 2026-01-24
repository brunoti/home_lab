# Audiobookshelf

**Category**: Books  
**Repository**: https://github.com/advplyr/audiobookshelf

Audiobook and podcast server with mobile app support.

## Usage

Start this service:
```bash
just up audiobookshelf
```

Stop this service:
```bash
just stop audiobookshelf
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/audiobookshelf/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
