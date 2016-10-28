# docker build -t tengine:simple -t tengine:latest --rm .
FROM centos:latest

MAINTAINER twesix <twesix@aliyun.com>

ENV TENGINE_VERSION 2.1.2

ADD src /root/src

WORKDIR /root/src/

RUN yum update -y
RUN yum install -y gcc gcc-c++ \
                   bzip2 \
                   make autoconf\
                   perl

RUN tar -zxvf tengine-2.1.2.tar.gz && \
    rm tengine.tar.gz && \
    tar -jxvf jemalloc-4.2.1.tar.bz2 && \
    rm jemalloc-4.2.1.tar.bz2 && \
    tar -zxvf pcre-8.39.tar.gz && \
    rm pcre-8.39.tar.gz && \
    tar -zxvf openssl-1.0.2j.tar.gz && \
    rm openssl-1.0.2j.tar.gz && \
    tar -zxvf zlib-1.2.8.tar.gz && \
    rm zlib-1.2.8.tar.gz

WORKDIR tengine-${TENGINE_VERSION}

RUN ./configure \
    \
    --with-jemalloc=/root/src/jemalloc-4.2.1 \
    --with-pcre=/root/src/pcre-8.39 \
    --with-zlib=/root/src/zlib-1.2.8 \
    --with-openssl=/root/src/openssl-1.0.2j \
    \
    --prefix=/root/tengine \
    --sbin-path=/root/tengine/tengine \
    \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_spdy_module \
    \
    --with-http_sysguard_module \
    --with-http_stub_status_module


RUN make
RUN make install

RUN rm -rf /root/src

WORKDIR /root/tengine/tengine

EXPOSE 80 443

CMD ["tengine", "-g", "daemon off;"]