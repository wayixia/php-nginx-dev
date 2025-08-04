#!/bin/bash

# 构建镜像
docker build -f Dockerfile_dev --platform=linux/amd64 -t php-nginx-dev:1.0 .

