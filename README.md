# Home Lab

A comprehensive, self-hosted home lab running 30 containerized services on Mac mini M4. Features media streaming, book management, music servers, monitoring, backups, and more.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-compose-blue.svg)](https://docs.docker.com/compose/)
[![OrbStack](https://img.shields.io/badge/runtime-orbstack-green.svg)](https://orbstack.dev)

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/brunoti/home_lab.git
cd home_lab

# Install dependencies
just install

# Setup environment - IMPORTANT: This must be done before starting services
cp .env.example .env

# Generate secure passwords for all services (recommended)
just password

# OR manually edit .env with your settings
# nano .env

# OrbStack will start automatically after installation
# Optionally verify it's running:
docker info

# Start all services
just up

# Access documentation
just docs --action serve
```

**Note:** The `.env` file must be created in the repository root directory before starting any services. It contains critical configuration including database passwords and API keys. Use `just password` to automatically generate secure passwords for all services.

## 📋 Features

- **30 Containerized Services** - Media, books, music, monitoring, and more
- **Modular Architecture** - Each service in its own directory under `services/`
- **Simplified Commands** - Argument-based `just` commands for easy management
- **Individual Service Control** - Start, stop, or manage services independently
- **Comprehensive Documentation** - Built-in MkDocs documentation server
- **Automated Backups** - Google Drive and Mega cloud backups with email notifications
- **Monitoring Stack** - Prometheus, Grafana, Loki for complete observability
- **M4 Optimized** - Configured for Mac mini M4 with 16GB RAM
- **Secure Access** - VPN-only external access via Headscale

## 📁 Repository Structure

```
home_lab/
├── services/                  # Modular service definitions
│   ├── jellyfin/
│   │   ├── docker-compose.yml
│   │   └── README.md
│   ├── postgres/
│   │   ├── docker-compose.yml
│   │   └── README.md
│   └── ...                    # 31 services total
├── config/                    # Service configurations
│   ├── prometheus/
│   ├── loki/
│   └── ...
├── scripts/                   # Helper scripts
├── docs/                      # Documentation
├── justfile                   # Task automation
├── .env.example              # Environment variables template
└── README.md
```

Each service is self-contained with its own `docker-compose.yml` file, making it easy to:
- Start/stop services individually
- Understand service dependencies
- Customize service configurations
- Add or remove services without affecting others

## 🏗️ Architecture

```
┌─────────────────────────────────────────────┐
│        Mac mini M4 (16GB RAM, 256GB SSD)    │
├─────────────────────────────────────────────┤
│  OrbStack (Docker) - Dynamic RAM allocation │
│                                              │
│  ├── Media & Entertainment (5 services)     │
│  │   ├── Jellyfin - Media streaming         │
│  │   ├── Immich - Photo management          │
│  │   ├── Speedtest Tracker                  │
│  │   └── ...                                │
│  │                                           │
│  ├── Books & Reading (5 services)           │
│  │   ├── Calibre - Library management       │
│  │   ├── Audiobookshelf - Audiobooks        │
│  │   └── ...                                │
│  │                                           │
│  ├── Music (2 services)                     │
│  │   ├── Koel - Modern music server         │
│  │   └── Navidrome - Subsonic compatible    │
│  │                                           │
│  ├── Monitoring (5 services)                │
│  │   ├── Prometheus - Metrics               │
│  │   ├── Grafana - Dashboards               │
│  │   └── ...                                │
│  │                                           │
│  └── And 13 more services...                │
└─────────────────────────────────────────────┘
```

## 📦 Services

### Media & Entertainment (5)
- **[Jellyfin](https://github.com/jellyfin/jellyfin)** (Port 8096) - Movies, TV shows, music streaming
- **[Koel](https://github.com/koel/koel)** (Port 13000) - Modern music server
- **[Navidrome](https://github.com/navidrome/navidrome)** (Port 4533) - Subsonic-compatible music
- **[Speedtest Tracker](https://github.com/alexjustesen/speedtest-tracker)** (Port 5000) - Internet speed monitoring
- **[Immich](https://github.com/immich-app/immich)** (Port 2283) - Photo management

### Books & Reading (5)
- **[Calibre](https://github.com/kovidgoyal/calibre)** (Port 8080) - Library management
- **[Calibre Web](https://github.com/janeczku/calibre-web)** (Port 8083) - Web reader interface
- **[Bookstore](https://github.com/BookStackApp/BookStack)** (Port 3002) - Book discovery
- **[Audiobookshelf](https://github.com/advplyr/audiobookshelf)** (Port 8000) - Audiobooks
- **[Lazylibrarian](https://github.com/lazylibrarian/LazyLibrarian)** (Port 8666) - Automated ebook discovery

### Network & Security (3)
- **[Headscale](https://github.com/juanfont/headscale)** (Port 8085) - VPN server
- **[PiHole](https://github.com/pi-hole/pi-hole)** (Port 8053, 53) - DNS & ad-blocking
- **[Authelia](https://github.com/authelia/authelia)** (Port 9091) - Authentication server

### Monitoring & Observability (5)
- **[Portainer](https://github.com/portainer/portainer)** (Port 9000) - Docker management
- **[Prometheus](https://github.com/prometheus/prometheus)** (Port 9090) - Metrics collection
- **[Grafana](https://github.com/grafana/grafana)** (Port 3001) - Dashboards
- **[Loki](https://github.com/grafana/loki)** (Port 3100) - Log aggregation
- **[Uptime Kuma](https://github.com/louislam/uptime-kuma)** (Port 3003) - Uptime monitoring

### Storage & Cloud (2)
- **[Nextcloud](https://github.com/nextcloud/server)** (Port 11000) - Cloud storage
- **[Rclone](https://github.com/rclone/rclone)** (Port 5572) - Cloud backups

### Utilities & Infrastructure (10)
- **[Homepage](https://github.com/gethomepage/homepage)** (Port 3000) - Dashboard
- **[Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)** (Port 81, 443) - Reverse proxy
- **[File Browser](https://github.com/filebrowser/filebrowser)** (Port 6060) - Web file manager
- **[MkDocs](https://github.com/squidfunk/mkdocs-material)** (Port 8001) - Documentation
- **[PostgreSQL](https://github.com/postgres/postgres)** - Database
- **[Redis](https://github.com/redis/redis)** - Caching
- **[Radarr](https://github.com/Radarr/Radarr)** (Port 7878) - Movie automation
- **[Sonarr](https://github.com/Sonarr/Sonarr)** (Port 8989) - TV automation
- **[Prowlarr](https://github.com/Prowlarr/Prowlarr)** (Port 9696) - Indexer manager
- **[Transmission](https://github.com/transmission/transmission)** (Port 6969) - Torrent client
- **[Affine](https://github.com/toeverything/AFFiNE)** (Port 3010) - Notes & wiki

## 🛠️ Command Reference

The home lab uses simplified, argument-based commands via `just`:

### Setup & Installation

```bash
# Install all dependencies
just install

# Validate configuration
just setup --target config
```

### Service Management

```bash
# Display all available just commands
just help

# List all available services
just services list

# Start all services
just up

# Start a specific service
just up jellyfin

# Stop all services
just stop

# Stop a specific service
just stop jellyfin

# Alternative: Advanced service management with legacy commands
# Check service status
just services status

# Check detailed status with resource usage
just services status --detailed
```

### Monitoring Services

```bash
# Check service status
just services status

# List all available services
just services list
```

## 📚 Documentation

Full documentation is available at http://localhost:8001 when running the documentation server:

```bash
# Start MkDocs documentation server
just up mkdocs
```

Or browse the documentation in the `docs/` directory:

- **[Quick Start Guide](docs/QUICK_START.md)** - Get started in 15 minutes
- **[Service Directory](docs/SERVICES.md)** - Complete service list with official GitHub links
- [Installation Guide](docs/getting-started/installation.md)
- [Service Documentation](docs/services/)
- [Backup & Restore](docs/operations/backup-restore.md)
- [Command Reference](docs/reference/commands.md)
- [Troubleshooting](docs/operations/troubleshooting.md)

## ⚙️ Configuration

### System Requirements

- **Device**: Mac mini M4 (or compatible)
- **RAM**: 16GB (32GB recommended)
- **Storage**: 256GB SSD minimum
- **OS**: macOS Ventura or later

### Resource Allocation

```
Total RAM: 16GB
├── OrbStack (Docker): Dynamic allocation (~8GB typical)
│   ├── Jellyfin: 2GB
│   ├── Databases: 1.5GB
│   ├── Monitoring: 1GB
│   └── Other services: 3.5GB
└── macOS: Remaining (~8GB)
```

### Environment Variables

The `.env` file must be created in the repository root directory and is required before starting any services.

**Quick Setup:**
```bash
# Copy template
cp .env.example .env

# Generate secure passwords automatically (recommended)
just password

# Verify configuration
just setup --target config
```

**Essential Variables:**
- Database passwords (PostgreSQL, Redis)
- Admin passwords (Grafana, PiHole, Portainer)
- Email configuration (SMTP settings)
- API keys (Radarr, Sonarr)

**Important Notes:**
- The `.env` file is located in the repository root and is shared by all services
- Never commit the `.env` file to version control (it's in `.gitignore`)
- Use `just password` to automatically generate secure passwords for empty variables
- Backup your `.env` file securely

See [Environment Variables Reference](docs/reference/environment-variables.md) for complete list.

## 🔐 Security

- **Local Network**: Full unrestricted access
- **External Access**: VPN-only via Headscale
- **Authentication**: Authelia for sensitive services
- **Ad-Blocking**: PiHole network-wide DNS filtering
- **Backups**: Encrypted cloud backups with email notifications

## 📊 Monitoring

Access monitoring dashboards:

- **Grafana**: http://localhost:3000 - Metrics and dashboards
- **Portainer**: http://localhost:9000 - Docker management
- **Homepage**: http://localhost:3000 - Service dashboard
- **Uptime Kuma**: http://localhost:3001 - Uptime monitoring

## 💾 Backup Strategy

- **Google Drive**: Full daily backups
- **Mega**: Incremental backups 2x daily
- **Local Cache**: 7-day rolling window
- **Email Notifications**: Success/failure alerts

```bash
# Setup backups
just backup --target gdrive --action setup
just backup --target mega --action setup

# Run backups
just backup --target gdrive
just backup --target mega

# Test disaster recovery
just test --target disaster-recovery
```

## 🔄 Updates

```bash
# Pull latest changes
git pull origin main

# Update Docker images for all services
for service_dir in services/*/; do
    if [ -f "${service_dir}docker-compose.yml" ]; then
        (cd "$service_dir" && docker compose pull)
    fi
done

# Restart services
just stop
just up
```

## 🐛 Troubleshooting

### Service Won't Start

```bash
# Check service status
just services status

# View service logs
docker compose -f services/<service-name>/docker-compose.yml logs -f

# Restart a specific service
just stop <service-name>
just up <service-name>
```

### High RAM Usage

```bash
# Check Docker resource usage
docker stats

# Restart heavy services
just stop jellyfin
just up jellyfin
```

### Network Issues

```bash
# Check Docker network
docker network inspect homelab

# Verify container networking
docker ps

# Check service ports
docker compose -f services/<service-name>/docker-compose.yml ps
```
```

See [Troubleshooting Guide](docs/operations/troubleshooting.md) for more solutions.

## 📈 Performance

**What Works Great:**
- ✅ All 30 services running simultaneously
- ✅ Jellyfin 1080p streaming with transcoding
- ✅ Multiple concurrent music streams
- ✅ Automated book discovery and imports
- ✅ Full monitoring with Prometheus + Grafana
- ✅ VPN access via Headscale
- ✅ Cloud backups to Google Drive & Mega

**Recommendations:**
- Limit Jellyfin to 2-3 concurrent transcodes
- Monitor RAM usage regularly
- Run disaster recovery tests monthly
- Keep Docker logs rotated

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see LICENSE file for details.

## 🙏 Acknowledgments

- All the amazing open-source projects that make this possible
- The home lab and self-hosting communities

## 📞 Support

- **Documentation**: http://localhost:8001 or [docs/](docs/)
- **Issues**: [GitHub Issues](https://github.com/brunoti/home_lab/issues)
- **Discussions**: [GitHub Discussions](https://github.com/brunoti/home_lab/discussions)

## 🗺️ Roadmap

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for the complete project plan and roadmap.

---

**Built with ❤️ for the home lab community**
