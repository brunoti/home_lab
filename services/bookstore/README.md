# BookStack

**Official Repository**: [BookStackApp/BookStack](https://github.com/BookStackApp/BookStack)  
**Category**: Books  
**Port**: 3002  
**Docker Image**: `linuxserver/bookstack:latest`

## Overview

BookStack is a simple, self-hosted, easy-to-use platform for organizing and storing information. It's ideal for creating documentation, wikis, and knowledge bases with a clean, user-friendly interface.

## Key Features

- 📖 **Hierarchical Organization** - Books, chapters, and pages
- ✏️ **WYSIWYG Editor** - Easy content creation
- 🔍 **Full-Text Search** - Find content quickly
- 👥 **Multi-User** - User roles and permissions
- 📱 **Mobile Friendly** - Responsive interface
- 🔗 **Markdown Support** - Write in Markdown
- 📊 **Activity Tracking** - View recent changes
- 🔐 **Authentication** - LDAP and SAML support

## Getting Started

1. **Start the service**:
   ```bash
   just up bookstore
   ```

2. **Access the web interface**: http://localhost:3002

3. **Initial Setup**:
   - Login with default admin credentials
   - Change admin password
   - Create your first book
   - Add chapters and pages
   - Configure user roles and permissions
   - Customize appearance (optional)

## Ports

- **3002** - Web interface

## Usage

Start this service:
```bash
just services --action start --name bookstore
```

Stop this service:
```bash
just services --action stop --name bookstore
```

View logs:
```bash
just services --action logs --name bookstore
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/bookstore/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
