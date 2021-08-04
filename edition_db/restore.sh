#!/bin/bash
set -e
psql -U root <<- EOSQL
    CREATE DATABASE digitaledition WITH OWNER root;
    GRANT ALL PRIVILEGES ON DATABASE digitaledition TO root;
EOSQL
psql -v ON_ERROR_STOP=1 -U root -d digitaledition -f /tmp/db_dump.sql