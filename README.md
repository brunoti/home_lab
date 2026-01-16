# Home Lab

A comprehensive, self-hosted home lab running 32 containerized services on Mac mini M4. Features media streaming, book management, music servers, monitoring, backups, and more.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-compose-blue.svg)](https://docs.docker.com/compose/)
[![Colima](https://img.shields.io/badge/runtime-colima-green.svg)](https://github.com/abiosoft/colima)

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/brunoti/home_lab.git
cd home_lab

# Install dependencies
just install

# Setup environment
cp .env.example .env
# Edit .env with your settings

# Setup Mac and Colima
just setup --target mac

# Start all services
just services --action start

# Access documentation
just docs --action serve
```

## 📋 Features

- **32 Containerized Services** - Media, books, music, monitoring, and more
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
│   └── ...                    # 32 services total
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
│  Colima (Docker) - 8GB RAM allocated        │
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

### Media & Entertainment (6)
- **Jellyfin** (Port 8096) - Movies, TV shows, music streaming
- **Koel** (Port 13000) - Modern music server
- **Navidrome** (Port 4533) - Subsonic-compatible music
- **Speedtest Tracker** (Port 5000) - Internet speed monitoring
- **Immich** (Port 2283) - Photo management
- **Dispatcharr** (Port 9191) - IPTV management & proxy

### Books & Reading (5)
- **Calibre** (Port 8080) - Library management
- **Calibre Web** (Port 8083) - Web reader interface
- **Bookstore** (Port 3000) - Book discovery
- **Audiobookshelf** (Port 8000) - Audiobooks
- **Lazylibrarian** (Port 8666) - Automated ebook discovery

### Network & Security (3)
- **Headscale** (Port 8085) - VPN server
- **PiHole** (Port 80, 53) - DNS & ad-blocking
- **Authelia** (Port 9091) - Authentication server

### Monitoring & Observability (5)
- **Portainer** (Port 9000) - Docker management
- **Prometheus** (Port 9090) - Metrics collection
- **Grafana** (Port 3000) - Dashboards
- **Loki** (Port 3100) - Log aggregation
- **Uptime Kuma** (Port 3001) - Uptime monitoring

### Storage & Cloud (2)
- **Nextcloud** (Port 11000) - Cloud storage
- **Rclone** (Port 5572) - Cloud backups

### Utilities & Infrastructure (11)
- **Homepage** (Port 3000) - Dashboard
- **Nginx Proxy Manager** (Port 81, 443) - Reverse proxy
- **File Browser** (Port 6060) - Web file manager
- **MkDocs** (Port 8001) - Documentation
- **PostgreSQL** - Database
- **Redis** - Caching
- **Radarr** (Port 7878) - Movie automation
- **Sonarr** (Port 8989) - TV automation
- **Prowlarr** (Port 9696) - Indexer manager
- **Transmission** (Port 6969) - Torrent client
- **Affine** (Port 3001) - Notes & wiki

## 🛠️ Command Reference

The home lab uses simplified, argument-based commands via `just`:

### Setup & Installation

```bash
# Install all dependencies
just install

# Setup Mac environment with Colima
just setup --target mac

# Validate configuration
just setup --target config
```

### Service Management

```bash
# List all available services
just services --action list

# Start all services
just services --action start

# Start a specific service
just services --action start --name jellyfin

# Stop all services
just services --action stop

# Stop a specific service
just services --action stop --name jellyfin

# Restart specific service
just services --action restart --name jellyfin

# View service logs
just services --action logs --name jellyfin --follow

# Check service status
just services --action status

# Check detailed status with resource usage
just services --action status --detailed
```

### Backups & Restore

```bash
# Setup cloud backups
just backup --target gdrive --action setup
just backup --target mega --action setup

# Create backups
just backup --target gdrive
just backup --target mega
just backup --target local

# List available backups
just backup --target gdrive --action list

# Restore from backup
just restore --source gdrive --date latest
just restore --source gdrive --date 2026-01-10
```

### Music Management

```bash
# Import music to Koel
just music --action import --service koel

# Sync Navidrome library
just music --action sync --service navidrome

# Check music service status
just music --action status
```

### Book Management

```bash
# Import books to Calibre
just books --action import --service calibre

# Convert book formats
just books --action convert --format epub --input book.pdf

# Search for books
just books --action search --service lazylibrarian --query "Book Title"
```

### Monitoring & Health

```bash
# Run health check
just monitor --target health

# Check RAM usage
just monitor --target ram

# Check disk usage
just monitor --target disk

# Generate performance report
just monitor --target performance

# Monitor specific service
just monitor --target service --name jellyfin
```

### Documentation

```bash
# Start documentation server
just docs --action serve

# Build static documentation
just docs --action build

# Update documentation dependencies
just docs --action update
```

### Testing

```bash
# Test disaster recovery
just test --target disaster-recovery

# Test email notifications
just test --target email

# Test backup procedures
just test --target backups

# Run integration tests
just test --target integration
```

## 📚 Documentation

Full documentation is available at http://localhost:8001 when running the documentation server:

```bash
just docs --action serve
```

Or browse the documentation in the `docs/` directory:

- [Quick Start Guide](docs/getting-started/quick-start.md)
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
├── Colima (Docker): 8GB
│   ├── Jellyfin: 2GB
│   ├── Databases: 1.5GB
│   ├── Monitoring: 1GB
│   └── Other services: 3.5GB
└── macOS: 8GB
```

### Environment Variables

Copy `.env.example` to `.env` and configure:

**Essential Variables:**
- Database passwords (PostgreSQL, Redis)
- Admin passwords (Grafana, PiHole, Portainer)
- Email configuration (SMTP settings)
- API keys (Radarr, Sonarr)

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

# Update Docker images
docker-compose pull

# Restart services
just services --action restart
```

## 🐛 Troubleshooting

### Service Won't Start

```bash
# Check logs
just services --action logs --name <service> --follow

# Check status
just services --action status --detailed

# Restart service
just services --action restart --name <service> --force
```

### High RAM Usage

```bash
# Check RAM usage
just monitor --target ram

# Check resource usage
just monitor --target resources

# Restart heavy services
just services --action restart --name jellyfin
```

### Network Issues

```bash
# Diagnose network
just network --action diagnose

# Check port mappings
just network --action ports

# Test connectivity
just test --target connectivity
```

See [Troubleshooting Guide](docs/operations/troubleshooting.md) for more solutions.

## 📈 Performance

**What Works Great:**
- ✅ All 32 services running simultaneously
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
