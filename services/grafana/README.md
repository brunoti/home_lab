# Grafana

**Official Repository**: [grafana/grafana](https://github.com/grafana/grafana)  
**Category**: Monitoring  
**Port**: 3001  
**Docker Image**: `grafana/grafana:latest`

## Overview

Grafana is the open-source platform for monitoring and observability. It allows you to query, visualize, alert on, and explore your metrics, logs, and traces from any data source.

## Key Features

- 📊 **Beautiful Dashboards** - Create stunning visualizations
- 🔌 **Multiple Data Sources** - Prometheus, Loki, InfluxDB, and more
- 📱 **Responsive Design** - Works on desktop and mobile
- 🚨 **Alerting** - Set up alerts and notifications
- 👥 **Team Collaboration** - Share dashboards with teams
- 🎨 **Customizable** - Extensive plugin ecosystem
- 📈 **Time Series Analysis** - Advanced query capabilities
- 🔐 **Authentication** - Multiple auth methods

## Getting Started

1. **Start the service**:
   ```bash
   just up grafana
   ```

2. **Access the web interface**: http://localhost:3001

3. **Initial Setup**:
   - Login with default credentials: `admin` / `admin`
   - Change default password
   - Add data sources (Prometheus, Loki)
   - Import or create dashboards
   - Configure alerts (optional)

## Ports

- **3001** - Web interface

## Usage

Start this service:
```bash
just up grafana
```

Stop this service:
```bash
just stop grafana
```

View logs:
```bash
docker compose -f services/grafana/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/grafana/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
