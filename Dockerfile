##########################################################################
# Dockerfile to create elogd-image
##########################################################################

FROM alpine:latest

# COPY ELOGD and resources
COPY elogd-static /usr/local/bin/
COPY elogd300-res.tar /data/elog-data/

# ADD ELOG USER AND GROUP
# create mount-point-dir and extract config and resources
# Note: mount-dir needs to be created BEFORE it is declared
RUN addgroup elog && adduser -D elog -G elog && \
    mkdir -p /data/elog-data /data/elog-config && \
    tar -xf /data/elog-data/elogd300-res.tar -C /data/elog-data && \
    cp /data/elog-data/elog.cfg /data/elog-config/elog.cfg && \
    chown -R elog:elog /data/ && \
    chmod +x /usr/local/bin/elogd-static
    
# Volumes: which directories should be publishable as volumes; no changes possible after declaration
#https://docs.docker.com/engine/reference/builder/#volume
#https://docs.docker.com/storage/volumes/
VOLUME ["/data/elog-data", "/data/elog-config"]

# set user for execution and all following commands
USER elog:elog

# EXPOSE PORTS
EXPOSE 8081/tcp

# START COMMAND
CMD ["/usr/local/bin/elogd-static", "-c", "/data/elog-config/elog.cfg", "-d", "/data/elog-data/logbooks", "-s", "/data/elog-data", "elog"]
