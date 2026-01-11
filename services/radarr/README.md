# Radarr

Category: Automation

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
just services --action start --name radarr
```

Stop this service:
```bash
just services --action stop --name radarr
```

View logs:
```bash
just services --action logs --name radarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/radarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
