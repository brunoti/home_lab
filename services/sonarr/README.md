# Sonarr

Category: Automation

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
just services --action start --name sonarr
```

Stop this service:
```bash
just services --action stop --name sonarr
```

View logs:
```bash
just services --action logs --name sonarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/sonarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
