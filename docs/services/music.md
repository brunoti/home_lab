# Music Services

Documentation for music streaming services in the home lab.

## Overview

The home lab includes three complementary music services:

1. **Koel**: Modern, beautiful web interface for desktop use
2. **Navidrome**: Subsonic-compatible for mobile apps
3. **Lidarr**: Automated music management and acquisition

Koel and Navidrome share the same music library with independent metadata caches, while Lidarr automates the download and organization of music.

## Lidarr - Music Automation

**Port**: 8686  
**Purpose**: Automated music management and acquisition

### Features

- **Automated Downloads**: Automatically download music releases
- **Quality Management**: Set preferred quality profiles
- **Artist Monitoring**: Track your favorite artists
- **Release Calendar**: See upcoming releases
- **Metadata Management**: Automatic tagging and organization
- **Integration**: Works with Transmission, Prowlarr
- **Notifications**: Get notified of new releases
- **Import Lists**: Import artists from Spotify, Last.fm

### Setup

1. Start Lidarr:
```bash
just services --action start --name lidarr
```

2. Access: http://localhost:8686

3. Initial Configuration:
   - Complete setup wizard
   - Set root music folder: `/music`
   - Configure download client (Transmission)
   - Connect to Prowlarr for indexers

4. Configure Quality Profiles:
   - Settings → Profiles
   - Choose preferred formats (FLAC, MP3)
   - Set quality cutoffs

### Integration with Other Services

**Prowlarr (Indexers):**
1. In Prowlarr, go to Settings → Apps
2. Add Lidarr
3. Use API key from Lidarr Settings → General
4. Test connection

**Transmission (Download Client):**
1. Settings → Download Clients → Add
2. Select Transmission
3. Host: `transmission`
4. Port: `6969`
5. Category: `lidarr`

**Music Library:**
- Lidarr organizes downloads into `/music`
- Koel and Navidrome automatically scan new music
- Manual rescan: `just music --action import`

### Adding Artists

**Manual:**
1. Search for artist name
2. Click artist to view details
3. Select "Add Artist"
4. Choose root folder and quality profile
5. Enable monitoring

**Import Lists:**
- Settings → Import Lists
- Add Spotify Artists
- Add Last.fm Loved Tracks
- Configure API keys

### Usage

**Monitor Artists:**
- Add artists to track new releases
- Set monitoring options:
  - All albums
  - Future albums only
  - Specific albums

**Search for Music:**
- Automatic: Lidarr searches on schedule
- Manual: Click magnifying glass icon
- Interactive Search: Choose specific release

**Quality Profiles:**
- FLAC: Lossless quality
- MP3 320kbps: High quality lossy
- Custom profiles for specific needs

**Release Calendar:**
- View upcoming releases
- See recently added albums
- Track wanted albums

### Configuration

**Root Folders:**
- Settings → Media Management → Root Folders
- Add `/music` as root folder
- Enable rename, organize options

**Metadata:**
- Settings → Metadata
- Enable metadata providers
- Configure file naming
- Embed album art

**Download Client:**
- Settings → Download Clients
- Configure Transmission
- Set completed download handling
- Enable import automation

## Koel - Modern Music Server

**Port**: 13000  
**Purpose**: Beautiful web-based music streaming

### Features

- **Modern Interface**: Beautiful, responsive design
- **Playlist Management**: Create and share playlists
- **Smart Playlists**: Auto-generate based on criteria
- **Last.fm Integration**: Scrobbling support
- **YouTube Integration**: Play music videos
- **Visualization**: Audio visualizer
- **Social Features**: Share music with others

### Setup

1. Generate app key:
```bash
docker compose exec koel php artisan key:generate --show
# Copy the generated key to KOEL_APP_KEY in .env
```

2. Update .env with the key and restart:
```bash
just services --action restart --name koel
```

3. Access: http://localhost:13000

4. Create admin account (use credentials from .env)

### Import Music

Place music files in the shared music directory:
```
./data/koel/music/
├── Artist Name/
│   └── Album Name/
│       ├── 01 - Track Name.mp3
│       ├── 02 - Track Name.mp3
│       └── cover.jpg
```

Import to Koel:
```bash
just music --action import --service koel
```

Or via web interface:
- Settings → Media → Scan

### Usage

**Web Interface:**
- Browse by artists, albums, songs
- Create playlists
- Search for music
- Queue songs
- View lyrics (if embedded)

**Features:**
- Equalizer
- Audio visualizer
- Volume normalization
- Crossfade
- Gapless playback

## Navidrome - Subsonic Server

**Port**: 4533  
**Purpose**: Subsonic-compatible music server for mobile apps

### Features

- **Subsonic Compatible**: Works with many mobile apps
- **Fast**: Efficient indexing and streaming
- **Transcoding**: On-the-fly format conversion
- **Smart Playlists**: Auto-generated playlists
- **Ratings & Favorites**: Star system
- **Podcasts**: Podcast support
- **Multi-User**: Multiple user accounts

### Setup

1. Start Navidrome:
```bash
just services --action start --name navidrome
```

2. Access: http://localhost:4533

3. Create admin account on first login

4. Configure scanning:
   - Settings → Media Folder
   - Verify path: `/music`
   - Set scan interval

### Import Music

Music is shared with Koel:
```bash
just music --action sync --service navidrome
```

Or trigger scan via web interface:
- Settings → Scan Media Folder

### Mobile Apps

Navidrome works with Subsonic-compatible apps:

**iOS:**
- **play:Sub**: Full-featured, offline mode
- **substreamer**: Simple interface
- **Amperfy**: Modern design

**Android:**
- **Ultrasonic**: Open source
- **DSub**: Feature-rich
- **Subtracks**: Material design

