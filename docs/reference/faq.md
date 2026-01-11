# Frequently Asked Questions

Common questions and answers about the home lab setup.

## General

### What hardware do I need?

**Minimum:**
- Mac mini M4 (or compatible ARM device)
- 16GB RAM
- 256GB SSD
- Gigabit Ethernet

**Recommended:**
- 32GB RAM for heavy usage
- 512GB+ SSD
- External storage for media

### Can I run this on non-Mac hardware?

Yes, but you'll need to adjust:
- Use Docker Desktop, Colima, or native Docker instead of OrbStack
- May need to adjust image architectures (ARM vs x86)
- Resource allocation settings will differ

### How much storage do I need?

Depends on your media library:
- **System + Docker**: ~80GB
- **Small library**: 256GB total sufficient
- **Medium library**: 512GB+ recommended
- **Large library**: 1TB+ or external storage

### Can I run fewer than 30 services?

Absolutely! Edit `docker-compose.yml` and comment out services you don't need:

```yaml
# jellyfin:
#   image: jellyfin/jellyfin:latest
#   ...
```

## Setup & Installation

### Do I need to install Docker Desktop?

No, we use OrbStack which is faster, more efficient, and has a better macOS integration. But Docker Desktop also works if you prefer it.

### Why OrbStack instead of Docker Desktop?

- Fast and lightweight
- Optimized for Apple Silicon (M1/M2/M3/M4)
- Dynamic resource allocation
- Better battery life
- Native macOS integration
- Automatic file sharing with VirtioFS
- Free for personal use

### The installation fails, what should I do?

1. Check logs: `just services --action logs --name service-name`
2. Verify .env: `just setup --target config`
3. Check disk space: `df -h`
4. See [Troubleshooting Guide](../operations/troubleshooting.md)

### How long does initial setup take?

- **Downloads**: 10-15 minutes (depends on internet speed)
- **First start**: 3-5 minutes (all services to initialize)
- **Configuration**: 30-60 minutes (setting up each service)

## Services

### Can I change service ports?

Yes, edit `docker-compose.yml`:

```yaml
ports:
  - "9999:8096"  # Change 9999 to your preferred port
```

### How do I disable a service I don't use?

Comment it out in `docker-compose.yml` or:

```bash
just services --action stop --name service-name
```

### Which services are essential?

Core services:
- postgres (database)
- redis (cache)
- portainer (management)
- homepage (dashboard)

All others are optional based on your needs.

### Can I add more services?

Yes! Add them to `docker-compose.yml`:

```yaml
  myservice:
    image: user/myservice:latest
    container_name: myservice
    restart: unless-stopped
    ports:
      - "PORT:PORT"
    networks:
      - homelab
```

## Performance

### How much RAM do the services actually use?

Typical usage:
- **Jellyfin**: 1-2GB (+ transcoding spikes)
- **PostgreSQL**: 500MB-1GB
- **Monitoring stack**: 500MB-1GB
- **Other services**: 100-200MB each
- **Total**: 6-8GB average, 10GB+ with heavy use

### My Mac is running hot, is this normal?

Some heat is normal, but excessive heat means:
- Too many transcoding streams
- Background scanning (media/books)
- Check CPU: `just monitor --target cpu`

### Can I run this 24/7?

Yes! The setup is designed for continuous operation. Recommendations:
- OrbStack starts automatically on boot
- Setup monitoring alerts
- Schedule maintenance weekly
- Monitor temperatures

### How many Jellyfin streams can I handle?

On M4 with 16GB:
- **Direct play**: 5-10 streams easily
- **1080p transcode**: 2-3 concurrent
- **4K transcode**: 1-2 concurrent
- Limit depends on content and settings

## Backups

### How often should I backup?

Recommended schedule:
- **Google Drive**: Daily full backup
- **Mega**: 2x daily incremental
- **Local**: Before major changes

### What gets backed up?

- Configuration files
- Service data
- Database dumps
- Custom settings

**Not included** (optional):
- Media files (due to size)
- Temporary files
- Logs

### How do I restore from backup?

```bash
just restore --source gdrive --date latest
```

See [Backup & Restore Guide](../operations/backup-restore.md) for details.

### Can I backup to NAS instead of cloud?

Yes! Configure rclone for your NAS:

```bash
rclone config create nas sftp
just backup --target nas
```

## Network & Access

### How do I access services remotely?

Use Headscale VPN (included):
1. Setup Headscale
2. Install Tailscale client on devices
3. Connect to your home lab network
4. Access services via VPN

**Never** expose services directly to internet!

### Can I use a custom domain?

Yes! Use Nginx Proxy Manager:
1. Configure domain DNS
2. Setup reverse proxy in NPM
3. Add SSL certificates
4. Configure service access

### How do I setup HTTPS?

