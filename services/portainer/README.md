# Portainer

**Official Repository**: [portainer/portainer](https://github.com/portainer/portainer)  
**Category**: Management  
**Ports**: 9000 (HTTP), 9443 (HTTPS)  
**Docker Image**: `portainer/portainer-ce:latest`

## Overview

Portainer is a lightweight management UI which allows you to easily manage your Docker environments. It simplifies container management with an intuitive web interface.

## Key Features

- 🐳 **Container Management** - Easy Docker management
- 📊 **Visual Dashboard** - Monitor all containers
- 📝 **Stack Deployment** - Deploy compose stacks via UI
- 🔐 **RBAC** - Role-based access control
- 📱 **Mobile Friendly** - Works on all devices
- 🔍 **Resource Monitoring** - CPU, memory, network stats
- 📦 **Image Management** - Pull, push, and manage images
- 🎯 **Multiple Endpoints** - Manage multiple Docker hosts

## Getting Started

1. **Start the service**:
   ```bash
   just up portainer
   ```

2. **Access the web interface**: http://localhost:9000 or https://localhost:9443

3. **Initial Setup**:
   - Create admin account on first access
   - Connect to local Docker endpoint
   - Explore containers, images, volumes, networks
   - Deploy new stacks or containers
   - Set up additional endpoints (optional)

## Ports

- **9000** - HTTP web interface
- **9443** - HTTPS web interface

## Usage

Start this service:
```bash
just up portainer
```

Stop this service:
```bash
just stop portainer
```

View logs:
```bash
docker compose -f services/portainer/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/portainer/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
