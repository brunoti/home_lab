# Jellyfin

**Category**: Media  
**Repository**: https://github.com/jellyfin/jellyfin  
**Access**: 
- **Direct**: http://localhost:8096
- **Proxy**: https://jellyfin.bop.lat (via Nginx Proxy Manager)

Free media server for movies, TV shows, music, and photos.

## Usage

Start this service:
```bash
just up jellyfin
```

Stop this service:
```bash
just stop jellyfin
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs in `../../data/jellyfin/config/`

## Network Access

### Local Network (Direct)
- **URL**: http://localhost:8096
- **Network**: `homelab` Docker bridge
- **Port**: 8096 published to host

### Domain Access (via Nginx Proxy Manager)
To access Jellyfin at `jellyfin.bop.lat`:

1. **DNS Configuration** (on your router or Pi-hole):
   - Add A record: `jellyfin.bop.lat` → `<Mac mini IP>`
   - Add A record: `nginx.bop.lat` → `<Mac mini IP>`

2. **Nginx Proxy Manager Setup**:
   - Access NPM UI: http://localhost:81
   - Login with default credentials (change immediately):
     - Email: `admin@example.com`
     - Password: `changeme`
   - Go to **Hosts** → **Proxy Hosts** → **Add Proxy Host**
   - Configure:
     - **Domain Names**: `jellyfin.bop.lat`
     - **Scheme**: `http`
     - **Forward Hostname/IP**: `jellyfin` (Docker service name)
     - **Forward Port**: `8096`
     - **Block Common Exploits**: ✓
     - **Websockets Support**: ✓
   - (Optional) **SSL** tab:
     - Request Let's Encrypt certificate if exposing externally
     - For LAN-only: leave SSL disabled or use self-signed

3. **Test Access**:
   ```bash
   curl -I http://jellyfin.bop.lat
   ```

### Security Notes
- **LAN-only**: Do not forward ports 80/443 on your router
- **VPN Access**: Use Headscale for remote access (see headscale service)
- Keep access local to home network only

## Ports

- **8096**: HTTP web interface (published to host)

## Dependencies

This service requires:
- `homelab` Docker network (auto-created by justfile)
- Volume paths: `../../data/jellyfin/config`, `../../data/jellyfin/cache`, `../../data/jellyfin/media`

## Volumes

- **Config**: `../../data/jellyfin/config` - Jellyfin configuration
- **Cache**: `../../data/jellyfin/cache` - Transcoding cache
- **Media**: `../../data/jellyfin/media` - Media library (movies, TV, music, photos)
