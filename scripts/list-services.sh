#!/usr/bin/env bash
# Helper script to get list of all services

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the project root (one level up from scripts/)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT/services" || exit 1

for dir in */; do
    if [ -f "${dir}docker-compose.yml" ]; then
        echo "${dir%/}"
    fi
done
