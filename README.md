# php-nginx-dev
php nginx dev enviroment


## docker build
docker build --platform=linux/amd64 -t php-nginx-dev:1.0 .

error list:
Q: i/o timeout
A: set terminal proxy:
``` export https_proxy=http://127.0.0.1:7890 ```

docker push
# docker tag php-nginx-dev:1.0 wayixia/php-nginx-dev:phpnginx
# docker push wayixia/php-nginx-dev:phpnginx

## deploy
``` docker run -d --name lonyda -v `pwd`/www/lonyda.com/upload:/app -p 443:443 wayixia/php-nginx-dev:phpnginx ```


## template struct 

-root
  - docker-db
  - docker--www
    - www
    - cert
    - nginx.conf





