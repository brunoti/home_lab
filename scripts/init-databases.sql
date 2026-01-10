-- Initialize all databases for home lab services
-- This script runs on first PostgreSQL container start

-- Create databases for each service that needs one
-- Note: PostgreSQL will skip if database already exists
SELECT 'CREATE DATABASE koel' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'koel')\gexec
SELECT 'CREATE DATABASE speedtest' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'speedtest')\gexec
SELECT 'CREATE DATABASE immich' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'immich')\gexec
SELECT 'CREATE DATABASE affine' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'affine')\gexec
SELECT 'CREATE DATABASE authelia' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'authelia')\gexec
SELECT 'CREATE DATABASE grafana' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'grafana')\gexec
SELECT 'CREATE DATABASE bookstack' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bookstack')\gexec
SELECT 'CREATE DATABASE nextcloud' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'nextcloud')\gexec
SELECT 'CREATE DATABASE nginx_proxy' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'nginx_proxy')\gexec
