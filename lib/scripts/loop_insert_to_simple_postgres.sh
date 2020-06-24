#!/bin/bash

(
for ((i=0 ; i< 1000; i++))
do
  echo "SELECT COUNT(*) FROM prefix_ar_10;"
done
) | psql -U postgres -d ddbj -h localhost -p 15432
exit $?