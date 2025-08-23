#!/bin/bash

# 设置文件权限
chown -R www-data:www-data /app

# 启动 Supervisor（管理 Nginx 和 PHP-FPM）
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
