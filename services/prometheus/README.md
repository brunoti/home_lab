# Prometheus

**Official Repository**: [prometheus/prometheus](https://github.com/prometheus/prometheus)  
**Category**: Monitoring  
**Port**: 9090  
**Docker Image**: `prom/prometheus:latest`

## Overview

Prometheus is an open-source systems monitoring and alerting toolkit. It collects and stores metrics as time series data, recording information with timestamps and optional key-value pairs called labels.

## Key Features

- 📊 **Time Series Database** - Efficient metrics storage
- 🎯 **Pull-Based Collection** - Scrapes metrics from targets
- 🔍 **Powerful Queries** - PromQL query language
- 🚨 **Alerting** - Flexible alerting rules
- 📈 **Multi-Dimensional Data** - Labels for flexible data modeling
- 🔌 **Service Discovery** - Automatic target discovery
- 🎨 **Visualization** - Built-in expression browser
- 🔗 **Grafana Integration** - Works seamlessly with Grafana

## Getting Started

1. **Start the service**:
   ```bash
   just up prometheus
   ```

2. **Access the web interface**: http://localhost:9090

3. **Initial Setup**:
   - Configure scrape targets in `prometheus.yml`
   - Set up alerting rules (optional)
   - Add Prometheus as data source in Grafana
   - Create queries using PromQL

## Ports

- **9090** - Web interface and API

## Usage

Start this service:
```bash
just services --action start --name prometheus
```

Stop this service:
```bash
just services --action stop --name prometheus
```

View logs:
```bash
just services --action logs --name prometheus
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/prometheus/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
