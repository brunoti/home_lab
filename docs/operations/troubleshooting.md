# Troubleshooting Guide

Common issues and their solutions for the home lab setup.

## Service Issues

### Service Won't Start

**Symptoms:**
- Service shows as "Exited" in `docker-compose ps`
- Service restarts repeatedly
- Error in logs

**Solutions:**

1. Check service logs:
```bash
just services --action logs --name service-name --follow
```

2. Verify configuration:
```bash
just setup --target config
```

3. Check dependencies:
```bash
# Ensure databases are running
docker-compose ps postgres redis
```

4. Restart with force:
```bash
just services --action restart --name service-name --force
```

5. Check for port conflicts:
```bash
lsof -i :PORT_NUMBER
```

### All Services Won't Start

**Symptoms:**
- Multiple services fail to start
- Docker errors

**Solutions:**

1. Check Colima status:
```bash
colima status
```

2. Restart Colima if needed:
```bash
colima stop
colima start --cpu 8 --memory 8 --disk 100
```

3. Check Docker:
```bash
docker ps
docker info
```

4. Verify .env file:
```bash
just setup --target config
```

### Service Crashes After Starting

**Symptoms:**
- Service starts but crashes within minutes
- Out of memory errors in logs

**Solutions:**

1. Check RAM usage:
```bash
just monitor --target ram
```

2. Check resource allocation:
```bash
docker stats
```

3. Reduce concurrent services:
```bash
# Stop non-essential services
just services --action stop --name service-name
```

4. Increase Colima memory:
```bash
colima stop
colima start --cpu 8 --memory 12 --disk 100
```

## Performance Issues

### High RAM Usage

**Symptoms:**
- System becomes slow
- Services become unresponsive
- macOS memory pressure high

**Solutions:**

1. Check RAM usage:
```bash
just monitor --target ram
just monitor --target resources
```

2. Identify memory hogs:
```bash
docker stats --format "table {{.Name}}\t{{.MemUsage}}\t{{.MemPerc}}" | sort -k3 -rh
```

3. Restart heavy services:
```bash
just services --action restart --name jellyfin
just services --action restart --name postgres
```

4. Clean Docker resources:
```bash
just maintain --target docker
```

5. Reduce Jellyfin transcoding:
- Limit concurrent streams
- Use direct play when possible
- Reduce transcoding quality

### High CPU Usage

**Symptoms:**
- Mac becomes hot
- Fan running at high speed
- Services slow to respond

**Solutions:**

1. Check CPU usage:
```bash
just monitor --target cpu
```

2. Identify CPU-intensive processes:
```bash
docker stats --format "table {{.Name}}\t{{.CPUPerc}}" | sort -k2 -rh
```

3. Common causes:
- Jellyfin transcoding (limit streams)
- Lazylibrarian scanning (schedule during off-hours)
- Prometheus scraping (reduce frequency)
- Media scanning (pause or schedule)

### Disk Space Issues

**Symptoms:**
- "No space left on device" errors
- Services can't write logs
- Backups fail

**Solutions:**

1. Check disk usage:
```bash
just monitor --target disk
docker system df
```

2. Clean Docker resources:
```bash
docker system prune -a
docker volume prune
```

3. Clean old logs:
```bash
just maintain --target logs
```

4. Clean old backups:
```bash
just backup --target local --action clean
```

5. Remove old Docker images:
```bash
docker image prune -a
```

## Network Issues

### Can't Access Services

**Symptoms:**
- Services unreachable in browser
- Connection refused errors

**Solutions:**

1. Check service status:
```bash
just services --action status
```

2. Verify port mappings:
```bash
just network --action ports
docker-compose ps
```

3. Test network connectivity:
```bash
just network --action check
```

4. Check firewall:
```bash
# Verify no firewall blocking
sudo pfctl -s all | grep -i block
```

5. Restart networking:
```bash
just services --action restart
```

### Intermittent Connectivity

**Symptoms:**
- Services sometimes unreachable
- Timeouts
- Connection drops

**Solutions:**

1. Check Docker network:
```bash
docker network ls
docker network inspect homelab
```

2. Restart Docker networking:
```bash
just services --action stop
docker network prune
just services --action start
```

3. Check for conflicts:
```bash
# Check for IP conflicts
arp -a | grep -i dup
```

### VPN Issues (Headscale)

**Symptoms:**
- Can't connect to VPN
- VPN connected but can't access services

**Solutions:**

1. Check Headscale status:
```bash
just network --action test-vpn
docker-compose logs headscale
```

2. Regenerate keys:
```bash
docker-compose exec headscale headscale preauthkeys create --expiration 24h
```

3. Check routes:
```bash
docker-compose exec headscale headscale routes list
```

## Database Issues

### PostgreSQL Won't Start

**Symptoms:**
- PostgreSQL container exiting
- "database system is shut down" in logs

**Solutions:**

1. Check logs:
```bash
just services --action logs --name postgres
```

2. Verify password set:
```bash
grep POSTGRES_PASSWORD .env
```

3. Check data directory permissions:
```bash
ls -la ~/homelab/data/postgres
```

4. Reset database (WARNING: data loss):
```bash
docker-compose down
docker volume rm homelab_postgres_data
just services --action start --name postgres
```

