#!/bin/bash
export customer_code=${PWD##*/} #默认当前父目录作为客户code
export web_port=8011
export dubboadmin_port=9011
docker-compose up -d
echo "The LFCP System of ${customer_code} has been started on port ${web_port}."