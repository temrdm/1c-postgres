# vim:set ft=dockerfile:
FROM ubuntu:14.04
MAINTAINER temrdm

RUN apt-get update
RUN groupadd -r postgres && useradd -r -g postgres postgres

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8

ENV LANG ru_RU.utf8

RUN mkdir /docker-entrypoint-initdb.d

ENV PG_MAJOR 9.2
ENV PG_VERSION 9.2.4-1
ENV ARCH amd64

RUN apt-get update && apt-get install -y libssl0.9.8 libossp-uuid16 libxslt1.1 \
    libicu52 libt1-5 libgfs-1.3-2 libgssapi-krb5-2 libkrb5-3 libldap-2.4-2 libedit2

ADD ./dist/ /opt/
COPY patch-postgresql-contrib.sh /opt/

RUN bash /opt/patch-postgresql-contrib.sh

RUN apt-get install -y postgresql-common postgresql-client-common
RUN dpkg -i /opt/libpq5_${PG_VERSION}.1C_${ARCH}.deb /opt/postgresql-${PG_MAJOR}_${PG_VERSION}.1C_${ARCH}.deb \
            /opt/postgresql-client-${PG_MAJOR}_${PG_VERSION}.1C_${ARCH}.deb \
            /opt/postgresql-contrib-${PG_MAJOR}_${PG_VERSION}.1C_${ARCH}_patched.deb

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/${PG_MAJOR}/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]