# eglog
create an elog image and push it to docker hub.

Steps:
- download elog source
- compile elog source into a static binary
- build an elog image with a Dockerfile
- push the image to docker hub

Tests:
- create a container from image on docker hub
- verify access

Alternative: use debian image

1. download source to a test-container
    ```
    docker run -it --rm --name gcc-test \
        --mount type=bind,source="$PWD",target=/elogd-static \
        gcc:latest bash
    #docker exec -u root -it gcc-test bash
    mkdir /myapp && cd /myapp
    wget https://elog.psi.ch/elog/download/tar/elog-latest.tar.gz
    ```
2. compile
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
3. copy the binary
    ```
    ```
4. build and tag that image
    ```
    docker image build -t stone1972/eglogd:v1 .
    docker image rm stone1972/eglogd:v1
    ```
5. start a container to get to the binary
    ```
    docker run -d --rm --name elogd-copy \
        --mount type=bind,source="$PWD",target=/elogd-static \
        stone1972/eglogd:v1 
    ```

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
