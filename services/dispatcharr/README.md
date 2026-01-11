# Dispatcharr

Category: Media Automation

## Service Information

Dispatcharr is an IPTV management and proxy solution that acts as a powerful IPTV streaming playlist (m3u/m3u8) editor and proxy. It allows users to curate complex M3U playlists, manage these lists, and proxy them to various media server applications including Emby, Plex, Jellyfin, or any compatible streaming platform.

### Key Features

- **Proxy Streaming Engine**: Optimizes bandwidth usage and increases stream reliability
- **Real-Time Stats Dashboard**: Live insights into stream health and client activity
- **EPG Auto-Match**: Automatically matches program guide data to channels
- **VOD Management**: Support for movies and TV series
- **Bulk Channel Editing**: Mass editing of streams and channels
- **HDHomeRun & XMLTV Support**: Wide compatibility with various clients

## Usage

Start this service:
```bash
just services --action start --name dispatcharr
```

Stop this service:
```bash
just services --action stop --name dispatcharr
```

View logs:
```bash
just services --action logs --name dispatcharr
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs in `${DISPATCHARR_CONFIG_DIR}`

## Access

- **Web UI**: http://localhost:9191
- **Default Port**: 9191 (configurable via DISPATCHARR_PORT)

## Ports

- `9191`: Web interface and API

## Dependencies

No external service dependencies required. Dispatcharr can integrate with:
- Jellyfin
- Plex
- Emby
- Other IPTV-compatible clients

## Integration

Dispatcharr can be used to manage IPTV streams for your media server:

1. Access Dispatcharr at http://localhost:9191
2. Import your M3U playlist URLs
3. Configure EPG sources
4. Generate proxy URLs for your media server
5. Add the proxy URLs to Jellyfin, Plex, or other clients

## Data Storage

- Configuration: `${DISPATCHARR_CONFIG_DIR}` (default: `../../data/dispatcharr/config`)
- Data: `${DISPATCHARR_DATA_DIR}` (default: `../../data/dispatcharr/data`)
