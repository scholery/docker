mysqldump -h127.0.0.1 -uroot -pLonger.1234 --default-character-set=utf8  --skip-opt --skip-comments --complete-insert --databases lfcp_jsnd_web> /home/lfcp/backup/mysql/lfcp_jsnd_web_$(date +%Y%m%d_%H%M%S).sql
find /home/lfcp/backup/mysql -mtime +30 -type f | xargs rm -f
