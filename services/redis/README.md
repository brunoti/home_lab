# Redis

**Category**: Databases  
**Repository**: https://github.com/redis/redis

In-memory data store used for caching and session management.

## Usage

Start this service:
```bash
just up redis
```

Stop this service:
```bash
just stop redis
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/redis/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
