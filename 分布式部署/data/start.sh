#!/bin/bash
cd `dirname $0`
export customer_code=${PWD##*/} #默认当前父目录作为客户code
docker-compose up -d
echo "Mysql and Sftp has been started."