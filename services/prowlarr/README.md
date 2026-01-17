# Prowlarr

**Official Repository**: [Prowlarr/Prowlarr](https://github.com/Prowlarr/Prowlarr)  
**Category**: Automation  
**Port**: 9696  
**Docker Image**: `linuxserver/prowlarr:latest`

## Overview

Prowlarr is an indexer manager/proxy built on the popular *arr .net/reactjs base stack to integrate with your various PVR apps. It supports management of both Torrent Trackers and Usenet Indexers.

## Key Features

- 🔍 **Indexer Management** - Centralized indexer configuration
- 🔗 ***arr Integration** - Auto-sync with Radarr, Sonarr, etc.
- 🌐 **Multi-Protocol** - Torrent and Usenet support
- 📊 **Statistics** - Track indexer performance
- 🎯 **Search** - Manual search across all indexers
- 🔄 **Automatic Sync** - Keep indexers in sync across apps
- 📈 **Health Checks** - Monitor indexer availability
- 🔐 **FlareSolverr** - Bypass Cloudflare protection

## Getting Started

1. **Start the service**:
   ```bash
   just up prowlarr
   ```

2. **Access the web interface**: http://localhost:9696

3. **Initial Setup**:
   - Complete initial setup wizard
   - Add indexers (torrent and/or Usenet)
   - Configure FlareSolverr if needed
   - Add applications (Radarr, Sonarr)
   - Sync indexers to connected apps
   - Test search functionality

## Ports

- **9696** - Web interface

## Usage

Start this service:
```bash
just services --action start --name prowlarr
```

Stop this service:
```bash
just services --action stop --name prowlarr
```

View logs:
```bash
just services --action logs --name prowlarr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/prowlarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
