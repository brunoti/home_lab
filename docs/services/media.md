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

## Dispatcharr - IPTV Management

**Port**: 9191  
**Purpose**: IPTV playlist management and proxy

### Features

- **Playlist Management**: Curate and edit M3U/M3U8 playlists
- **Proxy Streaming**: Optimizes bandwidth and reliability
- **EPG Support**: Electronic Program Guide with auto-matching
- **Real-Time Dashboard**: Monitor stream health and client activity
- **VOD Management**: Movies and TV series support
- **Bulk Editing**: Mass edit streams and channels
- **Wide Compatibility**: HDHomeRun, XMLTV, and M3U output formats

### Setup

1. Start Dispatcharr:
```bash
just services --action start --name dispatcharr
```

2. Access web interface: http://localhost:9191

3. Initial configuration:
   - Import M3U playlist URLs
   - Configure EPG sources
   - Set up proxy settings

### Configuration

#### Adding IPTV Sources

1. Navigate to Sources section
2. Add M3U playlist URL
3. Configure refresh interval
4. Import channels

#### EPG Configuration

1. Add EPG source (XMLTV URL)
2. Enable auto-match for channels
3. Set update schedule

#### Proxy Setup

Generate proxy URLs for media servers:
- M3U Playlist URL
- XMLTV EPG URL
- HDHomeRun compatible output

### Integration with Media Servers

#### Jellyfin Integration

1. In Jellyfin, go to Dashboard → Live TV
2. Add tuner device: "M3U Tuner"
3. Enter Dispatcharr M3U URL: `http://localhost:9191/playlist/proxy.m3u`
4. Add EPG source: `http://localhost:9191/epg/xmltv.xml`
5. Scan for channels

#### Plex/Emby Integration

Similar process - use the proxy URLs from Dispatcharr:
- M3U: `http://localhost:9191/playlist/proxy.m3u`
- EPG: `http://localhost:9191/epg/xmltv.xml`

### Usage

#### Managing Channels

```bash
# View logs
just services --action logs --name dispatcharr --follow

# Restart after configuration changes
just services --action restart --name dispatcharr
```

#### Channel Organization

- Bulk edit channel names
- Group channels by category
- Hide unwanted channels
- Set channel logos

### Troubleshooting

#### Streams Not Playing

- Check source playlist is accessible
- Verify network connectivity
- Review Dispatcharr logs
- Test stream URL directly

#### EPG Not Updating

- Verify EPG source URL
- Check update schedule
- Force manual refresh
- Review EPG format compatibility

#### Performance Issues

- Limit concurrent streams
- Enable caching if available
- Check bandwidth usage
- Monitor resource consumption

## Tips

1. **Enable Hardware Acceleration**: Critical for M4 performance
2. **Organize Media**: Proper naming helps metadata detection
3. **Monitor Resources**: Keep eye on CPU/RAM during transcoding
4. **Update Regularly**: Keep Jellyfin updated for bug fixes
5. **Backup Metadata**: Saves watch history and preferences
6. **Use Collections**: Group related movies/shows
7. **Configure Remote Access**: Use Headscale VPN for remote streaming
8. **Test IPTV Sources**: Verify M3U playlists before adding to Dispatcharr
9. **Regular EPG Updates**: Keep program guide data fresh
