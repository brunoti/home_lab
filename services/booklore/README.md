# BookLore

Category: Books

## Service Information

BookLore is a powerful, self-hosted web application designed to organize and manage your personal book collection with elegance and ease. Build your dream library with an intuitive interface, robust metadata management, and seamless multi-user support.

**Official Website**: [https://booklore.org](https://booklore.org)  
**GitHub**: [https://github.com/booklore-app/booklore](https://github.com/booklore-app/booklore)

## Features

### 📖 Library Management
- **Smart Organization**: Custom shelves with powerful filters
- **Magic Shelves**: Dynamic, auto-updating collections
- **Auto Metadata**: Rich details from multiple sources
- **Advanced Search**: Find any book instantly

### 🌐 Connectivity
- **Kobo Integration**: Seamless device sync
- **OPDS Support**: Connect any reading app
- **KOReader Sync**: Cross-platform progress tracking
- **Email Sharing**: One-click book sending

### 👥 User Experience
- **Multi-User Support**: Granular permissions
- **Flexible Auth**: Local or OIDC providers
- **Mobile Ready**: Responsive on all devices
- **Built-in Reader**: PDFs, EPUBs, comics

### 🚀 Smart Features
- **BookDrop Import**: Auto-detect bulk files
- **Private Notes**: Personal reading annotations
- **Community Reviews**: Enriched book data
- **Progress Tracking**: Reading statistics

## Usage

Start this service:
```bash
just services --action start --name booklore
```

Stop this service:
```bash
just services --action stop --name booklore
```

View logs:
```bash
just services --action logs --name booklore
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs in `/data/booklore/`

## Ports

- **6060**: BookLore web interface (default, configurable via BOOKLORE_PORT)

## Dependencies

This service requires:
- **mariadb**: MariaDB database for storing BookLore data

Check `depends_on` in `docker-compose.yml` for service dependencies.

## Environment Variables

Required environment variables in `.env`:
- `DB_PASSWORD`: Password for the MariaDB database user
- `MYSQL_DATABASE`: Database name (default: booklore)
- `DB_USER`: Database username (default: booklore)
- `BOOKLORE_PORT`: Port for BookLore web interface (default: 6060)
- `APP_USER_ID`: User ID for file permissions (default: 0)
- `APP_GROUP_ID`: Group ID for file permissions (default: 0)
- `TZ`: Timezone (default: UTC)

## Initial Setup

1. Ensure MariaDB service is running:
   ```bash
   just services --action start --name mariadb
   ```

2. Start BookLore:
   ```bash
   just services --action start --name booklore
   ```

3. Access BookLore at http://localhost:6060

4. Create your admin account on first login

## BookDrop: Automatic Import

BookLore includes a **BookDrop** feature for automatic book import:
- Place book files (EPUB, PDF, etc.) in the `data/booklore/bookdrop` directory
- BookLore automatically detects and imports them
- Files are processed and moved to the library

## Data Directories

- `data/booklore/data`: Application data and configuration
- `data/booklore/books`: Organized book library
- `data/booklore/bookdrop`: Drop folder for automatic import

## Demo

Try the official demo:
- **URL**: https://demo.booklore.org
- **Username**: booklore
- **Password**: 9HC20PGGfitvWaZ1

## Documentation

For more details, visit the official documentation:
- [Getting Started](https://booklore.org/docs/getting-started)
- [Features Guide](https://booklore.org/docs)
