#!/usr/bin/env python3
"""
Script to split the monolithic docker-compose.yml into service-specific files.
Each service will be placed in its own directory under services/.
"""

import os
import yaml
import re
from pathlib import Path

def parse_docker_compose(file_path):
    """Parse the docker-compose.yml file."""
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Parse YAML
    config = yaml.safe_load(content)
    return config

def extract_service_block(content, service_name):
    """Extract the full service block from the original file including comments."""
    lines = content.split('\n')
    service_lines = []
    in_service = False
    indent_level = None
    
    for i, line in enumerate(lines):
        # Check if we're starting the service
        if re.match(f'^  {service_name}:', line):
            in_service = True
            indent_level = len(line) - len(line.lstrip())
            service_lines.append(line)
            continue
        
        # If we're in the service, collect lines
        if in_service:
            # Check if we've moved to a new service (same indent level, non-comment)
            if line.strip() and not line.strip().startswith('#'):
                current_indent = len(line) - len(line.lstrip())
                if current_indent <= indent_level and line.strip().endswith(':'):
                    # We've hit the next service
                    break
            service_lines.append(line)
    
    return '\n'.join(service_lines)

def create_service_compose_file(service_name, service_config, network_config, original_content):
    """Create a docker-compose.yml file for a single service."""
    # Extract the full service block with comments
    service_block = extract_service_block(original_content, service_name)
    
    # Create the docker-compose structure
    compose_content = "services:\n"
    
    # Add the service block (remove first two spaces to adjust indent)
    service_lines = service_block.split('\n')
    for line in service_lines:
        if line.startswith('  '):
            compose_content += line[2:] + '\n'
        else:
            compose_content += line + '\n'
    
    # Add network configuration
    compose_content += "\nnetworks:\n"
    compose_content += "  homelab:\n"
    compose_content += "    external: true\n"
    compose_content += "    name: homelab\n"
    
    return compose_content

def get_service_category(service_name):
    """Determine the category of a service based on its name."""
    categories = {
        'media': ['jellyfin', 'immich', 'speedtest-tracker'],
        'music': ['koel', 'navidrome'],
        'books': ['calibre', 'calibre-web', 'audiobookshelf', 'lazylibrarian', 'bookstore'],
        'notes': ['affine'],
        'network': ['headscale', 'pihole', 'authelia'],
        'monitoring': ['portainer', 'prometheus', 'grafana', 'loki', 'uptime-kuma'],
        'proxy': ['nginx-proxy-manager', 'homepage'],
        'databases': ['postgres', 'redis'],
        'cloud': ['nextcloud', 'rclone'],
        'development': ['filebrowser', 'mkdocs'],
        'automation': ['radarr', 'sonarr', 'prowlarr'],
        'download': ['transmission']
    }
    
    for category, services in categories.items():
        if service_name in services:
            return category
    return 'other'

def main():
    compose_file = 'docker-compose.yml'
    services_dir = Path('services')
    
    # Read original content for extracting blocks
    with open(compose_file, 'r') as f:
        original_content = f.read()
    
    # Parse the docker-compose.yml
    config = parse_docker_compose(compose_file)
    
    if 'services' not in config:
        print("No services found in docker-compose.yml")
        return
    
    services = config['services']
    networks = config.get('networks', {})
    
    print(f"Found {len(services)} services")
    
    # Create service directories and compose files
    for service_name, service_config in services.items():
        print(f"Processing: {service_name}")
        
        # Create service directory
        service_dir = services_dir / service_name
        service_dir.mkdir(parents=True, exist_ok=True)
        
        # Create docker-compose.yml for this service
        compose_content = create_service_compose_file(
            service_name, 
            service_config, 
            networks,
            original_content
        )
        
        compose_file_path = service_dir / 'docker-compose.yml'
        with open(compose_file_path, 'w') as f:
            f.write(compose_content)
        
        print(f"  ✓ Created {compose_file_path}")
        
        # Create a README for the service
        category = get_service_category(service_name)
        readme_content = f"""# {service_name.title()}

Category: {category.title()}

## Service Information

This service is part of the Home Lab setup.

## Usage

Start this service:
```bash
just services --action start --name {service_name}
```

Stop this service:
```bash
just services --action stop --name {service_name}
```

View logs:
```bash
just services --action logs --name {service_name}
```

## Configuration

Configuration for this service is managed through:
- Docker Compose file: `docker-compose.yml`
- Environment variables in root `.env` file
- Service-specific configs (if any) in `/config/{service_name}/`

## Ports

See `docker-compose.yml` for port mappings.

## Dependencies

Check `depends_on` in `docker-compose.yml` for service dependencies.
"""
        
        readme_path = service_dir / 'README.md'
        with open(readme_path, 'w') as f:
            f.write(readme_content)
        
        print(f"  ✓ Created {readme_path}")
    
    print(f"\n✓ Successfully split {len(services)} services into individual directories")
    print(f"\nNext steps:")
    print(f"1. Review the generated docker-compose.yml files")
    print(f"2. Update the Justfile to work with the new structure")
    print(f"3. Test starting services individually and collectively")

if __name__ == '__main__':
    main()
