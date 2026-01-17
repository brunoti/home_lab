# Calibre-Web

**Official Repository**: [janeczku/calibre-web](https://github.com/janeczku/calibre-web)  
**Category**: Books  
**Port**: 8083  
**Docker Image**: `linuxserver/calibre-web:latest`

## Overview

Calibre-Web is a web application providing a clean interface for browsing, reading, and downloading e-books using an existing Calibre database. It's a lightweight alternative to Calibre's built-in content server.

## Key Features

- 📖 **Web Reader** - Built-in e-book reader
- 📱 **Mobile Friendly** - Responsive design
- 👥 **Multi-User** - User accounts and permissions
- 🔍 **Advanced Search** - Filter by author, series, tags
- 📧 **Send to E-reader** - Email books to Kindle
- 🌐 **OPDS Support** - E-reader app integration
- 📚 **Custom Shelves** - Create reading lists
- 🔐 **Authentication** - Built-in user management

## Getting Started

1. **Start the service**:
   ```bash
   just up calibre-web
   ```

2. **Access the web interface**: http://localhost:8083

3. **Initial Setup**:
   - Login with default: `admin` / `admin123`
   - Change admin password immediately
   - Point to Calibre library database
   - Create user accounts
   - Configure e-reader email settings (optional)
   - Set up OPDS for mobile apps

## Ports

- **8083** - Web interface

## Usage

Start this service:
```bash
just services --action start --name calibre-web
```

Stop this service:
```bash
just services --action stop --name calibre-web
```

View logs:
```bash
just services --action logs --name calibre-web
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/calibre-web/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
