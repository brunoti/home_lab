# Lazylibrarian

**Category**: Books  
**Repository**: https://github.com/lazylibrarian/LazyLibrarian

Automated e-book and audiobook library manager.

## Usage

Start this service:
```bash
just up lazylibrarian
```

Stop this service:
```bash
just stop lazylibrarian
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/lazylibrarian/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
