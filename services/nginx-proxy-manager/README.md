# Nginx Proxy Manager

**Category**: Proxy  
**Repository**: https://github.com/NginxProxyManager/nginx-proxy-manager

Reverse proxy manager with SSL/TLS certificate management.

## Usage

Start this service:
```bash
just up nginx-proxy-manager
```

Stop this service:
```bash
just stop nginx-proxy-manager
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/nginx-proxy-manager/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
