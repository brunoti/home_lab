# Redis

**Official Repository**: [redis/redis](https://github.com/redis/redis)  
**Category**: Database  
**Port**: 6379  
**Docker Image**: `redis:latest`

## Overview

Redis is an open-source, in-memory data structure store used as a database, cache, message broker, and streaming engine. It provides blazing-fast performance for caching and session storage.

## Key Features

- ⚡ **In-Memory Speed** - Microsecond response times
- 🔄 **Data Structures** - Strings, hashes, lists, sets, sorted sets
- 💾 **Persistence** - Optional disk persistence
- 🔔 **Pub/Sub** - Message broker capabilities
- 📊 **Transactions** - Atomic operations
- 🔒 **Security** - Password authentication and ACLs
- 🎯 **TTL Support** - Automatic key expiration
- 🚀 **High Performance** - Handles millions of requests per second

## Getting Started

1. **Start the service**:
   ```bash
   just up redis
   ```

2. **Access Redis CLI**:
   ```bash
   docker exec -it redis redis-cli
   ```

3. **Initial Setup**:
   - Redis starts immediately with default configuration
   - Used by services like Immich, Authelia for caching
   - No manual setup required for dependent services

## Ports

- **6379** - Redis server

## Usage

Start this service:
```bash
just up redis
```

Stop this service:
```bash
just stop redis
```

View logs:
```bash
docker compose -f services/redis/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/redis/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
