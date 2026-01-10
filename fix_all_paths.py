#!/usr/bin/env python3
"""
Fix all volume paths in service docker-compose files to be relative to project root.
"""

import os
import re
from pathlib import Path

def fix_paths_in_compose_file(file_path):
    """Fix volume paths to be relative to project root."""
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    fixed_lines = []
    for line in lines:
        # Check if line contains a volume mapping starting with ./
        if '- ./' in line and ':' in line:
            # Replace ./ with ../../ for volume mappings
            line = line.replace('- ./', '- ../../')
        fixed_lines.append(line)
    
    with open(file_path, 'w') as f:
        f.writelines(fixed_lines)

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
