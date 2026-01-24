# Uptime Kuma

**Category**: Monitoring  
**Repository**: https://github.com/louislam/uptime-kuma

Self-hosted uptime monitoring with notifications.

## Usage

Start this service:
```bash
just up uptime-kuma
```

Stop this service:
```bash
just stop uptime-kuma
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/uptime-kuma/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
