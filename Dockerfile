FROM debian:jessie

ENV HTTPTERM_VERSION 1.7.2
ENV HTTPTERM_MD5 531c0a83c5a6e75cb4b8eb212b56492c

ENV HTTPTERM_NAME httpterm-${HTTPTERM_VERSION}
ENV HTTPTERM_ARCHIVE ${HTTPTERM_NAME}.tar.gz

ENV HTTPTERM_MAXCONN 300000

RUN buildDeps='curl gcc make libc-dev' && \
    apt-get update && \
    apt-get install --no-install-recommends -y ${buildDeps} && \

    curl -OJ http://1wt.eu/tools/httpterm/${HTTPTERM_ARCHIVE} && \
    echo "${HTTPTERM_MD5}  ${HTTPTERM_ARCHIVE}" | md5sum -c && \

    tar zxvf ${HTTPTERM_ARCHIVE} && \
    make -C ${HTTPTERM_NAME} && \
    mv ${HTTPTERM_NAME}/httpterm /usr/local/sbin && \

    rm -rf /var/lib/apt/lists/* ${HTTPTERM_NAME} ${HTTPTERM_ARCHIVE} && \
    apt-get purge -y --auto-remove ${buildDeps}


EXPOSE 8000

# Intentionally use shell form here, so ^C will work.
CMD httpterm -n ${HTTPTERM_MAXCONN} -N ${HTTPTERM_MAXCONN} -L :8000
