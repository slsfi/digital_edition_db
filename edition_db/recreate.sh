#!/bin/bash
set -e
psql -U root -f /tmp/db_dump.sql
