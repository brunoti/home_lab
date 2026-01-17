# Lidarr

Category: Automation

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
cd services/lidarr && docker compose up -d
```

Stop this service:
```bash
cd services/lidarr && docker compose down
```

View logs:
```bash
cd services/lidarr && docker compose logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/lidarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
