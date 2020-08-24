#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username username --dbname postgres <<-EOSQL
EOSQL
