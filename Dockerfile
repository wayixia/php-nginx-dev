# 使用官方 PHP 基础镜像（包含 FPM）
FROM php:8.2-fpm

#Maintainer
LABEL maintainer="wayixia@gmail.com"


# 安装 Nginx 和常用工具
RUN apt-get update && apt-get install -y \
        nginx \
        supervisor \
        curl \
        git \
        vim \
        certbot \
        python3-certbot-nginx \
        mariadb-server \
        libfreetype6-dev \
	libjpeg62-turbo-dev \
        net-tools \
	libpng-dev

#配置mariadb
# 复制配置文件（如果有自定义配置文件的话）
COPY my.cnf /etc/mysql/conf.d/my.cnf

# 设置环境变量
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=mydb
ENV MYSQL_USER=lonyda
ENV MYSQL_PASSWORD=lonyda12$

# 初始化数据库并设置权限
RUN mysql_install_db --user=mysql \
    && mysqld_safe --user=mysql & \
    sleep 10 \
    && mysqladmin -u root password "$MYSQL_ROOT_PASSWORD" \
    && mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

#COPY mysql_init.sh /mysql_init.sh
#RUN chmod +x /mysql_init.sh



# 安装常用 PHP 扩展
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache gd
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-enable mysqli

# 安装 Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# 添加 Xdebug 配置
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# 安装 Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# 安装 Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# 配置 Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# 配置 Supervisor（用于管理多个进程）
#RUN echo "[supervisord]" > /etc/supervisor/conf.d/supervisord.conf && \
#    echo "nodaemon=true" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "[program:nginx]" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "command=/usr/sbin/nginx -g 'daemon off;'" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "[program:php-fpm]" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "command=/usr/local/sbin/php-fpm --nodaemonize" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord.conf && \
#    echo "" >> /etc/supervisor/conf.d/supervisord.conf && \


COPY supervisord.conf  /etc/supervisor/conf.d/supervisord.conf

# 设置工作目录
WORKDIR /app

#mysql persist
VOLUME /var/lib/mysql

# 复制网站文件
COPY info.php /app/www/info.php

# 复制启动脚本并设置权限
COPY start.sh /start.sh
RUN chmod +x /start.sh


# 暴露端口
#EXPOSE 80 
EXPOSE 443
EXPOSE 3306

# 设置容器启动命令
# CMD ["/mysql_init.sh"]
CMD ["/start.sh"]

