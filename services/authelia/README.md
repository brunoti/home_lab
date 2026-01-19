# Authelia

**Official Repository**: [authelia/authelia](https://github.com/authelia/authelia)  
**Category**: Network  
**Port**: 9091  
**Docker Image**: `authelia/authelia:latest`

## Overview

Authelia is an open-source authentication and authorization server providing single sign-on (SSO) and two-factor authentication for your applications via a web portal.

## Key Features

- 🔐 **Single Sign-On** - SSO for all your applications
- 🔑 **Two-Factor Auth** - TOTP, WebAuthn, Security Keys
- 🌐 **Reverse Proxy Integration** - Works with nginx, Traefik, Caddy
- 📧 **Email Notifications** - Account verification and alerts
- 🔒 **Access Control** - Fine-grained authorization rules
- 👥 **Multi-Backend** - LDAP, Active Directory, file-based
- 📱 **Mobile App Support** - TOTP apps like Google Authenticator
- 🛡️ **Brute Force Protection** - Failed login attempt throttling

## Getting Started

1. **Start the service**:
   ```bash
   just up authelia
   ```

2. **Access the portal**: http://localhost:9091

3. **Initial Setup**:
   - Configure users in configuration file
   - Set up access control rules
   - Configure email notifications
   - Integrate with reverse proxy (Nginx Proxy Manager)
   - Register 2FA devices for users

## Ports

- **9091** - Authentication portal

## Usage

Start this service:
```bash
just up authelia
```

Stop this service:
```bash
just stop authelia
```

View logs:
```bash
docker compose -f services/authelia/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/authelia/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
