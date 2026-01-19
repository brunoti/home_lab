# Immich

**Official Repository**: [immich-app/immich](https://github.com/immich-app/immich)  
**Category**: Media  
**Port**: 2283  
**Docker Image**: `ghcr.io/immich-app/immich-server:latest`

## Overview

Immich is a high-performance self-hosted photo and video backup solution. Direct from your mobile phone, it automatically backs up photos and videos to your server with a beautiful mobile and web interface.

## Key Features

- 📱 **Mobile Auto Backup** - iOS and Android apps with background upload
- 🖼️ **Smart Search** - AI-powered photo search by objects, people, and locations
- 👥 **Facial Recognition** - Automatic face detection and grouping
- 📍 **Map View** - View photos on an interactive map
- 🎬 **Video Support** - Upload and stream videos
- 📲 **Sharing** - Share albums with family and friends
- 🔒 **Privacy First** - Full control of your data
- 🚀 **High Performance** - Fast browsing and searching

## Getting Started

1. **Start the service**:
   ```bash
   just up immich
   ```

2. **Access the web interface**: http://localhost:2283

3. **Initial Setup**:
   - Create an admin account
   - Configure storage settings
   - Download mobile app (iOS/Android)
   - Configure mobile app with server URL
   - Enable auto-backup on mobile devices

## Ports

- **2283** - Web interface and API

## Usage

Start this service:
```bash
just up immich
```

Stop this service:
```bash
just stop immich
```

View logs:
```bash
docker compose -f services/immich/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/immich/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
