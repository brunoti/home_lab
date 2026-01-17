# Audiobookshelf

**Official Repository**: [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf)  
**Category**: Books  
**Port**: 8000  
**Docker Image**: `ghcr.io/advplyr/audiobookshelf:latest`

## Overview

Audiobookshelf is a self-hosted audiobook and podcast server. It provides a beautiful interface for managing and streaming your audiobook and podcast collection across all your devices.

## Key Features

- 🎧 **Audiobook Management** - Organize your audiobook library
- 📻 **Podcast Support** - Subscribe and manage podcasts
- 📱 **Mobile Apps** - iOS and Android apps available
- 👥 **Multi-User** - User accounts with progress tracking
- 🔊 **Streaming** - Stream to any device
- 📖 **Metadata** - Automatic metadata fetching
- ⏱️ **Progress Sync** - Sync across devices
- 📊 **Statistics** - Track listening stats

## Getting Started

1. **Start the service**:
   ```bash
   just up audiobookshelf
   ```

2. **Access the web interface**: http://localhost:8000

3. **Initial Setup**:
   - Create admin account on first access
   - Add audiobook and podcast libraries
   - Configure metadata providers
   - Create user accounts for family members
   - Download mobile app and connect to server
   - Start listening and track progress

## Ports

- **8000** - Web interface and API

## Usage

Start this service:
```bash
just services --action start --name audiobookshelf
```

Stop this service:
```bash
just services --action stop --name audiobookshelf
```

View logs:
```bash
just services --action logs --name audiobookshelf
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/audiobookshelf/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
