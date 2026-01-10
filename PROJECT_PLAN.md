# Home Lab Project - Complete Plan
**Date:** 2026-01-10  
**Repository:** brunoti/home_lab  
**Owner:** brunoti

## 📋 Project Overview

A self-hosted home lab running on Mac mini M4 with 16GB RAM and 256GB SSD. All services run on local network freely, with VPN (Headscale) access only for external connections. Cloud backups to Google Drive and Mega with email notifications.

## 🏗️ Architecture & Infrastructure

### Hardware
- **Device:** Mac mini M4
- **RAM:** 16GB
- **Storage:** 256GB internal SSD
- **Container Runtime:** Docker (via Colima)
- **OS:** macOS

### Network
- **Local Network:** Full unrestricted access to all services
- **External Access:** VPN-only via Headscale
- **Reverse Proxy:** Nginx Proxy Manager with SSL/TLS
- **Dashboard:** Homepage for service discovery
- **Authentication:** Authelia for sensitive services

### Backup Strategy
- **Google Drive:** Full daily backups
- **Mega:** Incremental backups 2x daily
- **Local Cache:** 7-day rolling window
- **Notifications:** Email alerts on backup success/failure
- **Disaster Recovery:** Complete recovery procedures documented
- **Metadata:** Jellyfin metadata stored locally, included in backups

