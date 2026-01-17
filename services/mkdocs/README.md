# MkDocs Material

**Official Repository**: [squidfunk/mkdocs-material](https://github.com/squidfunk/mkdocs-material)  
**Category**: Documentation  
**Port**: 8001  
**Docker Image**: `squidfunk/mkdocs-material:latest`

## Overview

MkDocs Material is a powerful documentation framework based on MkDocs with a beautiful Material Design theme. It provides a technical documentation site that just works with minimal configuration.

## Key Features

- 📚 **Material Design** - Beautiful, modern theme
- 🔍 **Full-Text Search** - Fast, client-side search
- 📱 **Mobile Optimized** - Responsive design
- 🌙 **Dark Mode** - Automatic or manual theme switching
- 🎨 **Customizable** - Extensive theming options
- 🔌 **Extensions** - Rich plugin ecosystem
- 📖 **Code Highlighting** - Syntax highlighting for 200+ languages
- 🚀 **Fast** - Static site generation

## Getting Started

1. **Start the documentation server**:
   ```bash
   just docs --action serve
   # Or: just up mkdocs
   ```

2. **Access the documentation**: http://localhost:8001

3. **Usage**:
   - Browse documentation in your browser
   - Edit markdown files in `docs/` directory
   - Changes are reflected automatically in dev mode
   - Build static site with `just docs --action build`

## Ports

- **8001** - Documentation web server

## Usage

Start this service:
```bash
just services --action start --name mkdocs
```

Stop this service:
```bash
just services --action stop --name mkdocs
```

View logs:
```bash
just services --action logs --name mkdocs
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/mkdocs/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
