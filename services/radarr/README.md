# Radarr

**Official Repository**: [Radarr/Radarr](https://github.com/Radarr/Radarr)  
**Category**: Automation  
**Port**: 7878  
**Docker Image**: `linuxserver/radarr:latest`

## Overview

Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them.

## Key Features

- 🎬 **Movie Management** - Automated movie downloads
- 📅 **Release Tracking** - Monitor upcoming releases
- 🔍 **Quality Profiles** - Customize quality preferences
- 📊 **Calendar View** - Visual release calendar
- 🔄 **Automatic Import** - Auto-import and rename
- 🎯 **Smart Search** - Find best releases automatically
- 🔗 **Integration** - Works with Prowlarr and download clients
- 📱 **Mobile Friendly** - Responsive web interface

## Getting Started

1. **Start the service**:
   ```bash
   just up radarr
   ```

2. **Access the web interface**: http://localhost:7878

3. **Initial Setup**:
   - Complete initial setup wizard
   - Add indexers via Prowlarr integration
   - Configure download client (Transmission)
   - Set up root folder for movies
   - Add movies to monitor
   - Configure quality profiles

## Ports

- **7878** - Web interface

## Usage

Start this service:
```bash
just up radarr
```

Stop this service:
```bash
just stop radarr
```

View logs:
```bash
docker compose -f services/radarr/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/radarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
