# Headscale

Category: Network

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
just services --action start --name headscale
```

Stop this service:
```bash
just services --action stop --name headscale
```

View logs:
```bash
just services --action logs --name headscale
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/headscale/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
