# Monitoring & Observability

Documentation for monitoring, metrics, and observability services.

## Overview

The monitoring stack provides complete visibility into your home lab:

- **Portainer**: Docker container management
- **Prometheus**: Metrics collection
- **Grafana**: Visualization and dashboards  
- **Loki**: Log aggregation
- **Uptime Kuma**: Uptime monitoring

## Portainer - Container Management

**Port**: 9000  
**Purpose**: Visual Docker management interface

### Features

- Container management
- Image management  
- Volume management
- Network management
- Stack deployment
- User management
- Templates

### Setup

1. Start Portainer:
```bash
just services --action start --name portainer
```

2. Access: http://localhost:9000

3. Create admin account on first visit

4. Select "Local" environment

### Usage

**Manage Containers:**
- View all containers
- Start/stop/restart
- View logs
- Access console
- Inspect details

**Deploy Stacks:**
- Stacks → Add stack
- Paste docker-compose content
- Deploy

**Monitoring:**
- Dashboard shows resource usage
- View container stats
- Monitor networks

## Prometheus - Metrics Collection

**Port**: 9090  
**Purpose**: Time-series metrics database

### Features

- Metrics scraping
- Time-series database
- Query language (PromQL)
- Alerting rules
- Service discovery
- Long-term storage

### Setup

1. Start Prometheus:
```bash
just services --action start --name prometheus
```

2. Access: http://localhost:9090

3. Configure targets in `config/prometheus/prometheus.yml`

### Configuration

Add scrape targets:

```yaml
scrape_configs:
  - job_name: 'my-service'
    static_configs:
      - targets: ['service:port']
```

### Usage

**Query Metrics:**
- Graph tab for visualizations
- Use PromQL for queries
- Example: `rate(http_requests_total[5m])`

**Check Targets:**
- Status → Targets
- View scrape status
- Check for errors

## Grafana - Dashboards

**Port**: 3001  
**Purpose**: Metrics visualization and dashboards

### Features

- Beautiful dashboards
- Multiple data sources
- Alerting
- User management
- Templating
- Annotations
- Sharing

### Setup

1. Start Grafana:
```bash
just services --action start --name grafana
```

2. Access: http://localhost:3001

3. Login with credentials from .env

4. Add Prometheus data source:
   - Configuration → Data Sources → Add
   - Type: Prometheus
   - URL: http://prometheus:9090
   - Save & Test

### Create Dashboards

**Import Existing:**
1. Dashboards → Import
2. Enter dashboard ID or upload JSON
3. Select data source
4. Import

**Create Custom:**
1. Dashboards → New Dashboard
2. Add Panel
3. Select metrics
4. Configure visualization
5. Save dashboard

### Recommended Dashboards

- Node Exporter (ID: 1860)
- Docker Monitoring (ID: 893)
- System Overview (ID: 3662)

### Alerting

**Configure Alerts:**
1. Alerting → Notification channels
2. Add channel (email, Slack, etc.)
3. Create alert rules in panels
4. Test notifications

## Loki - Log Aggregation

**Port**: 3100  
**Purpose**: Centralized log collection and querying

### Features

- Log aggregation
- Label-based indexing
- LogQL query language
- Integration with Grafana
- Efficient storage
- Multi-tenancy

### Setup

1. Start Loki:
```bash
just services --action start --name loki
```

2. Add to Grafana:
   - Configuration → Data Sources → Add
   - Type: Loki
   - URL: http://loki:3100
   - Save & Test

### Usage

**Query Logs in Grafana:**
1. Explore → Select Loki
2. Use LogQL queries
3. Example: `{job="varlogs"} |= "error"`

**Common Queries:**
```
# All logs from a service
{container_name="jellyfin"}

# Error logs
{container_name="jellyfin"} |= "error"

# Rate of errors
rate({container_name="jellyfin"} |= "error" [5m])
```

## Uptime Kuma - Uptime Monitoring

**Port**: 3003  
**Purpose**: Service availability monitoring

### Features

- HTTP(s) monitoring
- TCP port monitoring
- Ping monitoring
- Status pages
- Notifications
- Multi-language
- Beautiful UI
- Tag system

### Setup

1. Start Uptime Kuma:
```bash
just services --action start --name uptime-kuma
```

2. Access: http://localhost:3003

3. Create admin account

4. Add monitors

### Add Monitors

**HTTP Monitor:**
1. Add New Monitor
2. Monitor Type: HTTP(s)
3. Friendly Name: Service name
4. URL: http://localhost:port
5. Heartbeat Interval: 60 seconds
6. Save

**Monitor Types:**
- HTTP(s): Web services
- TCP Port: Check port availability
- Ping: ICMP ping
- DNS: DNS resolution

