# Quick Start Guide

Get your home lab up and running in minutes!

## Prerequisites

- Mac mini M4 (16GB RAM recommended)
- macOS installed
- Internet connection
- Basic terminal knowledge

## 1. Install Dependencies

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install just
brew install --cask orbstack
```

## 2. Clone Repository

```bash
git clone https://github.com/brunoti/home_lab.git
cd home_lab
```

## 3. Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your settings
nano .env  # or use your preferred editor
```

**Required Variables to Set:**
- Database passwords (PostgreSQL, Redis)
- Admin passwords (Grafana, PiHole, Portainer)
- API keys (Radarr, Sonarr)
- Email configuration (for notifications)

## 4. Verify Docker

```bash
# OrbStack starts automatically
# Verify Docker is running
docker info
```

## 5. Launch Services

```bash
# Start all services
just services --action start

# Wait for services to initialize (2-3 minutes)
```

## 6. Access Services

Open your browser and visit:

- **Dashboard**: http://localhost:3000 (Homepage)
- **Media**: http://localhost:8096 (Jellyfin)
- **Monitoring**: http://localhost:3000 (Grafana)
- **Container Management**: http://localhost:9000 (Portainer)
- **Documentation**: http://localhost:8001

## 7. Initial Setup Tasks

```bash
# Test email notifications
just test --target email

# Run health check
just monitor --target health

# Import your media libraries
just music --action import --service koel
just books --action import --service calibre
```

## 8. Configure Backups

```bash
# Setup Google Drive backup
just backup --target gdrive --action setup

# Setup Mega backup
just backup --target mega --action setup

# Run first backup
just backup --target gdrive
```

## Next Steps

- Review [Service Configuration](../services/) for detailed service setup
- Set up [Monitoring & Alerts](../operations/monitoring.md)
- Configure [Backup Strategy](../operations/backup-restore.md)
- Explore [Command Reference](../reference/commands.md)

## Troubleshooting

If you encounter issues:

1. Check service logs: `just services --action logs --name <service>`
2. Verify configuration: `just setup --target config`
3. Check RAM usage: `just monitor --target ram`
4. Ensure Docker is running: `docker info`
5. Review [Troubleshooting Guide](../operations/troubleshooting.md)

## Getting Help

- Check the [FAQ](../reference/faq.md)
- Review [Troubleshooting Guide](../operations/troubleshooting.md)
- Open an issue on [GitHub](https://github.com/brunoti/home_lab/issues)
