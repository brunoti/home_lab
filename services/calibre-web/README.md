# Calibre-web

**Category**: Books  
**Repository**: https://github.com/janeczku/calibre-web

Web interface for browsing and managing Calibre e-book library.

## Usage

Start this service:
```bash
just up calibre-web
```

Stop this service:
```bash
just stop calibre-web
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/calibre-web/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
