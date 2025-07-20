#!/bin/bash
# Let's Encrypt 免费 HTTPS 证书申请脚本
# 支持 Ubuntu 18.04+/CentOS 7+
# 需提前将域名解析指向当前服务器

DOMAIN="lonyda.com"       # 替换为你的域名
EMAIL="wayixia@gmail.com" # 替换为你的邮箱（重要，用于紧急通知）


docker run -it --rm \
     	-v /root/docker/cert:/etc/letsencrypt \
     	certbot/certbot certonly \
      	--manual \
     	--preferred-challenges dns \
     	-d www.lonyda.com
