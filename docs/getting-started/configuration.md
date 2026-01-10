# Configuration Guide

Complete guide for configuring your home lab environment.

## Environment Setup

### 1. Copy Environment Template

```bash
cp .env.example .env
```

### 2. Essential Configuration

#### Database Configuration

PostgreSQL is the primary database:

```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password_here
POSTGRES_DB=postgres
POSTGRES_PORT=5432
```

**Security Note**: Use a strong password (16+ characters, mixed case, numbers, symbols)

Redis cache configuration:

```bash
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password_here
REDIS_APPENDONLY=yes
```

#### Admin Passwords

Set strong passwords for admin interfaces:

```bash
# Grafana
GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=your_grafana_password

# PiHole
PIHOLE_WEBPASSWORD=your_pihole_password

# Portainer
PORTAINER_ADMIN_USER=admin
PORTAINER_ADMIN_PASSWORD=your_portainer_password
```

#### Email Notifications (Recommended)

Configure SMTP for backup and alert notifications:

```bash
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_app_password
SMTP_FROM=your-email@gmail.com
```

**For Gmail**: 
1. Enable 2FA in Google Account
2. Generate App Password at: https://myaccount.google.com/apppasswords
3. Use the 16-character app password

### 3. Service-Specific Configuration

#### Jellyfin (Media Server)

```bash
JELLYFIN_UID=1000
JELLYFIN_GID=1000
JELLYFIN_DATA_DIR=/path/to/your/media
```

Update `JELLYFIN_DATA_DIR` to point to your media library.

#### Music Services

```bash
# Koel
KOEL_APP_KEY=base64:generate_with_php_artisan
KOEL_ADMIN_EMAIL=admin@example.com
KOEL_ADMIN_PASSWORD=your_koel_password

# Navidrome
NAVIDROME_MUSIC_FOLDER=/path/to/your/music
NAVIDROME_SCAN_INTERVAL=1m
```

#### Book Services

```bash
# Calibre
CALIBRE_LIBRARY_PATH=/path/to/your/books
CALIBRE_UID=1000
CALIBRE_GID=1000

# Lazylibrarian
LAZYLIBRARIAN_LIBRARY_DIR=/path/to/your/books
```

#### Media Automation

```bash
# Radarr (Movies)
RADARR_MOVIES_DIR=/path/to/movies
RADARR_API_KEY=generate_in_radarr_settings

# Sonarr (TV)
SONARR_TV_DIR=/path/to/tv
SONARR_API_KEY=generate_in_sonarr_settings

# Prowlarr (Indexers)
PROWLARR_API_KEY=generate_in_prowlarr_settings
```

### 4. Network Configuration

#### Headscale (VPN)

```bash
HEADSCALE_PORT=8085
HEADSCALE_DATA_DIR=/var/lib/headscale
HEADSCALE_PRIVATE_KEY_PATH=/var/lib/headscale/private.key
```

#### PiHole (DNS)

```bash
PIHOLE_DNS1=8.8.8.8
PIHOLE_DNS2=8.8.4.4
PIHOLE_TZ=America/New_York  # Set your timezone
```

### 5. Directory Structure

Create required directories:

```bash
mkdir -p ~/homelab/{data,config,cache,logs,backups}
mkdir -p ~/homelab/data/{jellyfin,calibre,koel,navidrome}
mkdir -p ~/homelab/config/{grafana,prometheus,nginx}
```

### 6. Validation

Validate your configuration:

```bash
just setup --target config
```

This checks for:
- Missing .env file
- Empty required variables
- Invalid paths
- Port conflicts

## Advanced Configuration

### Custom Ports

To change default ports, edit `docker-compose.yml`:

```yaml
services:
  jellyfin:
    ports:
      - "8096:8096"  # Change first number for host port
```

### Resource Limits

Adjust resource limits in `docker-compose.yml`:

```yaml
services:
  jellyfin:
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '2.0'
```

### Volume Mounts

Configure custom volume mounts:

```yaml
services:
  jellyfin:
    volumes:
      - /your/custom/path:/media
      - ${JELLYFIN_CONFIG_DIR}:/config
```

