#!/bin/bash
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres

if [ "$STATUS" == "complete" ]; then
  cd /ecommerce-workshop/deploy
  docker-compose -f docker-compose-fixed-instrumented.yml up -d\
  echo "App is up!"
fi