### Database Connection Errors

**Symptoms:**
- Services can't connect to database
- "connection refused" errors

**Solutions:**

1. Verify database is running:
```bash
docker-compose ps postgres
```

2. Test connection:
```bash
docker-compose exec postgres psql -U postgres -c "SELECT 1;"
```

3. Check connection strings:
```bash
grep DB_HOST .env
```

4. Restart database:
```bash
just services --action restart --name postgres
```

## Backup & Restore Issues

### Backup Fails

**Symptoms:**
- Backup command fails
- "permission denied" errors
- Upload timeout

**Solutions:**

1. Check disk space:
```bash
df -h
```

2. Verify rclone configuration:
```bash
rclone config show
```

3. Test rclone connection:
```bash
rclone lsd gdrive:
```

4. Check logs:
```bash
tail -f ~/homelab/logs/backup.log
```

5. Retry with verbose output:
```bash
just backup --target gdrive --verbose
```

### Restore Fails

**Symptoms:**
- Restore command fails
- Data not restored
- Service errors after restore

**Solutions:**

1. Verify backup exists:
```bash
just backup --target gdrive --action list
```

2. Check backup integrity:
```bash
just backup --action verify --source gdrive
```

3. Restore to temporary location first:
```bash
mkdir /tmp/restore-test
# Extract backup there first
```

4. Check permissions after restore:
```bash
sudo chown -R 1000:1000 ~/homelab/data
```

## Email Notification Issues

### Emails Not Sending

**Symptoms:**
- No backup notifications
- Alert emails not received

**Solutions:**

1. Test email configuration:
```bash
just test --target email
```

2. Verify SMTP settings:
```bash
grep SMTP .env
```

3. Check for Gmail app password:
- Must use app password, not regular password
- Ensure 2FA enabled
- Generate new app password if needed

4. Test with curl:
```bash
curl --url 'smtp://smtp.gmail.com:587' \
     --ssl-reqd \
     --mail-from 'your-email@gmail.com' \
     --mail-rcpt 'your-email@gmail.com' \
     --user 'your-email@gmail.com:app-password'
```

## Jellyfin Issues

### Transcoding Not Working

**Symptoms:**
- Videos won't play
- Buffering issues
- "Playback Error" messages

**Solutions:**

1. Enable hardware acceleration:
- Dashboard → Playback → Hardware acceleration
- Select "Video Toolbox" for M4 Mac

2. Check transcoding logs:
```bash
just services --action logs --name jellyfin | grep -i transcode
```

3. Verify ffmpeg:
```bash
docker-compose exec jellyfin ffmpeg -version
```

4. Reduce transcoding quality:
- Dashboard → Playback → Streaming
- Lower max bitrate

### Library Scan Issues

**Symptoms:**
- New media not appearing
- Scan takes very long
- Scan fails

**Solutions:**

1. Check permissions:
```bash
ls -la /path/to/media
```

2. Manual scan:
- Dashboard → Libraries → Scan All Libraries

3. Check logs:
```bash
just services --action logs --name jellyfin | grep -i scan
```

4. Restart Jellyfin:
```bash
just services --action restart --name jellyfin
```

## Common Error Messages

### "bind: address already in use"

**Cause:** Port already in use by another service

**Solution:**
```bash
# Find what's using the port
lsof -i :PORT

# Change port in docker-compose.yml or stop other service
```

### "no space left on device"

**Cause:** Disk full

**Solution:**
```bash
just maintain --target docker
just maintain --target logs
just backup --target local --action clean
```

### "Cannot connect to the Docker daemon"

**Cause:** Docker not running

**Solution:**
```bash
colima status
colima start --cpu 8 --memory 8 --disk 100
```

### "permission denied"

**Cause:** File permission issues

**Solution:**
```bash
# Fix ownership
sudo chown -R 1000:1000 ~/homelab/data

# Check .env permissions
chmod 600 .env
```

## Getting Help

If issues persist:

1. **Check logs:**
```bash
just services --action logs --name service-name --follow
```

2. **Check health:**
```bash
just monitor --target health --detailed
```

3. **Collect diagnostics:**
```bash
just monitor --target resources > diagnostics.txt
docker-compose ps >> diagnostics.txt
docker-compose logs >> diagnostics.txt
```

4. **Search documentation:**
- Review [Service Documentation](../services/)
- Check [Command Reference](../reference/commands.md)

5. **Community support:**
- GitHub Issues: [github.com/brunoti/home_lab/issues](https://github.com/brunoti/home_lab/issues)
- Include diagnostics output
- Describe what you've tried

## Prevention

### Regular Maintenance

```bash
# Weekly
just monitor --target health
just maintain --target logs

# Monthly
just maintain --target system
just test --target disaster-recovery
just maintain --target update
```

### Monitoring

Set up alerts for:
- RAM > 80%
- Disk < 20GB
- Service downtime
- Backup failures

```bash
just setup --target alerts
```

### Best Practices

1. **Keep backups current**
```bash
just backup --target gdrive
```

2. **Monitor resources**
```bash
just monitor --target resources
```

3. **Update regularly**
```bash
just maintain --target update
```

4. **Test recovery**
```bash
just test --target disaster-recovery
```

5. **Review logs**
```bash
just services --action logs --name service-name
```
