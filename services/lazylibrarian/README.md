# LazyLibrarian

**Official Repository**: [lazylibrarian/LazyLibrarian](https://github.com/lazylibrarian/LazyLibrarian)  
**Category**: Books  
**Port**: 8666  
**Docker Image**: `linuxserver/lazylibrarian:latest`

## Overview

LazyLibrarian is an automated e-book and audiobook manager. It searches for books you want and downloads them automatically, managing your digital library with minimal effort.

## Key Features

- 📚 **Automated Downloads** - Auto-download wanted books
- 🔍 **Multiple Sources** - Search across many sources
- 📖 **Author Tracking** - Follow favorite authors
- 🎧 **Audiobook Support** - Manage audiobooks too
- 🔄 **Format Conversion** - Convert to preferred formats
- 📊 **Goodreads Integration** - Import wishlists and ratings
- 🔗 **Calibre Integration** - Import to Calibre library
- 📅 **Release Tracking** - Monitor upcoming releases

## Getting Started

1. **Start the service**:
   ```bash
   just up lazylibrarian
   ```

2. **Access the web interface**: http://localhost:8666

3. **Initial Setup**:
   - Complete initial setup wizard
   - Configure download sources and indexers
   - Set up download client integration
   - Add authors or books to watchlist
   - Configure Calibre integration (optional)
   - Set up automatic processing rules

## Ports

- **8666** - Web interface

## Usage

Start this service:
```bash
just services --action start --name lazylibrarian
```

Stop this service:
```bash
just services --action stop --name lazylibrarian
```

View logs:
```bash
just services --action logs --name lazylibrarian
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/lazylibrarian/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
