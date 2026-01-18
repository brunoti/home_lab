# Calibre

**Official Repository**: [kovidgoyal/calibre](https://github.com/kovidgoyal/calibre)  
**Category**: Books  
**Ports**: 8080 (Desktop UI), 8081 (Web Server)  
**Docker Image**: `linuxserver/calibre:latest`

## Overview

Calibre is a powerful and easy-to-use e-book manager. It provides a complete e-book solution, allowing you to manage your e-book collection, convert between formats, and sync to your e-reader devices.

## Key Features

- 📚 **E-book Management** - Organize your entire library
- 🔄 **Format Conversion** - Convert between 20+ formats
- 📖 **E-book Viewer** - Built-in reader for all formats
- 📝 **Metadata Editing** - Edit book information and covers
- 🌐 **Content Server** - Share books over network
- 📱 **Device Sync** - Sync to Kindle, Kobo, etc.
- 🔍 **Search & Filter** - Powerful library search
- 📥 **News Download** - Fetch news as e-books

## Getting Started

1. **Start the service**:
   ```bash
   just up calibre
   ```

2. **Access the desktop UI**: http://localhost:8080
3. **Access the content server**: http://localhost:8081

4. **Initial Setup**:
   - Configure library location
   - Add e-books to library
   - Edit metadata and covers
   - Set up e-reader device syncing
   - Enable content server for remote access

## Ports

- **8080** - Desktop GUI via web browser
- **8081** - Content server for book browsing

## Usage

Start this service:
```bash
just up calibre
```

Stop this service:
```bash
just stop calibre
```

View logs:
```bash
docker compose -f services/calibre/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/calibre/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
