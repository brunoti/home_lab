# Sonarr

**Official Repository**: [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr)  
**Category**: Automation  
**Port**: 8989  
**Docker Image**: `linuxserver/sonarr:latest`

## Overview

Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort, and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Key Features

- 📺 **TV Show Management** - Automated TV episode downloads
- 📅 **Episode Tracking** - Track aired and upcoming episodes
- 🔍 **Quality Profiles** - Customize quality preferences
- 📊 **Calendar View** - Visual episode calendar
- 🔄 **Automatic Import** - Auto-import and rename episodes
- 🎯 **Season Packs** - Smart season pack handling
- 🔗 **Integration** - Works with Prowlarr and download clients
- 📱 **Mobile Friendly** - Responsive web interface

## Getting Started

1. **Start the service**:
   ```bash
   just up sonarr
   ```

2. **Access the web interface**: http://localhost:8989

3. **Initial Setup**:
   - Complete initial setup wizard
   - Add indexers via Prowlarr integration
   - Configure download client (Transmission)
   - Set up root folder for TV shows
   - Add TV shows to monitor
   - Configure quality profiles and episode tracking

## Ports

- **8989** - Web interface

## Usage

Start this service:
```bash
just up sonarr
```

Stop this service:
```bash
just stop sonarr
```

View logs:
```bash
docker compose -f services/sonarr/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/sonarr/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
