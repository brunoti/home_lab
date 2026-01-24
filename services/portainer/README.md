# Portainer

**Category**: Monitoring  
**Repository**: https://github.com/portainer/portainer

Docker management UI for containers, images, and networks.

## Usage

Start this service:
```bash
just up portainer
```

Stop this service:
```bash
just stop portainer
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/portainer/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
