# eglog
create an elog image and push it to docker hub
```
#https://docs.docker.com/engine/reference/builder
# use with
#docker build .
#docker image list
#docker image tag <image-ID> stone1972/elogd:v20
#docker login -u stone1972
#docker push stone1972/elogd:v20
#
#docker run -d --publish 192.168.102.6:8084:8081 \
#  --mount source=elog-data,destination=/data/elog-data \
#  --mount source=elog-config,destination=/data/elog-config \
#  --name elogdv20local stone1972/elogd:v20
#
#docker rm elogdv20local
#docker rmi elogd:v20
#docker volume rm elog-config elog-data
#
```
