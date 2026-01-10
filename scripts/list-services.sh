#!/usr/bin/env bash
# Helper script to get list of all services
cd /home/runner/work/home_lab/home_lab/services
for dir in */; do
    if [ -f "${dir}docker-compose.yml" ]; then
        echo "${dir%/}"
    fi
done
