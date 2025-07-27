#!/bin/bash

docker run -d --name lonyda -v /root/docker:/app -v /root/docker-db:/var/lib/mysql -p 443:443 php-nginx-dev:1.0
