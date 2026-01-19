# Loki

**Official Repository**: [grafana/loki](https://github.com/grafana/loki)  
**Category**: Monitoring  
**Port**: 3100  
**Docker Image**: `grafana/loki:latest`

## Overview

Loki is a horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus. It is designed to be cost-effective and easy to operate.

## Key Features

- 📝 **Log Aggregation** - Collect logs from all services
- 🏷️ **Label-Based Indexing** - Efficient log indexing
- 🔍 **LogQL** - Powerful query language
- 📊 **Grafana Integration** - Native integration with Grafana
- 💰 **Cost-Effective** - Only indexes metadata
- 🚀 **High Performance** - Fast log queries
- 🔗 **Promtail Support** - Log shipping agent
- 📈 **Scalable** - Horizontal scaling support

## Getting Started

1. **Start the service**:
   ```bash
   just up loki
   ```

2. **Access via Grafana**: http://localhost:3001

3. **Initial Setup**:
   - Add Loki as data source in Grafana
   - URL: `http://loki:3100`
   - Configure Promtail or Docker logging driver
   - Create log queries using LogQL
   - Build log dashboards in Grafana

## Ports

- **3100** - HTTP API and query interface

## Usage

Start this service:
```bash
just up loki
```

Stop this service:
```bash
just stop loki
```

View logs:
```bash
docker compose -f services/loki/docker-compose.yml logs -f
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/loki/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
