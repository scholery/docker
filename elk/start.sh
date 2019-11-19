#!/bin/bash
cd `dirname $0`
export ELK_VERSION=7.4.2
docker-compose up -d
echo "The elk has been started,version ${ELK_VERSION}."