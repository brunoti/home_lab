# Bookstore (BookStack)

Category: Books

## Service Information

BookStack is a simple, self-hosted platform for organizing and storing information. It provides a wiki-style documentation system with books, chapters, and pages.

## Usage

Start this service:
```bash
just services --action start --name bookstore
```

Stop this service:
```bash
just services --action stop --name bookstore
```

View logs:
```bash
just services --action logs --name bookstore
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/bookstore/`

## Ports

- **3002**: BookStack web interface (HTTP)

## Dependencies

This service requires:
- **postgres**: PostgreSQL database for storing BookStack data

Check `depends_on` in `docker-compose.yml` for service dependencies.

## Initial Setup

1. After starting the service, access BookStack at http://localhost:3002
2. Default credentials:
   - Email: admin@admin.com
   - Password: password
3. **Important**: Change the default password immediately after first login

## Database

BookStack uses the `bookstack` database in the shared PostgreSQL instance. The database is automatically created by the initialization script in `scripts/init-databases.sql`.
