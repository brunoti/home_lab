# Headscale

**Official Repository**: [juanfont/headscale](https://github.com/juanfont/headscale)  
**Category**: Network  
**Port**: 8085  
**Docker Image**: `headscale/headscale:latest`

## Overview

Headscale is an open-source, self-hosted implementation of the Tailscale control server. It allows you to create your own private mesh network without relying on Tailscale's SaaS infrastructure.

## Key Features

- 🔒 **Self-Hosted VPN** - Full control of your mesh network
- 🌐 **Mesh Networking** - Direct peer-to-peer connections
- 🔑 **Authentication** - Multiple authentication methods
- 📱 **Cross-Platform** - Works with official Tailscale clients
- 🛡️ **Security** - WireGuard-based encryption
- 🏢 **Multi-User** - Support for multiple users and namespaces
- 📊 **ACL Support** - Fine-grained access control lists
- 🔌 **API Access** - RESTful API for automation

## Getting Started

1. **Start the service**:
   ```bash
   just up headscale
   ```

2. **Access the control server**: http://localhost:8085

3. **Initial Setup**:
   - Create a namespace: `docker exec headscale headscale namespaces create <name>`
   - Generate an auth key: `docker exec headscale headscale preauthkeys create -n <namespace>`
   - Configure Tailscale client to use your Headscale server
   - Connect devices using the auth key

## Ports

- **8085** - Control server and API

## Usage

Start this service:
```bash
just services --action start --name headscale
```

Stop this service:
```bash
just services --action stop --name headscale
```

View logs:
```bash
just services --action logs --name headscale
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/headscale/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
