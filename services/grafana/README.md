# Grafana

**Category**: Monitoring  
**Repository**: https://github.com/grafana/grafana

Visualization and monitoring platform for metrics and logs.

## Usage

Start this service:
```bash
just up grafana
```

Stop this service:
```bash
just stop grafana
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/grafana/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
