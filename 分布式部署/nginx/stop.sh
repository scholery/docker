#!/bin/bash
export customer_code=${PWD##*/}  #默认当前父目录作为客户code
export hostIP=10.1.17.5
export nginx_port=80
docker-compose stop
echo "The nginx on ${hostIP} has been stoped."