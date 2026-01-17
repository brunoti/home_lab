# Homepage

**Official Repository**: [gethomepage/homepage](https://github.com/gethomepage/homepage)  
**Category**: Dashboard  
**Port**: 3000  
**Docker Image**: `ghcr.io/gethomepage/homepage:latest`

## Overview

Homepage is a modern, fully static, fast, secure, fully customizable application dashboard with integrations for over 100 services. It's designed to be your home lab's central hub.

## Key Features

- 🎨 **Fully Customizable** - YAML-based configuration
- 🔗 **100+ Integrations** - Built-in service widgets
- 📊 **Service Widgets** - Real-time stats and info
- 🌐 **Docker Integration** - Auto-discover containers
- 🔍 **Web Search** - Integrated search providers
- 🖼️ **Beautiful UI** - Modern, clean design
- 📱 **Responsive** - Works on all devices
- ⚡ **Fast & Lightweight** - Static site generation

## Getting Started

1. **Start the service**:
   ```bash
   just up homepage
   ```

2. **Access the dashboard**: http://localhost:3000

3. **Initial Setup**:
   - Edit configuration files in `/config/homepage/`
   - Add services and bookmarks
   - Configure widgets for service stats
   - Customize layout and appearance
   - Set up Docker integration for auto-discovery

## Ports

- **3000** - Web interface

## Usage

Start this service:
```bash
just services --action start --name homepage
```

Stop this service:
```bash
just services --action stop --name homepage
```

View logs:
```bash
just services --action logs --name homepage
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/homepage/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
