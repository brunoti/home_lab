# Rclone

**Official Repository**: [rclone/rclone](https://github.com/rclone/rclone)  
**Category**: Cloud  
**Port**: 5572  
**Docker Image**: `rclone/rclone:latest`

## Overview

Rclone is a command-line program to manage files on cloud storage. It syncs files and directories to and from cloud storage providers like Google Drive, Amazon S3, Dropbox, and more.

## Key Features

- ☁️ **Multi-Cloud Support** - 40+ cloud storage providers
- 🔄 **Sync & Copy** - One-way and two-way sync
- 🔐 **Encryption** - Client-side encryption
- 📊 **Progress Tracking** - Monitor transfers
- ⚡ **Fast Transfers** - Parallel uploads/downloads
- 🌐 **Mount Support** - Mount cloud storage as filesystem
- 📝 **Bandwidth Control** - Rate limiting
- 🔍 **Deduplication** - Efficient file handling

## Getting Started

1. **Start the service**:
   ```bash
   just up rclone
   ```

2. **Access the web interface**: http://localhost:5572

3. **Initial Setup**:
   - Configure remote storage: `docker exec -it rclone rclone config`
   - Add cloud provider credentials
   - Test connection: `docker exec -it rclone rclone lsd <remote>:`
   - Set up sync schedules in cron or docker-compose
   - Configure encryption (optional)

## Ports

- **5572** - Web GUI (rclone serve http)

## Usage

Start this service:
```bash
just services --action start --name rclone
```

Stop this service:
```bash
just services --action stop --name rclone
```

View logs:
```bash
just services --action logs --name rclone
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/rclone/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
