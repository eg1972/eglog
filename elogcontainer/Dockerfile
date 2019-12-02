FROM alpine:latest

COPY ./elogcontainer/elogd-static /usr/local/bin/elogd-static
COPY ./elogcontainer/elog-resources.tar /data/elog-data/
COPY ./elogcontainer/elog.cfg /data/elog-config/

RUN cd /data/elog-data/ && tar -xvf elog-resources.tar
RUN addgroup elog && adduser -D elog -G elog
RUN chown -R elog:elog /data/elog-config && chown -R elog:elog /data/elog-data

USER elog:elog
EXPOSE 8081/tcp
# the volumen definition needs to be in the end, otherwise the chown instructions would not work
VOLUME ["/data/elog-data", "/data/elog-config"]

CMD ["/usr/local/bin/elogd-static", "-c", "/data/elog-config/elog.cfg", "-d", "/data/elog-data/logbooks", "-s", "/data/elog-data", "elog"]