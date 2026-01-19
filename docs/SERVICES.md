# Service Directory

Complete directory of all services in the home lab with links to official GitHub repositories.

## Quick Reference

| Service | Port | Category | Official Repository |
|---------|------|----------|---------------------|
| [Jellyfin](#jellyfin) | 8096 | Media | [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin) |
| [Koel](#koel) | 13000 | Music | [koel/koel](https://github.com/koel/koel) |
| [Navidrome](#navidrome) | 4533 | Music | [navidrome/navidrome](https://github.com/navidrome/navidrome) |
| [Calibre](#calibre) | 8080, 8081 | Books | [kovidgoyal/calibre](https://github.com/kovidgoyal/calibre) |
| [Calibre Web](#calibre-web) | 8083 | Books | [janeczku/calibre-web](https://github.com/janeczku/calibre-web) |
| [Bookstore](#bookstore) | 3002 | Books | [BookStackApp/BookStack](https://github.com/BookStackApp/BookStack) |
| [Lazylibrarian](#lazylibrarian) | 8666 | Books | [lazylibrarian/LazyLibrarian](https://github.com/lazylibrarian/LazyLibrarian) |
| [Audiobookshelf](#audiobookshelf) | 8000 | Books | [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf) |
| [Affine](#affine) | 3010 | Productivity | [toeverything/AFFiNE](https://github.com/toeverything/AFFiNE) |
| [Immich](#immich) | 2283 | Media | [immich-app/immich](https://github.com/immich-app/immich) |
| [Headscale](#headscale) | 8085 | Network | [juanfont/headscale](https://github.com/juanfont/headscale) |
| [PiHole](#pihole) | 53, 8053 | Network | [pi-hole/pi-hole](https://github.com/pi-hole/pi-hole) |
| [Authelia](#authelia) | 9091 | Security | [authelia/authelia](https://github.com/authelia/authelia) |
| [Nginx Proxy Manager](#nginx-proxy-manager) | 80, 81, 443 | Network | [NginxProxyManager/nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager) |
| [PostgreSQL](#postgresql) | 5432 | Database | [postgres/postgres](https://github.com/postgres/postgres) |
| [Redis](#redis) | 6379 | Database | [redis/redis](https://github.com/redis/redis) |
| [Prometheus](#prometheus) | 9090 | Monitoring | [prometheus/prometheus](https://github.com/prometheus/prometheus) |
| [Grafana](#grafana) | 3001 | Monitoring | [grafana/grafana](https://github.com/grafana/grafana) |
| [Loki](#loki) | 3100 | Monitoring | [grafana/loki](https://github.com/grafana/loki) |
| [Rclone](#rclone) | 5572 | Backup | [rclone/rclone](https://github.com/rclone/rclone) |
| [Radarr](#radarr) | 7878 | Automation | [Radarr/Radarr](https://github.com/Radarr/Radarr) |
| [Sonarr](#sonarr) | 8989 | Automation | [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr) |
| [Transmission](#transmission) | 6969 | Automation | [transmission/transmission](https://github.com/transmission/transmission) |
| [Portainer](#portainer) | 9000, 9443 | Management | [portainer/portainer](https://github.com/portainer/portainer) |
| [Uptime Kuma](#uptime-kuma) | 3003 | Monitoring | [louislam/uptime-kuma](https://github.com/louislam/uptime-kuma) |
| [Speedtest Tracker](#speedtest-tracker) | 5000 | Monitoring | [alexjustesen/speedtest-tracker](https://github.com/alexjustesen/speedtest-tracker) |
| [Homepage](#homepage) | 3000 | Dashboard | [gethomepage/homepage](https://github.com/gethomepage/homepage) |
| [Nextcloud](#nextcloud) | 11000 | Storage | [nextcloud/server](https://github.com/nextcloud/server) |
| [Prowlarr](#prowlarr) | 9696 | Automation | [Prowlarr/Prowlarr](https://github.com/Prowlarr/Prowlarr) |
| [File Browser](#file-browser) | 6060 | Utilities | [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser) |
| [MkDocs](#mkdocs) | 8001 | Documentation | [squidfunk/mkdocs-material](https://github.com/squidfunk/mkdocs-material) |

---

## Media & Entertainment

### Jellyfin

**Official Repository**: [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin)  
**Port**: 8096  
**Docker Image**: `jellyfin/jellyfin:latest`

The Free Software Media System. Stream your media to any device from your own server, with no strings attached.

**Key Features**:
- Movies, TV shows, music, and photo streaming
- Hardware-accelerated transcoding (M4 Video Toolbox support)
- Multiple client apps (web, mobile, TV)
- Live TV and DVR support
- User management with profiles

**Access**: http://localhost:8096

**Configuration**: See [services/jellyfin/README.md](../services/jellyfin/README.md)

---

### Immich

**Official Repository**: [immich-app/immich](https://github.com/immich-app/immich)  
**Port**: 2283  
**Docker Image**: `ghcr.io/immich-app/immich-server:latest`

High-performance self-hosted photo and video backup solution directly from your mobile phone.

**Key Features**:
- Mobile app auto-backup
- AI-powered face recognition
- Smart search by objects, faces, locations
- Album organization and sharing
- Video transcoding support

**Access**: http://localhost:2283

**Configuration**: See [services/immich/README.md](../services/immich/README.md)

---

### Speedtest Tracker

**Official Repository**: [alexjustesen/speedtest-tracker](https://github.com/alexjustesen/speedtest-tracker)  
**Port**: 5000  
**Docker Image**: `ghcr.io/alexjustesen/speedtest-tracker:latest`

Self-hosted internet performance tracking application that runs speedtest checks on a regular basis.

**Key Features**:
- Scheduled speed tests
- Historical data and graphs
- Result notifications
- Performance statistics
- Exportable reports

**Access**: http://localhost:5000

**Configuration**: See [services/speedtest-tracker/README.md](../services/speedtest-tracker/README.md)

---

## Music Streaming

### Koel

**Official Repository**: [koel/koel](https://github.com/koel/koel)  
**Port**: 13000  
**Docker Image**: `phanan/koel:latest`

Simple web-based personal audio streaming service written in Vue and Laravel.

**Key Features**:
- Beautiful, modern interface
- Playlist management
- Last.fm integration
- Audio equalizer
- Multiple user support
- Smart playlists

**Access**: http://localhost:13000

**Configuration**: See [services/koel/README.md](../services/koel/README.md)

---

### Navidrome

**Official Repository**: [navidrome/navidrome](https://github.com/navidrome/navidrome)  
**Port**: 4533  
**Docker Image**: `deluan/navidrome:latest`

Modern Music Server and Streamer compatible with Subsonic/Airsonic clients.

**Key Features**:
- Subsonic API compatibility
- Scrobble to Last.fm
- Low resource usage
- Multi-platform (iOS, Android, web)
- Smart playlists
- Jukebox mode

**Access**: http://localhost:4533

**Configuration**: See [services/navidrome/README.md](../services/navidrome/README.md)

---

## Books & Reading

### Calibre

**Official Repository**: [kovidgoyal/calibre](https://github.com/kovidgoyal/calibre)  
**Ports**: 8080 (GUI), 8081 (Web Server)  
**Docker Image**: `lscr.io/linuxserver/calibre:latest`

E-book management application supporting all major e-book formats.

**Key Features**:
- E-book library management
- Format conversion (EPUB, MOBI, PDF, etc.)
- Metadata editing and organization
- Content server for browsing
- E-book editing tools
- News download and conversion

**Access**: http://localhost:8080

**Configuration**: See [services/calibre/README.md](../services/calibre/README.md)

---

### Calibre Web

**Official Repository**: [janeczku/calibre-web](https://github.com/janeczku/calibre-web)  
**Port**: 8083  
**Docker Image**: `lscr.io/linuxserver/calibre-web:latest`

Web app providing a clean interface for browsing, reading and downloading e-books using a Calibre database.

**Key Features**:
- Web-based e-book reader
- OPDS catalog support
- User management
- Goodreads integration
- Send to Kindle
- Custom book lists

**Access**: http://localhost:8083

**Configuration**: See [services/calibre-web/README.md](../services/calibre-web/README.md)

---

### Bookstore

**Official Repository**: [BookStackApp/BookStack](https://github.com/BookStackApp/BookStack)  
**Port**: 3002  
**Docker Image**: `bookstackapp/bookstack:latest`

Simple, self-hosted, easy-to-use platform for organizing and storing information.

**Key Features**:
- Book/chapter/page organization
- Full-text search
- WYSIWYG editor
- Page templates
- Multi-language support
- Role-based permissions

**Access**: http://localhost:3002

**Configuration**: See [services/bookstore/README.md](../services/bookstore/README.md)

---

### Lazylibrarian

**Official Repository**: [lazylibrarian/LazyLibrarian](https://github.com/lazylibrarian/LazyLibrarian)  
**Port**: 8666  
**Docker Image**: `lscr.io/linuxserver/lazylibrarian:latest`

Automated book download tool that follows authors and helps you build your e-book library.

**Key Features**:
- Author/book searching
- Automated downloads
- Calibre integration
- GoodReads integration
- Magazine downloads
- Multiple source providers

**Access**: http://localhost:8666

**Configuration**: See [services/lazylibrarian/README.md](../services/lazylibrarian/README.md)

---

### Audiobookshelf

**Official Repository**: [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf)  
**Port**: 8000  
**Docker Image**: `ghcr.io/advplyr/audiobookshelf:latest`

Self-hosted audiobook and podcast server.

**Key Features**:
- Audiobook library management
- Podcast management
- Progress tracking
- Sleep timer
- Mobile apps (iOS/Android)
- Web-based playback

**Access**: http://localhost:8000

**Configuration**: See [services/audiobookshelf/README.md](../services/audiobookshelf/README.md)

---

## Productivity & Notes

### Affine

**Official Repository**: [toeverything/AFFiNE](https://github.com/toeverything/AFFiNE)  
**Port**: 3010  
**Docker Image**: `ghcr.io/toeverything/affine-graphql:stable`

Next-gen knowledge base that brings planning, sorting and creating all together. Privacy-first, open-source, and always free.

**Key Features**:
- Hybrid of docs and whiteboard
- Block-based editing
- Real-time collaboration
- Local-first architecture
- Markdown support
- Templates and databases

**Access**: http://localhost:3010

**Configuration**: See [services/affine/README.md](../services/affine/README.md)

---

## Network & Security

### Headscale

**Official Repository**: [juanfont/headscale](https://github.com/juanfont/headscale)  
**Port**: 8085  
**Docker Image**: `headscale/headscale:latest`

Open source, self-hosted implementation of the Tailscale control server.

**Key Features**:
- Secure VPN mesh network
- Zero-config VPN
- End-to-end encrypted
- Cross-platform support
- No central server dependency
- ACL-based access control

**Access**: http://localhost:8085

**Configuration**: See [services/headscale/README.md](../services/headscale/README.md)

---

### PiHole

**Official Repository**: [pi-hole/pi-hole](https://github.com/pi-hole/pi-hole)  
**Ports**: 53 (DNS), 8053 (Web UI)  
**Docker Image**: `pihole/pihole:latest`

Network-wide ad blocking via your own Linux hardware.

**Key Features**:
- DNS-based ad blocking
- Network-wide protection
- DHCP server
- Query logging and statistics
- Custom blocklists
- Whitelist/blacklist management

**Access**: http://localhost:8053/admin

**Configuration**: See [services/pihole/README.md](../services/pihole/README.md)

---

### Authelia

**Official Repository**: [authelia/authelia](https://github.com/authelia/authelia)  
**Port**: 9091  
**Docker Image**: `authelia/authelia:latest`

Open-source authentication and authorization server providing 2-factor authentication and single sign-on (SSO).

**Key Features**:
- Two-factor authentication
- Single sign-on (SSO)
- Access control policies
- LDAP/Active Directory support
- Password reset portal
- Session management

**Access**: http://localhost:9091

**Configuration**: See [services/authelia/README.md](../services/authelia/README.md)

---

### Nginx Proxy Manager

**Official Repository**: [NginxProxyManager/nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager)  
**Ports**: 80 (HTTP), 81 (Admin), 443 (HTTPS)  
**Docker Image**: `jc21/nginx-proxy-manager:latest`

Docker container for managing Nginx proxy hosts with a simple, powerful interface.

**Key Features**:
- Easy SSL certificate management
- Let's Encrypt integration
- Access lists
- Custom locations
- Stream (TCP/UDP) support
- Beautiful web interface

**Access**: http://localhost:81

**Configuration**: See [services/nginx-proxy-manager/README.md](../services/nginx-proxy-manager/README.md)

---

## Databases

### PostgreSQL

**Official Repository**: [postgres/postgres](https://github.com/postgres/postgres)  
**Port**: 5432  
**Docker Image**: `postgres:16-alpine`

The world's most advanced open source relational database.

**Key Features**:
- ACID compliance
- JSON/JSONB support
- Full-text search
- Advanced indexing
- Replication support
- Extensions ecosystem

**Configuration**: See [services/postgres/README.md](../services/postgres/README.md)

---

### Redis

**Official Repository**: [redis/redis](https://github.com/redis/redis)  
**Port**: 6379  
**Docker Image**: `redis:7-alpine`

In-memory data structure store used as a database, cache, message broker, and streaming engine.

**Key Features**:
- In-memory data storage
- Multiple data structures
- Pub/sub messaging
- Persistence options
- Lua scripting
- Replication and clustering

**Configuration**: See [services/redis/README.md](../services/redis/README.md)

---

## Monitoring & Observability

### Prometheus

**Official Repository**: [prometheus/prometheus](https://github.com/prometheus/prometheus)  
**Port**: 9090  
**Docker Image**: `prom/prometheus:latest`

Open-source systems monitoring and alerting toolkit.

**Key Features**:
- Multi-dimensional data model
- Powerful query language (PromQL)
- Time-series database
- Service discovery
- Alerting rules
- Visualization support

**Access**: http://localhost:9090

**Configuration**: See [services/prometheus/README.md](../services/prometheus/README.md)

---

### Grafana

**Official Repository**: [grafana/grafana](https://github.com/grafana/grafana)  
**Port**: 3001  
**Docker Image**: `grafana/grafana:latest`

Open source analytics and interactive visualization web application.

**Key Features**:
- Beautiful dashboards
- Multiple data sources
- Alerting system
- Plugin ecosystem
- Team collaboration
- Custom panels

**Access**: http://localhost:3001

**Configuration**: See [services/grafana/README.md](../services/grafana/README.md)

---

### Loki

**Official Repository**: [grafana/loki](https://github.com/grafana/loki)  
**Port**: 3100  
**Docker Image**: `grafana/loki:latest`

Horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus.

**Key Features**:
- Log aggregation
- Label-based indexing
- PromQL-like query language (LogQL)
- Grafana integration
- Cost-effective storage
- Multi-tenancy support

**Access**: Via Grafana at http://localhost:3001

**Configuration**: See [services/loki/README.md](../services/loki/README.md)

---

### Portainer

**Official Repository**: [portainer/portainer](https://github.com/portainer/portainer)  
**Ports**: 9000 (HTTP), 9443 (HTTPS)  
**Docker Image**: `portainer/portainer-ce:latest`

Container management software for Docker, Kubernetes, and more.

**Key Features**:
- Container management
- Stack deployment
- Image registry
- Network management
- Volume management
- User access control

**Access**: http://localhost:9000

**Configuration**: See [services/portainer/README.md](../services/portainer/README.md)

---

### Uptime Kuma

**Official Repository**: [louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)  
**Port**: 3003  
**Docker Image**: `louislam/uptime-kuma:latest`

Fancy self-hosted monitoring tool like "Uptime Robot".

**Key Features**:
- Service monitoring
- Multi-protocol support (HTTP, TCP, ping)
- Status page
- Notification integrations
- Certificate monitoring
- Beautiful UI

**Access**: http://localhost:3003

**Configuration**: See [services/uptime-kuma/README.md](../services/uptime-kuma/README.md)

---

## Backup & Cloud Storage

### Rclone

**Official Repository**: [rclone/rclone](https://github.com/rclone/rclone)  
**Port**: 5572  
**Docker Image**: `rclone/rclone:latest`

Command-line program to sync files and directories to and from cloud storage.

**Key Features**:
- 40+ cloud storage providers
- Encryption support
- Mount capabilities
- Sync and copy operations
- Bandwidth limiting
- Progress tracking

**Access**: Command-line interface

**Configuration**: See [services/rclone/README.md](../services/rclone/README.md)

---

### Nextcloud

**Official Repository**: [nextcloud/server](https://github.com/nextcloud/server)  
**Port**: 11000  
**Docker Image**: `nextcloud:latest`

Self-hosted productivity platform that puts you in control.

**Key Features**:
- File sync and share
- Calendar and contacts
- Document editing
- Video calls
- Mobile apps
- Extensible with apps

**Access**: http://localhost:11000

**Configuration**: See [services/nextcloud/README.md](../services/nextcloud/README.md)

---

## Automation

### Radarr

**Official Repository**: [Radarr/Radarr](https://github.com/Radarr/Radarr)  
**Port**: 7878  
**Docker Image**: `lscr.io/linuxserver/radarr:latest`

Movie collection manager for Usenet and BitTorrent users.

**Key Features**:
- Automated movie downloads
- Quality profiles
- Calendar integration
- Import list support
- Custom formats
- Notification integrations

**Access**: http://localhost:7878

**Configuration**: See [services/radarr/README.md](../services/radarr/README.md)

---

### Sonarr

**Official Repository**: [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr)  
**Port**: 8989  
**Docker Image**: `lscr.io/linuxserver/sonarr:latest`

TV show collection manager for Usenet and BitTorrent users.

**Key Features**:
- Automated TV show downloads
- Episode management
- Calendar view
- Import list support
- Custom formats
- Multi-language support

**Access**: http://localhost:8989

**Configuration**: See [services/sonarr/README.md](../services/sonarr/README.md)

---

### Prowlarr

**Official Repository**: [Prowlarr/Prowlarr](https://github.com/Prowlarr/Prowlarr)  
**Port**: 9696  
**Docker Image**: `lscr.io/linuxserver/prowlarr:latest`

Indexer manager/proxy built on the popular *arr .net/reactjs base stack to integrate with your various PVR apps.

**Key Features**:
- Indexer management
- Integration with Sonarr/Radarr
- Built-in search
- Statistics tracking
- FlareSolverr support
- Multiple indexer support

**Access**: http://localhost:9696

**Configuration**: See [services/prowlarr/README.md](../services/prowlarr/README.md)

---

### Transmission

**Official Repository**: [transmission/transmission](https://github.com/transmission/transmission)  
**Ports**: 6969 (Web UI), 6881 (Peer connections)  
**Docker Image**: `lscr.io/linuxserver/transmission:latest`

Fast, easy, and free BitTorrent client.

**Key Features**:
- Web interface
- Encryption support
- Bandwidth management
- Peer exchange
- Magnet link support
- Watch folder

**Access**: http://localhost:6969

**Configuration**: See [services/transmission/README.md](../services/transmission/README.md)

---

## Dashboard & Utilities

### Homepage

**Official Repository**: [gethomepage/homepage](https://github.com/gethomepage/homepage)  
**Port**: 3000  
**Docker Image**: `ghcr.io/gethomepage/homepage:latest`

Highly customizable homepage with Docker and service integrations.

**Key Features**:
- Service monitoring
- Docker integration
- Weather widgets
- Bookmarks
- Search bar
- Beautiful themes

**Access**: http://localhost:3000

**Configuration**: See [services/homepage/README.md](../services/homepage/README.md)

---

### File Browser

**Official Repository**: [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser)  
**Port**: 6060  
**Docker Image**: `filebrowser/filebrowser:latest`

Web-based file manager with a simple and intuitive interface.

**Key Features**:
- File management
- Upload/download
- User management
- Search functionality
- Mobile-friendly
- Custom commands

**Access**: http://localhost:6060

**Configuration**: See [services/filebrowser/README.md](../services/filebrowser/README.md)

---

## Documentation

### MkDocs

**Official Repository**: [squidfunk/mkdocs-material](https://github.com/squidfunk/mkdocs-material)  
**Port**: 8001  
**Docker Image**: `squidfunk/mkdocs-material:latest`

Material theme for MkDocs - technical documentation that just works.

**Key Features**:
- Material Design theme
- Full-text search
- Syntax highlighting
- Mobile-optimized
- Dark mode
- Version control

**Access**: http://localhost:8001

**Configuration**: See [services/mkdocs/README.md](../services/mkdocs/README.md)

---

## Service Management Commands

All services can be managed using the `just` command-line tool:

```bash
# Start all services
just up

# Start a specific service
just up <service-name>

# Stop all services
just stop

# Stop a specific service
just stop <service-name>

# View logs for a service
docker compose -f services/<service-name>/docker-compose.yml logs -f

# Check service status
just services status

# List all available services
just services list
```

For detailed command reference, see [Command Reference](reference/commands.md).