### Network Configuration

Custom network settings:

```yaml
networks:
  homelab:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

## Service-Specific Setup

### Jellyfin Setup

1. Start Jellyfin: `just services --action start --name jellyfin`
2. Visit http://localhost:8096
3. Complete setup wizard
4. Add media libraries
5. Enable hardware acceleration:
   - Dashboard → Playback → Hardware acceleration
   - Select "Video Toolbox" for M4 Mac

### Grafana Setup

1. Start Grafana: `just services --action start --name grafana`
2. Visit http://localhost:3000
3. Login with credentials from .env
4. Add Prometheus data source:
   - Configuration → Data Sources → Add
   - Type: Prometheus
   - URL: http://prometheus:9090
5. Import dashboards from config/grafana/

### Calibre Setup

1. Start Calibre: `just services --action start --name calibre`
2. Visit http://localhost:8080
3. Set library location: `/books`
4. Import existing library or start fresh

### Koel Setup

1. Generate app key:
   ```bash
   docker-compose exec koel php artisan key:generate
   # Copy the generated key to KOEL_APP_KEY in .env
   ```
2. Restart Koel: `just services --action restart --name koel`
3. Visit http://localhost:13000
4. Create admin account
5. Import music: `just music --action import --service koel`

## Configuration Files

### Docker Compose Override

Create `docker-compose.override.yml` for local customizations:

```yaml
version: '3.8'

services:
  jellyfin:
    environment:
      - CUSTOM_VAR=value
    volumes:
      - /custom/path:/extra
```

This file is git-ignored and won't be overwritten on updates.

### Grafana Provisioning

Place custom dashboards in `config/grafana/dashboards/`.

Example dashboard config:

```yaml
# config/grafana/dashboards/homelab.yml
apiVersion: 1

providers:
  - name: 'Home Lab'
    folder: 'Home Lab'
    type: file
    options:
      path: /etc/grafana/provisioning/dashboards
```

### Prometheus Configuration

Custom metrics in `config/prometheus/prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'custom-service'
    static_configs:
      - targets: ['service:port']
```

## Troubleshooting Configuration

### Environment Variables Not Loading

```bash
# Check .env file exists
ls -la .env

# Verify no syntax errors
cat .env | grep -v '^#' | grep -v '^$'

# Restart services
just services --action restart
```

### Port Conflicts

```bash
# Check which process uses a port
lsof -i :8096

# Change port in docker-compose.yml or stop conflicting service
```

### Permission Issues

```bash
# Fix ownership of data directories
sudo chown -R 1000:1000 ~/homelab/data

# Check UIDs match in .env
grep UID .env
```

### Service Won't Start

```bash
# Check logs
just services --action logs --name service-name --follow

# Verify configuration
docker-compose config

# Check dependencies
docker-compose ps
```

## Security Best Practices

1. **Use Strong Passwords**
   - Minimum 16 characters
   - Mix of upper/lower/numbers/symbols
   - Different password for each service

2. **Secure .env File**
   ```bash
   chmod 600 .env
   ```

3. **Enable Authentication**
   - Configure Authelia for sensitive services
   - Use Headscale VPN for external access

4. **Regular Updates**
   - Update passwords quarterly
   - Keep services updated
   - Review access logs

5. **Backup Configuration**
   ```bash
   just backup --target gdrive --config-only
   ```

## Next Steps

After configuration:

1. [Start Services](../getting-started/quick-start.md#5-launch-services)
2. [Setup Backups](../operations/backup-restore.md)
3. [Configure Monitoring](../operations/monitoring.md)
4. [Import Media Libraries](#service-specific-setup)

## Configuration Checklist

- [ ] Copy .env.example to .env
- [ ] Set database passwords
- [ ] Configure admin passwords
- [ ] Setup email notifications
- [ ] Configure media paths
- [ ] Create directory structure
- [ ] Validate configuration
- [ ] Test email notifications
- [ ] Setup cloud backups
- [ ] Configure monitoring alerts
