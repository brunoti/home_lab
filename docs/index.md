# Home Lab Documentation

Welcome to the comprehensive documentation for brunoti's Home Lab. This documentation covers setup, configuration, usage, and maintenance of all services running in the home lab environment.

## 📚 Documentation Sections

### Getting Started
- [Quick Start Guide](getting-started/quick-start.md) - Get up and running quickly
- [Installation Guide](getting-started/installation.md) - Detailed installation instructions
- [Configuration Guide](getting-started/configuration.md) - Environment setup and configuration
- [Migration Guide](getting-started/migration.md) - Migrate from monolithic to modular architecture

### Architecture
- [Modular Services](architecture/modular-services.md) - Understanding the new modular service architecture

### Services
- [Media Services](services/media.md) - Jellyfin, Immich, Speedtest Tracker
- [Music Services](services/music.md) - Koel, Navidrome
- [Book Services](services/books.md) - Calibre, Calibre Web, Audiobookshelf, Lazylibrarian, Bookstore
- [Notes & Knowledge](services/notes.md) - Affine
- [Network & Security](services/network.md) - Headscale, PiHole, Authelia
- [Monitoring](services/monitoring.md) - Prometheus, Grafana, Loki, Portainer, Uptime Kuma
- [Storage & Cloud](services/storage.md) - Nextcloud, Rclone
- [Media Automation](services/automation.md) - Radarr, Sonarr, Prowlarr, Transmission
- [Utilities](services/utilities.md) - File Browser, Homepage, Nginx Proxy Manager

### Operations
- [Backup & Restore](operations/backup-restore.md) - Backup strategies and recovery procedures
- [Monitoring & Alerts](operations/monitoring.md) - System monitoring and alert configuration
- [Maintenance](operations/maintenance.md) - Regular maintenance tasks
- [Troubleshooting](operations/troubleshooting.md) - Common issues and solutions

### Reference
- [Command Reference](reference/commands.md) - All justfile commands
- [Environment Variables](reference/environment-variables.md) - Configuration reference
- [Network Configuration](reference/network.md) - Ports and network setup
- [Resource Allocation](reference/resources.md) - RAM and storage allocation

## 🚀 Quick Links

- **Dashboard**: http://localhost:3000 (Homepage)
- **Monitoring**: http://localhost:3000 (Grafana)
- **Container Management**: http://localhost:9000 (Portainer)
- **Documentation**: http://localhost:8001 (This site)

## 🏗️ Architecture Overview

This home lab runs on a Mac mini M4 with 16GB RAM and 256GB SSD, hosting 30 containerized services:

```
┌─────────────────────────────────────────────┐
│           Mac mini M4 (16GB RAM)            │
├─────────────────────────────────────────────┤
│  OrbStack (Docker Runtime) - Dynamic alloc. │
│  ├── Media Services (5)                     │
│  ├── Books & Reading (5)                    │
│  ├── Music Streaming (2)                    │
│  ├── Network & Security (3)                 │
│  ├── Monitoring (5)                         │
│  ├── Storage & Cloud (2)                    │
│  ├── Media Automation (3)                   │
│  ├── Utilities (5)                          │
│  └── Databases (2)                          │
└─────────────────────────────────────────────┘
```

## 📞 Support

For issues, questions, or contributions:
- GitHub Repository: [brunoti/home_lab](https://github.com/brunoti/home_lab)
- Review the [Troubleshooting Guide](operations/troubleshooting.md)
- Check the [FAQ](reference/faq.md)
