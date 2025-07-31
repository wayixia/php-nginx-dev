#!/bin/bash
set -e

# 初始化数据库（如果未初始化）
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql
fi

# 启动 MariaDB
#exec mysqld_safe

/etc/init.d/mariadb restart
