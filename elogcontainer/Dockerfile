FROM alpine:latest

COPY elogd-static /usr/local/bin/
COPY elog-resources.tar /data/elog-data/
COPY elog.cfg /data/elog-config/

RUN cd /data/elog-data/ && tar -xvf elog-resources.tar
RUN addgroup elog && adduser -D elog -G elog
RUN chown -R elog:elog /data/elog-config && chown -R elog:elog /data/elog-data

USER elog:elog
VOLUME ["/data/elog-data", "/data/elog-config"]
EXPOSE 8081/tcp

CMD ["/usr/local/bin/elogd-static", "-c", "/data/elog-config/elog.cfg", "-d", "/data/elog-data/logbooks", "-s", "/data/elog-data", "elog"]