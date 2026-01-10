#!/usr/bin/env python3
"""
Fix volume paths in service docker-compose files to be relative to project root.
"""

import os
import re
from pathlib import Path

def fix_paths_in_compose_file(file_path):
    """Fix volume paths to be relative to project root."""
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Replace relative paths with paths relative to root
    # Pattern: ./something -> ../../something
    # Pattern: ${VAR:-./something} -> ${VAR:-../../something}
    
    # Fix paths in volume mappings
    content = re.sub(r':\s*\./data/', r': ../../data/', content)
    content = re.sub(r':\s*\./config/', r': ../../config/', content)
    content = re.sub(r':\s*\./scripts/', r': ../../scripts/', content)
    content = re.sub(r':\s*\./', r': ../../', content)
    
    # Fix paths in environment variable defaults
    content = re.sub(r'\$\{([^}]+):-\./data/', r'${\1:-../../data/', content)
    content = re.sub(r'\$\{([^}]+):-\./config/', r'${\1:-../../config/', content)
    content = re.sub(r'\$\{([^}]+):-\./scripts/', r'${\1:-../../scripts/', content)
    
    with open(file_path, 'w') as f:
        f.write(content)

def main():
    services_dir = Path('services')
    
    # Process each service directory
    for service_dir in services_dir.iterdir():
        if service_dir.is_dir():
            compose_file = service_dir / 'docker-compose.yml'
            if compose_file.exists():
                print(f"Fixing paths in {compose_file}")
                fix_paths_in_compose_file(compose_file)
    
    print("✓ All paths fixed")

if __name__ == '__main__':
    main()
