#!/bin/bash
export customer_code=${PWD##*/}  #默认当前父目录作为客户code
export hostIP=172.16.0.203
export api_port=8080
export web_port=8081
export dubbo_port=20887
docker-compose stop
echo "The LFCP System on ${hostIP} has been stoped."