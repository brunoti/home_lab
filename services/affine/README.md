# Affine

**Category**: Notes  
**Repository**: https://github.com/toeverything/affine

Open-source design tool combining notes, whiteboards, and databases.

## Usage

Start this service:
```bash
just up affine
```

Stop this service:
```bash
just stop affine
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/affine/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
