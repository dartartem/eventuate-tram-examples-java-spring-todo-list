#! /bin/bash -e


. ./set-env-postgres-wal.sh

docker-compose -f docker-compose-postgres-wal.yml down

docker-compose -f docker-compose-postgres-wal.yml up -d --build elasticsearch
docker-compose -f docker-compose-postgres-wal.yml up -d --build postgres

./wait-for-postgres.sh

docker-compose -f docker-compose-postgres-wal.yml up -d --build tramcdcservice

./wait-for-infrastructure.sh

./gradlew build

docker-compose -f docker-compose-postgres-wal.yml down