# Backup & Restore

Comprehensive backup and disaster recovery procedures for your home lab.

## Backup Strategy Overview

The home lab uses a multi-tier backup approach:

1. **Google Drive**: Full daily backups
2. **Mega**: Incremental backups 2x daily
3. **Local Cache**: 7-day rolling window
4. **Email Notifications**: Success/failure alerts

## Google Drive Backup

### Setup

```bash
# Configure Google Drive authentication
just backup --target gdrive --action setup
```

Follow the authentication prompts to authorize rclone access.

### Manual Backup

```bash
# Full backup to Google Drive
just backup --target gdrive

# Backup specific service
just backup --target gdrive --service jellyfin
```

### Scheduled Backups

Configure automatic daily backups:

```bash
# Setup cron job (example for daily at 2 AM)
crontab -e

# Add:
0 2 * * * cd /path/to/home_lab && just backup --target gdrive
```

### Restore from Google Drive

```bash
# List available backups
just backup --target gdrive --action list

# Restore full backup
just restore --source gdrive --date 2026-01-10

# Restore specific service
just restore --source gdrive --service jellyfin --date 2026-01-10
```

## Mega Backup

### Setup

```bash
# Configure Mega authentication
just backup --target mega --action setup
```

### Incremental Backup

```bash
# Incremental backup to Mega
just backup --target mega

# Schedule for twice daily
0 8,20 * * * cd /path/to/home_lab && just backup --target mega
```

### Restore from Mega

```bash
# List backups
just backup --target mega --action list

# Restore
just restore --source mega --date 2026-01-10
```

## Local Backup

### Quick Local Backup

```bash
# Create local backup
just backup --target local

# Stored in: ~/homelab/backups/
```

### Backup Retention

Local backups are kept for 7 days:
```bash
# View local backups
ls -lh ~/homelab/backups/

# Manually clean old backups
just backup --target local --action clean
```

## What Gets Backed Up

### Database Backups
- PostgreSQL databases (all)
- Redis data
- SQLite databases (Calibre, etc.)

### Configuration Files
- Docker compose files
- Environment variables (encrypted)
- Service configurations
- Custom scripts

### Application Data
- Jellyfin metadata
- Calibre library database
- Affine workspace data
- Grafana dashboards
- Prometheus metrics (last 7 days)

### Media Files (Optional)
Media files (movies, music, books) can be excluded due to size:
```bash
# Backup without media files
just backup --target gdrive --exclude media
```

## Disaster Recovery

### Complete System Failure

In case of complete system loss:

```bash
# 1. Install dependencies (see Installation Guide)
brew install just colima docker docker-compose

# 2. Clone repository
git clone https://github.com/brunoti/home_lab.git
cd home_lab

# 3. Restore configuration
just restore --source gdrive --date latest --config-only

# 4. Start core services
just services --action start

# 5. Restore data
just restore --source gdrive --date latest

# 6. Verify
just monitor --target health
```

### Service-Specific Recovery

#### Jellyfin Metadata Recovery
```bash
# Backup metadata
just backup --service jellyfin --metadata-only

# Restore metadata
just restore --service jellyfin --metadata-only
```

#### Database Recovery
```bash
# Restore PostgreSQL
just restore --service postgres --date 2026-01-10

# Restore Redis
just restore --service redis --date 2026-01-10
```

#### Calibre Library Recovery
```bash
# Restore Calibre library and database
just restore --service calibre --date 2026-01-10
```

## Testing Disaster Recovery

### Monthly Recovery Test

Run this monthly to ensure backups are working:

```bash
# Run disaster recovery test
just test --target disaster-recovery
```

This test:
1. Creates test backup
2. Simulates service failure
3. Restores from backup
4. Verifies data integrity
5. Reports results via email

### Manual Recovery Test

```bash
# 1. Stop services
just services --action stop

# 2. Backup current state
just backup --target local --name pre-test

# 3. Clear test service data
docker volume rm homelab_test_data

# 4. Restore from backup
just restore --source local --name pre-test

# 5. Start services
just services --action start

# 6. Verify
just monitor --target health
```

