# Base on latest (edge) alpine image
FROM arm32v6/alpine:edge

MAINTAINER “Jonathan Ervine” <docker@ervine.org>

# Install updates
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' \
    VERSION='0.2.6' \
    MED_USER='mediaservice' \
    MED_UID='1003' \
    MED_GID='1003'

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk update && \
  apk -U upgrade && \
  apk -U add \
    python

RUN wget https://github.com/pymedusa/Medusa/archive/v$VERSION.tar.gz -O medusa.tar.gz && \
  tar zxvf medusa.tar.gz && \
  mv Medusa-$VERSION medusa && \
  rm -rf medusa.tar.gz && \
  apk del make gcc g++ && \
  rm -rf /tmp/src && \
  rm -rf /var/cache/apk/* \
  adduser -u $MED_UID -g $MED_GID -M $MED_USER

EXPOSE 8081

USER $MED_USER

CMD [ "/usr/bin/python", "/medusa/SickBeard.py", "--nolaunch", "--datadir=/config" ]
