# AFFiNE

**Official Repository**: [toeverything/AFFiNE](https://github.com/toeverything/AFFiNE)  
**Category**: Productivity  
**Port**: 3010  
**Docker Image**: `ghcr.io/toeverything/affine:latest`

## Overview

AFFiNE is a next-generation knowledge base that brings planning, sorting, and creating all together. It's a privacy-focused, local-first, open-source alternative to Notion.

## Key Features

- 📝 **Rich Text Editor** - Notion-like editing experience
- 🎨 **Whiteboard Mode** - Visual brainstorming and planning
- 🔒 **Privacy First** - Local-first with optional sync
- 📱 **Cross-Platform** - Web, desktop, and mobile
- 🔗 **Block-Based** - Flexible content blocks
- 👥 **Collaboration** - Real-time collaboration
- 📊 **Database Views** - Table, kanban, calendar views
- 🌓 **Dark Mode** - Beautiful light and dark themes

## Getting Started

1. **Start the service**:
   ```bash
   just up affine
   ```

2. **Access the web interface**: http://localhost:3010

3. **Initial Setup**:
   - Create account or workspace
   - Create your first page
   - Explore editor and whiteboard modes
   - Set up workspace organization
   - Configure sync settings (optional)
   - Invite collaborators (optional)

## Ports

- **3010** - Web interface

## Usage

Start this service:
```bash
just up affine
```

Stop this service:
```bash
just stop affine
```

View logs:
```bash
docker compose -f services/affine/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/affine/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
