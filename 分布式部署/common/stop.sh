#!/bin/bash
export customer_code=${PWD##*/}  #默认当前父目录作为客户code
export dubboadmin_port=9014
docker-compose stop
echo "The zookeeper,redis and dubboadmin has been stoped."