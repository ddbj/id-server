#!/bin/bash
psql -U postgres -d ddbj << EOSQL
CREATE TABLE  PREFIX_AR_10 (
  id bigserial NOT NULL  primary key,
  accession CHAR(10) NOT NULL,
  agent TEXT NOT NULL,
  version VARCHAR(10) NOT NULL,
  status VARCHAR(10) NOT NULL,
  visibility BOOLEAN NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  deleted_at TIMESTAMP
);

CREATE UNIQUE INDEX accession_index ON prefix_ar_10 (accession);

CREATE TABLE PREFIX_MANAGEMENT (
  id bigserial NOT NULL,
  prefix VARCHAR(5) NOT NULL,
  digits INT NOT NULL,
  publisher VARCHAR(50) NOT NULL,
  resource_type VARCHAR(50),
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  deleted_at TIMESTAMP,
  related_to INT,
  UNIQUE (prefix)
);
EOSQL
