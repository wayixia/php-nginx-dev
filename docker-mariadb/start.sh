#!/bin/bash

# 设置文件权限
chown -R www-data:www-data /app/www

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/mysqld.{err,out}.log
chown mysql:mysql /var/log/mysql/mysqld.*.log

# 启动 Supervisor（管理 Nginx 和 PHP-FPM）
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
