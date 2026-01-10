# Media Services

Documentation for media streaming services in the home lab.

## Jellyfin - Media Server

**Port**: 8096  
**Purpose**: Stream movies, TV shows, music, and photos

### Features

- **Media Streaming**: Movies, TV shows, music, photos
- **Hardware Acceleration**: M4 optimized transcoding
- **Multiple Clients**: Web, mobile, TV apps
- **User Management**: Multiple user accounts
- **Live TV**: OTA antenna support (with tuner)

### Setup

1. Start Jellyfin:
```bash
just services --action start --name jellyfin
```

2. Access web interface: http://localhost:8096

3. Complete setup wizard:
   - Create admin account
   - Set up media libraries
   - Configure transcoding

### Configuration

#### Media Libraries

Add your media folders:
- Dashboard → Libraries → Add Library
- Select library type (Movies, TV, Music, Photos)
- Add folder path
- Configure metadata providers

#### Hardware Acceleration

Enable M4 hardware acceleration:
1. Dashboard → Playback → Hardware acceleration
2. Select **"Video Toolbox"** (macOS)
3. Enable hardware decoding
4. Save changes

**Supported codecs on M4:**
- H.264 (AVC)
- H.265 (HEVC)
- VP9

#### Transcoding Settings

Recommended settings for M4:
- Max streaming bitrate: 8 Mbps
- Concurrent transcodes: 2-3 maximum
- Prefer direct play when possible

### Usage

#### Import Media

Place media files in your configured directory:
```
/path/to/media/
├── Movies/
│   └── Movie Name (2024)/
│       └── Movie Name (2024).mkv
├── TV Shows/
│   └── Show Name/
│       └── Season 01/
│           └── S01E01.mkv
└── Music/
    └── Artist/
        └── Album/
            └── track.mp3
```

Trigger library scan:
- Dashboard → Libraries → Scan All Libraries

#### Monitor Jellyfin

```bash
# Check status
just monitor --target service --name jellyfin

# View logs
just services --action logs --name jellyfin --follow

# Check resource usage
docker stats jellyfin
```

### Troubleshooting

#### Playback Issues

- **Buffering**: Reduce streaming quality or enable direct play
- **No video**: Check codec support, enable hardware acceleration
- **Audio sync issues**: Try different player or client

#### Transcoding Issues

- **Slow transcoding**: Check CPU usage, reduce concurrent streams
- **Transcode fails**: Check logs, verify ffmpeg installation
- **Quality issues**: Adjust bitrate settings

#### Library Scan Issues

- **Media not appearing**: Check file permissions, naming convention
- **Slow scanning**: Large libraries take time, be patient
- **Metadata missing**: Check internet connection, metadata providers

## Immich - Photo Management

**Port**: 2283  
**Purpose**: Self-hosted photo and video backup

### Features

- **Auto Backup**: Mobile app auto-uploads
- **Face Recognition**: AI-powered face detection
- **Search**: Search by objects, faces, locations
- **Albums**: Organize photos into albums
- **Sharing**: Share photos with others

### Setup

1. Start Immich:
```bash
just services --action start --name immich
```

2. Access: http://localhost:2283

3. Create account and install mobile app

### Usage

- Upload photos via web interface or mobile app
- Create albums
- Use search to find photos
- Share albums with family/friends

## Speedtest Tracker

**Port**: 5000  
**Purpose**: Monitor internet connection speed

### Features

- **Scheduled Tests**: Automatic speed tests
- **History Tracking**: Historical data and graphs
- **Notifications**: Alert on slow speeds
- **Statistics**: Average, min, max speeds

### Setup

1. Start Speedtest Tracker:
```bash
just services --action start --name speedtest-tracker
```

2. Access: http://localhost:5000

3. Configure test schedule:
   - Settings → Schedule
   - Set frequency (e.g., every hour)
   - Enable notifications

### Usage

- View current speeds
- Check historical data
- Export reports
- Set up alerts for slow speeds

## Best Practices

### Media Organization

Use proper naming:
- **Movies**: `Movie Name (Year)/Movie Name (Year).ext`
- **TV Shows**: `Show Name/Season XX/SXXExx - Episode Name.ext`
- **Music**: `Artist/Album/## - Track.ext`

### Performance Optimization

1. **Direct Play**: Configure clients to direct play when possible
2. **Transcoding**: Limit concurrent transcodes to 2-3
3. **Storage**: Use SSD for database, HDD for media
4. **Network**: Use wired connection for best performance

### Backup

Backup Jellyfin metadata:
```bash
just backup --target gdrive --service jellyfin
```

Jellyfin metadata includes:
- Watch history
- User preferences
- Custom artwork
- Collections

Media files should be backed up separately due to size.

### Monitoring

```bash
# Check all media services
just services --action status

# Monitor resource usage
just monitor --target resources

# View logs
just services --action logs --name jellyfin --follow
```

## Clients

### Jellyfin Clients

- **Web**: http://localhost:8096
- **Android**: Jellyfin app from Play Store
- **iOS**: Jellyfin app from App Store
- **TV**: Jellyfin apps for Roku, Fire TV, Android TV
- **Desktop**: Jellyfin Media Player

### Immich Clients

- **Web**: http://localhost:2283
- **Mobile**: Immich app (iOS/Android)

## Tips

1. **Enable Hardware Acceleration**: Critical for M4 performance
2. **Organize Media**: Proper naming helps metadata detection
3. **Monitor Resources**: Keep eye on CPU/RAM during transcoding
4. **Update Regularly**: Keep Jellyfin updated for bug fixes
5. **Backup Metadata**: Saves watch history and preferences
6. **Use Collections**: Group related movies/shows
7. **Configure Remote Access**: Use Headscale VPN for remote streaming
