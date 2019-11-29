FROM gcc:latest

RUN     mkdir /myapp && cd /myapp && mkdir /elogd-static && \
        wget https://elog.psi.ch/elog/download/tar/elog-latest.tar.gz && \
        tar -xzvf elog-latest.tar.gz && \
        rm elog-latest.tar.gz && \
        cd elog-* && \
        make && \
        gcc -static -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o crypt.o src/crypt.c && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -c -o strlcpy.o mxml/strlcpy.c && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -o elog src/elog.c crypt.o strlcpy.o -lssl && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o regex.o src/regex.c && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -w -c -o auth.o src/auth.c && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -c -o mxml.o mxml/mxml.c && \
        gcc -static  -O3 -funroll-loops -fomit-frame-pointer -W -Wall -Wno-deprecated-declarations -Imxml -o elogd src/elogd.c crypt.o auth.o regex.o mxml.o strlcpy.o && \
        cp elogd /elogd

VOLUME ["/elogd-static"]


CMD ["cp", "/elogd", "/elogd-static/elogd-static"]