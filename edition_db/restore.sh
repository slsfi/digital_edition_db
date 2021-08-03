#!/bin/bash
set -e
psql <<- EOSQL
    CREATE USER root with encrypted password 'somepassword';
    CREATE DATABASE digitaledition WITH OWNER root;
    GRANT ALL PRIVILEGES ON DATABASE digitaledition TO root;
EOSQL
psql -v ON_ERROR_STOP=1 --username=root -d digitaledition -f /tmp/db_dump.sql