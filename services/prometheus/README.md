# Prometheus

**Category**: Monitoring  
**Repository**: https://github.com/prometheus/prometheus

Metrics collection and alerting system for time-series data.

## Usage

Start this service:
```bash
just up prometheus
```

Stop this service:
```bash
just stop prometheus
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/prometheus/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
