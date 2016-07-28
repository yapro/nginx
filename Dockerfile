FROM debian:jessie

MAINTAINER Lebedenko Nikolay <lebnikpro@gmail.com>

RUN cd /tmp && \
 apt-get update && \
 apt-get install -y \
 unzip \
 make \
 g++ \
 libpcre3 \
 libpcre3-dev \
 libpcrecpp0 \
 libssl-dev \
 zlib1g-dev && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NGINX_PUSH_STREAM_MODULE_PATH=$PWD/nginx-push-stream-module-0.5.2

ADD https://github.com/wandenberg/nginx-push-stream-module/archive/0.5.2.zip ./
ADD http://nginx.org/download/nginx-1.10.1.tar.gz ./

RUN unzip 0.5.2.zip
RUN tar xzvf nginx-1.10.1.tar.gz

RUN cd nginx-1.10.1 && \
 ./configure --add-module=../nginx-push-stream-module-0.5.2 && \
 make && \
 make install

CMD nginx start
