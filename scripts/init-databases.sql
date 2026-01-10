-- Initialize all databases for home lab services
-- This script runs on first PostgreSQL container start

-- Create databases for each service that needs one
-- Using DO blocks for proper conditional creation

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'koel') THEN
        CREATE DATABASE koel;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'speedtest') THEN
        CREATE DATABASE speedtest;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'immich') THEN
        CREATE DATABASE immich;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'affine') THEN
        CREATE DATABASE affine;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'authelia') THEN
        CREATE DATABASE authelia;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'grafana') THEN
        CREATE DATABASE grafana;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bookstack') THEN
        CREATE DATABASE bookstack;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'nextcloud') THEN
        CREATE DATABASE nextcloud;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'nginx_proxy') THEN
        CREATE DATABASE nginx_proxy;
    END IF;
END
$$;
