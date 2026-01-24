# Authelia

**Category**: Network  
**Repository**: https://github.com/authelia/authelia

Authentication and authorization server with 2FA support.

## Usage

Start this service:
```bash
just up authelia
```

Stop this service:
```bash
just stop authelia
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/authelia/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
