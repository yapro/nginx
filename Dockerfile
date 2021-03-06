FROM debian:jessie

MAINTAINER Lebedenko Nikolay <lebnikpro@gmail.com>

RUN apt-get update && \
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

ENV NGINX_PUSH_STREAM_MODULE_PATH=/tmp/nginx-push-stream-module-0.5.2

ADD https://github.com/wandenberg/nginx-push-stream-module/archive/0.5.2.zip ./tmp
ADD http://nginx.org/download/nginx-1.2.0.tar.gz ./tmp

RUN cd /tmp && unzip 0.5.2.zip
RUN cd /tmp && tar xzvf nginx-1.2.0.tar.gz

RUN cd /tmp/nginx-1.2.0 && \
 ./configure --add-module=../nginx-push-stream-module-0.5.2 && \
 make && \
 make install

CMD /usr/local/nginx/sbin/nginx -c $NGINX_PUSH_STREAM_MODULE_PATH/misc/nginx.conf
