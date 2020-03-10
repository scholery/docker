#!/bin/bash
cd `dirname $0`
export customer_code=${PWD##*/} #默认当前父目录作为客户code
export hostIP=28.0.7.11
export nginx_port=80
docker-compose up -d
echo "The nginx on ${hostIP} has been started on port ${nginx_port}."