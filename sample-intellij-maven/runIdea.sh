#!/usr/bin/env bash
docker-compose up -d && docker-compose exec ide bash -c 'idea'
