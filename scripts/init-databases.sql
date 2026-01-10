-- Initialize all databases for home lab services
-- This script runs on first PostgreSQL container start

-- Create databases for each service that needs one
CREATE DATABASE IF NOT EXISTS koel;
CREATE DATABASE IF NOT EXISTS speedtest;
CREATE DATABASE IF NOT EXISTS immich;
CREATE DATABASE IF NOT EXISTS affine;
CREATE DATABASE IF NOT EXISTS authelia;
CREATE DATABASE IF NOT EXISTS grafana;
CREATE DATABASE IF NOT EXISTS bookstack;
CREATE DATABASE IF NOT EXISTS nextcloud;
CREATE DATABASE IF NOT EXISTS nginx_proxy;

-- Grant all privileges to postgres user (default superuser)
GRANT ALL PRIVILEGES ON DATABASE koel TO postgres;
GRANT ALL PRIVILEGES ON DATABASE speedtest TO postgres;
GRANT ALL PRIVILEGES ON DATABASE immich TO postgres;
GRANT ALL PRIVILEGES ON DATABASE affine TO postgres;
GRANT ALL PRIVILEGES ON DATABASE authelia TO postgres;
GRANT ALL PRIVILEGES ON DATABASE grafana TO postgres;
GRANT ALL PRIVILEGES ON DATABASE bookstack TO postgres;
GRANT ALL PRIVILEGES ON DATABASE nextcloud TO postgres;
GRANT ALL PRIVILEGES ON DATABASE nginx_proxy TO postgres;