### Notifications

**Configure Alerts:**
1. Settings → Notifications
2. Add notification method:
   - Email
   - Slack
   - Discord
   - Telegram
   - Webhooks
3. Test notification
4. Apply to monitors

### Status Page

**Create Public Status Page:**
1. Status Pages → Add
2. Select monitors to display
3. Customize appearance
4. Share URL

## Monitoring Best Practices

### What to Monitor

**System Metrics:**
- CPU usage
- RAM usage
- Disk space
- Network I/O

**Service Metrics:**
- Response time
- Error rate
- Request rate
- Queue depth

**Business Metrics:**
- Active users
- Transcoding jobs
- Library size
- Backup success

### Alert Thresholds

**RAM:**
- Warning: >80%
- Critical: >90%

**Disk:**
- Warning: <20GB free
- Critical: <10GB free

**CPU:**
- Warning: >80% sustained
- Critical: >90% sustained

**Service:**
- Warning: Response time >2s
- Critical: Service down

### Dashboard Organization

**Home Dashboard:**
- Overall system health
- Key metrics
- Recent alerts
- Service status

**Service Dashboards:**
- Jellyfin: Streams, transcodes
- Database: Connections, queries
- Network: Traffic, errors

**Infrastructure:**
- Host metrics
- Container stats
- Volume usage

## Advanced Configuration

### Custom Metrics

**Expose Metrics:**
1. Service must expose `/metrics` endpoint
2. Add to Prometheus config
3. Restart Prometheus
4. Create Grafana dashboard

### Log Forwarding

**Docker Logs to Loki:**
1. Configure Docker logging driver
2. Or use Promtail
3. Logs auto-collected

### Alert Routing

**Grafana Alert Rules:**
```yaml
- alert: HighMemoryUsage
  expr: (node_memory_Active_bytes / node_memory_MemTotal_bytes) > 0.8
  for: 5m
  annotations:
    summary: "High memory usage detected"
```

## Maintenance

### Check Monitoring Health

```bash
# Check all monitoring services
just monitor --target health

# Specific service
just monitor --target service --name prometheus
```

### Backup Dashboards

```bash
# Backup Grafana configuration
just backup --target local --service grafana
```

### Clean Old Data

**Prometheus:**
- Retention set to 15 days (default)
- Automatic cleanup

**Loki:**
- Configure retention in config
- Automatic cleanup

### Update Services

```bash
# Pull latest images
docker compose pull prometheus grafana loki

# Restart
just services --action restart
```

## Troubleshooting

### Prometheus Not Scraping

1. Check target configuration
2. Verify service reachable
3. Check firewall
4. View Prometheus logs

### Grafana Dashboard Empty

1. Verify data source connected
2. Check time range
3. Test query in Explore
4. Check Prometheus has data

### Loki Not Receiving Logs

1. Check Loki running
2. Verify log forwarding configured
3. Test LogQL query
4. Check Loki logs

### Uptime Kuma False Positives

1. Increase heartbeat interval
2. Add retry count
3. Check network stability
4. Verify service actually stable

## Integration

### Email Notifications

Configure in services:
- Grafana: SMTP settings
- Uptime Kuma: Email notification

### Slack Integration

1. Create Slack webhook
2. Add to Grafana notification channels
3. Add to Uptime Kuma
4. Test notifications

### Mobile Apps

- **Grafana**: Mobile app available
- **Uptime Kuma**: Progressive web app

## Useful Queries

### PromQL Examples

```promql
# CPU usage
rate(process_cpu_seconds_total[5m])

# Memory usage
process_resident_memory_bytes

# HTTP request rate
rate(http_requests_total[5m])

# Error rate
rate(http_requests_total{status="500"}[5m])
```

### LogQL Examples

```logql
# Service logs
{container_name="jellyfin"}

# Error logs
{container_name="jellyfin"} |= "error"

# JSON parsing
{container_name="jellyfin"} | json | level="error"

# Rate of logs
rate({container_name="jellyfin"}[5m])
```

## Resources

- Prometheus docs: https://prometheus.io/docs/
- Grafana docs: https://grafana.com/docs/
- Loki docs: https://grafana.com/docs/loki/
- Uptime Kuma: https://github.com/louislam/uptime-kuma

## Tips

1. **Start Simple**: Basic dashboards first
2. **Alert Fatigue**: Don't over-alert
3. **Test Alerts**: Ensure notifications work
4. **Regular Review**: Check metrics weekly
5. **Backup Dashboards**: Export regularly
6. **Document Custom Dashboards**: Note queries used
7. **Use Tags**: Organize monitors and dashboards
8. **Set Realistic Thresholds**: Based on baseline
