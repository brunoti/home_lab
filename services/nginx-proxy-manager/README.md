# Nginx Proxy Manager

**Official Repository**: [NginxProxyManager/nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager)  
**Category**: Network  
**Ports**: 80 (HTTP), 81 (Admin), 443 (HTTPS)  
**Docker Image**: `jc21/nginx-proxy-manager:latest`

## Overview

Nginx Proxy Manager is a simple, powerful reverse proxy management interface powered by Nginx. It enables you to easily forward to your websites running at home or otherwise, including free SSL certificates.

## Key Features

- 🌐 **Reverse Proxy** - Forward traffic to internal services
- 🔒 **Free SSL Certificates** - Automatic Let's Encrypt certificates
- 🎯 **Easy Management** - Beautiful web interface
- 🔐 **Access Control** - Built-in access lists
- 📊 **Statistics** - View proxy statistics
- 🛡️ **Custom SSL** - Upload your own certificates
- 🔧 **Advanced Config** - Custom Nginx configurations
- 📱 **Mobile Friendly** - Responsive design

## Getting Started

1. **Start the service**:
   ```bash
   just up nginx-proxy-manager
   ```

2. **Access the admin interface**: http://localhost:81

3. **Initial Setup**:
   - Login with default credentials: `admin@example.com` / `changeme`
   - Change default password immediately
   - Add proxy hosts for your services
   - Configure SSL certificates
   - Set up access lists (optional)

## Ports

- **80** - HTTP traffic
- **81** - Admin web interface
- **443** - HTTPS traffic

## Usage

Start this service:
```bash
just up nginx-proxy-manager
```

Stop this service:
```bash
just stop nginx-proxy-manager
```

View logs:
```bash
docker compose -f services/nginx-proxy-manager/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/nginx-proxy-manager/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
