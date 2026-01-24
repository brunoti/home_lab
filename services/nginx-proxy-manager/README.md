# Nginx Proxy Manager

**Category**: Proxy  
**Repository**: https://github.com/NginxProxyManager/nginx-proxy-manager  
**Access**:
- **Admin UI**: http://localhost:81
- **Proxy UI**: https://nginx.bop.lat (after setup)

Reverse proxy manager with SSL/TLS certificate management and user-friendly web UI.

## Usage

Start this service:
```bash
just up nginx-proxy-manager
```

Stop this service:
```bash
just stop nginx-proxy-manager
```

## Initial Setup

### 1. First Login

Access the admin UI at http://localhost:81

**Default credentials:**
- **Email**: `admin@example.com`
- **Password**: `changeme`

**IMPORTANT**: Change credentials immediately after first login.

### 2. DNS Configuration

Configure DNS records on your router or Pi-hole to point `*.bop.lat` to your Mac mini's IP address:

```
jellyfin.bop.lat    → <Mac mini IP>
nginx.bop.lat       → <Mac mini IP>
booklore.bop.lat    → <Mac mini IP>  (future)
```

Example Pi-hole configuration:
- Go to **Local DNS** → **DNS Records**
- Add each subdomain pointing to your Mac mini's local IP (e.g., `192.168.1.100`)

### 3. Create Proxy Hosts

For each service (e.g., Jellyfin):

1. **Hosts** → **Proxy Hosts** → **Add Proxy Host**
2. **Details** tab:
   - **Domain Names**: `jellyfin.bop.lat`
   - **Scheme**: `http`
   - **Forward Hostname/IP**: `jellyfin` (use Docker service name from docker-compose.yml)
   - **Forward Port**: `8096` (service's internal port)
   - **Block Common Exploits**: ✓ Enable
   - **Websockets Support**: ✓ Enable (required for Jellyfin)
3. **SSL** tab (optional for LAN-only):
   - For local network only: Leave SSL disabled or use self-signed certificate
   - For external access: Request Let's Encrypt certificate
4. **Save**

Repeat for other services:
- **Nginx UI itself**: `nginx.bop.lat` → `nginx-proxy-manager:81`
- **Booklore** (when ready): `booklore.bop.lat` → `booklore:PORT`

### 4. Test Access

```bash
# Test proxy configuration
curl -I http://jellyfin.bop.lat

# Test Nginx UI proxy
curl -I http://nginx.bop.lat
```

Open browser and navigate to `http://jellyfin.bop.lat` (should load Jellyfin web interface).

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Data and certificates stored in `../../data/nginx-proxy-manager/`

## Network Access

### Ports Published to Host
- **80**: HTTP traffic (proxy to services)
- **81**: Admin UI (manage proxy hosts, SSL certificates)
- **443**: HTTPS traffic (SSL/TLS termination)

### Local Network Only
**IMPORTANT**: Do not forward ports 80/443 on your router to keep services local-only.

- Services accessible only on LAN via `*.bop.lat` domains
- For remote access, use Headscale VPN (see headscale service)

### Docker Service Communication
Nginx Proxy Manager connects to other services via the shared `homelab` network using Docker service names (e.g., `jellyfin`, `booklore`).

## Security Best Practices

1. **Change default credentials immediately**
2. **Enable "Block Common Exploits"** for all proxy hosts
3. **Use strong passwords** for admin accounts
4. **Keep local-only**: No port forwarding on router unless using VPN
5. **Regular updates**: Update NPM image via `docker compose pull`

## SSL/TLS Certificates

### For Local Network (Recommended)
- No SSL needed (use `http://`)
- OR use self-signed certificate (browser warnings expected)

### For External Access (via VPN)
- Request Let's Encrypt certificate in NPM UI
- Requires domain ownership verification
- Certificates auto-renew

## Dependencies

This service requires:
- `postgres` service (database: `nginx_proxy`)
- `homelab` Docker network (auto-created by justfile)
- Volume paths: `../../data/nginx-proxy-manager/data`, `../../data/nginx-proxy-manager/letsencrypt`

## Troubleshooting

### Proxy host not working
- Check service name matches docker-compose.yml
- Verify service is running: `docker ps | grep <service>`
- Check Docker network: `docker network inspect homelab`
- Review NPM logs: `docker logs nginx-proxy-manager`

### SSL certificate issues
- For local-only, disable SSL
- For external, ensure domain DNS points to your public IP
- Check Let's Encrypt rate limits

### Cannot access admin UI
- Verify port 81 is not in use: `lsof -i :81`
- Check container logs: `docker logs nginx-proxy-manager`
- Ensure PostgreSQL is running
