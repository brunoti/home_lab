# Fitness Services

Documentation for fitness and health tracking services in the home lab.

## Wingfit - Fitness Tracker

**Port**: 8080  
**Purpose**: Minimalist fitness app for planning workouts and tracking records

### Features

- **Workout Planning**: Plan and organize your workout routines
- **Record Tracking**: Track personal records and progress
- **Smartwatch Integration**: Import data from smartwatches
- **Privacy-Focused**: Self-hosted, open-source solution
- **Modern Stack**: FastAPI backend, Angular frontend
- **SQLite Storage**: Lightweight database for fitness data

### Setup

1. Start Wingfit:
```bash
just services --action start --name wingfit
```

2. Access web interface: http://localhost:8080

3. Create your account and start tracking:
   - Set up your profile
   - Plan your first workout
   - Begin tracking your fitness journey

### Configuration

#### Environment Variables

Configure Wingfit in your `.env` file:

```bash
WINGFIT_UID=1000              # User ID for file permissions
WINGFIT_GID=1000              # Group ID for file permissions
WINGFIT_PORT=8080             # Port to access Wingfit
WINGFIT_STORAGE_DIR=/path     # Path for SQLite database and data
```

#### Storage

Wingfit uses SQLite for data storage. All data is stored in `/app/storage` inside the container, which maps to your configured storage directory.

**Storage structure:**
```
/path/to/wingfit/storage/
├── database.db              # SQLite database
└── uploads/                 # User uploads (if any)
```

### Usage

#### Planning Workouts

1. Navigate to the workout planner
2. Create a new workout routine
3. Add exercises and sets
4. Save your workout plan

#### Tracking Records

1. Go to the records section
2. Log your workout session
3. Enter sets, reps, and weight
4. Track your progress over time

#### Smartwatch Integration

If your smartwatch supports data export:
1. Export workout data from your smartwatch app
2. Import the data into Wingfit
3. View consolidated fitness data

### Monitoring

```bash
# Check status
just monitor --target service --name wingfit

# View logs
just services --action logs --name wingfit --follow

# Check resource usage
docker stats wingfit
```

### Troubleshooting

#### Container Won't Start

```bash
# Check logs for errors
just services --action logs --name wingfit

# Verify storage directory permissions
ls -la /path/to/wingfit/storage

# Restart service
just services --action restart --name wingfit
```

#### Cannot Access Web Interface

- **Check port mapping**: Verify port 8080 is not in use
- **Check network**: Ensure homelab network exists
- **Firewall**: Verify local firewall allows port 8080

#### Database Issues

- **Backup database**: Copy `database.db` before troubleshooting
- **Reset database**: Remove `database.db` to start fresh (loses data)
- **Check permissions**: Ensure correct UID/GID for storage directory

### Best Practices

#### Data Management

1. **Regular Backups**: Backup the storage directory regularly
   ```bash
   just backup --target gdrive --service wingfit
   ```

2. **Storage Cleanup**: Monitor storage size as workout history grows

3. **Export Data**: Regularly export your fitness data for safekeeping

#### Security

1. **Access Control**: Use Authelia or VPN for external access
2. **Updates**: Keep Wingfit updated to latest version
3. **Password**: Use strong password for your account

#### Performance

1. **Database**: SQLite is lightweight and efficient for single-user
2. **Resources**: Minimal resource requirements (< 100MB RAM)
3. **Mobile Access**: Use responsive web interface on mobile devices

### Backup

Wingfit data is stored in the storage directory. To backup:

```bash
# Backup entire storage directory
cp -r /path/to/wingfit/storage /path/to/backup/

# Or use the built-in backup command
just backup --target local --service wingfit
```

**What to backup:**
- SQLite database (`database.db`)
- User uploads (if any)
- Configuration files

### Updates

Update Wingfit to the latest version:

```bash
# Pull latest image
cd services/wingfit
docker-compose pull

# Restart service
just services --action restart --name wingfit
```

### Integration

#### With Monitoring Services

Wingfit can be monitored through:
- **Portainer**: Container management
- **Uptime Kuma**: Uptime monitoring on http://localhost:8080
- **Prometheus**: Export metrics (if available)

#### With Homepage Dashboard

Add Wingfit to your Homepage dashboard:
```yaml
- Fitness:
    - Wingfit:
        icon: fitness-center.png
        href: http://localhost:8080
        description: Fitness tracking
```

### Tips

1. **Consistent Tracking**: Log workouts regularly for accurate progress tracking
2. **Set Goals**: Define fitness goals and track progress toward them
3. **Mobile Access**: Bookmark on mobile for quick access during workouts
4. **Privacy**: Keep fitness data private and self-hosted
5. **Backups**: Schedule regular backups of your fitness database
6. **Explore Features**: Wingfit is actively developed, check for new features

### Resources

- **GitHub**: https://github.com/itskovacs/wingfit
- **Docker Hub**: ghcr.io/itskovacs/wingfit
- **Documentation**: Check GitHub README for latest features

## Future Fitness Services

Consider adding these complementary services:

- **FitTrackee**: Advanced workout tracking with GPS routes
- **Tandoor Recipes**: Nutrition and meal planning
- **Home Assistant**: IoT integration for health devices
