# Quick Start Guide

Get your home lab up and running in 15 minutes! This guide will help you deploy all 31 services quickly and efficiently.

## Prerequisites

Before you begin, ensure you have:

- **Hardware**: Mac mini M4 (or compatible Apple Silicon Mac)
- **RAM**: 16GB minimum (32GB recommended for all services)
- **Storage**: 256GB SSD minimum (1TB recommended for media)
- **OS**: macOS Ventura or later
- **Network**: Stable internet connection
- **Skills**: Basic terminal/command-line knowledge

## Step 1: Install Required Software

### Install Homebrew

If you don't have Homebrew installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install OrbStack and Just

```bash
# Install OrbStack (Docker replacement optimized for Mac)
brew install --cask orbstack

# Install Just (command runner)
brew install just
```

**Note**: OrbStack will start automatically after installation. It's optimized for Apple Silicon and provides better performance than Docker Desktop.

## Step 2: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/brunoti/home_lab.git

# Navigate to the directory
cd home_lab
```

## Step 3: Configure Environment Variables

The home lab uses a centralized `.env` file for all service configuration.

### Quick Setup (Recommended)

```bash
# Copy the example environment file
cp .env.example .env

# Generate secure passwords for all services
just password
```

The `just password` command will automatically generate strong passwords for all services that need them.

### Manual Setup (Alternative)

If you prefer to set passwords manually:

```bash
# Copy the template
cp .env.example .env

# Edit with your preferred editor
nano .env  # or: vim .env, code .env
```

**Essential variables to configure**:
- `POSTGRES_PASSWORD` - PostgreSQL database password
- `REDIS_PASSWORD` - Redis cache password
- `GRAFANA_ADMIN_PASSWORD` - Grafana dashboard password
- `PIHOLE_WEBPASSWORD` - PiHole admin password
- `PORTAINER_ADMIN_PASSWORD` - Portainer admin password
- Email settings (SMTP configuration for notifications)

See [.env.example](../.env.example) for a complete list of configurable variables.

## Step 4: Verify Docker

Ensure OrbStack/Docker is running:

```bash
# Check Docker status
docker info

# Verify Docker Compose
docker compose version
```

If Docker is not running, start OrbStack from Applications or run:

```bash
open -a OrbStack
```

## Step 5: Create Docker Network

All services communicate via a shared Docker network:

```bash
# Create the homelab network
docker network create homelab
```

## Step 6: Start Services

### Start All Services

```bash
# Start all 31 services
just up

# This will take 2-5 minutes for initial setup
```

### Start Services Selectively

If you have limited RAM or want to start services gradually:

```bash
# Start core services first
just up postgres
just up redis
just up nginx-proxy-manager

# Then start media services
just up jellyfin
just up immich

# Add other services as needed
just up koel
just up navidrome
```

### Monitor Startup Progress

```bash
# Check service status
just services status

# View logs for all services
docker compose logs -f

# View logs for a specific service
just services --action logs --name jellyfin --follow
```

## Step 7: Access Your Services

Once services are running, access them through your browser:

### Essential Services

| Service | URL | Purpose |
|---------|-----|---------|
| Homepage Dashboard | http://localhost:3000 | Central dashboard |
| Portainer | http://localhost:9000 | Docker management |
| Grafana | http://localhost:3001 | Monitoring dashboards |

### Media & Entertainment

| Service | URL | Purpose |
|---------|-----|---------|
| Jellyfin | http://localhost:8096 | Media streaming |
| Immich | http://localhost:2283 | Photo management |
| Speedtest Tracker | http://localhost:5000 | Internet monitoring |

### Music

| Service | URL | Purpose |
|---------|-----|---------|
| Koel | http://localhost:13000 | Modern music player |
| Navidrome | http://localhost:4533 | Subsonic-compatible |

### Books

| Service | URL | Purpose |
|---------|-----|---------|
| Calibre Web | http://localhost:8083 | E-book reader |
| Audiobookshelf | http://localhost:8000 | Audiobooks |
| Bookstore | http://localhost:3002 | Book wiki |
| Lazylibrarian | http://localhost:8666 | Book automation |

### Network & Security

| Service | URL | Purpose |
|---------|-----|---------|
| PiHole | http://localhost:8053/admin | DNS & ad-blocking |
| Nginx Proxy Manager | http://localhost:81 | Reverse proxy |
| Authelia | http://localhost:9091 | Authentication |
| Headscale | http://localhost:8085 | VPN control |

### Automation

| Service | URL | Purpose |
|---------|-----|---------|
| Radarr | http://localhost:7878 | Movie automation |
| Sonarr | http://localhost:8989 | TV automation |
| Prowlarr | http://localhost:9696 | Indexer manager |
| Transmission | http://localhost:6969 | Torrent client |

### Other Services

| Service | URL | Purpose |
|---------|-----|---------|
| Nextcloud | http://localhost:11000 | Cloud storage |
| File Browser | http://localhost:6060 | File management |
| Uptime Kuma | http://localhost:3003 | Uptime monitoring |
| Affine | http://localhost:3010 | Notes & wiki |
| Documentation | http://localhost:8001 | This documentation |

For a complete list, see [SERVICES.md](SERVICES.md).

## Step 8: Initial Configuration

### Set Up Monitoring Stack

1. **Access Grafana**: http://localhost:3001
   - Default login: `admin` / (password from `.env`)
   - Import dashboards from the config folder
   - Configure Prometheus data source

2. **Configure Portainer**: http://localhost:9000
   - Create admin account on first visit
   - Connect to local Docker environment
   - Explore running containers

3. **Set Up Uptime Kuma**: http://localhost:3003
   - Create admin account
   - Add monitors for all services
   - Configure notification channels

### Configure Media Services

1. **Jellyfin Setup**: http://localhost:8096
   - Create admin account
   - Add media libraries
   - Enable hardware acceleration (Video Toolbox for M4)
   - Configure transcoding settings

2. **Immich Setup**: http://localhost:2283
   - Create account
   - Install mobile app
   - Configure auto-backup

### Configure Music Services

1. **Koel**: http://localhost:13000
   - Complete setup wizard
   - Import music library
   - Configure scrobbling (optional)

2. **Navidrome**: http://localhost:4533
   - Create admin account
   - Scan music library
   - Configure transcoding

### Configure Network Services

1. **PiHole**: http://localhost:8053/admin
   - Login with password from `.env`
   - Add blocklists
   - Configure DNS settings
   - Update network devices to use PiHole

2. **Nginx Proxy Manager**: http://localhost:81
   - Login with default credentials (admin@example.com / changeme)
   - Change password immediately
   - Add proxy hosts for services
   - Configure SSL certificates

## Step 9: Configure Backups

For automated backups, you'll need to set up Rclone manually:

```bash
# Start Rclone service
just up rclone

