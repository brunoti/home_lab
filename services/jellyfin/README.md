# Jellyfin

**Official Repository**: [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin)  
**Category**: Media  
**Port**: 8096  
**Docker Image**: `jellyfin/jellyfin:latest`

## Overview

Jellyfin is the Free Software Media System that puts you in control of managing and streaming your media. It is an alternative to proprietary systems like Plex and Emby.

## Key Features

- 🎬 **Media Streaming** - Movies, TV shows, music, and photos
- 🚀 **Hardware Acceleration** - M4 Video Toolbox support for efficient transcoding
- 📱 **Multiple Clients** - Web, iOS, Android, TV apps (Roku, Fire TV, Android TV)
- 👥 **User Management** - Multiple profiles with parental controls
- 📺 **Live TV & DVR** - With compatible tuner hardware
- 🎵 **Music Library** - Full music server capabilities
- 📖 **E-book Reader** - Built-in e-book reader

## Usage

Start this service:
```bash
just up jellyfin
```

Stop this service:
```bash
just stop jellyfin
```

View logs:
```bash
docker compose -f services/jellyfin/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/jellyfin/`

### Media Organization

Organize media files as:
```
media/
├── Movies/
│   └── Movie Name (Year)/
│       └── Movie Name (Year).mkv
├── TV Shows/
│   └── Show Name/
│       └── Season 01/
│           └── S01E01 - Episode.mkv
└── Music/
    └── Artist/
        └── Album/
            └── track.mp3
```

### Hardware Acceleration (M4)

Enable Video Toolbox for Apple Silicon:
1. Dashboard → Playback → Hardware acceleration
2. Select "Video Toolbox"
3. Enable hardware decoding for H.264, HEVC, VP9
4. Save changes

**Recommended Settings for M4**:
- Max concurrent transcodes: 2-3
- Prefer direct play when possible
- Max streaming bitrate: 8 Mbps

## Getting Started

1. **Start the service**:
   ```bash
   just up jellyfin
   ```

2. **Access the web interface**: http://localhost:8096

3. **Initial Setup**:
   - Create an admin account
   - Add media libraries (Movies, TV Shows, Music)
   - Configure hardware acceleration (Dashboard → Playback → Video Toolbox)
   - Set transcoding quality settings

## Ports

- **8096** - Web interface and streaming

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
