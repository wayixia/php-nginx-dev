#!/bin/bash

# 构建镜像
docker build --platform=linux/amd64 -t php-nginx-dist:1.0 .

