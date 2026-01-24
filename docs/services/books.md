# Book Services

Documentation for ebook and audiobook services in the home lab.

## Overview

The home lab provides a complete book ecosystem:

1. **Calibre**: Core library management
2. **Calibre Web**: Web reader interface
3. **Audiobookshelf**: Audiobook streaming
4. **Lazylibrarian**: Automated ebook discovery
5. **Booklore**: Modern digital library manager

All services share the same book library when configured.

## Calibre - Library Management

**Port**: 8080, 8081  
**Purpose**: Comprehensive ebook management

### Features

- **Library Management**: Organize ebooks
- **Format Conversion**: Convert between formats
- **Metadata Editing**: Edit book information
- **Reading**: Built-in reader
- **Sync Devices**: Sync to e-readers
- **Search**: Advanced search capabilities
- **Series Management**: Track book series

### Setup

1. Start Calibre:
```bash
just services --action start --name calibre
```

2. Access: http://localhost:8080

3. Initialize library:
   - Set library location: `/books`
   - Import existing library or start fresh

### Import Books

Place ebooks in the library directory:
```bash
# Organize by author
./data/calibre/books/
├── Author Name/
│   ├── Book Title (1)/
│   │   └── Book Title - Author Name.epub
│   └── Another Book (2)/
│       └── Another Book - Author Name.epub
```

Import to Calibre:
```bash
just books --action import --service calibre
```

Or via web interface:
- Add books button
- Select files to import
- Calibre auto-organizes

### Convert Formats

Convert between ebook formats:
```bash
# Via command
just books --action convert --format epub --input book.mobi

# Via web interface
# Right-click book → Convert books → Select format
```

**Supported formats:**
- EPUB (recommended, universal)
- MOBI (Kindle)
- AZW3 (Kindle)
- PDF (documents)
- TXT (plain text)
- Many more

## Calibre Web - Web Reader

**Port**: 8083  
**Purpose**: Web-based reading interface

### Features

- **Web Reader**: Read in browser
- **OPDS Support**: Compatible with reading apps
- **User Management**: Multiple users
- **Download**: Download books
- **Send to Kindle**: Email to Kindle
- **Ratings & Reviews**: Rate books
- **Collections**: Organize books

### Setup

1. Start Calibre Web:
```bash
just services --action start --name calibre-web
```

2. Access: http://localhost:8083

3. First login:
   - Username: `admin`
   - Password: `admin123`
   - Change password immediately

4. Configure library:
   - Admin → Basic Configuration
   - Point to Calibre library: `/books`

### Usage

**Reading:**
- Click book cover
- Choose "Read" or "Download"
- Web reader opens in browser

**Sending to Kindle:**
- Configure email settings
- Click "Send to Kindle"
- Receive via Amazon

**OPDS Catalog:**
- Compatible reading apps can browse
- URL: `http://localhost:8083/opds`

## Audiobookshelf - Audiobook Server

**Port**: 8000  
**Purpose**: Audiobook and podcast streaming

### Features

- **Audiobook Streaming**: Stream audiobooks
- **Podcasts**: Subscribe to podcasts
- **Progress Tracking**: Resume playback
- **Collections**: Organize audiobooks
- **User Accounts**: Multiple users
- **Mobile Apps**: iOS and Android apps
- **Sleep Timer**: Auto-stop playback
- **Playback Speed**: Adjust speed

### Setup

1. Start Audiobookshelf:
```bash
just services --action start --name audiobookshelf
```

2. Access: http://localhost:8000

3. Create admin account

4. Add library:
   - Settings → Libraries → Add
   - Type: Audiobooks
   - Folder: `/audiobooks`
   - Scan library

### Import Audiobooks

Organize audiobooks:
```
./data/audiobookshelf/audiobooks/
├── Author Name/
│   └── Book Title/
│       ├── 01 - Chapter 1.mp3
│       ├── 02 - Chapter 2.mp3
│       └── cover.jpg
```

Import:
```bash
just books --action import --service audiobookshelf --path /path/to/audiobooks
```

### Mobile Apps

- **iOS**: Audiobookshelf from App Store
- **Android**: Audiobookshelf from Play Store

**Configuration:**
- Server: `http://YOUR_IP:8000`
- Username: Your username
- Password: Your password

## Lazylibrarian - Automated Discovery

**Port**: 8666  
**Purpose**: Automated ebook search and download

### Features

- **Book Search**: Find ebooks automatically
- **Goodreads Integration**: Import wish lists
- **Author Tracking**: Follow favorite authors
- **RSS Feeds**: Monitor book releases
- **Format Preferences**: Choose preferred formats
- **Quality Filtering**: Filter by quality
- **Integration**: Works with Calibre

### Setup

1. Start Lazylibrarian:
```bash
just services --action start --name lazylibrarian
```

2. Access: http://localhost:8666

3. Configure:
   - Settings → Processing
   - Set book directory: `/books`
   - Configure download clients

4. Add indexers:
   - Settings → Indexers
   - Add book sources

### Usage

**Search for Books:**
```bash
just books --action search --service lazylibrarian --query "Book Title"
```

Or via web interface:
- Add author
- Search for books
- Mark books as wanted
- Automatic search

**Import to Calibre:**
```bash
just books --action import-from-lazy
```

## Complete Workflow

### Adding New Books

1. **Acquire ebook**
2. **Import to Calibre:**
```bash
just books --action import --service calibre --path /path/to/new/books
```
3. **Convert if needed:**
```bash
just books --action convert --format epub --input book.mobi
```
4. **Read** via Calibre Web or download to device

### Adding Audiobooks

