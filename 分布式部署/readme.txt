1.各个服务器已docker方式安装相关服务
2.服务器之间通过host配置机器名访问
3.开启启动，将目录下的start.sh配置到/etc/rc.local，修改改文件权限为可执行

规划建议：
nginx(10.1.17.5)
|-web1(10.1.17.3)
|-web2(10.1.17.4)
|-redis&zk(10.1.17.1)
|-db(10.1.18.1)

端口：
80：nginx
8080：api
8081：web1
9000：dubboadmin
2181：zookeeper
20887：dubbo