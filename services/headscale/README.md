# Headscale

**Category**: Network  
**Repository**: https://github.com/juanfont/headscale

Open-source Tailscale control server for private mesh VPN.

## Usage

Start this service:
```bash
just up headscale
```

Stop this service:
```bash
just stop headscale
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
