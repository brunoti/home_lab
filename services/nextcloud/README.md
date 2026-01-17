# Nextcloud

**Official Repository**: [nextcloud/server](https://github.com/nextcloud/server)  
**Category**: Cloud  
**Port**: 11000  
**Docker Image**: `nextcloud:latest`

## Overview

Nextcloud is a suite of client-server software for creating and using file hosting services. It's like your own private Dropbox, with file sync, sharing, calendars, contacts, and much more.

## Key Features

- ☁️ **File Sync & Share** - Private cloud storage
- 📱 **Mobile Apps** - iOS and Android sync clients
- 📅 **Calendar & Contacts** - Built-in CalDAV and CardDAV
- 💬 **Collaboration** - Online document editing
- 🔒 **Encryption** - End-to-end encryption
- 📧 **Mail Client** - Built-in email
- 📞 **Video Calls** - Nextcloud Talk integration
- 🔌 **Apps Ecosystem** - Hundreds of apps available

## Getting Started

1. **Start the service**:
   ```bash
   just up nextcloud
   ```

2. **Access the web interface**: http://localhost:11000

3. **Initial Setup**:
   - Create admin account
   - Configure database connection (PostgreSQL)
   - Set data directory location
   - Install recommended apps
   - Download desktop sync client (optional)
   - Configure mobile apps

## Ports

- **11000** - Web interface

## Dependencies

- **PostgreSQL** - Database backend
- **Redis** - Caching and file locking

## Usage

Start this service:
```bash
just services --action start --name nextcloud
```

Stop this service:
```bash
just services --action stop --name nextcloud
```

View logs:
```bash
just services --action logs --name nextcloud
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/nextcloud/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
