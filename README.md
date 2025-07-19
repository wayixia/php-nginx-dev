# php-nginx-dev
php nginx dev enviroment


## docker build
docker build --platform=linux/amd64 -t php-nginx-dev:1.0 .

error list:
Q: i/o timeout
A: set terminal proxy:
``` export https_proxy=http://127.0.0.1:7890 ```



## deploy
``` docker run -d --name lonyda -v `pwd`/www/lonyda.com/upload:/app -p 443:443 wayixia/php-nginx-dev:phpnginx ```
