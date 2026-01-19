# Pi-hole

**Official Repository**: [pi-hole/pi-hole](https://github.com/pi-hole/pi-hole)  
**Category**: Network  
**Ports**: 53 (DNS), 8053 (Web)  
**Docker Image**: `pihole/pihole:latest`

## Overview

Pi-hole is a network-wide ad blocker that acts as a DNS sinkhole. It blocks ads at the DNS level for all devices on your network without requiring client-side software.

## Key Features

- 🚫 **Network-Wide Blocking** - Blocks ads on all devices
- 📊 **Statistics Dashboard** - Detailed query and blocking stats
- 🎯 **Custom Blocklists** - Add your own blocklists
- 🔒 **Privacy Protection** - Block tracking domains
- ⚡ **Fast DNS** - Efficient DNS caching
- 📱 **Works Everywhere** - Protects all network devices
- 🛡️ **DNSSEC Support** - Secure DNS validation
- 🔧 **Whitelist/Blacklist** - Fine-grained domain control

## Getting Started

1. **Start the service**:
   ```bash
   just up pihole
   ```

2. **Access the web interface**: http://localhost:8053/admin

3. **Initial Setup**:
   - Login with password from `.env` file (PIHOLE_PASSWORD)
   - Configure your router to use Pi-hole as DNS (point to server IP)
   - Or configure devices individually to use server IP as DNS
   - Add additional blocklists (optional)
   - Configure whitelist for allowed domains

## Ports

- **53** - DNS server (TCP/UDP)
- **8053** - Web admin interface

## Usage

Start this service:
```bash
just up pihole
```

Stop this service:
```bash
just stop pihole
```

View logs:
```bash
docker compose -f services/pihole/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/pihole/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
