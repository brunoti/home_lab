# Koel

**Official Repository**: [koel/koel](https://github.com/koel/koel)  
**Category**: Music  
**Port**: 13000  
**Docker Image**: `phanan/koel:latest`

## Overview

Koel (also styled as koel, with a lowercase k) is a simple web-based personal audio streaming service written in Vue on the client side and Laravel on the server side.

## Key Features

- 🎵 **Beautiful Interface** - Modern, responsive design
- 📱 **Mobile Support** - Works great on phones and tablets
- 🎧 **Playlist Management** - Create and organize playlists
- 📊 **Last.fm Integration** - Scrobble your plays
- 🎛️ **Audio Equalizer** - Built-in equalizer
- 👥 **Multi-user** - Support for multiple users
- 🔍 **Smart Search** - Quick search across your library

## Getting Started

1. **Start the service**:
   ```bash
   just up koel
   ```

2. **Access the web interface**: http://localhost:13000

3. **Initial Setup**:
   - Login with admin credentials from `.env` file
   - Import your music library
   - Configure Last.fm (optional)

## Ports

- **13000** - Web interface

## Usage

Start this service:
```bash
just services --action start --name koel
```

Stop this service:
```bash
just services --action stop --name koel
```

View logs:
```bash
just services --action logs --name koel
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file (KOEL_APP_KEY, KOEL_ADMIN_EMAIL, KOEL_ADMIN_PASSWORD)
- PostgreSQL database integration

### Environment Variables

Required in `.env`:
- `KOEL_APP_KEY` - Application key for encryption
- `KOEL_ADMIN_EMAIL` - Admin user email
- `KOEL_ADMIN_PASSWORD` - Admin user password
- `POSTGRES_PASSWORD` - Database password

### Importing Music

```bash
# Import music using the just command
just music --action import --service koel

# Or manually scan library from Koel settings
```

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
