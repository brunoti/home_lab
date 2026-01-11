# Retrom

Category: Media & Gaming

## Service Information

Retrom is a centralized game library/collection management service focused heavily on emulation. It enables users to organize, launch, and manage their games—from retro emulated titles to modern native PC games—in one unified library across devices.

### Features
- Host your own cloud game library service
- Scan your filesystem for games/platforms and automatically add them to your library
- Install/uninstall and play games from the service on any desktop clients (Windows, MacOS, and Linux)
- Access your library from anywhere with the web client
- Unify your emulation library with third party libraries (Steam, GOG)
- Manage emulator profiles on a per-client basis
- Automatically download game metadata and artworks from supported providers

### Ports
- **5101**: Main service API
- **3000**: Web client interface

## Usage

Start this service:
```bash
just services --action start --name retrom
```

Stop this service:
```bash
just services --action stop --name retrom
```

View logs:
```bash
just services --action logs --name retrom
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs in `/data/retrom/config/`

### Initial Setup

1. Start the service: `just services --action start --name retrom`
2. Access the web interface at `http://localhost:3000`
3. Download the desktop client from: https://github.com/JMBeresford/retrom/releases/latest
4. Configure your game library directory in `RETROM_LIBRARY_DIR`
5. Optional: Set up IGDB API keys for metadata scraping

### Game Library Structure

Place your game files in the directory specified by `RETROM_LIBRARY_DIR` (default: `../../data/retrom/library`). Retrom will automatically scan and organize your games.

## Dependencies

This service runs independently without dependencies on other home lab services.

## Resources

- GitHub: https://github.com/JMBeresford/retrom
- Documentation: https://github.com/JMBeresford/retrom/wiki
- Download Client: https://github.com/JMBeresford/retrom/releases/latest
