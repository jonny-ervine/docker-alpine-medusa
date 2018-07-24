# Base on latest (edge) alpine image
FROM alpine:edge

MAINTAINER “Jonathan Ervine” <docker@ervine.org>

# Install updates
ENV container docker \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' \
    VERSION='develop'

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk update && \
  apk -U upgrade && \
  apk -U add \
    python

RUN wget https://github.com/pymedusa/Medusa/archive/v0.2.6.tar.gz -O medusa.tar.gz && \
  tar zxvf medusa.tar.gz && \
  mv Medusa-0.2.6 medusa && \
  rm -rf medusa.tar.gz && \
  apk del make gcc g++ && \
  rm -rf /tmp/src && \
  rm -rf /var/cache/apk/*

EXPOSE 8081

CMD [ "/usr/bin/python", "/medusa/SickBeard.py", "--nolaunch", "--datadir=/config" ]