Nginx Proxy Manager handles this:
1. Add proxy host in NPM
2. Select "Force SSL"
3. Use Let's Encrypt for free certificates
4. Configure renewal

### Why can't I access a service?

Check:
1. Service running: `just services --action status`
2. Port correct: `just network --action ports`
3. No firewall blocking
4. Docker running: `docker info`

## Troubleshooting

### A service keeps crashing

1. Check logs: `just services --action logs --name service-name --follow`
2. Check RAM: `just monitor --target ram`
3. Verify config: `just setup --target config`
4. Try force restart: `just services --action restart --name service-name --force`

### Database connection errors

1. Verify postgres running: `docker compose ps postgres`
2. Check password: `grep POSTGRES_PASSWORD .env`
3. Test connection: `docker compose exec postgres psql -U postgres`
4. Restart: `just services --action restart --name postgres`

### Out of disk space

```bash
# Clean Docker resources
just maintain --target docker

# Clean logs
just maintain --target logs

# Clean old backups
just backup --target local --action clean
```

### High RAM usage

```bash
# Check usage
just monitor --target ram

# Stop non-essential services
just services --action stop --name service-name

# OrbStack manages memory dynamically
# Check overall system resources
vm_stat
```

## Updates & Maintenance

### How do I update services?

```bash
# Pull latest images
docker compose pull

# Recreate containers
just services --action restart

# Or use maintain command
just maintain --target update
```

### How often should I update?

Recommended:
- **Security updates**: As needed
- **Major updates**: Monthly
- **Check for updates**: Weekly

### Will updates break anything?

Unlikely, but:
- Always backup before major updates
- Check release notes
- Test in staging if possible
- Keep backups recent

### How do I rollback an update?

```bash
# Stop services
just services --action stop

# Restore backup
just restore --source local --date YYYY-MM-DD

# Start services
just services --action start
```

## Security

### Is this setup secure?

Yes, when configured properly:
- No direct internet exposure
- VPN-only external access
- Authelia for authentication
- Regular updates
- Encrypted backups

### Do I need antivirus?

macOS built-in security is generally sufficient. Best practices:
- Keep macOS updated
- Use strong passwords
- Enable FileVault
- Regular backups

### How do I secure sensitive services?

1. Configure Authelia
2. Use strong passwords
3. Enable 2FA where available
4. VPN-only access
5. Regular security audits

### What about password management?

Recommended approach:
- Store in secure password manager (external)
- Never commit passwords to git
- Use .env for configuration
- Rotate passwords quarterly

## Customization

### Can I change the dashboard?

Yes! Homepage is customizable:
- Edit `config/homepage/services.yaml`
- Add custom widgets
- Change theme
- See Homepage documentation

### Can I add custom monitoring?

Yes! Add to Prometheus config:
- Edit `config/prometheus/prometheus.yml`
- Add scrape targets
- Create Grafana dashboards
- Configure alerts

### How do I customize service configs?

1. Edit service config files in `config/` directory
2. Or use `docker-compose.override.yml` for local changes
3. Restart service to apply changes

## Migration

### Can I migrate from existing setup?

Yes! Steps:
1. Backup existing data
2. Copy data to new structure
3. Update paths in .env
4. Import to services
5. Verify everything works

### How do I migrate between machines?

1. Backup on old machine: `just backup --target gdrive`
2. Setup new machine with this repo
3. Restore: `just restore --source gdrive --date latest`
4. Verify and test

## Support

### Where can I get help?

1. Check documentation: http://localhost:8001
2. Review [Troubleshooting Guide](../operations/troubleshooting.md)
3. Search GitHub Issues
4. Open new issue with details

### How do I report a bug?

1. Check if already reported
2. Collect diagnostics:
   ```bash
   just monitor --target health > issue.txt
   docker compose ps >> issue.txt
   ```
3. Open GitHub issue with details

### Can I contribute?

Yes! Contributions welcome:
1. Fork repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

## Best Practices

### What's the recommended workflow?

Daily:
- Check dashboard for alerts
- Monitor resource usage

Weekly:
- Review logs
- Check for updates
- Verify backups

Monthly:
- Run disaster recovery test
- Update services
- Clean old data
- Review security

### Should I use production or latest tags?

Depends:
- **latest**: Most recent features, more updates
- **stable/version**: More stable, less frequent updates
- **Recommendation**: Use stable for critical services

### How do I organize media files?

Recommended structure:
```
/media/
├── movies/
│   └── Movie Name (Year)/
│       └── movie.mkv
├── tv/
│   └── Show Name/
│       └── Season 01/
│           └── episode.mkv
├── music/
│   └── Artist/
│       └── Album/
│           └── track.mp3
└── books/
    └── Author/
        └── book.epub
```

### Any other tips?

- Start small, add services gradually
- Test backups regularly
- Monitor resource usage
- Document custom changes
- Keep .env secure
- Join home lab communities
- Share your setup and learn from others
