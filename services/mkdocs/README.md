# MkDocs

**Category**: Development  
**Repository**: https://github.com/mkdocs/mkdocs

Project documentation site generator with live preview.

## Usage

Start this service:
```bash
just up mkdocs
```

Stop this service:
```bash
just stop mkdocs
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/mkdocs/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
