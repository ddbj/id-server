#!/bin/bash
psql -U postgres  << EOSQL
CREATE DATABASE  ddbj;
EOSQL