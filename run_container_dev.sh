#!/bin/bash

docker run -d --name lonyda -v /root/docker:/app -v /root/docker-db:/var/lib/mysql -p 443:443 -p 3306:3306 php-nginx-dev:1.0
