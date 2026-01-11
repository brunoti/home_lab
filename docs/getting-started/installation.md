# Installation Guide

Comprehensive installation instructions for setting up your home lab environment.

## System Requirements

### Hardware
- **Device**: Mac mini M4 (or compatible)
- **RAM**: 16GB minimum (32GB recommended for heavy usage)
- **Storage**: 256GB SSD minimum (512GB+ recommended)
- **Network**: Gigabit Ethernet (for optimal performance)

### Software
- **OS**: macOS Ventura or later
- **Docker**: Via OrbStack (Docker Desktop also supported)
- **Package Manager**: Homebrew

## Step 1: Install Homebrew

If you don't have Homebrew installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the post-installation instructions to add Homebrew to your PATH.

## Step 2: Install Core Dependencies

```bash
# Install task runner
brew install just

# Install container runtime
brew install --cask orbstack

# Install Docker CLI tools (if not already included)
brew install docker docker-compose

# Install optional utilities
brew install git curl wget jq
```

## Step 3: Configure OrbStack

OrbStack starts automatically after installation and manages resources dynamically. Verify it's running:

```bash
# Check Docker context
docker info

# Verify OrbStack is running
docker ps
```

### OrbStack Auto-Start

OrbStack automatically starts on boot by default. No additional configuration is needed.

### Resource Management

OrbStack dynamically allocates resources based on workload. It automatically:
- Adjusts memory allocation as needed
- Uses efficient file sharing with VirtioFS
- Optimizes for Apple Silicon architecture
- Provides fast container startup times

## Step 4: Clone Repository

```bash
# Clone the repository
git clone https://github.com/brunoti/home_lab.git
cd home_lab

# Verify files
ls -la
```

Expected files:
- `docker-compose.yml`
- `.env.example`
- `justfile`
- `README.md`
- `docs/`

## Step 5: Configure Environment

```bash
# Copy environment template
cp .env.example .env
```

### Edit Configuration

Open `.env` in your preferred editor and configure:

#### Essential Settings

```bash
# PostgreSQL Database
POSTGRES_PASSWORD=your_secure_password

# Redis
REDIS_PASSWORD=your_redis_password

# Grafana Admin
GRAFANA_ADMIN_PASSWORD=your_grafana_password

# PiHole Admin
PIHOLE_WEBPASSWORD=your_pihole_password

# Portainer Admin
PORTAINER_ADMIN_PASSWORD=your_portainer_password
```

#### Media Services

```bash
# Jellyfin paths
JELLYFIN_DATA_DIR=/path/to/media

# Music paths
NAVIDROME_MUSIC_FOLDER=/path/to/music

# Books paths
CALIBRE_LIBRARY_PATH=/path/to/books
```

#### Email Notifications (Optional but Recommended)

```bash
# Gmail SMTP Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
SMTP_FROM=your-email@gmail.com
```

For Gmail, create an [App Password](https://support.google.com/accounts/answer/185833).

## Step 6: Validate Configuration

```bash
# Validate environment configuration
just setup --target config

# Check for missing required variables
grep -E "^[A-Z_]+=$" .env
```

## Step 7: Create Required Directories

```bash
# Create data directories
mkdir -p ~/homelab/{data,config,cache,logs}

# Set proper permissions
chmod -R 755 ~/homelab
```

## Step 8: Pull Docker Images

```bash
# Pull all required images (may take 10-15 minutes)
docker-compose pull
```

## Step 9: Start Services

```bash
# Start all services
just services --action start

# Monitor startup
just services --action logs
```

### First-Time Startup

Services will initialize in the following order:
1. Databases (PostgreSQL, Redis) - ~30 seconds
2. Core infrastructure (Nginx, Homepage) - ~1 minute
3. Monitoring stack (Prometheus, Grafana) - ~2 minutes
4. Media services (Jellyfin, etc.) - ~3 minutes
5. All other services - ~5 minutes total

## Step 10: Verify Installation

```bash
# Check service health
just monitor --target health

# Check RAM usage
just monitor --target ram

# View service status
just services --action status
```

## Step 11: Access Services

Open your browser and verify access:

- **Homepage Dashboard**: http://localhost:3000
- **Portainer**: http://localhost:9000
- **Grafana**: http://localhost:3000
- **Jellyfin**: http://localhost:8096

## Step 12: Initial Service Configuration

### Portainer Setup
1. Navigate to http://localhost:9000
2. Create admin account
3. Select "Local" environment

### Grafana Setup
1. Navigate to http://localhost:3000
2. Login with admin credentials from .env
3. Add Prometheus data source (http://prometheus:9090)
4. Import dashboards from config/grafana/

### Jellyfin Setup
1. Navigate to http://localhost:8096
2. Complete initial setup wizard
3. Add media libraries
4. Enable hardware acceleration for M4

## Post-Installation

### Setup Backups

```bash
# Configure Google Drive
just backup --target gdrive --action setup

# Configure Mega
just backup --target mega --action setup

# Test backup
just backup --target local
```

### Configure Email Alerts

```bash
# Test email configuration
just test --target email

# Configure alert rules
just setup --target alerts
```

### Import Media Libraries

```bash
# Import music
just music --action import --service koel
just music --action sync --service navidrome

# Import books
just books --action import --service calibre
```

## Troubleshooting

### OrbStack Won't Start
```bash
# Check OrbStack status via GUI or
docker info

# Restart OrbStack
# Use the OrbStack app menu: OrbStack > Quit
# Then relaunch OrbStack from Applications
```

### Services Won't Start
```bash
# Check logs
docker-compose logs

# Verify .env file
just setup --target config

# Check disk space
df -h
```

### Port Conflicts
```bash
# Check for port conflicts
lsof -i :8096  # Example for Jellyfin

# Stop conflicting service or change port in docker-compose.yml
```

## Next Steps

- Complete [Configuration Guide](configuration.md)
- Review [Service Documentation](../services/)
- Set up [Monitoring & Alerts](../operations/monitoring.md)
- Configure [Backup Strategy](../operations/backup-restore.md)

## Upgrading

To upgrade to a new version:

```bash
# Pull latest changes
git pull origin main

# Update images
docker-compose pull

# Restart services
just services --action restart
```
