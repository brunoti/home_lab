# File Browser

**Official Repository**: [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser)  
**Category**: Utility  
**Port**: 6060  
**Docker Image**: `filebrowser/filebrowser:latest`

## Overview

File Browser is a create-your-own-cloud-kind of software where you can install it on a server, direct it to a path, and have a virtual file manager in the browser. It provides a simple and clean interface for managing files through a web browser.

## Key Features

- 📁 **File Management** - Upload, download, move, copy files
- 🔍 **Search** - Full-text file search
- 👥 **Multi-User** - User accounts and permissions
- 📦 **Archive Support** - Create and extract archives
- ✏️ **File Editor** - Built-in text and code editor
- 📱 **Mobile Friendly** - Responsive design
- 🔗 **Sharing** - Share files with links
- 🎨 **Customizable** - Themes and branding

## Getting Started

1. **Start the service**:
   ```bash
   just up filebrowser
   ```

2. **Access the web interface**: http://localhost:6060

3. **Initial Setup**:
   - Login with default: `admin` / `admin`
   - Change admin password immediately
   - Configure root directory path
   - Create user accounts
   - Set up file permissions
   - Customize interface (optional)

## Ports

- **6060** - Web interface

## Usage

Start this service:
```bash
just services --action start --name filebrowser
```

Stop this service:
```bash
just services --action stop --name filebrowser
```

View logs:
```bash
just services --action logs --name filebrowser
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/filebrowser/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
