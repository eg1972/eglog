# eglog
create an elog image and push it to docker hub.

Documentation:
- [https://jenkins.io/doc/book/pipeline/docker/](https://jenkins.io/doc/book/pipeline/docker/)
- [https://jenkins.io/doc/book/pipeline/syntax/#agent](https://jenkins.io/doc/book/pipeline/syntax/#agent)



Steps:
- download elog source
- compile elog source into a static binary
- build an elog image with a Dockerfile
- push the image to docker hub

Tests:
- create a container from image on docker hub
- verify access

TODO:
- extract the resources from the latest elog-source
- implement a Jenkins pipeline with the steps below
## Automatic process using Jenkins pipeline
### Jenkins prerequisites
### installing Jenkins in a docker container
### Jenkins configuraton
### building an elog-image with Jenkins

## Manual Process
1. Manual test: compile a static elogdownload source to a test-container
    ```
    docker run -it --rm --name gcc-test \
        --mount type=bind,source="$PWD",target=/elogd-static \
        gcc:latest bash
    #docker exec -u root -it gcc-test bash
    mkdir /myapp && cd /myapp
    wget https://elog.psi.ch/elog/download/tar/elog-latest.tar.gz
    ```
    ```
    tar -xzvf elog-latest.tar.gz
    rm elog-latest.tar.gz
    cd elog-*
    make
    gcc -static -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o crypt.o src/crypt.c
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -c -o strlcpy.o mxml/strlcpy.c
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -o elog src/elog.c crypt.o strlcpy.o -lssl
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o regex.o src/regex.c
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o auth.o src/auth.c
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -c -o mxml.o mxml/mxml.c
    gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -o elogd src/elogd.c crypt.o auth.o regex.o mxml.o strlcpy.o
    ```
2. Build a statically-linked elogd image using Dockerfile
    ```
    cd buildcontainer
    docker image build -t stone1972/eglogd-build:v1 .
    ```
3. start a container to get to the binary into a local directory
    ```
    docker run -d --rm --name elogd-copy \
        --mount type=bind,source="$PWD/../elogcontainer",target=/elogd-static \
        stone1972/eglogd-build:v1 
    ```
4. Build an image for the elog container using Dockerfile
    ```
    cd elogcontainer
    docker image build -t stone1972/eglogd:v1 .
    ```
5. start an elog container running the binary
    ```
    docker run -d --publish 127.0.0.1:8084:8081 --name eglogd-v1 stone1972/eglogd:v1
    ```
    [http://localhost:8084](http://localhost:8084)
6. push the image to the Docker hub
    ```
    docker login -u stone1972
    docker push stone1972/eglogd:v1
    ```
    [https://hub.docker.com/repository/docker/stone1972/eglogd](https://hub.docker.com/repository/docker/stone1972/eglogd)
7. clean up
    ```
    docker container rm -f eglogd-v1
    docker image rm stone1972/eglogd-build:v1
    docker image rm stone1972/eglogd:v1
    ```
Notes:
- the elogcontainer directory needs to be 777, so that the jenkins-user can write to it
- the docker socket needs to be 777 so that docker in the jenkins container can control it 
(```docker exec -it -u root jenkins chmod 777 /var/run/docker.sock```)

```
#
#create a container with mounted volumes:
#  docker volume create eglog-data
#  docker volume create eglog-config
#docker run -d --publish 127.0.0.1:8084:8081 \
#  --mount source=eglog-data,destination=/data/eglog-data \
#  --mount source=eglog-config,destination=/data/eglog-config \
#  --name eglogd-vol-v1 stone1972/eglog:v1
#
#create a container without mounted volumes:
#docker run -d --publish 127.0.0.1:8084:8081 \
#  --name eglogd-v1 stone1972/eglog:v1
#
#docker rm eglogdv1
#docker rmi eglogd:v1
#docker volume rm eglog-config eglog-data
#
#docker login -u stone1972
#docker push stone1972/eglogd:v1
#
```