## Backup Verification

### Check Backup Integrity

```bash
# Verify latest backup
just backup --action verify --source gdrive

# Check backup size and contents
just backup --action info --source gdrive --date 2026-01-10
```

### Data Integrity Check

```bash
# Run integrity check on databases
just test --target data-integrity

# Check file checksums
just backup --action checksum --source local
```

## Email Notifications

### Configure Email Alerts

```bash
# Setup email for backup notifications
just setup --target email

# Test email
just test --target email
```

### Alert Types

- **Backup Success**: Confirmation with backup size and duration
- **Backup Failure**: Error details and troubleshooting steps
- **Restore Started**: Notification when restore begins
- **Restore Complete**: Confirmation with restored data summary
- **Backup Warning**: Disk space low or backup size anomaly

## Backup Rotation

### Google Drive Retention
- Daily backups: Keep for 30 days
- Weekly backups: Keep for 90 days
- Monthly backups: Keep for 1 year

```bash
# Configure retention policy
just backup --target gdrive --action configure-retention
```

### Mega Retention
- Incremental backups: Keep for 14 days
- Full weekly: Keep for 30 days

### Local Retention
- Daily backups: Keep for 7 days
- Auto-cleanup enabled

## Bandwidth Optimization

### Compression

All backups are compressed:
- tar.gz for files
- pg_dump for PostgreSQL
- RDB snapshots for Redis

### Incremental Backups

Mega backups only upload changed files:
```bash
# Force full backup
just backup --target mega --full
```

## Backup Storage Estimates

### Typical Backup Sizes
- Configuration only: ~10 MB
- Databases: ~500 MB
- Application data: ~2 GB
- Full (with small media): ~50 GB
- Full (with large media): ~500+ GB

### Storage Requirements
- Google Drive: 100 GB recommended (free tier)
- Mega: 50 GB recommended (free tier)
- Local: 50 GB (7-day rotation)

## Troubleshooting

### Backup Fails

```bash
# Check disk space
df -h

# Check rclone configuration
rclone config

# View backup logs
just services --action logs --name rclone

# Retry with verbose output
just backup --target gdrive --verbose
```

### Restore Fails

```bash
# Check backup exists
just backup --target gdrive --action list

# Verify backup integrity
just backup --action verify --source gdrive --date 2026-01-10

# View restore logs
tail -f ~/homelab/logs/restore.log
```

### Email Notifications Not Working

```bash
# Test email configuration
just test --target email

# Check SMTP settings in .env
grep SMTP .env

# View email logs
just services --action logs --name notification
```

## Best Practices

1. **Test regularly**: Run monthly disaster recovery tests
2. **Multiple destinations**: Use both Google Drive and Mega
3. **Verify backups**: Check backup integrity weekly
4. **Monitor emails**: Ensure backup notifications are received
5. **Document custom data**: Keep list of custom configurations
6. **Separate media**: Consider separate backup strategy for large media files
7. **Encrypt sensitive data**: Use rclone encryption for sensitive backups
8. **Update regularly**: Keep backup scripts and rclone updated

## Advanced Topics

### Encrypted Backups

```bash
# Setup encrypted remote
rclone config

# Backup with encryption
just backup --target gdrive --encrypt
```

### Selective Restore

```bash
# Restore only configuration
just restore --source gdrive --config-only

# Restore specific paths
just restore --source gdrive --path /config/jellyfin
```

### Backup to NAS

```bash
# Configure NAS remote
just backup --target nas --action setup

# Backup to NAS
just backup --target nas
```

## Quick Reference

```bash
# Setup
just backup --target gdrive --action setup
just backup --target mega --action setup

# Backup
just backup --target gdrive
just backup --target mega
just backup --target local

# Restore
just restore --source gdrive --date latest
just restore --source mega --date 2026-01-10

# Verify
just backup --action verify --source gdrive
just test --target disaster-recovery

# List
just backup --target gdrive --action list
just backup --target local --action list
```