### Colima Configuration
- **CPU Allocation:** 8 cores (from M4's efficiency cores)
- **RAM Allocation:** 8GB (leaving 8GB for macOS)
- **Auto-start:** Configured on boot

## 📁 Repository Structure

```
home_lab/
├── docker-compose.yml
├── .env.example
├── justfile
├── README.md
├── docs/
├── scripts/
├── config/
└── services/
```

## 🎯 Services by Category

### Media & Entertainment (5 services)
1. **Jellyfin** (Port 8096) - Movies, TV shows, music streaming
2. **Koel** (Port 13000) - Modern music server
3. **Navidrome** (Port 4533) - Subsonic-compatible music
4. **Speedtest Tracker** (Port 5000) - Internet speed monitoring
5. **Immich** (Port 2283) - Photo management

### Books & Reading (5 services)
1. **Calibre** (Port 8080) - Library management
2. **Calibre Web** (Port 8083) - Web reader interface
3. **Bookstore** (Port 3000) - Book discovery
4. **Audiobookshelf** (Port 8000) - Audiobooks
5. **Lazylibrarian** (Port 8666) - Automated ebook discovery

### Notes & Knowledge (1 service)
1. **Affine** (Port 3001) - Collaborative notes & wiki

### Security & Network (3 services)
1. **Headscale** (Port 8085) - VPN
2. **PiHole** (Port 80, 53) - DNS & ad-blocking
3. **Authelia** (Port 9091) - Authentication

### Reverse Proxy & Dashboard (2 services)
1. **Nginx Proxy Manager** (Port 81, 443, 80)
2. **Homepage** (Port 3000)

### Monitoring & Observability (5 services)
1. **Portainer** (Port 9000) - Docker GUI
2. **Prometheus** (Port 9090) - Metrics collection
3. **Grafana** (Port 3000) - Dashboards
4. **Loki** (Port 3100) - Log aggregation
5. **Uptime Kuma** (Port 3001) - Uptime monitoring

### Databases & Caching (2 services)
1. **PostgreSQL** - Relational database
2. **Redis** - Caching

### Cloud & Storage (2 services)
1. **Nextcloud** (Port 11000) - Cloud storage
2. **Rclone** (Port 5572) - Cloud backups

### Development & Productivity (2 services)
1. **File Browser** (Port 6060) - Web file manager
2. **MkDocs** (Port 8001) - Documentation hosting

### Media Automation (3 services)
1. **Radarr** (Port 7878) - Movie automation
2. **Sonarr** (Port 8989) - TV series automation
3. **Prowlarr** (Port 9696) - Indexer manager

### Download Client (1 service)
1. **Transmission** (Port 6969) - Torrent client

## 🧠 Resource Allocation (16GB RAM)

```
Total: 16GB
├── Colima (Docker): 8GB
│   ├── Jellyfin: 2GB
│   ├── Affine: 1GB
│   ├── Calibre: 1GB
│   ├── Lazylibrarian: 768MB
│   ├── Koel: 512MB
│   ├── Bookstore: 512MB
│   ├── Navidrome: 256MB
│   ├── PostgreSQL: 1.5GB
│   ├── Prometheus: 512MB
│   ├── Other services: 256MB
│   └── Headroom/Buffer: 128MB
│
└── macOS + System: 8GB
```

## 💾 Storage Breakdown (256GB SSD)

```
256GB Total
├── macOS OS: 50GB
├── Docker images & configs: 30GB
├── Service Data: 50GB
├── Cache & Temporary: 20GB
├── Logs (rotated): 10GB
└── Available for growth: ~96GB
```

## 🚀 Setup & Configuration

### Technology Stack
- **Container Runtime:** Docker (via Colima)
- **Orchestration:** Docker Compose
- **Scripting:** Bun (TypeScript runtime)
- **Task Automation:** Justfile
- **Configuration:** `.env` files

### Simplified Justfile Commands

**Setup & Installation:**
```
just setup --target mac          # Setup Mac environment
just setup --target config       # Validate configuration
just install                     # Install dependencies
```

**Service Management:**
```
just services --action start     # Start all services
just services --action stop      # Stop all services
just services --action restart   # Restart all services
just services --action logs --name <service>  # View logs for a service
just services --action status    # Check service status
```

**Backup & Restore:**
```
just backup --target gdrive      # Backup to Google Drive
just backup --target mega        # Backup to Mega
just backup --target local       # Local backup
just restore --source gdrive     # Restore from Google Drive
just restore --source mega       # Restore from Mega
```

**Media Services:**
```
just music --action import --service koel      # Import music to Koel
just music --action sync --service navidrome   # Sync Navidrome library
just books --action import --service calibre   # Import books to Calibre
just books --action convert --format epub      # Convert book formats
just books --action search --service lazylibrarian  # Search for books
```

**Monitoring & Health:**
```
just monitor --target health     # Run health check
just monitor --target ram        # Check RAM usage
just monitor --target performance  # Generate performance report
just monitor --target service --name jellyfin  # Monitor specific service
```

**Documentation:**
```
just docs --action serve         # Start documentation server
just docs --action build         # Build documentation
just docs --action update        # Update documentation
```

**Testing:**
```
just test --target disaster-recovery  # Test disaster recovery
just test --target email         # Test email notifications
just test --target backups       # Test backup procedures
```

## 📧 Email Notifications

**Configured for Gmail SMTP**

**Alerts Triggered For:**
- Backup completion (success/failure)
- RAM usage > 80% (warning)
- RAM usage > 90% (critical)
- Disk space < 20GB available
- Service health issues
- Service crashes/restarts
- Restoration status updates
- Database backup completion

## 🔄 Disaster Recovery

### Complete Recovery Procedures
- Full system failure recovery
- Partial data loss recovery
- Service-specific recovery
- Database recovery
- Metadata recovery

### Testing
- Monthly recovery drill procedures
- Data integrity verification

## 📊 Monitoring & Observability

### Grafana Dashboards
1. Overall System Health
2. Jellyfin Dashboard
3. Music Servers Dashboard
4. Books & Reading Dashboard
5. Backup Status Dashboard
6. Email Alert History

### Alert Thresholds
- RAM > 80%: Warning email
- RAM > 90%: Critical email
- Disk < 20GB: Low storage warning
- Service unhealthy: Immediate alert
- Backup failure: Error alert

## 🎬 Jellyfin M4 Optimization

### Hardware Acceleration
- M4 media engine enabled by default
- H.264 and HEVC transcoding support

### Transcoding Profiles
- Local network: 1080p @ 6 Mbps (recommended)
- Direct play: Full bitrate
- Transcode max: 8 Mbps

### Performance
- Single 1080p stream: ~15% CPU
- Two concurrent 1080p: ~40-50% CPU
- Three concurrent 1080p: ~70% CPU (max recommended)

## 📚 Book Ecosystem

### Complete Workflow
```
Lazylibrarian (Automation)
  ↓ Auto-downloads & imports
Calibre (Management)
  ↓ Shared library
├── Calibre Web (Reading)
├── Bookstore (Discovery)
└── Audiobookshelf (Audiobooks)
```

## 🎵 Music Setup

### Two Music Servers (Complementary)
1. **Koel** - Beautiful desktop experience
2. **Navidrome** - Mobile-friendly Subsonic compatibility

Both services read the same music folder with independent metadata caches.

## 🔐 Security & Privacy

### Local Network
- All services fully accessible
- No restrictions within home network

### External Access
- VPN-only via Headscale
- No direct internet exposure
- Encrypted tunnel to all services

### Authentication
- Authelia protects sensitive services
- Single sign-on support

### Ad-Blocking & Privacy
- PiHole network-wide DNS filtering
- Ad blocking at DNS level
- Query logging and analysis

## 🎯 Next Steps

1. Clone and Configure
```
git clone https://github.com/brunoti/home_lab.git
cd home_lab
cp .env.example .env
```

2. Install Dependencies
```
just install
```

3. Setup Authentication
```
just setup-gdrive
just setup-mega
just setup-email
```

4. Start Services
```
just up
```

5. Import Libraries
```
just calibre-import
just koel-import
just navidrome-sync
```

6. Verify Everything
```
just health-check
just disaster-recovery-test
```

### Performance Expectations

### What Works Great on M4 16GB RAM
✅ All 30 services running simultaneously
✅ Jellyfin 1080p streaming with transcoding
✅ Multiple concurrent music streams
✅ Automated book discovery and imports
✅ Full monitoring with Prometheus + Grafana
✅ VPN access via Headscale
✅ Cloud backups to Google Drive & Mega
✅ Email notifications

### Recommendations
- Limit Jellyfin to 2-3 concurrent transcodes
- Monitor RAM with Grafana
- Review logs weekly
- Run disaster recovery test monthly
- Keep Docker logs rotated
- Monitor disk space

## 🎯 Summary

**What You Get:**
- 30 services in a single, unified system
- Complete media streaming (movies, music, books, audiobooks)
- Automated book discovery and library management
- Collaborative notes and knowledge base
- Network-wide ad-blocking and DNS
- Secure VPN access via Headscale
- Cloud backups with email notifications
- Comprehensive monitoring and disaster recovery
- M4 Mac-optimized performance
- Full documentation and recovery procedures

**All Optimized For:**
- 16GB RAM allocation
- 256GB SSD storage
- Mac mini M4 hardware
- Local network access + VPN external access
- Cloud backup redundancy
- Email notifications
- Automatic recovery procedures