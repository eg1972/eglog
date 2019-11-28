# eglog
create an elog image and push it to docker hub

TODO: use debian image

```
#https://docs.docker.com/engine/reference/builder
# use with
#docker build -t stone1972/eglog:v1 .
#docker image list
#docker image tag <image-ID> stone1972/eglogd:v1
#docker login -u stone1972
#docker push stone1972/eglogd:v1
#
# create a container with mounted volumes:
#  docker volume create eglog-data
#  docker volume create eglog-config
#docker run -d --publish 192.168.102.6:8084:8081 \
#  --mount source=eglog-data,destination=/data/eglog-data \
#  --mount source=eglog-config,destination=/data/eglog-config \
#  --name eglogd-vol-v1 stone1972/eglog:v1
#
# create a container without mounted volumes:
#docker run -d --publish 127.0.0.1:8084:8081 \
#  --name eglogd-v1 stone1972/eglog:v1
#
#docker rm eglogdv1
#docker rmi eglogd:v1
#docker volume rm eglog-config eglog-data
#
```
