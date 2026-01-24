# Homepage

**Category**: Proxy  
**Repository**: https://github.com/benphelps/homepage

Customizable dashboard for accessing all homelab services.

## Usage

Start this service:
```bash
just up homepage
```

Stop this service:
```bash
just stop homepage
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/homepage/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
