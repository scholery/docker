#!/bin/bash
chmod -R 777 ./* 
#1.install docker
echo "1.install docker"
#rpm -ivh ./software/require/*.rpm
rpm -ivh ./software/require/libseccomp-2.3.1-3.el7.x86_64.rpm
rpm -ivh ./software/require/device-mapper-persistent-data-0.8.5-1.el7.src.rpm
rpm -ivh ./software/docker-ce-cli-19.03.5-3.el7.x86_64.rpm
rpm -ivh ./software/container-selinux-2.107-3.el7.noarch.rpm
rpm -ivh ./software/containerd.io-1.2.6-3.3.el7.x86_64.rpm
rpm -ivh ./software/docker-ce-19.03.5-3.el7.x86_64.rpm

cp ./software/docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#2.start docker
echo "2.start docker"
systemctl enable docker.service
systemctl start docker

#3.import docker images
echo "3.import docker images"
#export shell
#docker save -o /home/docker/images/mysql.tar mysql:latest
#docker save -o /home/docker/images/zookeeper.tar zookeeper:latest
#docker save -o /home/docker/images/redis.tar redis:latest
#docker save -o /home/docker/images/sftp.tar atmoz/sftp:latest
#docker save -o /home/docker/images/openjdk.tar openjdk:latest
#docker save -o /home/docker/images/nginx.tar nginx:latest
#docker save -o /home/docker/images/tomcat.tar tomcat:latest
docker load < ./images/mysql.tar
docker load < ./images/sftp.tar
docker load < ./images/nginx.tar
docker load < ./images/zookeeper.tar
docker load < ./images/redis.tar
docker load < ./images/openjdk.tar
docker load < ./images/tomcat.tar

