mysqldump -uroot -prtdb.mysql --default-character-set=utf8  --databases lfcp_gzrtdb_web> /home/backup/mysqldb/lfcp_gzrtdb_web_$(date +%Y%m%d_%H%M%S).sql
find /home/backup/mysqldb -mtime +30 -type f | xargs rm -f