# Nginx-Proxy-Manager

Category: Proxy

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
just services --action start --name nginx-proxy-manager
```

Stop this service:
```bash
just services --action stop --name nginx-proxy-manager
```

View logs:
```bash
just services --action logs --name nginx-proxy-manager
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
