# Koel

**Category**: Music  
**Repository**: https://github.com/koel/koel

Personal music streaming service with modern web interface.

## Usage

Start this service:
```bash
just up koel
```

Stop this service:
```bash
just stop koel
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/koel/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
