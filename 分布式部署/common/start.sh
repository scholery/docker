#!/bin/bash
cd `dirname $0`
export customer_code=${PWD##*/} #默认当前父目录作为客户code
export dubboadmin_port=9000
docker-compose up -d
echo "The Zookeeper,redis and dubboadmin has been started on dubbo's port ${dubboadmin_port}."