1. **Organize files** in audiobooks directory
2. **Import:**
```bash
just books --action import --service audiobookshelf
```
3. **Scan library** to detect changes
4. **Listen** via web or mobile app

### Automated Discovery

1. **Setup Lazylibrarian** with indexers
2. **Add authors** you follow
3. **Mark books wanted**
4. **Lazylibrarian** auto-searches and downloads
5. **Books appear** in Calibre library

## Maintenance

### Sync Libraries

Keep services in sync:
```bash
just books --action sync --service lazylibrarian
```

### Backup Library

Backup books and metadata:
```bash
just books --action backup --service calibre
```

### Check Status

```bash
# Check all book services
just books --action status

# View logs
just services --action logs --name calibre
just services --action logs --name audiobookshelf
```

### Database Maintenance

Rebuild Calibre database:
```bash
just books --action rebuild-db --service calibre
```

## Best Practices

### Organization

1. **Use Calibre**: As central library
2. **Consistent Naming**: Author/Title format
3. **Add Metadata**: Title, author, series, tags
4. **Cover Art**: Include book covers
5. **Series Info**: Track series order

### Format Recommendations

- **EPUB**: Universal, preferred format
- **MOBI/AZW3**: For Kindle devices
- **PDF**: For documents, not ideal for reading

### Metadata

Essential fields:
- Title
- Author
- Series (if applicable)
- Series number
- Publication date
- Publisher
- Tags/Genre
- Description
- Cover image

Use Calibre's metadata plugins:
- Goodreads
- Amazon
- Google Books

### File Management

```
books/
├── Author Last, First/
│   ├── Book Title (1)/
│   │   ├── cover.jpg
│   │   ├── metadata.opf
│   │   └── Book Title - Author.epub
│   └── Another Book (2)/
│       └── ...
```

## Troubleshooting

### Books Not Appearing

**Calibre:**
- Check file permissions
- Verify import path
- Check supported formats
- Rebuild database

**Calibre Web:**
- Point to correct Calibre library
- Restart service
- Check library permissions

### Conversion Issues

- Verify source format supported
- Check conversion logs
- Try different output settings
- Install required conversion tools

### Lazylibrarian Not Finding Books

- Configure indexers properly
- Check indexer credentials
- Verify search criteria
- Check logs for errors

## Integration

### With Download Clients

Configure Lazylibrarian to work with:
- Transmission (included)
- Other torrent clients
- Usenet clients

### With E-Readers

**Kindle:**
- Use Calibre's "Send to device"
- Or email via Calibre Web

**Other E-Readers:**
- Copy EPUB files
- Or use OPDS in reading apps

### With Mobile Apps

**Reading Apps:**
Use OPDS catalog from Calibre Web:
- KyBook (iOS)
- Moon+ Reader (Android)
- FBReader (Multi-platform)

**URL:** `http://YOUR_IP:8083/opds`

## Tips

1. **Start with Calibre**: Core of book management
2. **Use EPUB**: Most compatible format
3. **Add Metadata**: Makes searching easier
4. **Regular Backups**: Protect your library
5. **Tag Books**: For organization
6. **Use Series**: Track reading order
7. **Calibre Web for Access**: Easy remote reading
8. **Lazylibrarian for Discovery**: Find new books
9. **Audiobookshelf for Audio**: Great mobile experience

## Resources

- Calibre documentation: https://manual.calibre-ebook.com/
- Calibre Web wiki
- Audiobookshelf docs
- Lazylibrarian wiki- Booklore documentation: https://booklore.org/docs/

## Booklore - Modern Digital Library

**Port**: 6060  
**Purpose**: Modern, open-source library management system

### Features

- **Smart Organization**: Shelves, filters, magic shelves, and fast search
- **Automatic Metadata**: Fetch book details, covers, and reviews automatically
- **OPDS Support**: Connect reading apps for wireless downloads
- **Built-in Reader**: Read EPUBs, PDFs, and comics in browser
- **Multi-User**: Share library with granular permissions
- **Kobo/KOReader Sync**: Sync reading progress and highlights
- **Bookdrop**: Automatic import by dropping files into folder
- **Email Sharing**: Send books to Kindle or any email

### Setup

1. Start Booklore:
```bash
just up booklore
```

2. Access: http://localhost:6060

3. Complete setup wizard:
   - Create administrator account
   - Set email and timezone
   - Configure preferences

4. Create library:
   - Settings → Libraries → Add Library
   - Name: "My Library"
   - Path: `/books`
   - Enable scanning

### Import Books

**Method 1: Direct Copy**
```bash
# Copy books to library
cp /path/to/books/*.epub data/booklore/books/
# Trigger scan in Booklore UI
```

**Method 2: Bookdrop (Recommended)**
```bash
# Enable in Settings → Bookdrop
# Drop files for automatic import
cp book.epub data/booklore/bookdrop/
# Booklore processes automatically
```

**Method 3: Web Upload**
- Navigate to library
- Click "Upload Books"
- Select and upload files

### Magic Shelves

Create dynamic collections that auto-update:

1. Settings → Shelves → Create Magic Shelf
2. Set rules (e.g., "Rating > 4 stars", "Genre = Sci-Fi")
3. Books matching rules appear automatically

### Database

Booklore uses its own MariaDB container for data storage:
- Container: `booklore-mariadb`
- Automatic initialization on first start
- Backup `data/booklore/mariadb` regularly

### Integration

**With Calibre:**
Point Booklore library to Calibre's book directory for shared storage.

**With Download Clients:**
Use Bookdrop to automatically import downloaded books.

**With OPDS Readers:**
Get OPDS URL from Settings → OPDS for reading apps.

**With Nginx Proxy Manager:**
Configure domain: booklore.bop.lat → booklore:6060