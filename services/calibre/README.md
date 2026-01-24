# Calibre

**Category**: Books  
**Repository**: https://github.com/kovidgoyal/calibre

E-book library management and conversion tool.

## Usage

Start this service:
```bash
just up calibre
```

Stop this service:
```bash
just stop calibre
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/calibre/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
