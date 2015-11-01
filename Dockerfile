FROM node:latest

MAINTAINER Josh Owens "joshua.owens@gmail.com"

RUN echo deb http://ftp.debian.org/debian/ jessie main contrib non-free > /etc/apt/source.list

RUN apt-get update -y && apt-get install -y \
    python2.7 python-pip \
    libfreetype6 libfontconfig

RUN mkdir /data

ADD ./package.json /data/package.json
RUN cd /data && npm install

ADD . /data/

ENV TERM=xterm-color

RUN apt-get update; \
    apt-get install -y \
    bison \
    build-essential \
    curl \
    flex \
    g++ \
    git \
    gperf \
    sqlite3 \
    libsqlite3-dev \
    fontconfig \
    libfontconfig1 \
    libfontconfig1-dev \
    libfreetype6 \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libqt5webkit5-dev \
    ruby \
    perl \
    unzip \
    wget

RUN mkdir -p /usr/src; \
    cd /usr/src; \
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip; \
    unzip phantomjs-2.0.0-source.zip; \
    rm phantomjs-2.0.0-source.zip; \
    cd phantomjs-2.0.0; \
    ./build.sh --confirm

RUN cp /usr/src/phantomjs-2.0.0/bin/phantomjs /usr/local/bin/phantomjs

ENV PHANTOMJS_PATH /usr/local/bin/phantomjs

CMD node /data/server.js
