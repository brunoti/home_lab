# Uptime Kuma

**Official Repository**: [louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)  
**Category**: Monitoring  
**Port**: 3003  
**Docker Image**: `louislam/uptime-kuma:latest`

## Overview

Uptime Kuma is a fancy self-hosted monitoring tool. It's a modern, beautiful, and easy-to-use uptime monitoring solution that looks great and provides comprehensive monitoring capabilities.

## Key Features

- 📊 **Service Monitoring** - HTTP, TCP, ping, DNS, and more
- 🚨 **Multi-Channel Alerts** - Email, Slack, Discord, Telegram, etc.
- 📱 **Beautiful UI** - Modern and intuitive interface
- 📈 **Status Pages** - Public status pages for services
- 🔔 **Notifications** - 90+ notification services
- 📊 **Charts & History** - Visual uptime history
- 🌐 **Multi-Language** - Supports 20+ languages
- 🔐 **Authentication** - Secure login system

## Getting Started

1. **Start the service**:
   ```bash
   just up uptime-kuma
   ```

2. **Access the web interface**: http://localhost:3003

3. **Initial Setup**:
   - Create admin account on first access
   - Add monitors for your services
   - Configure notification channels
   - Set up status pages (optional)
   - Configure check intervals and retry settings

## Ports

- **3003** - Web interface

## Usage

Start this service:
```bash
just up uptime-kuma
```

Stop this service:
```bash
just stop uptime-kuma
```

View logs:
```bash
docker compose -f services/uptime-kuma/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/uptime-kuma/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
