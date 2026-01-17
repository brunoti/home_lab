# Navidrome

**Official Repository**: [navidrome/navidrome](https://github.com/navidrome/navidrome)  
**Category**: Music  
**Port**: 4533  
**Docker Image**: `deluan/navidrome:latest`

## Overview

Navidrome is a modern Music Server and Streamer compatible with Subsonic/Airsonic clients. It allows you to enjoy your music collection from anywhere, by making it available through a modern web UI and through a wide range of third-party compatible mobile apps.

## Key Features

- 🎵 **Subsonic API** - Compatible with dozens of mobile apps
- 📱 **Mobile Apps** - Use iOS/Android Subsonic clients
- 🔊 **Transcoding** - On-the-fly audio transcoding
- 📊 **Last.fm Scrobbling** - Track your listening history
- ⚡ **Low Resources** - Efficient and fast
- 🎨 **Modern UI** - Clean, responsive web interface
- 🎯 **Smart Playlists** - Automatic playlist generation
- 🔌 **Jukebox Mode** - Server-side audio playback

## Getting Started

1. **Start the service**:
   ```bash
   just up navidrome
   ```

2. **Access the web interface**: http://localhost:4533

3. **Initial Setup**:
   - Create admin account on first access
   - Music library will scan automatically
   - Configure Last.fm integration (optional)
   - Download mobile app (e.g., DSub, Substreamer, Ultrasonic)

## Ports

- **4533** - Web interface and Subsonic API

## Usage

Start this service:
```bash
just services --action start --name navidrome
```

Stop this service:
```bash
just services --action stop --name navidrome
```

View logs:
```bash
just services --action logs --name navidrome
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/navidrome/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
