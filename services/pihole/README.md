# Pi-hole

**Category**: Network  
**Repository**: https://github.com/pi-hole/pi-hole

Network-wide ad blocker and DNS sinkhole.

## Usage

Start this service:
```bash
just up pihole
```

Stop this service:
```bash
just stop pihole
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/pihole/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
