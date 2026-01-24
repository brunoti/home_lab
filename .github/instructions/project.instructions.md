---
applyTo: '**'
---
# Home Lab AI Agent Instructions

**Project**: Self-hosted home lab infrastructure  
**Runtime**: OrbStack (Docker) on Mac mini M4  
**Architecture**: Modular service-based (32 independent services)

---

## Core Architecture

### Modular Service Structure

Each service lives in `services/<service-name>/` with its own `docker-compose.yml` and `README.md`. All services share:
- **External network**: `homelab` (must exist before starting services)
- **Centralized config**: Root `.env` file referenced via `env_file: ../../.env`
- **Relative paths**: Data volumes use `../../data/` and `../../config/` from service directories
- **PostgreSQL**: Shared database (`services/postgres/`) with per-service databases

**Why this matters**: Commands run from service directories, not root. Justfile handles directory navigation. Never manually `cd` into service dirs to run Docker commands—use `just` recipes.

### Service Categories (32 total)

```
Media (5)         → jellyfin, immich, speedtest-tracker, koel, navidrome
Books (5)         → calibre, calibre-web, audiobookshelf, lazylibrarian, booklore
Network (3)       → headscale, pihole, authelia
Monitoring (5)    → portainer, prometheus, grafana, loki, uptime-kuma
Proxy (2)         → nginx-proxy-manager, homepage
Databases (2)     → postgres, redis
Cloud (2)         → nextcloud, rclone
Development (2)   → filebrowser, mkdocs
Automation (3)    → radarr, sonarr, prowlarr
Download (1)      → transmission
Notes (1)         → affine
```

---

## Critical Workflows

### Starting Services

```bash
# Network setup (first time only)
docker network create homelab

# Start all services
just up

# Start specific service
just up jellyfin

# View status
just services --action status
```

**How it works**: Justfile iterates through `services/*/docker-compose.yml`, runs `docker compose --env-file ../../.env up -d` from each service directory. Network is validated/created automatically.

### Environment Configuration

**MANDATORY**: `.env` file must exist before starting services. Generated from `.env.example`:

```bash
cp .env.example .env
just password  # Auto-generates secure passwords for all services
```

