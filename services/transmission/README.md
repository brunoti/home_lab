# Transmission

**Category**: Download  
**Repository**: https://github.com/transmission/transmission

Lightweight BitTorrent client with web interface.

## Usage

Start this service:
```bash
just up transmission
```

Stop this service:
```bash
just stop transmission
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/transmission/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
