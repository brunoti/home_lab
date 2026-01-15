# MariaDB

Category: Database

## Service Information

MariaDB is a community-developed, commercially supported fork of the MySQL relational database management system. This instance is primarily used by BookLore but can be shared by other services that require MariaDB/MySQL.

## Usage

Start this service:
```bash
just services --action start --name mariadb
```

Stop this service:
```bash
just services --action stop --name mariadb
```

View logs:
```bash
just services --action logs --name mariadb
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs in `/data/mariadb/config`

## Ports

- **3306**: MariaDB database port

## Environment Variables

Required environment variables in `.env`:
- `MYSQL_ROOT_PASSWORD`: Root password for MariaDB
- `DB_PASSWORD`: Password for the application database user
- `MYSQL_DATABASE`: Database name (default: booklore)
- `DB_USER`: Database username (default: booklore)
- `DB_USER_ID`: User ID for file permissions (default: 1000)
- `DB_GROUP_ID`: Group ID for file permissions (default: 1000)
- `TZ`: Timezone (default: UTC)

## Dependencies

None - this is a base service that other services depend on.

## Notes

- Data is persisted in `data/mariadb/config`
- The healthcheck ensures the database is ready before dependent services start
- Uses LinuxServer.io's MariaDB image for better compatibility and features