**Configuration:**
- Server: `http://YOUR_IP:4533`
- Username: Your Navidrome username
- Password: Your Navidrome password

### Usage

**Web Interface:**
- Browse library
- Create playlists
- Star favorites
- Search music
- Stream to browser

**Mobile Apps:**
- Offline caching
- Playlist sync
- Equalizer
- Sleep timer
- Car mode

## Music Library Management

### Organization

Recommended structure:
```
music/
├── Artist Name/
│   ├── Album Name (Year)/
│   │   ├── 01 - Track.flac
│   │   ├── 02 - Track.flac
│   │   └── cover.jpg
│   └── Another Album/
│       └── ...
└── Various Artists/
    └── Compilation Album/
        └── ...
```

### File Formats

**Supported:**
- FLAC (lossless, recommended)
- MP3 (lossy, universal)
- AAC/M4A (lossy, good quality)
- OGG Vorbis (lossy, open)
- ALAC (lossless, Apple)

**Recommended:**
- FLAC for archival
- MP3 320kbps for compatibility
- Include album art

### Metadata

Use proper ID3 tags:
- **Title**: Track name
- **Artist**: Artist name
- **Album**: Album name
- **Album Artist**: Album artist (for compilations)
- **Year**: Release year
- **Genre**: Music genre
- **Track Number**: Track position
- **Disc Number**: For multi-disc albums
- **Artwork**: Embedded album art

Tools for tagging:
- **MusicBrainz Picard**: Auto-tagging
- **Kid3**: Manual tagging
- **beets**: CLI auto-tagger

### Import Workflow

1. **Organize files**:
```bash
# Place in music directory
cp -r /path/to/new/music ./data/koel/music/
```

2. **Fix permissions**:
```bash
chmod -R 755 ./data/koel/music
```

3. **Import to services**:
```bash
# Import to both services
just music --action import

# Or individually
just music --action import --service koel
just music --action sync --service navidrome
```

4. **Verify**:
   - Check web interfaces
   - Search for new music
   - Test playback

## Synchronization

### Keep Libraries in Sync

Music is stored once, accessed by both services:
- Koel: `/music` → `./data/koel/music`
- Navidrome: `/music` → `./data/koel/music` (read-only)

### Rescan Libraries

After adding new music:
```bash
# Rescan both services
just music --action import

# Or trigger in web interfaces
```

### Metadata Updates

Services maintain independent metadata:
- Playlists in Koel don't sync to Navidrome
- Ratings in Navidrome separate from Koel
- Each service caches differently

## Advanced Configuration

### Transcoding

**Koel:**
- Configured in web interface
- Settings → Media → Streaming bitrate

**Navidrome:**
- Automatic transcoding for mobile
- Configure in Settings → Transcoding
- Uses ffmpeg for conversion

### Integration

**Last.fm (Koel):**
1. Get Last.fm API key
2. Settings → Last.fm
3. Connect account
4. Enable scrobbling

**Podcasts (Navidrome):**
1. Settings → Podcasts
2. Add podcast RSS feeds
3. Auto-download episodes

## Maintenance

### Scan Libraries

Regular scanning ensures new music appears:
```bash
# Weekly or after adding music
just music --action import
```

### Clear Caches

If metadata is incorrect:
```bash
just music --action clear-cache --service koel
just music --action clear-cache --service navidrome
```

### Backup

Backup music library metadata:
```bash
# Backup configurations and playlists
just backup --target gdrive
```

Music files should be backed up separately due to size.

### Monitor Performance

```bash
# Check service status
just music --action status

# View logs
just services --action logs --name koel
just services --action logs --name navidrome

# Check resource usage
docker stats koel navidrome
```

## Troubleshooting

### Music Not Appearing

**Koel:**
```bash
# Force rescan
just music --action import --service koel

# Check logs
just services --action logs --name koel
```

**Navidrome:**
```bash
# Force rescan
just music --action sync --service navidrome

# Check scan interval
# May need to wait for scheduled scan
```

### Playback Issues

**Koel:**
- Check browser console for errors
- Try different browser
- Check file formats supported

**Navidrome:**
- Enable transcoding
- Check mobile app settings
- Verify network connectivity

### Metadata Issues

- Check ID3 tags in files
- Use MusicBrainz Picard to fix
- Rescan after fixing tags

### Permission Issues

```bash
# Fix ownership
chmod -R 755 ./data/koel/music

# Restart services
just services --action restart --name koel
just services --action restart --name navidrome
```

## Best Practices

1. **Use FLAC**: Better quality, future-proof
2. **Tag Properly**: Accurate metadata essential
3. **Include Artwork**: Embed or place in album folder
4. **Organize Logically**: By artist/album structure
5. **Regular Scans**: After adding music
6. **Backup Music**: Keep originals safe
7. **Test Playback**: Verify files play correctly
8. **Monitor Space**: Music libraries grow quickly

## Clients & Access

### Desktop
- **Koel**: http://localhost:13000 (web)
- **Navidrome**: http://localhost:4533 (web)

### Mobile
- **Navidrome**: Use Subsonic apps
  - iOS: play:Sub, Amperfy
  - Android: Ultrasonic, DSub

### Remote Access
- Use Headscale VPN
- Access via internal IP:port
- Secure connection recommended

## Tips

1. **Choose Service**: Koel for desktop, Navidrome for mobile, Lidarr for automation
2. **Organize First**: Good structure saves time
3. **Tag Music**: Proper metadata crucial
4. **Use Lossless**: FLAC when possible
5. **Regular Backups**: Protect your collection
6. **Monitor Storage**: Track disk usage
7. **Update Services**: Keep software current
8. **Test Apps**: Try different mobile clients
9. **Automate Wisely**: Configure Lidarr quality profiles carefully
