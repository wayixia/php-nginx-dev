#!/bin/bash


local_path=$(cd "$(dirname "$0")"; pwd)

docker run -d --name lonydadev \
	-v $local_path/example:/app \
	-v $local_path/example/nginx-sites-enabled:/etc/nginx/sites-enabled \
	-p 80:80 \
	-p 9000:9000 \
	php-nginx-dev:1.0


#wayixia/php-nginx-dev:1.0
