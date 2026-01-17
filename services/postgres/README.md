# PostgreSQL

**Official Repository**: [postgres/postgres](https://github.com/postgres/postgres)  
**Category**: Database  
**Port**: 5432  
**Docker Image**: `postgres:latest`

## Overview

PostgreSQL is a powerful, open-source object-relational database system with a strong reputation for reliability, feature robustness, and performance. It serves as the primary database for multiple services in this home lab.

## Key Features

- 🗄️ **ACID Compliant** - Reliable transactions and data integrity
- 🔍 **Advanced Queries** - Complex SQL queries and indexing
- 📊 **JSON Support** - Native JSON and JSONB data types
- 🔐 **Security** - Role-based access control
- 🚀 **Performance** - Efficient query planning and execution
- 🔄 **Replication** - Streaming and logical replication
- 🧩 **Extensions** - Rich ecosystem of extensions
- 📈 **Scalability** - Handles large datasets efficiently

## Getting Started

1. **Start the service**:
   ```bash
   just up postgres
   ```

2. **Access the database**:
   ```bash
   docker exec -it postgres psql -U postgres
   ```

3. **Initial Setup**:
   - Ensure `POSTGRES_PASSWORD` is set in `.env` file
   - Database is ready when logs show "database system is ready to accept connections"
   - Services depending on PostgreSQL will auto-connect

## Ports

- **5432** - PostgreSQL server

## Prerequisites

**Important:** Before starting the PostgreSQL service, ensure you have created a `.env` file in the repository root:

```bash
# From the repository root
cp .env.example .env

# Generate secure passwords (recommended)
just password

# OR manually set POSTGRES_PASSWORD in .env
nano .env
```

The `.env` file must contain at minimum:
- `POSTGRES_PASSWORD` - Database superuser password (required)
- `POSTGRES_USER` - Database superuser username (defaults to 'postgres')
- `POSTGRES_DB` - Default database name (defaults to 'postgres')

## Usage

Start this service:
```bash
just services --action start --name postgres
```

Stop this service:
```bash
just services --action stop --name postgres
```

View logs:
```bash
just services --action logs --name postgres
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file (automatically loaded via `env_file` directive)
- Service-specific configs (if any) in `/config/postgres/`

## Environment Variables

The service loads environment variables from the root `.env` file. Required variables:
- `POSTGRES_PASSWORD` - **Required** - Superuser password
- `POSTGRES_USER` - Optional - Superuser username (default: postgres)
- `POSTGRES_DB` - Optional - Default database name (default: postgres)
- `PGDATA` - Optional - Data directory path (default: /var/lib/postgresql/data/pgdata)

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
