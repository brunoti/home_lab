# Booklore

**Category**: Books  
**Repository**: https://github.com/booklore-app/booklore  
**Website**: https://booklore.org

Modern, open-source library management system for organizing, reading, and managing your digital book collection. Provides automatic metadata fetching, OPDS support, built-in reader, multi-user support, and Kobo/KOReader sync.

## Features

- **Smart Organization**: Shelves, filters, magic shelves, and fast search
- **Automatic Metadata**: Fetch book details, covers, and reviews automatically
- **OPDS Support**: Connect reading apps for wireless downloads
- **Built-in Reader**: Read EPUBs, PDFs, and comics in browser with sync
- **Multi-User**: Share library with granular permissions
- **Kobo/KOReader Sync**: Sync reading progress and highlights
- **Bookdrop**: Automatic import by dropping files into folder

## Usage

Start this service:
```bash
just up booklore
```

Stop this service:
```bash
just stop booklore
```

Access the web interface:
```
http://localhost:6060
```

Or via domain (if configured):
```
http://booklore.bop.lat
```

## First-Time Setup

1. **Access Interface**: Open http://localhost:6060
2. **Create Admin Account**: Complete setup wizard
   - Create administrator username and password
   - Set email address
   - Configure timezone
3. **Create Library**: Settings → Libraries → Add Library
   - Name: "My Library"
   - Path: `/books`
   - Enable scanning
4. **Add Books**:
   - Direct copy: Copy books to `data/booklore/books/`
   - Bookdrop: Drop files into `data/booklore/bookdrop/` (auto-import)
   - Web upload: Use upload button in UI
5. **Enable Metadata**: Settings → Metadata → Add Google Books API key (optional)

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Application data stored in `data/booklore/data/`

### Database

Booklore uses its own MariaDB container (`booklore-mariadb`) for data storage. The database is automatically initialized on first start.

### Volume Mounts

- `data/booklore/data` - Application data, cache, and logs
- `data/booklore/books` - Main library storage
- `data/booklore/bookdrop` - Automatic import folder
- `data/booklore/mariadb` - MariaDB database files

## Ports

- **6060**: Web interface (configurable via `BOOKLORE_PORT`)

## Dependencies

- **booklore-mariadb**: Internal MariaDB database container
- **homelab network**: External Docker network (must exist)

## Environment Variables

Key variables from `.env`:

```bash
BOOKLORE_UID=1000              # User ID for file permissions
BOOKLORE_GID=1000              # Group ID for file permissions
BOOKLORE_PORT=6060             # Web interface port
BOOKLORE_DATABASE_URL          # MariaDB connection URL
BOOKLORE_DB_USER               # Database username
BOOKLORE_DB_PASSWORD           # Database password
BOOKLORE_MYSQL_ROOT_PASSWORD   # MariaDB root password
BOOKLORE_MYSQL_DATABASE        # Database name
BOOKLORE_DB_UID=1000          # MariaDB container user ID
BOOKLORE_DB_GID=1000          # MariaDB container group ID
```

## Integration with Other Services

### Calibre
Booklore can import books from Calibre library directories. Point Booklore library to Calibre's book storage.

### Transmission/Download Clients
Use Bookdrop to automatically import downloaded books from download client watch folders.

### Nginx Proxy Manager
Configure reverse proxy for external access:
- Domain: booklore.bop.lat
- Forward to: booklore:6060
- Enable SSL/TLS

## Backup

Critical directories to backup:
- `data/booklore/mariadb` - Database (all metadata)
- `data/booklore/books` - Book files
- `data/booklore/data` - Application settings

## Troubleshooting

### Container Won't Start
Check logs:
```bash
docker compose -f services/booklore/docker-compose.yml logs booklore
docker compose -f services/booklore/docker-compose.yml logs booklore-mariadb
```

Common issues:
- Port 6060 already in use
- Database password mismatch
- Insufficient permissions on mounted directories

### Database Connection Errors
Verify MariaDB is healthy:
```bash
docker compose -f services/booklore/docker-compose.yml ps booklore-mariadb
```

Ensure credentials match:
- `DATABASE_PASSWORD` must match `MYSQL_PASSWORD`
- `DATABASE_USERNAME` must match `MYSQL_USER`

### Permission Errors
Fix directory permissions:
```bash
sudo chown -R 1000:1000 data/booklore
```

Update `BOOKLORE_UID` and `BOOKLORE_GID` in `.env` to match your user.

## Resources

- [Documentation](https://booklore.org/docs/getting-started)
- [GitHub Repository](https://github.com/booklore-app/booklore)
- [Docker Hub](https://hub.docker.com/r/booklore/booklore-app)
- [Community Discord](https://discord.gg/Ee5hd458Uz)
