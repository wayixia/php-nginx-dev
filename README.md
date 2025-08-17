# php-nginx-dev
php nginx dev enviroment


## docker build
docker build --platform=linux/amd64 -t php-nginx-dev:1.0 .

error list:
Q: i/o timeout
A: set terminal proxy:
``` export https_proxy=http://127.0.0.1:7890 ```

## docker push
```
# docker tag php-nginx-dev:1.0 wayixia/php-nginx-dev:phpnginx
# docker push wayixia/php-nginx-dev:phpnginx
```


## deploy
``` 

docker run -d --name yourdockername \
  -v /path/to/rootdir/app:/app \
  -v /path/to/rootdir/app/nginx-sites-enabled:/etc/nginx/sites-enabled \
  -p 443:443 \
  wayixia/php-nginx-dev:phpnginx 

```


## docker-web 目录结构 

- /
  - nginx-sites-enabled
    - www1.conf
    - www2.conf
    - www3.conf
    - www*.conf
  - www1
    - upload
    - cert
    - nginx.conf
  - www2
  - www3
  - www...





