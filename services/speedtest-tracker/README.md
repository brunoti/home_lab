# Speedtest Tracker

**Official Repository**: [alexjustesen/speedtest-tracker](https://github.com/alexjustesen/speedtest-tracker)  
**Category**: Monitoring  
**Port**: 5000  
**Docker Image**: `linuxserver/speedtest-tracker:latest`

## Overview

Speedtest Tracker is a self-hosted internet performance tracking application that runs speedtest checks against Ookla's Speedtest service. It provides historical data and charts to monitor your internet connection quality over time.

## Key Features

- 📊 **Speed Testing** - Automated internet speed tests
- 📈 **Historical Data** - Track performance over time
- 📉 **Charts & Graphs** - Visual performance trends
- ⏰ **Scheduled Tests** - Automatic testing on schedule
- 🚨 **Notifications** - Alert on performance issues
- 📱 **Mobile Friendly** - Responsive interface
- 🌐 **Multiple Servers** - Test against different locations
- 📝 **Export Data** - Download historical results

## Getting Started

1. **Start the service**:
   ```bash
   just up speedtest-tracker
   ```

2. **Access the web interface**: http://localhost:5000

3. **Initial Setup**:
   - Complete initial setup wizard
   - Configure test schedule (e.g., hourly, daily)
   - Select speedtest servers
   - Set up notifications (optional)
   - Run first manual test to verify

## Ports

- **5000** - Web interface

## Usage

Start this service:
```bash
just up speedtest-tracker
```

Stop this service:
```bash
just stop speedtest-tracker
```

View logs:
```bash
docker compose -f services/speedtest-tracker/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/speedtest-tracker/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
