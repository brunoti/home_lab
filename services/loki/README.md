# Loki

**Category**: Monitoring  
**Repository**: https://github.com/grafana/loki

Log aggregation system designed for Grafana integration.

## Usage

Start this service:
```bash
just up loki
```

Stop this service:
```bash
just stop loki
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/loki/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
