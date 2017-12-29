#! /bin/bash -e


. ./set-env-postgres-polling.sh

docker-compose -f docker-compose-postgres-polling.yml down

docker-compose -f docker-compose-postgres-polling.yml up -d --build elasticsearch
docker-compose -f docker-compose-postgres-polling.yml up -d --build postgres

./wait-for-postgres.sh

docker-compose -f docker-compose-postgres-polling.yml up -d --build tramcdcservice

./wait-for-infrastructure.sh

./gradlew build

docker-compose -f docker-compose-postgres-polling.yml down