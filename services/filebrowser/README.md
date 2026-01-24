# Filebrowser

**Category**: Development  
**Repository**: https://github.com/filebrowser/filebrowser

Web-based file manager with sharing and upload capabilities.

## Usage

Start this service:
```bash
just up filebrowser
```

Stop this service:
```bash
just stop filebrowser
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/filebrowser/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