# Access Rclone container to configure remotes
docker exec -it rclone rclone config

# Follow prompts to add Google Drive, Mega, or other cloud storage
```

See the [Rclone documentation](https://rclone.org/docs/) for detailed configuration instructions.

## Step 10: Verify Your Setup

Check that everything is working:

```bash
# Check all service status
just services status

# Check Docker resource usage
docker stats --no-stream

# View logs for a specific service
docker compose -f services/<service-name>/docker-compose.yml logs

# Test service connectivity by accessing the web interfaces
# See the service access table above for URLs
```

## Common First-Time Issues

### Service Won't Start

```bash
# Check service logs
docker compose -f services/<service-name>/docker-compose.yml logs -f

# Common issues:
# 1. Port already in use - check with: lsof -i :<port>
# 2. Missing environment variables - verify .env file
# 3. Permission issues - check volume mount permissions
```

### High Memory Usage

```bash
# Check resource usage
docker stats

# If RAM is maxed out:
# 1. Stop non-essential services with: just stop <service-name>
# 2. Limit Jellyfin concurrent transcodes
# 3. Consider upgrading to 32GB RAM
```

### Cannot Access Services

```bash
# Check if services are running
just services status

# Check Docker network
docker network inspect homelab

# Restart problematic service
just stop <service-name>
just up <service-name>
```

### Database Connection Errors

```bash
# Ensure PostgreSQL is running
docker ps | grep postgres

# Check PostgreSQL logs
docker compose -f services/postgres/docker-compose.yml logs -f

# Verify .env has correct POSTGRES_PASSWORD
```

## Next Steps

Now that your home lab is running, explore these resources:

1. **[Service Directory](SERVICES.md)** - Detailed information about each service
2. **[Command Reference](reference/commands.md)** - All available `just` commands
3. **[Backup & Restore](operations/backup-restore.md)** - Protect your data
4. **[Troubleshooting](operations/troubleshooting.md)** - Fix common issues
5. **[Architecture](architecture/modular-services.md)** - Understand the system design

## Useful Commands

### Service Management

```bash
# List all services
just services list

# Start a service
just up <service-name>

# Stop a service
just stop <service-name>

# View logs
docker compose -f services/<service-name>/docker-compose.yml logs -f
```

### Monitoring

```bash
# Check status
just services status

# Check Docker resource usage
docker stats

# View container details
docker ps
```

### Updates

```bash
# Pull latest Docker images for a service
(cd services/<service-name> && docker compose pull)

# Update and restart a service
just stop <service-name>
just up <service-name>

# Update all services
just stop
for service_dir in services/*/; do
    (cd "$service_dir" && docker compose pull)
done
just up
```

### Documentation

```bash
# Start documentation server
just up mkdocs

# Access at: http://localhost:8001
```

## Getting Help

- **Documentation**: http://localhost:8001
- **FAQ**: [docs/reference/faq.md](reference/faq.md)
- **Troubleshooting**: [docs/operations/troubleshooting.md](operations/troubleshooting.md)
- **GitHub Issues**: https://github.com/brunoti/home_lab/issues
- **GitHub Discussions**: https://github.com/brunoti/home_lab/discussions

## Security Reminders

- ✅ Change all default passwords
- ✅ Keep `.env` file secure and never commit it
- ✅ Enable Authelia for sensitive services
- ✅ Use Headscale VPN for remote access
- ✅ Keep services updated regularly
- ✅ Enable PiHole for network-wide ad blocking
- ✅ Set up automated backups
- ✅ Test disaster recovery periodically

---

**Congratulations!** 🎉 Your home lab is now running. Enjoy your self-hosted services!
