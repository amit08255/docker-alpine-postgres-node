FROM alpine
LABEL maintainer "Dominic Taylor <dominic@yobasystems.co.uk>" architecture="AMD64/x86_64"
LABEL postgres-version="11.1" alpine-version="3.9.0" date="11-Feb-2018"

ENV LANG en_GB.utf8
ENV PGDATA /var/lib/postgresql/data

RUN apk update && \
    apk add su-exec tzdata libpq postgresql-client postgresql postgresql-contrib nodejs npm && \
    mkdir /docker-entrypoint-initdb.d && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    rm -rf /var/cache/apk/*


VOLUME /var/lib/postgresql/data

COPY files/docker-entrypoint.sh /

COPY files/start.sh /

COPY src /src

RUN chown -R postgres /src

RUN chmod +x /docker-entrypoint.sh

RUN chmod +x /start.sh

WORKDIR /src

RUN npm install

WORKDIR /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432 7000
CMD /start.sh
