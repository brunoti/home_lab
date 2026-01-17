# Transmission

**Official Repository**: [transmission/transmission](https://github.com/transmission/transmission)  
**Category**: Download  
**Port**: 6969  
**Docker Image**: `linuxserver/transmission:latest`

## Overview

Transmission is a fast, easy, and free BitTorrent client. It's designed for easy, powerful use with minimal resource usage, making it perfect for home server applications.

## Key Features

- 🚀 **Fast & Lightweight** - Minimal resource usage
- 🌐 **Web Interface** - Browser-based control
- 📡 **Remote Control** - RPC API for automation
- 🔐 **Encryption** - Built-in protocol encryption
- ⚡ **DHT Support** - Decentralized peer discovery
- 📊 **Statistics** - Detailed transfer stats
- 🎯 **Selective Downloads** - Choose files within torrents
- 🔗 ***arr Integration** - Works with Radarr and Sonarr

## Getting Started

1. **Start the service**:
   ```bash
   just up transmission
   ```

2. **Access the web interface**: http://localhost:6969

3. **Initial Setup**:
   - Login with credentials from `.env` file
   - Configure download directories
   - Set bandwidth limits (optional)
   - Enable encryption for privacy
   - Add to Radarr/Sonarr as download client

## Ports

- **6969** - Web interface and RPC

## Usage

Start this service:
```bash
just services --action start --name transmission
```

Stop this service:
```bash
just services --action stop --name transmission
```

View logs:
```bash
just services --action logs --name transmission
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/transmission/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
