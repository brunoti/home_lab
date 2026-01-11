# Wingfit

Category: Fitness

## Service Information

Wingfit is a minimalist fitness app for planning workouts, tracking records, and integrating smartwatch data. It's privacy-focused and fully open-source.

## Usage

Start this service:
```bash
just services --action start --name wingfit
```

Stop this service:
```bash
just services --action stop --name wingfit
```

View logs:
```bash
just services --action logs --name wingfit
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/wingfit/`

## Ports

See `docker-compose.yml` for port mappings. Default: 8080

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.

## Features

- Workout planning and tracking
- Record management
- Smartwatch data integration
- Privacy-focused, open-source
- FastAPI/SQLModel backend
- Angular frontend
- SQLite storage

## Access

Once started, access Wingfit at: http://localhost:8080
