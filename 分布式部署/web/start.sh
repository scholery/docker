#!/bin/bash
cd `dirname $0`
export customer_code=jsnd #默认当前父目录作为客户code
export hostIP=28.0.7.13
export api_port=8080
export web_port=8081
export dubbo_port=20887
docker-compose up -d
echo "The LFCP System has been started on port ${api_port},${web_port},${dubbo_port}."