**Pattern**: All services load environment via `env_file: ../../.env`. Variables follow `SERVICE_VARIABLE` naming (e.g., `JELLYFIN_UID`, `KOEL_DB_PASSWORD`). See [.env.example](.env.example#L1-L50) for full schema.

### Database Initialization

PostgreSQL service runs [scripts/init-databases.sql](scripts/init-databases.sql) on first start. Creates databases: `koel`, `speedtest`, `immich`, `affine`, `authelia`, `grafana`, `nextcloud`, `nginx_proxy`.

**When adding services**: If service needs PostgreSQL, add `CREATE DATABASE` block to init script using DO/IF NOT EXISTS pattern.

### Validation

```bash
./validate.sh  # 37 checks across structure, files, Docker config
```

Checks: file existence, directory structure, service definitions, volume paths, network configs. All checks must pass before committing changes.

---

## Project-Specific Patterns

### Justfile Command Structure

**Modern pattern** (post-restructure):
```bash
just <action> [arguments]
just up [service]           # Start all or specific service
just stop [service]         # Stop all or specific service  
just services --action list # List all services
just password               # Generate secure passwords
just backup --target gdrive # Backup to Google Drive
```

**Legacy commands removed**: Individual service commands (`just calibre-import`) consolidated into category-based flags (`just books --action import --service calibre`).

### Docker Compose Path Convention

All compose files use **relative paths from service directory**:

```yaml
# ✅ Correct (in services/jellyfin/docker-compose.yml)
volumes:
  - ../../data/jellyfin/config:/config
env_file:
  - ../../.env

# ❌ Wrong
volumes:
  - ./data/jellyfin/config:/config  # Missing ../../
```

**Why**: Compose is run from service subdirectory via Justfile's `cd "$service_dir" && docker compose ...` pattern.

### Service README Template

Each service README documents:
1. Purpose and functionality
2. Port and access URL  
3. Dependencies (PostgreSQL, Redis, etc.)
4. Volume mounts and data persistence
5. Configuration variables from .env
6. Service-specific commands

See [services/jellyfin/README.md](services/jellyfin/README.md) as reference template.

### Network Architecture

**Local network**: All services accessible without restrictions  
**External access**: VPN-only via Headscale  
**Reverse proxy**: Nginx Proxy Manager handles SSL/TLS  
**DNS**: Pi-hole for ad-blocking and local DNS

Services communicate via `homelab` Docker network. No host networking mode. All ports published explicitly.

---

## Common Pitfalls

### Environment File Missing
**Symptom**: Services fail to start with "env_file not found"  
**Fix**: `cp .env.example .env && just password`

### Network Not Created
**Symptom**: "network homelab not found"  
**Fix**: `docker network create homelab` (Justfile does this automatically)

### Volume Path Errors
**Symptom**: Empty volumes or permission errors  
**Cause**: Wrong relative path in docker-compose.yml  
**Fix**: Ensure `../../data/` and `../../config/` prefixes from service dirs

### Database Initialization Skipped
**Symptom**: Service reports "database does not exist"  
**Cause**: PostgreSQL already initialized, new database not added  
**Fix**: Add database to [init-databases.sql](scripts/init-databases.sql), restart PostgreSQL with `docker compose down -v` (WARNING: drops all data)

### Port Conflicts
**Symptom**: "port already allocated"  
**Fix**: Check `.env` for duplicate port assignments, verify no other apps using port

---

## Adding New Services

1. **Create service directory**: `services/new-service/`
2. **Create docker-compose.yml**:
   - Use relative paths: `../../data/new-service/`
   - Reference external network: `homelab`
   - Add env_file: `../../.env`
3. **Update .env.example**: Add service-specific variables
4. **Create README.md**: Follow template pattern
5. **Update documentation**: Add to service list in docs
6. **If needs PostgreSQL**: Update `scripts/init-databases.sql`
7. **Validate**: Run `./validate.sh`

**Example**: See [services/jellyfin/](services/jellyfin/) as minimal template.

---

## Documentation Structure

- **Getting Started**: [quick-start.md](docs/getting-started/quick-start.md), [installation.md](docs/getting-started/installation.md)
- **Architecture**: [modular-services.md](docs/architecture/modular-services.md)  
- **Services**: Category-specific docs in [docs/services/](docs/services/)
- **Operations**: [backup-restore.md](docs/operations/backup-restore.md), [troubleshooting.md](docs/operations/troubleshooting.md)
- **Live docs**: `just docs --action serve` (MkDocs on port 8001)

**Update docs**: When changing architecture or adding services, update both Markdown files and MkDocs nav in [mkdocs.yml](mkdocs.yml).

---

## Resource Constraints

**Hardware**: Mac mini M4, 16GB RAM, 256GB SSD  
**OrbStack**: Dynamic allocation (~8GB typical container usage)  
**Storage**: Monitor disk usage—limited to ~100GB for container data

**Before scaling**: Check available resources. Services like Jellyfin (2GB) and PostgreSQL (1.5GB) are memory-heavy. See [PROJECT_PLAN.md](PROJECT_PLAN.md#L107-L119) for allocation breakdown.

---

## Key Files Reference

- [justfile](justfile) - All automation commands  
- [.env.example](.env.example) - Environment variable schema  
- [validate.sh](validate.sh) - Repository validation  
- [scripts/init-databases.sql](scripts/init-databases.sql) - Database initialization  
- [PROJECT_PLAN.md](PROJECT_PLAN.md) - Complete project overview  
- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) - Feature implementation history  
- [RESTRUCTURE_SUMMARY.md](RESTRUCTURE_SUMMARY.md) - Modular architecture migration

---

## Quick Decision Tree

**Modifying service?** → Edit `services/<name>/docker-compose.yml`  
**Adding environment variable?** → Update `.env` and `.env.example`  
**Service won't start?** → Check `.env` exists, network exists, volume paths correct  
**Need new database?** → Update `scripts/init-databases.sql`  
**Testing changes?** → Run `./validate.sh` before committing  
**Documentation?** → Update both `docs/*.md` and `mkdocs.yml`
