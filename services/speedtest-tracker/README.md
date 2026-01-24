# Speedtest Tracker

**Category**: Media  
**Repository**: https://github.com/henrywhitaker3/Speedtest-Tracker

Internet speed monitoring with historical data and charts.

## Usage

Start this service:
```bash
just up speedtest-tracker
```

Stop this service:
```bash
just stop speedtest-tracker
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/speedtest-tracker/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
