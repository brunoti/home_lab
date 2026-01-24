# Rclone

**Category**: Cloud  
**Repository**: https://github.com/rclone/rclone

Cloud storage manager with sync and backup capabilities.

## Usage

Start this service:
```bash
just up rclone
```

Stop this service:
```bash
just stop rclone
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/rclone/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
